import streamlit as st
import pandas as pd
import plotly.express as px
from prophet import Prophet

# -------------------------------
# PAGE CONFIG
# -------------------------------
st.set_page_config(
    page_title="Bakery Sales Forecasting Dashboard",
    page_icon="📈",
    layout="wide"
)

st.title("📈 Bakery Sales Forecasting Dashboard")

# -------------------------------
# LOAD DATA
# -------------------------------
df = pd.read_csv("data/cleaned/cleaned_bakery_sales.csv")

# Convert datetime
df['date_time'] = pd.to_datetime(df['date_time'])

# -------------------------------
# DAILY SALES
# -------------------------------
daily_sales = (
    df.groupby(df['date_time'].dt.date)
      .size()
      .reset_index(name='sales')
)

daily_sales.columns = ['ds', 'y']

# -------------------------------
# KPI SECTION
# -------------------------------
col1, col2, col3 = st.columns(3)

with col1:
    st.metric(
        "Total Sales",
        f"{daily_sales['y'].sum():,}"
    )

with col2:
    st.metric(
        "Average Daily Sales",
        round(daily_sales['y'].mean(), 2)
    )

with col3:
    st.metric(
        "Highest Daily Sales",
        daily_sales['y'].max()
    )

st.divider()

# -------------------------------
# HISTORICAL SALES CHART
# -------------------------------
st.subheader("Historical Daily Sales")

hist_fig = px.line(
    daily_sales,
    x='ds',
    y='y',
    title='Daily Bakery Sales'
)

st.plotly_chart(hist_fig, use_container_width=True)

st.divider()

# -------------------------------
# FORECASTING
# -------------------------------
st.subheader("Sales Forecast")

forecast_days = st.slider(
    "Select Forecast Days",
    min_value=7,
    max_value=90,
    value=30
)

# Prophet Model
model = Prophet()

model.fit(daily_sales)

future = model.make_future_dataframe(
    periods=forecast_days
)

forecast = model.predict(future)

# -------------------------------
# FORECAST CHART
# -------------------------------
forecast_fig = px.line(
    forecast,
    x='ds',
    y='yhat',
    title=f'{forecast_days}-Day Sales Forecast'
)

st.plotly_chart(
    forecast_fig,
    use_container_width=True
)

st.divider()

# -------------------------------
# FORECAST TABLE
# -------------------------------
st.subheader("Forecasted Sales")

forecast_table = forecast[
    ['ds', 'yhat']
].tail(forecast_days)

forecast_table.columns = [
    'Date',
    'Predicted Sales'
]

st.dataframe(
    forecast_table,
    use_container_width=True
)

# -------------------------------
# DOWNLOAD
# -------------------------------
csv = forecast_table.to_csv(
    index=False
)

st.download_button(
    "Download Forecast CSV",
    csv,
    "data/forecasts/sales_forecast.csv",
    "text/csv"
)
