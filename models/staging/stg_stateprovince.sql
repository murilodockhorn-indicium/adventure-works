{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.stateprovince
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS StateProvinceID,
        CAST(_c1 AS STRING) AS StateProvinceCode,
        CAST(_c2 AS STRING) AS CountryRegionCode,
        CAST(_c3 AS BOOLEAN) AS IsOnlyStateProvinceFlag,
        CAST(_c4 AS STRING) AS Name,
        CAST(_c5 AS INT) AS TerritoryID,
        CAST(_c6 AS STRING) AS rowguid,
        CAST(_c7 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed