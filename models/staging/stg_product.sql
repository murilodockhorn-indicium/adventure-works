{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.product
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS ProductID,
        CAST(_c1 AS STRING) AS Name,
        CAST(_c2 AS STRING) AS ProductNumber,
        CAST(_c3 AS BOOLEAN) AS MakeFlag,
        CAST(_c4 AS BOOLEAN) AS FinishedGoodsFlag,
        CAST(_c5 AS STRING) AS Color,
        CAST(_c6 AS INT) AS SafetyStockLevel,
        CAST(_c7 AS INT) AS ReorderPoint,
        CAST(_c8 AS DECIMAL(18,4)) AS StandardCost,
        CAST(_c9 AS DECIMAL(18,4)) AS ListPrice,
        CAST(_c10 AS STRING) AS Size,
        CAST(_c11 AS STRING) AS SizeUnitMeasureCode,
        CAST(_c12 AS STRING) AS WeightUnitMeasureCode,
        CAST(_c13 AS DECIMAL(18,2)) AS Weight,
        CAST(_c14 AS INT) AS DaysToManufacture,
        CAST(_c15 AS STRING) AS ProductLine,
        CAST(_c16 AS STRING) AS Class,
        CAST(_c17 AS STRING) AS Style,
        CAST(_c18 AS INT) AS ProductSubcategoryID,
        CAST(_c19 AS INT) AS ProductModelID,
        CAST(_c20 AS TIMESTAMP) AS SellStartDate,
        CAST(_c21 AS TIMESTAMP) AS SellEndDate,
        CAST(_c22 AS TIMESTAMP) AS DiscontinuedDate,
        CAST(_c23 AS STRING) AS rowguid,
        CAST(_c24 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
