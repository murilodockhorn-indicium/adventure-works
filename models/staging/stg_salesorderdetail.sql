{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.salesorderdetail
),

renamed AS (
    SELECT
        CAST(_c0 AS INT) AS SalesOrderID,
        CAST(_c1 AS INT) AS SalesOrderDetailID,
        CAST(_c2 AS STRING) AS CarrierTrackingNumber,
        CAST(_c3 AS INT) AS OrderQty,
        CAST(_c4 AS INT) AS ProductID,
        CAST(_c5 AS INT) AS SpecialOfferID,
        CAST(_c6 AS DECIMAL(18,4)) AS UnitPrice,
        CAST(_c7 AS DECIMAL(18,4)) AS UnitPriceDiscount,
        CAST(_c8 AS DECIMAL(18,4)) AS LineTotal, 
        
        CAST(_c9 AS STRING) AS rowguid,          
        CAST(_c10 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed