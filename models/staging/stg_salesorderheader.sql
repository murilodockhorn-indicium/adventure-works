{{ config(
    catalog = 'workspace'
) }}

WITH source AS (
    SELECT * 
    FROM workspace.adventure_works.salesorderheader
),

renamed AS (
    SELECT
        CAST(_c0  AS INT) AS SalesOrderID,
        CAST(_c1  AS INT) AS RevisionNumber,
        CAST(_c2  AS TIMESTAMP) AS OrderDate,
        CAST(_c3  AS TIMESTAMP) AS DueDate,
        CAST(_c4  AS TIMESTAMP) AS ShipDate,
        CAST(_c5  AS INT) AS Status,
        CAST(_c6  AS BOOLEAN) AS OnlineOrderFlag,
        CAST(_c7  AS STRING) AS SalesOrderNumber,
        CAST(_c8  AS STRING) AS PurchaseOrderNumber,
        CAST(_c9  AS STRING) AS AccountNumber,
        CAST(_c10 AS INT) AS CustomerID,
        CAST(_c11 AS INT) AS SalesPersonID,
        CAST(_c12 AS INT) AS TerritoryID,
        CAST(_c13 AS INT) AS BillToAddressID,
        CAST(_c14 AS INT) AS ShipToAddressID,
        CAST(_c15 AS INT) AS ShipMethodID,
        CAST(_c16 AS INT) AS CreditCardID,
        CAST(_c17 AS STRING) AS CreditCardApprovalCode,
        CAST(_c18 AS INT) AS CurrencyRateID,
        CAST(_c19 AS DECIMAL(18,4)) AS SubTotal,
        CAST(_c20 AS DECIMAL(18,4)) AS TaxAmt,
        CAST(_c21 AS DECIMAL(18,4)) AS Freight,
        CAST(_c22 AS DECIMAL(18,4)) AS TotalDue,
        CAST(_c23 AS STRING) AS Comment,
        CAST(_c24 AS STRING) AS rowguid,
        CAST(_c25 AS TIMESTAMP) AS ModifiedDate
    FROM source
)

SELECT * FROM renamed
