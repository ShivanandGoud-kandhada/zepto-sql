-- ============================================
-- 🧠 BUSINESS PROBLEM
-- ============================================
-- Analyze Zepto product dataset to identify:
-- 1. High revenue categories
-- 2. Best-value products
-- 3. Inventory inefficiencies
-- 4. Pricing and discount strategies

-- ============================================
-- 🏗️ TABLE SETUP
-- ============================================

DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto (
    sku_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp DECIMAL(8,2),
    discountPercent DECIMAL(5,2),
    availableQuantity INT,
    discountedSellingPrice DECIMAL(8,2),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

-- ============================================
-- 🔍 DATA EXPLORATION
-- ============================================

-- Total records
SELECT COUNT(*) AS total_rows FROM zepto;

-- Sample data
SELECT * FROM zepto LIMIT 10;

-- Null check
SELECT * FROM zepto
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

-- Unique categories
SELECT DISTINCT category FROM zepto ORDER BY category;

-- Stock availability
SELECT outOfStock, COUNT(*) AS product_count
FROM zepto
GROUP BY outOfStock;

-- Duplicate products
SELECT name, COUNT(*) AS sku_count
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY sku_count DESC;

-- ============================================
-- 🧹 DATA CLEANING
-- ============================================

-- Remove invalid prices
DELETE FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- Convert paise → rupees
UPDATE zepto
SET 
    mrp = mrp / 100,
    discountedSellingPrice = discountedSellingPrice / 100;

-- Remove duplicates (keep lowest sku_id)
DELETE FROM zepto
WHERE sku_id NOT IN (
    SELECT * FROM (
        SELECT MIN(sku_id)
        FROM zepto
        GROUP BY name, category
    ) AS temp
);

-- ============================================
-- ⚡ PERFORMANCE OPTIMIZATION
-- ============================================

CREATE INDEX idx_category ON zepto(category);
CREATE INDEX idx_price ON zepto(discountedSellingPrice);

-- ============================================
-- 📊 DATA ANALYSIS
-- ============================================

-- Q1: Top 10 best-value products
SELECT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Insight:
-- High discount % products attract price-sensitive customers.

-- --------------------------------------------

-- Q2: High MRP but Out of Stock
SELECT name, mrp
FROM zepto
WHERE outOfStock = TRUE AND mrp > 300
ORDER BY mrp DESC;

-- Insight:
-- Expensive products going out of stock indicate strong demand or supply issues.

-- --------------------------------------------

-- Q3: Revenue per category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue DESC;

-- Insight:
-- Categories with highest revenue drive business growth.

-- --------------------------------------------

-- Q4: High price & low discount
SELECT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC;

-- Insight:
-- Premium products rely less on discounting strategy.

-- --------------------------------------------

-- Q5: Top categories by avg discount
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Insight:
-- High discount categories may indicate competitive markets.

-- --------------------------------------------

-- Q6: Price per gram (value analysis)
SELECT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice / weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- Insight:
-- Lower price/gram = better customer value.

-- --------------------------------------------

-- Q7: Product segmentation by weight
SELECT name, weightInGms,
CASE 
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
END AS weight_category
FROM zepto;

-- Insight:
-- Helps in packaging and logistics strategy.

-- --------------------------------------------

-- Q8: Total inventory weight per category
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight DESC;

-- Insight:
-- High inventory weight impacts storage and supply chain cost.

-- ============================================
-- 🚀 ADVANCED SQL (KEY DIFFERENTIATOR)
-- ============================================

-- Q9: Top 3 products per category (Window Function)
SELECT *
FROM (
    SELECT name, category, discountedSellingPrice,
           RANK() OVER (PARTITION BY category ORDER BY discountedSellingPrice DESC) AS rnk
    FROM zepto
) ranked
WHERE rnk <= 3;

-- Insight:
-- Identifies premium products within each category.

-- --------------------------------------------

-- Q10: Revenue contribution per category (Window)
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS revenue,
ROUND(
    SUM(discountedSellingPrice * availableQuantity) * 100.0 /
    SUM(SUM(discountedSellingPrice * availableQuantity)) OVER (),
2) AS revenue_percentage
FROM zepto
GROUP BY category;

-- Insight:
-- Shows which categories dominate total business revenue.

-- --------------------------------------------

-- Q11: Clean data using CTE
WITH clean_data AS (
    SELECT *
    FROM zepto
    WHERE mrp > 0 AND discountedSellingPrice > 0
)
SELECT category, COUNT(*) AS total_products
FROM clean_data
GROUP BY category;

-- Insight:
-- Ensures only valid data is used in analysis.
 