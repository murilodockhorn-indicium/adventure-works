{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2
    from {{ source('adventure_works', 'countryregion') }}
),

renamed_and_casted as (
    select
        cast(_c0 as string) as CountryRegionCode,
        cast(_c1 as string) as Name,
        cast(_c2 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (CountryRegionCode).
    -- Mantemos o registro mais recente em caso de duplicidade na origem.
    qualify row_number() over (partition by CountryRegionCode order by ModifiedDate desc) = 1
)

select * from deduplicated_data