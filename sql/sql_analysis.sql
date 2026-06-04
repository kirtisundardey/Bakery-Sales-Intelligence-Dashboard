CREATE DATABASE bakery_sales_intelligence;
USE bakery_sales_intelligence;

-- 1. What are the top 10 best-selling bakery products?
SELECT Item,
COUNT(*) AS total_sales
FROM bakery
GROUP BY Item
ORDER BY total_sales DESC
LIMIT 10;


-- 2. Which hour of the day has the highest sales?
SELECT Hour,
COUNT(*) AS total_orders
FROM bakery
GROUP BY Hour
ORDER BY total_orders DESC;


-- 3. Are weekend sales higher than weekday sales?
SELECT weekday_weekend,
COUNT(*) AS total_sales
FROM bakery
GROUP BY weekday_weekend;


-- 4. Which time period generates the most sales?
SELECT period_day,
COUNT(*) AS sales_count
FROM bakery
GROUP BY period_day
ORDER BY sales_count DESC;


-- 5. What are the monthly sales trends?
SELECT Month,
COUNT(*) AS total_sales
FROM bakery
GROUP BY Month
ORDER BY Month;


-- 6. Which products are least sold?
SELECT Item,
COUNT(*) AS total_sales
FROM bakery
GROUP BY Item
ORDER BY total_sales ASC
LIMIT 10;


-- 7. What are the busiest transaction hours on weekends?
SELECT Hour,
COUNT(*) AS total_orders
FROM bakery
WHERE weekday_weekend = 'Weekend'
GROUP BY Hour
ORDER BY total_orders DESC;


-- 8. What is the average number of transactions per day?
SELECT Date,
COUNT(*) AS daily_transactions
FROM bakery
GROUP BY Date;


-- 9. Which products are most popular during the morning?
SELECT Item,
COUNT(*) AS total_sales
FROM bakery
WHERE period_day = 'Morning'
GROUP BY Item
ORDER BY total_sales DESC
LIMIT 10;


-- 10. Which products are most popular during the evening?
SELECT Item,
COUNT(*) AS total_sales
FROM bakery
WHERE period_day = 'Evening'
GROUP BY Item
ORDER BY total_sales DESC
LIMIT 10;


-- 11. Which day type has more product variety?
SELECT weekday_weekend,
COUNT(DISTINCT Item) AS unique_products
FROM bakery
GROUP BY weekday_weekend;


-- 12. What is the total number of unique bakery products sold?
SELECT COUNT(DISTINCT Item) AS unique_products
FROM bakery;


-- 13. Which month recorded the highest sales?
SELECT Month,
COUNT(*) AS total_sales
FROM bakery
GROUP BY Month
ORDER BY total_sales DESC
LIMIT 1;


-- 14. Which hour has the lowest sales activity?
SELECT Hour,
COUNT(*) AS total_sales
FROM bakery
GROUP BY Hour
ORDER BY total_sales ASC
LIMIT 5;


-- 15. Which products are consistently sold across all time periods?
SELECT Item,
COUNT(DISTINCT period_day) AS periods_available
FROM bakery
GROUP BY Item
ORDER BY periods_available DESC;