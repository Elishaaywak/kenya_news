# train_model.py
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import LinearSVC
import joblib
import mysql.connector
from config import DB_CONFIG
from deep_translator import GoogleTranslator

# 🔁 Translate non-English tweets
def translate_to_english(text):
    try:
        return GoogleTranslator(source='auto', target='en').translate(text)
    except:
        return text

# 📥 Load labeled data
conn = mysql.connector.connect(**DB_CONFIG)
query = "SELECT text, lang, label FROM raw_tweets WHERE label IN ('HATE', 'NOT_HATE')"
df = pd.read_sql(query, conn)
conn.close()

# 🌍 Translate non-English tweets
df['text'] = df['text'].apply(translate_to_english)

# 🎯 Encode labels
df['label'] = df['label'].map({'HATE': 1, 'NOT_HATE': 0})

# ✏️ Train the model
vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(df['text'])
y = df['label']

model = LinearSVC()
model.fit(X, y)

# 💾 Save to disk
joblib.dump(model, 'hate_model.pkl')
joblib.dump(vectorizer, 'vectorizer.pkl')

print("✅ Model training complete. Files saved: hate_model.pkl, vectorizer.pkl")

