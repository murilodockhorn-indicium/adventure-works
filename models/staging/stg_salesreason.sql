{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.salesreason
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS SalesReasonID,
        CAST(_c1 AS STRING) AS Name,
        CAST(_c2 AS STRING) AS ReasonType,
        CAST(_c3 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
