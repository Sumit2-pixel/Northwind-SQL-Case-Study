-- Q4:Perform Pareto Analysis (80/20 Rule) on Category Revenue Contribution

WITH t1 AS
(
    SELECT
        c.category_name,
        ROUND(
            SUM(
                od.unit_price::numeric * od.quantity::numeric
                - od.discount::numeric
            ),
            2
        ) AS category_revenue
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY c.category_name
),

t2 AS
(
    SELECT
        category_name,
        category_revenue,
        ROUND(
            (
                category_revenue::numeric
                / SUM(category_revenue) OVER()::numeric
                * 100
            ),
            2
        ) AS contribution_percent
    FROM t1
),

t3 AS
(
    SELECT
        category_name,
        contribution_percent,
        SUM(contribution_percent)
        OVER(
            ORDER BY contribution_percent DESC
        ) AS running_total
    FROM t2
)

SELECT *
FROM t3
ORDER BY contribution_percent DESC;
