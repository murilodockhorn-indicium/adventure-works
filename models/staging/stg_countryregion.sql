{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.countryregion
),

renamed AS (
    SELECT
        CAST(_c0 AS STRING) AS CountryRegionCode,
        CAST(_c1 AS STRING) AS Name,
        CAST(_c2 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
