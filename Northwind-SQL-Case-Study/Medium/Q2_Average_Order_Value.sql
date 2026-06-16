-- Q2: Average Order Value (AOV)

SELECT
    ROUND(
        AVG(order_revenue),
        2
    ) AS average_order_value
FROM
(
    SELECT
        o.order_id,
        SUM(
            od.unit_price::numeric * od.quantity::numeric
            - od.discount::numeric
        ) AS order_revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    GROUP BY o.order_id
) t1;