{{ config(
    materialized = 'table'
) }}

with stg_salesreason as (
    select
        SalesReasonID,
        Name as ReasonName,
        ReasonType
    from {{ ref('stg_salesreason') }}
)

select * from stg_salesreason