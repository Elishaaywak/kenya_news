# classify_new_tweets.py
import joblib
import mysql.connector
from config import DB_CONFIG
from deep_translator import GoogleTranslator

# 🔄 Translation
def translate_to_english(text):
    try:
        return GoogleTranslator(source='auto', target='en').translate(text)
    except:
        return text

# 🚀 Load model
model = joblib.load('hate_model.pkl')
vectorizer = joblib.load('vectorizer.pkl')

# 🔌 Connect to DB
conn = mysql.connector.connect(**DB_CONFIG)
cursor = conn.cursor(dictionary=True)

# 📥 Fetch unlabeled tweets
cursor.execute("SELECT id, text, lang FROM raw_tweets WHERE label = 'UNLABELED' LIMIT 50")
tweets = cursor.fetchall()

for tweet in tweets:
    original = tweet['text']
    lang = tweet['lang']
    translated = translate_to_english(original) if lang != 'en' else original

    # Vectorize + predict
    X = vectorizer.transform([translated])
    prediction = model.predict(X)[0]
    label = 'HATE' if prediction == 1 else 'NOT_HATE'

    # Update DB
    cursor.execute(
        "UPDATE raw_tweets SET label = %s, translated_text = %s WHERE id = %s",
        (label, translated, tweet['id'])
    )

conn.commit()
conn.close()
print("✅ Classification complete and database updated.")

