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
    SELECT department_id
    FROM {{ref("stg_department")}}
),
aisles AS (
   SELECT aisle_id
   FROM {{ref("stg_aisles")}} 
),
cte AS 
    (SELECT 
        c.customer_id,
        c.age,
        o.order_id,
        o.quantity,
        o.order_dow,
        p.product_id,
        p.unit_price,
        p.unit_cost,
        d.department_id,
        a.aisle_id
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN products p ON p.product_id = o.product_id
    JOIN department d ON d.department_id = p.department_id
    JOIN aisles a ON a.aisle_id = p.aisle_id
)

SELECT * FROM cte
