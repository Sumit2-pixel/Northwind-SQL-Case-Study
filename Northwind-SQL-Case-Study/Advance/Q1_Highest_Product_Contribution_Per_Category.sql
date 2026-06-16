-- Q1:For Each Category, Find the Product that Contributes the Highest Percentage of Revenue Within that Category

WITH t1 AS
(
    SELECT
        c.category_name,
        p.product_name,
        ROUND(
            SUM(
                od.unit_price::numeric * od.quantity::numeric
                - od.discount::numeric
            ),
            2
        ) AS product_revenue
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY
        c.category_name,
        p.product_name
),

t2 AS
(
    SELECT
        category_name,
        SUM(product_revenue) AS category_revenue
    FROM t1
    GROUP BY category_name
),

t3 AS
(
    SELECT
        t1.category_name,
        t1.product_name,
        t1.product_revenue,
        t2.category_revenue,
        ROUND(
            (
                t1.product_revenue::numeric
                / t2.category_revenue::numeric
                * 100
            ),
            2
        ) AS contribution_percent
    FROM t1
    JOIN t2
        ON t1.category_name = t2.category_name
),

t4 AS
(
    SELECT
        category_name,
        product_name,
        contribution_percent,
        DENSE_RANK() OVER
        (
            PARTITION BY category_name
            ORDER BY contribution_percent DESC
        ) AS rank
    FROM t3
)

SELECT
    category_name,
    product_name,
    contribution_percent
FROM t4
WHERE rank = 1;
