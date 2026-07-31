{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3
    from {{ source('adventure_works', 'salesreason') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as SalesReasonID,
        cast(_c1 as string) as Name,
        cast(_c2 as string) as ReasonType,
        cast(_c3 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (SalesReasonID).
    -- Mantemos o registro mais recente em caso de duplicidade na origem.
    qualify row_number() over (partition by SalesReasonID order by ModifiedDate desc) = 1
)

select * from deduplicated_data
