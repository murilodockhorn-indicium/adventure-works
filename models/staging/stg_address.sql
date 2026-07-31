{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, 
        _c4, _c5, _c6, _c7, _c8
    from {{ source('adventure_works', 'address') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as AddressID,
        cast(_c1 as string) as AddressLine1,
        cast(_c2 as string) as AddressLine2,
        cast(_c3 as string) as City,
        cast(_c4 as int) as StateProvinceID,
        cast(_c5 as string) as PostalCode,
        cast(_c6 as string) as SpatialLocation,
        cast(_c7 as string) as rowguid,
        cast(_c8 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (AddressID).
    -- Caso o ERP envie o mesmo endereço duplicado, mantemos apenas o com a data de modificação mais recente.
    qualify row_number() over (partition by AddressID order by ModifiedDate desc) = 1
)

select * from deduplicated_data