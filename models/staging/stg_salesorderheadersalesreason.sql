{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.salesorderheadersalesreason
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS SalesOrderID,
        CAST(_c1 AS INT) AS SalesReasonID,
        CAST(_c2 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
