
{{ config(materialized='view') }}

with source_data as 
    (
        select * from{{source('instacart_dump', 'customers')}}
    ),
    name_merge as
    (
        select customer_id,
        concat(first_name, '  ', last_name) as customer_name,
        email,
        address,
        phone_number,
        country,
        age,
        gender
        from source_data
    )

select * from name_merge


