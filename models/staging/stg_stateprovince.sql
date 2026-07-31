{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, 
        _c4, _c5, _c6, _c7
    from {{ source('adventure_works', 'stateprovince') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as StateProvinceID,
        cast(_c1 as string) as StateProvinceCode,
        cast(_c2 as string) as CountryRegionCode,
        cast(_c3 as boolean) as IsOnlyStateProvinceFlag,
        cast(_c4 as string) as Name,
        cast(_c5 as int) as TerritoryID,
        cast(_c6 as string) as rowguid,
        cast(_c7 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (StateProvinceID).
    -- Mantemos o registro mais recente em caso de duplicidade na origem.
    qualify row_number() over (partition by StateProvinceID order by ModifiedDate desc) = 1
)

select * from deduplicated_data