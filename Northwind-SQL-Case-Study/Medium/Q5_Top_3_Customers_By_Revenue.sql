-- Q5: Top 3 Customers by Total Revenue Generated

SELECT
    c.customer_id,
    c.company_name,
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
GROUP BY
    c.customer_id,
    c.company_name
ORDER BY revenue DESC
LIMIT 3;
