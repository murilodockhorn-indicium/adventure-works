{{ config(
    materialized = 'table'
) }}

with address as (
    select
        AddressID,
        City,
        StateProvinceID
    from {{ ref('stg_address') }}
),

stateprovince as (
    select
        StateProvinceID,
        CountryRegionCode,
        Name as StateProvinceName -- Renomeamos aqui para evitar conflito
    from {{ ref('stg_stateprovince') }}
),

countryregion as (
    select
        CountryRegionCode,
        Name as CountryRegionName -- Renomeamos aqui para evitar conflito
    from {{ ref('stg_countryregion') }}
),

final as (
    select
        a.AddressID,
        a.City,
        sp.StateProvinceName,
        cr.CountryRegionName
    from address a
    left join stateprovince sp 
        on a.StateProvinceID = sp.StateProvinceID
    left join countryregion cr 
        on sp.CountryRegionCode = cr.CountryRegionCode
)

select * from final