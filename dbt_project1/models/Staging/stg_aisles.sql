
{{ config(materialized='view') }}

with source_data as 
    (
        select * from{{source('instacart_dump', 'aisles')}}
    ),
    aisle_merge as
    (
        select aisle_id,
        aisle
        from source_data
    )

select * from aisle_merge


