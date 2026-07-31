{{ config(
    materialized = 'table'
) }}

with stg_creditcard as (
    select 
        CreditCardID,
        CardType
        -- Excelente prática: omitimos o CardNumber para proteger os dados sensíveis (PII) dos clientes.
    from {{ ref('stg_creditcard') }}
)

select * from stg_creditcard