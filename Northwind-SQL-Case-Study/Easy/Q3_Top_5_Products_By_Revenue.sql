-- Q3: Top 5 Products by Revenue

SELECT
    p.product_name,
    ROUND(
        SUM(
            od.unit_price::numeric * od.quantity::numeric
            - od.discount::numeric
        ),
        2
    ) AS revenue
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;