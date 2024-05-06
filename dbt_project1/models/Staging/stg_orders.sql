
{{ config(materialized='view') }}

with source_data as 
    (
        select * from{{source('instacart_dump', 'orders')}}
    ),
    order_merge as
    (
        select order_id,
        customer_id,
        order_dow,
        order_hour_of_day,
        days_since_prior_order,
        product_id,
        quantity,
        order_date,
        order_status,
        delivery_date,
        updated_at
        from source_data
    )

select * from order_merge


