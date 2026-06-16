-- Q5: Country with Highest Revenue

SELECT
    c.country,
    ROUND(
        SUM(
            od.unit_price::numeric * od.quantity::numeric
            - od.discount::numeric
        ),
        2
    ) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
GROUP BY c.country
ORDER BY revenue DESC
LIMIT 1;