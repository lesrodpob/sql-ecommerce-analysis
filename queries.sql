-- 📊 E-COMMERCE SALES ANALYSIS PROJECT
-- SQL Queries for Data Analysis

-- =========================================
-- 1. Overview of dataset
-- =========================================
SELECT *
FROM sales
LIMIT 10;

-- =========================================
-- 2. Total revenue
-- =========================================
SELECT SUM(quantity * unit_price) AS total_revenue
FROM sales;

-- =========================================
-- 3. Total number of orders
-- =========================================
SELECT COUNT(DISTINCT invoice_no) AS total_orders
FROM sales;

-- =========================================
-- 4. Total unique customers
-- =========================================
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales;

-- =========================================
-- 5. Top 10 customers by total spending
-- =========================================
SELECT customer_id,
       SUM(quantity * unit_price) AS total_spent
FROM sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- =========================================
-- 6. Top 10 best-selling products (by quantity)
-- =========================================
SELECT description,
       SUM(quantity) AS total_units_sold
FROM sales
GROUP BY description
ORDER BY total_units_sold DESC
LIMIT 10;

-- =========================================
-- 7. Top 10 products by revenue
-- =========================================
SELECT description,
       SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY description
ORDER BY revenue DESC
LIMIT 10;

-- =========================================
-- 8. Sales by country
-- =========================================
SELECT country,
       SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY country
ORDER BY revenue DESC;

-- =========================================
-- 9. Monthly sales trend
-- =========================================
SELECT DATE_TRUNC('month', invoice_date) AS month,
       SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY month
ORDER BY month;

-- =========================================
-- 10. Daily sales trend
-- =========================================
SELECT DATE(invoice_date) AS day,
       SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY day
ORDER BY day;

-- =========================================
-- 11. One-time customers
-- =========================================
SELECT customer_id
FROM sales
GROUP BY customer_id
HAVING COUNT(DISTINCT invoice_no) = 1;

-- =========================================
-- 12. Returned or negative quantity products
-- =========================================
SELECT description,
       SUM(quantity) AS total_quantity
FROM sales
WHERE quantity < 0
GROUP BY description
ORDER BY total_quantity ASC;

-- =========================================
-- 13. Average order value
-- =========================================
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT invoice_no,
           SUM(quantity * unit_price) AS order_total
    FROM sales
    GROUP BY invoice_no
) t;
