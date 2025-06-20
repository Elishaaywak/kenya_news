# twitter_scraper.py
import tweepy
import mysql.connector
from config import DB_CONFIG, TWITTER_BEARER_TOKEN

# Set up Twitter API
client = tweepy.Client(bearer_token=TWITTER_BEARER_TOKEN, wait_on_rate_limit=True)

# Connect to MySQL
conn = mysql.connector.connect(**DB_CONFIG)
cursor = conn.cursor()

# Your search query (customize as needed)
query = "(Ruto OR Raila OR Kenya OR Kisumu OR elections OR Uhuru) lang:en -is:retweet"

# Fetch tweets
def fetch_and_store_tweets():
    tweets = client.search_recent_tweets(query=query, max_results=100, tweet_fields=["id", "text", "created_at", "lang", "author_id"])
    
    for tweet in tweets.data:
        try:
            cursor.execute("""
                INSERT IGNORE INTO raw_tweets (id, text, username, created_at, lang)
                VALUES (%s, %s, %s, %s, %s)
            """, (
                tweet.id,
                tweet.text,
                str(tweet.author_id),
                tweet.created_at.strftime("%Y-%m-%d %H:%M:%S"),
                tweet.lang
            ))
        except Exception as e:
            print(f"Error saving tweet {tweet.id}: {e}")

    conn.commit()
    print("Tweets fetched and saved.")

if __name__ == "__main__":
    fetch_and_store_tweets()
    conn.close()

