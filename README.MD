# 🏭 Manufacturing KPI Analysis & OEE Dashboard

## 📌 Project Overview

This project focuses on analyzing manufacturing efficiency using key performance indicators (KPIs) such as **Availability, Performance, Quality, and Overall Equipment Effectiveness (OEE)**.

The goal is to identify inefficiencies across machines, shifts, and downtime reasons, and present actionable insights through a professional Power BI dashboard.

---

## 🎯 Objectives

* Analyze machine performance and efficiency
* Identify root causes of low OEE
* Perform downtime analysis
* Build a scalable data model using Star Schema
* Create an interactive Power BI dashboard for decision-making

---

## 🗂️ Project Structure

```
manufacturing_project/
│
├── data/
│   ├── raw/
│   │   └── manufacturing_raw.csv
│   ├── processed/
│   │   └── final_manufacturing_data.csv
│
├── notebook/
│   ├── data_cleaning.ipynb
│   ├── eda_analysis.ipynb
│   └── kpi_calculation.ipynb
│
├── sql/
│   ├── create_tables.sql
│   ├── star_schema.sql
│   └── analysis_queries.sql
│
├── dashboard/
│   └── manufacturing_dashboard.pbix
│
└── README.md
```

---

## ⚙️ Tools & Technologies

* Python (Pandas, NumPy, Matplotlib, Seaborn)
* MySQL (Data storage & querying)
* Power BI (Dashboard & visualization)
* Jupyter Notebook (EDA & analysis)

---

## 🔄 Workflow

### 1️⃣ Data Generation

* Created synthetic manufacturing dataset
* Included missing values and outliers for realism

---

### 2️⃣ Data Cleaning & EDA

* Handled missing values (mean/logic-based imputation)
* Detected and capped outliers
* Performed distribution and skewness analysis
* Visualized missing values and outliers

---

### 3️⃣ KPI Calculation

**Formulas Used:**

* Availability = Operating Time / Planned Production Time
* Performance = (Ideal Cycle Time × Total Production) / Operating Time
* Quality = Good Production / Total Production
* OEE = Availability × Performance × Quality

---

### 4️⃣ Data Validation

* Ensured KPI values are within valid range (0–1)
* Handled anomalies (e.g., OEE > 1)
* Created realistic variation across machines

---

### 5️⃣ SQL Implementation

* Loaded processed data into MySQL
* Performed KPI analysis using SQL queries
* Validated Python results using SQL

---

### 6️⃣ Star Schema Design

**Fact Table:**

* fact_production

**Dimension Tables:**

* dim_machine
* dim_shift
* dim_date
* dim_downtime
* dim_location

This structure improves query performance and supports scalable BI reporting.

---

### 7️⃣ Power BI Dashboard

#### Key Features:

* KPI Cards (OEE, Availability, Performance, Quality)
* OEE by Machine (sorted & dynamic)
* Machine KPI Breakdown (root cause analysis)
* Interactive Filters (Machine, Date, Shift, Downtime, Location)

---

## 📊 Key Insights

* M4 is the best performing machine with highest OEE
* M3 shows lowest OEE due to performance issues
* Downtime is a major contributor to inefficiency
* Shift-based variation impacts overall performance

---

## 🚀 Business Impact

* Helps identify underperforming machines
* Supports data-driven maintenance planning
* Improves operational efficiency
* Enables real-time monitoring through dashboard

---


