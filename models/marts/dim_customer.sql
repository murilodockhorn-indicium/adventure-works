{{ config(
    materialized = 'table'
) }}

with customers as (
    select 
        CustomerID,
        PersonID,
        StoreID
    from {{ ref('stg_customer') }}
),

persons as (
    select 
        BusinessEntityID,
        FirstName,
        LastName
    from {{ ref('stg_person') }}
),

final as (
    select
        c.CustomerID,
        c.PersonID,
        c.StoreID,
        coalesce(p.FirstName || ' ' || p.LastName, 'Loja/Revenda') as CustomerName
    from customers c
    left join persons p 
        on c.PersonID = p.BusinessEntityID
)

select * from final
    