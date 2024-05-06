{{ config(materialized='view') }}

with source_data as 
    (
        select * from{{source('instacart_dump', 'payment')}}
    ),
    payment_merge as
    (
        select payment_id,
        order_id,
        payment_date
        from source_data
    )

select * from payment_merge
