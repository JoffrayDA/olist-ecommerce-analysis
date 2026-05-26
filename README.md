# 🛒 Olist E-Commerce Analysis

End-to-end Business Analyst project on the Brazilian e-commerce dataset Olist (~100K orders, 2016–2018): SQL exploration in DuckDB + 5-page interactive Power BI dashboard.

---

## 🎯 Business Questions

1. What is the revenue trajectory and seasonality?
2. How does Olist perform on delivery logistics across Brazil?
3. Is there a measurable link between delivery time and customer satisfaction?
4. Who are the top sellers and where are they concentrated?

---

## 🛠 Tech Stack

**DuckDB** (SQL engine) · **Python** (query runner) · **Power BI** (dashboard + DAX) · **Git/GitHub**

---

## 📁 Structure

```
├── data/         # 9 raw CSV tables
├── sql/          # 6 analysis queries (exploration → seller perf)
├── dashboard/    # .pbix + screenshots
└── run_query.py  # DuckDB wrapper
```

**Dataset:** [Brazilian E-Commerce by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — 9 tables, ~100K orders, 27 states, ~3K sellers.

---

## 📊 Dashboard Walkthrough

### 1️⃣ General Overview
Executive snapshot: **R$ 16.01M revenue**, **103.89K orders**, **4.09/5 avg rating**, **12.5 days avg delivery**. Surfaces the core tension explored in the rest of the dashboard: solid satisfaction despite Brazil-scale logistics challenges.

### 2️⃣ Revenue Analysis
Monthly revenue trend + MoM variation. Reveals a clear **growth trajectory with November 2017 (Black Friday) as the peak month**.

### 3️⃣ Delivery Analysis
Brazil choropleth map (blue → red gradient) + top slowest states. **The North/Northeast averages 25–29 days vs 12 days in the South-East** — a 2× gap that reveals Olist's structural logistics bottleneck. Olist still beats its own estimates by ~12 days on average (under-promise, over-deliver).

### 4️⃣ Customer Satisfaction
Scatter (delay × score by state) + bar chart by delivery bucket. **The killer insight:** orders delivered in 0–7 days score **4.4/5**; orders delivered in 30+ days drop to **2.5/5** — a 43% satisfaction loss directly tied to logistics. Every state follows this trend individually.

### 5️⃣ Seller Performance
Top 10 sellers by revenue + average revenue by state. **São Paulo alone generates 5× more revenue than the next state**, and the top 4 states (all South-East) dominate the marketplace — which structurally *explains* the Northern delivery problem from Page 3.

---

## 🧠 Key DAX Measures

```dax
Delai_moyen_jours = 
AVERAGEX(
    FILTER(orders, NOT(ISBLANK(orders[order_delivered_customer_date]))),
    DATEDIFF(orders[order_purchase_timestamp], orders[order_delivered_customer_date], DAY)
)

Pct_Retard = 
DIVIDE(
    CALCULATE(COUNTROWS(orders), orders[order_delivered_customer_date] > orders[order_estimated_delivery_date]),
    CALCULATE(COUNTROWS(orders), NOT(ISBLANK(orders[order_delivered_customer_date])))
)

Revenue_Seller = SUM(order_items[price])
```

---

## 📌 Run

```bash
git clone https://github.com/JoffrayDA/olist-ecommerce-analysis.git
cd olist-ecommerce-analysis
pip install duckdb pandas
python run_query.py sql/02_revenue_analysis.sql
# Open dashboard/olist_dashboard.pbix in Power BI Desktop
```
