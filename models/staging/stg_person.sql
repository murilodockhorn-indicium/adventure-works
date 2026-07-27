{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.person
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS BusinessEntityID,
        CAST(_c1 AS STRING) AS PersonType,
        CAST(_c2 AS BOOLEAN) AS NameStyle,
        CAST(_c3 AS STRING) AS Title,
        CAST(_c4 AS STRING) AS FirstName,
        CAST(_c5 AS STRING) AS MiddleName,
        CAST(_c6 AS STRING) AS LastName,
        CAST(_c7 AS STRING) AS Suffix,
        CAST(_c8 AS INT) AS EmailPromotion,
        CAST(_c9 AS STRING) AS AdditionalContactInfo,
        CAST(_c10 AS STRING) AS Demographics,
        CAST(_c11 AS STRING) AS rowguid,
        CAST(_c12 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
