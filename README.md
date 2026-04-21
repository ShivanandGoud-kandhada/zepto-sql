# 🛒 Zepto SQL Data Analysis Project

## 📌 Overview

This project performs an end-to-end analysis of a quick-commerce dataset (Zepto-like) using **SQL in MySQL Workbench** to derive actionable business insights.

The analysis focuses on **pricing strategy, discount optimization, inventory management, and revenue generation**.

---

## 🎯 Business Objectives

* Identify **top-performing revenue categories**
* Discover **best-value products for customers**
* Analyze **discount patterns across categories**
* Detect **inventory inefficiencies**
* Evaluate **pricing strategies**

---

## 🗂️ Dataset Description

The dataset contains product-level information:

| Column Name            | Description          |
| ---------------------- | -------------------- |
| sku_id                 | Unique product ID    |
| category               | Product category     |
| name                   | Product name         |
| mrp                    | Maximum Retail Price |
| discountPercent        | Discount percentage  |
| discountedSellingPrice | Final selling price  |
| availableQuantity      | Stock available      |
| weightInGms            | Product weight       |
| outOfStock             | Stock status         |
| quantity               | Units per product    |

---

## ⚙️ Tools & Technologies

* SQL (MySQL)
* MySQL Workbench
* Data Cleaning & Transformation
* Advanced SQL (CTE, Window Functions)

---

## 🧹 Data Cleaning

* Removed records with **invalid pricing (MRP = 0)**
* Converted **paise → rupees**
* Eliminated **duplicate products**
* Handled **NULL values**
* Standardized numeric columns

---

## 🔍 Exploratory Data Analysis

* Total product count and category distribution
* Stock availability analysis
* Duplicate SKU detection
* Category diversity analysis

---

## 📊 Key Business Insights

### 💰 Revenue Analysis

* Certain categories dominate total revenue contribution
* High-revenue categories indicate **strong demand and faster inventory turnover**

---

### 🏷️ Discount Strategy

* Categories with high average discounts suggest:

  * Competitive pricing environments
  * Overstock clearance strategies

---

### 📦 Inventory Insights

* High-MRP products frequently going out of stock indicate:

  * Strong demand
  * Potential supply chain inefficiencies

---

### ⚖️ Value for Money

* Products with lower **price per gram** provide better customer value
* Useful for optimizing pricing and promotional strategies

---

## 📈 Key Results

* 🥇 Top Revenue Category: *(Add your result here)*
* 💸 Highest Discount Category: *(Add your result here)*
* 🛍️ Best Value Product: *(Add your result here)*
* 📦 Inventory Risk Insight: *(Add your finding here)*

---

## 🚀 Advanced SQL Implementation

Below are key advanced SQL queries used:

```sql
-- Top 3 products per category (Window Function)
SELECT *
FROM (
    SELECT name, category, discountedSellingPrice,
           RANK() OVER (PARTITION BY category ORDER BY discountedSellingPrice DESC) AS rank
    FROM zepto
) ranked
WHERE rank <= 3;

-- Revenue contribution percentage
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS revenue,
ROUND(
    SUM(discountedSellingPrice * availableQuantity) * 100.0 /
    SUM(SUM(discountedSellingPrice * availableQuantity)) OVER (),
2) AS revenue_percentage
FROM zepto
GROUP BY category;

-- CTE for clean data analysis
WITH clean_data AS (
    SELECT *
    FROM zepto
    WHERE mrp > 0 AND discountedSellingPrice > 0
)
SELECT category, COUNT(*) 
FROM clean_data
GROUP BY category;
```

---

## ⚡ Performance Optimization

Indexes created on:

* `category`
* `discountedSellingPrice`

This improves query performance for large datasets.

---

## 📁 Project Structure

```
├── data/
├── sql/
│   └── zepto_analysis.sql
├── README.md
```

---

## 📌 Key Learnings

* Writing **business-oriented SQL queries**
* Converting raw data into **actionable insights**
* Using **CTEs and window functions**
* Structuring a real-world data analysis workflow

---

## 🧠 Conclusion

This project demonstrates the ability to:

* Solve real-world business problems using SQL
* Perform structured data analysis
* Generate insights that support decision-making

It reflects **industry-ready SQL and analytical thinking skills**.

---

## 📎 Future Improvements

* Build **Power BI dashboard**
* Perform **time-series analysis**
* Add **profit margin calculations**
* Integrate **Python-based EDA**

---

## 👤 Author

**Shivanand Goud Kandhada**
📧 [shivanandgoudkandhada@gmail.com](mailto:shivanandgoudkandhada@gmail.com)
📱 9440821493

---

## ⭐ If you found this useful

Give this repo a ⭐ and feel free to connect!
