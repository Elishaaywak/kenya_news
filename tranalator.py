# translator.py
from langdetect import detect
from googletrans import Translator

translator = Translator()

def translate_to_english(text):
    try:
        lang = detect(text)
        if lang != 'en':
            return translator.translate(text, dest='en').text
        return text
    except Exception:
        return text  # fallback

