{{ config(
    materialized = 'table'
) }}

with stg_product as (
    select
        ProductID,
        Name as ProductName,
        ProductNumber,
        MakeFlag,
        FinishedGoodsFlag
    from {{ ref('stg_product') }}
)

select * from stg_product