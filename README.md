# 🛒 Zepto SQL Data Analysis Project

## 📌 Overview

This project analyzes a product dataset from a quick-commerce platform (Zepto-like) using **SQL** in MySQL Workbench.

The goal is to extract **business insights** related to pricing, discounts, inventory, and category performance using structured query language.

---

## 🎯 Business Objectives

* Identify **high revenue categories**
* Discover **best-value products**
* Analyze **discount strategies**
* Detect **inventory inefficiencies**
* Evaluate **pricing patterns**

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

## 🧹 Data Cleaning Steps

* Removed rows with **invalid pricing (MRP = 0)**
* Converted **paise → rupees**
* Removed **duplicate products**
* Handled **NULL values**
* Ensured consistency in numeric fields

---

## 🔍 Exploratory Data Analysis

* Total number of products
* Unique product categories
* Stock availability distribution
* Duplicate product detection

---

## 📊 Key Business Insights

### 💰 Revenue Analysis

* Certain categories contribute significantly more to total revenue.
* High-revenue categories indicate **strong demand and faster turnover**.

---

### 🏷️ Discount Strategy

* Some categories offer consistently higher discounts.
* High discounts may indicate:

  * Competitive markets
  * Overstock clearance

---

### 📦 Inventory Insights

* High-MRP products going out of stock suggest:

  * Strong demand
  * Potential supply chain gaps

---

### ⚖️ Value for Money

* Products with **low price per gram** provide better value.
* Useful for pricing optimization and customer targeting.


### 🔹 Window Functions

* Ranked top products within each category
* Calculated revenue contribution percentage

### 🔹 Common Table Expressions (CTEs)

* Used for cleaner and modular query design

### 🔹 Aggregations

* Revenue, averages, and inventory weight analysis

### 🔹 CASE Statements

* Product segmentation (Low / Medium / Bulk)
---

## ⚡ Performance Optimization

* Created indexes on:

  * `category`
  * `discountedSellingPrice`

This improves query execution speed for large datasets.

---

## 📌 Key Learnings

* Writing **business-focused SQL queries**
* Translating raw data into **actionable insights**
* Using **advanced SQL features** effectively
* Structuring a project like a real-world data analyst

---

## 🧠 Conclusion

This project demonstrates how SQL can be used beyond basic querying to:

* Solve real business problems
* Generate meaningful insights
* Support decision-making

It reflects a **strong foundation in data analysis using SQL** with practical business applications.

---

## 📎 Future Improvements

* Integrate with **Power BI dashboard**
* Add **trend analysis (time-based data)**
* Include **profit margin calculations**
* Build **predictive models**

---

## 👤 Author

**Shivanand Goud Kandhada**
📧 [shivanandgoudkandhada@gmail.com](mailto:shivanandgoudkandhada@gmail.com)
📱 9440821493

---

## ⭐ If you found this useful

Give this repo a ⭐ and feel free to connect!
