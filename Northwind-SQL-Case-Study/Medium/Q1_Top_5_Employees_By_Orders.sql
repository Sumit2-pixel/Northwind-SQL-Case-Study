-- Q1: Top 5 Employees by Total Orders Handled

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    COUNT(o.order_id) AS total_orders
FROM employees e
JOIN orders o
    ON e.employee_id = o.employee_id
GROUP BY
    e.employee_id,
    e.first_name,
    e.last_name
ORDER BY total_orders DESC
LIMIT 5;
