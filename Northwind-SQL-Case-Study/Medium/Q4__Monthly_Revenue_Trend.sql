-- Q4: Monthly Revenue Trend

SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    ROUND(
        SUM(
            od.unit_price::numeric * od.quantity::numeric
            - od.discount::numeric
        ),
        2
    ) AS revenue
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
GROUP BY month
ORDER BY month;
