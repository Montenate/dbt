{{ config(materialized='view') }}

with source_data as 
    (
        select * from{{source('instacart_dump', 'department')}}
    ),
    department_merge as
    (
        select department_id,
        department
        from source_data
    )
select * from department_merge
