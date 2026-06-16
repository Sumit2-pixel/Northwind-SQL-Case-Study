-- Q4: Year with Highest Number of Orders

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_year
ORDER BY total_orders DESC
LIMIT 1;
