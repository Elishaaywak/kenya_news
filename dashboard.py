import streamlit as st
import plotly.express as px
import pandas as pd
import mysql.connector
from config import DB_CONFIG
from wordcloud import WordCloud
import matplotlib.pyplot as plt
import io
import re
from collections import Counter

st.set_page_config(page_title="🇰🇪 Hate Speech Dashboard", layout="wide")
st.title("📊 Kenya Hate Speech Tweet Dashboard")

# 🔌 Connect to DB
try:
    conn = mysql.connector.connect(**DB_CONFIG)
except Exception as e:
    st.error(f"Database connection error: {e}")
    st.stop()

# 📥 Load data
query = """
    SELECT id, text, translated_text, label, lang, username, created_at
    FROM raw_tweets
    WHERE label IN ('HATE', 'NOT_HATE') AND created_at IS NOT NULL
"""
df = pd.read_sql(query, conn)
conn.close()

# 🧹 Clean
df['created_at'] = pd.to_datetime(df['created_at'])
df['date'] = df['created_at'].dt.date

# --------------------------
# 🔍 Sidebar Filters
# --------------------------
st.sidebar.title("🔍 Filters")

langs = df['lang'].dropna().unique().tolist()
users = df['username'].dropna().unique().tolist()

lang_filter = st.sidebar.multiselect("Filter by Language", langs, default=langs)
user_filter = st.sidebar.multiselect("Filter by Username", users, default=users)

min_date = df['date'].min()
max_date = df['date'].max()

if min_date == max_date:
    st.sidebar.markdown(f"🗓️ Date: **{min_date}** (Only one day of data)")
    date_range = (min_date, max_date)
else:
    date_range = st.sidebar.slider("Filter by Date", min_value=min_date, max_value=max_date,
                                   value=(min_date, max_date))


# 🧪 Apply filters
filtered_df = df[
    (df['lang'].isin(lang_filter)) &
    (df['username'].isin(user_filter)) &
    (df['date'] >= date_range[0]) &
    (df['date'] <= date_range[1])
]

# --------------------------
# 📊 Bar Chart: Tweet Trends
# --------------------------
daily_counts = filtered_df.groupby(['date', 'label']).size().reset_index(name='count')
fig_bar = px.bar(
    daily_counts,
    x="date", y="count", color="label",
    barmode="group", title="🗓️ Labeled Tweets Over Time",
    color_discrete_map={'HATE': 'crimson', 'NOT_HATE': 'green'}
)
st.plotly_chart(fig_bar, use_container_width=True)

# 📥 Export Chart
st.download_button(
    label="📸 Export Bar Chart as PNG",
    data=fig_bar.to_image(format="png"),
    file_name="hate_speech_trends.png",
    mime="image/png"
)

# --------------------------
# 🥧 Pie Chart
# --------------------------
label_counts = filtered_df['label'].value_counts().reset_index()
label_counts.columns = ['label', 'count']
fig_pie = px.pie(
    label_counts,
    names='label',
    values='count',
    color='label',
    title="🔄 Tweet Label Distribution",
    color_discrete_map={'HATE': 'crimson', 'NOT_HATE': 'green'}
)
st.plotly_chart(fig_pie, use_container_width=True)

# --------------------------
# ☁️ Word Cloud: HATE Tweets
# --------------------------
st.markdown("### ☁️ Common Words in HATE Tweets")
hate_text = " ".join(filtered_df[filtered_df['label'] == 'HATE']['translated_text'].fillna(''))

if hate_text.strip():
    wc = WordCloud(width=1000, height=300, background_color='white', colormap='Reds').generate(hate_text)
    fig_wc, ax = plt.subplots(figsize=(12, 4))
    ax.imshow(wc, interpolation='bilinear')
    ax.axis('off')

    st.pyplot(fig_wc)

    # Export word cloud as image
    img_buf = io.BytesIO()
    fig_wc.savefig(img_buf, format='png')
    img_buf.seek(0)

    st.download_button("☁️ Export Word Cloud", img_buf, "hate_wordcloud.png", "image/png")
else:
    st.info("No HATE tweets available in filtered results to show word cloud.")

# --------------------------
# 🔖 Top Hashtags
# --------------------------
def extract_hashtags(text):
    return re.findall(r"#\w+", text)

all_hashtags = filtered_df['text'].dropna().apply(extract_hashtags).explode()
top_hashtags = Counter(all_hashtags).most_common(10)

if top_hashtags:
    st.markdown("### 🔖 Top Hashtags")
    st.table(pd.DataFrame(top_hashtags, columns=['Hashtag', 'Count']))
else:
    st.info("No hashtags found in filtered tweets.")

# --------------------------
# 📢 Top Mentions
# --------------------------
def extract_mentions(text):
    return re.findall(r"@\w+", text)

all_mentions = filtered_df['text'].dropna().apply(extract_mentions).explode()
top_mentions = Counter(all_mentions).most_common(10)

if top_mentions:
    st.markdown("### 📢 Top Mentions")
    st.table(pd.DataFrame(top_mentions, columns=['Mention', 'Count']))
else:
    st.info("No mentions found in filtered tweets.")

# --------------------------
# 📋 Table of Tweets
# --------------------------
st.markdown("### 📋 Filtered Tweet Table")

with st.expander("View Labeled Tweets Table"):
    st.dataframe(filtered_df[['id', 'username', 'lang', 'label', 'date', 'text', 'translated_text']])

    # Export CSV
    csv = filtered_df.to_csv(index=False).encode('utf-8')
    st.download_button("📤 Export Filtered Tweets as CSV", csv, "filtered_tweets.csv", "text/csv")

# --------------------------
# 📌 Summary Stats
# --------------------------
st.markdown("### 📌 Summary Statistics")
col1, col2 = st.columns(2)
col1.metric("🟥 Total HATE Tweets", len(filtered_df[filtered_df['label'] == 'HATE']))
col2.metric("🟩 Total NOT_HATE Tweets", len(filtered_df[filtered_df['label'] == 'NOT_HATE']))

