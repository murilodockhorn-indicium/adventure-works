{{ config(catalog = 'workspace') }}

SELECT
    ProductID,
    Name AS ProductName,
    ProductNumber,
    MakeFlag,
    FinishedGoodsFlag
FROM {{ ref('stg_product') }}