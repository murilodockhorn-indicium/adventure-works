{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.customer
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS CustomerID,
        CAST(_c1 AS INT) AS PersonID,
        CAST(_c2 AS INT) AS StoreID,
        CAST(_c3 AS INT) AS TerritoryID,
        CAST(_c4 AS STRING) AS AccountNumber,
        CAST(_c5 AS STRING) AS rowguid,
        CAST(_c6 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
