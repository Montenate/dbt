{{ config(materialized='view') }}

with source_data as 
    (
        select * from{{source('instacart_dump', 'products')}}
    ),
    product_merge as
    (
        select product_id,
        product_name,
        aisle_id,
        department_id,
        unit_price,
        unit_cost,
        product_category
        from source_data
    )
select * from product_merge
