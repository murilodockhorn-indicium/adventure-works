{{ config(catalog = 'workspace') }}

SELECT
    a.AddressID,
    a.City,
    sp.Name AS StateProvinceName,
    cr.Name AS CountryRegionName
FROM {{ ref('stg_address') }} a
LEFT JOIN {{ ref('stg_stateprovince') }} sp 
    ON a.StateProvinceID = sp.StateProvinceID
LEFT JOIN {{ ref('stg_countryregion') }} cr 
    ON sp.CountryRegionCode = cr.CountryRegionCode
    