# main.py
from scraper import fetch_kenya_news
from translator import translate_to_english
from classifier import classify
from database import store_news

def run_pipeline():
    tweets = fetch_kenya_news()
    for tweet in tweets:
        translated = translate_to_english(tweet)
        label = classify(translated)
        store_news(tweet, translated, label)

if __name__ == "__main__":
    run_pipeline()

