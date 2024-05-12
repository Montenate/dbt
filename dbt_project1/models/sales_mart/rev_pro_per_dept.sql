{{ config(materialized='view') }}

WITH customers AS (
    SELECT customer_id,
            age
    FROM {{ref("stg_customers")}}
),
orders AS (
    SELECT order_id,
            customer_id,
            product_id,
            quantity,
            order_dow
    FROM {{ref("stg_orders")}}
),
products AS (
    SELECT product_id,
            unit_price,
            unit_cost,
            department_id,
            aisle_id
    FROM {{ref("stg_products")}}
),
department AS (
    SELECT department_id,
            department
    FROM {{ref("stg_department")}}
),
cte AS 
    (SELECT 
        d.department,
        SUM(((p.unit_price - p.unit_cost) * o.quantity)) AS "profit ($)" ,
        SUM((p.unit_price * o.quantity)) AS "revenue ($)"             
    FROM orders o
    JOIN products p ON p.product_id = o.product_id
    JOIN department d ON d.department_id = p.department_id
    GROUP BY 1
)
SELECT * FROM cte