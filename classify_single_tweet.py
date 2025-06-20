import streamlit as st
import joblib
from deep_translator import GoogleTranslator

# Load model/vectorizer
model = joblib.load('hate_model.pkl')
vectorizer = joblib.load('vectorizer.pkl')

def translate(text):
    try:
        return GoogleTranslator(source='auto', target='en').translate(text)
    except:
        return text

st.title("🔍 Tweet Hate Speech Classifier")

tweet = st.text_area("Paste a tweet here", height=100)

if st.button("Classify"):
    translated = translate(tweet)
    vector = vectorizer.transform([translated])
    result = model.predict(vector)[0]
    label = "🟥 HATE SPEECH" if result == 1 else "🟩 NOT HATE"
    st.markdown(f"**Prediction:** {label}")
    st.markdown(f"*Translated:* {translated}")

