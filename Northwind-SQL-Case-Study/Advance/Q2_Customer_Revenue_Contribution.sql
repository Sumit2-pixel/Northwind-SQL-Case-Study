-- Q2:Calculate Each Customer's Percentage Contribution to the Company's Total Revenue

SELECT
    customer_id,
    revenue,
    total_revenue,
    ROUND(
        (
            revenue::numeric
            / total_revenue::numeric
            * 100
        ),
        2
    ) AS contribution_percent
FROM
(
    SELECT
        t1.customer_id,
        t1.revenue,
        SUM(revenue) OVER() AS total_revenue
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
ORDER BY contribution_percent DESC;

