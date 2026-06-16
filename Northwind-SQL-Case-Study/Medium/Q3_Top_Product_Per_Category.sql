-- Q3: Top-Selling Product in Each Category Based on Revenue

WITH product_revenue AS
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
        ) AS revenue
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY
        c.category_name,
        p.product_name
),

ranked_products AS
(
    SELECT
        category_name,
        product_name,
        revenue,
        DENSE_RANK() OVER
        (
            PARTITION BY category_name
            ORDER BY revenue DESC
        ) AS rank
    FROM product_revenue
)

SELECT
    category_name,
    product_name,
    revenue
FROM ranked_products
WHERE rank = 1;
