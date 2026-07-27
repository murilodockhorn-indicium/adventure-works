{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.address
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS AddressID,
        CAST(_c1 AS STRING) AS AddressLine1,
        CAST(_c2 AS STRING) AS AddressLine2,
        CAST(_c3 AS STRING) AS City,
        CAST(_c4 AS INT) AS StateProvinceID,
        CAST(_c5 AS STRING) AS PostalCode,
        CAST(_c6 AS STRING) AS SpatialLocation,
        CAST(_c7 AS STRING) AS rowguid,
        CAST(_c8 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
