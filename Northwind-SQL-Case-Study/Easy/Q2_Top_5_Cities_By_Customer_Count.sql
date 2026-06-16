-- Q2: Top 5 Cities by Customer Count

SELECT
    city,
    COUNT(customer_id) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC
LIMIT 5;