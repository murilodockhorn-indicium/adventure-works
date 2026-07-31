{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2
    from {{ source('adventure_works', 'salesorderheadersalesreason') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as SalesOrderID,
        cast(_c1 as int) as SalesReasonID,
        cast(_c2 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK composta.
    -- Como é uma tabela de relacionamento, validamos a combinação de SalesOrderID e SalesReasonID.
    qualify row_number() over (partition by SalesOrderID, SalesReasonID order by ModifiedDate desc) = 1
)

select * from deduplicated_data
