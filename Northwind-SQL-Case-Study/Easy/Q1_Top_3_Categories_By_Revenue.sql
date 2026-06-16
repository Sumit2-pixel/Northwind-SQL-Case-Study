-- Q1: Top 3 Categories by Revenue

SELECT
    c.category_name,
    ROUND(
        SUM(
            od.unit_price::numeric * od.quantity::numeric
            - od.discount::numeric
        ),
        2
    ) AS revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY c.category_name
ORDER BY revenue DESC
LIMIT 3;