# classifier.py
from transformers import pipeline
import joblib

bert_classifier = pipeline("text-classification", model="Davlan/bert-base-multilingual-cased-ner-hrl", tokenizer="bert-base-multilingual-cased")

svm_model = joblib.load("models/trained_model.pkl")  # trained on hate speech dataset

def classify(text):
    result_bert = bert_classifier(text)[0]['label']
    result_svm = svm_model.predict([text])[0]

    # Fusion strategy: weighted vote or if either says hate, classify as hate
    if result_bert == 'LABEL_1' or result_svm == 'HATE':
        return "HATE"
    return "NOT_HATE"

