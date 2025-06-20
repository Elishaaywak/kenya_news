# database.py
import mysql.connector
from config import DB_CONFIG

def store_news(text, translated, classification):
    conn = mysql.connector.connect(**DB_CONFIG)
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO news (original_text, translated_text, classification)
        VALUES (%s, %s, %s)
    """, (text, translated, classification))
    conn.commit()
    conn.close()

