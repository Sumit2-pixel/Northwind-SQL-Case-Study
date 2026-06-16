-- Q3:Find Customers Whose Revenue is Above the Average Customer Revenue

SELECT *
FROM
(
    SELECT
        t1.customer_id,
        t1.revenue,
        AVG(revenue) OVER() AS avg_revenue
    FROM
    (
        SELECT
            c.customer_id,
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
        GROUP BY c.customer_id
    ) t1
) t2
WHERE revenue > avg_revenue;
