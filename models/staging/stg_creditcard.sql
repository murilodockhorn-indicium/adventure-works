{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.creditcard
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS CreditCardID,
        CAST(_c1 AS STRING) AS CardType,
        CAST(_c2 AS STRING) AS CardNumber,
        CAST(_c3 AS INT) AS ExpMonth,
        CAST(_c4 AS INT) AS ExpYear,
        CAST(_c5 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
