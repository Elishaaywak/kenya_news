# label_tweets.py
import streamlit as st
import mysql.connector
from config import DB_CONFIG

conn = mysql.connector.connect(**DB_CONFIG)
cursor = conn.cursor(dictionary=True)

st.title("📝 Kenyan Tweet Hate Speech Labeling")

# Get one UNLABELED tweet
cursor.execute("SELECT * FROM raw_tweets WHERE label = 'UNLABELED' LIMIT 1")
tweet = cursor.fetchone()

if tweet:
    st.write(f"**Tweet ID**: {tweet['id']}")
    st.text_area("Tweet Text", tweet['text'], height=100)
    
    label = st.radio("Assign a label:", ('HATE', 'NOT_HATE'))

    if st.button("Submit Label"):
        cursor.execute("UPDATE raw_tweets SET label = %s WHERE id = %s", (label, tweet['id']))
        conn.commit()
        st.success("Label saved! Refresh to get next tweet.")
else:
    st.success("✅ All tweets labeled!")

conn.close()

