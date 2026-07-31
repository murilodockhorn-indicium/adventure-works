{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, 
        _c4, _c5, _c6
    from {{ source('adventure_works', 'customer') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as CustomerID,
        cast(_c1 as int) as PersonID,
        cast(_c2 as int) as StoreID,
        cast(_c3 as int) as TerritoryID,
        cast(_c4 as string) as AccountNumber,
        cast(_c5 as string) as rowguid,
        cast(_c6 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (CustomerID).
    -- Mantemos o registro mais recente (última atualização) caso o ERP envie o cliente em duplicidade.
    qualify row_number() over (partition by CustomerID order by ModifiedDate desc) = 1
)

select * from deduplicated_data
