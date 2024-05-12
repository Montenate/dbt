{{ config(materialized='view') }}

with source_data as 
    (
        select * from{{source('instacart_dump', 'credit_card')}}
    ),
    credit_card_merge as
    (
        select card_number,
                customer_id,
                card_expiry_date,
                bank_name
        from source_data
    )
select * from credit_card_merge
