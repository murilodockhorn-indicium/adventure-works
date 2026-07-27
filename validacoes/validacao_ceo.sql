{{ config(
    catalog = 'workspace'
) }}

SELECT 
    SUM(d.OrderQty * d.UnitPrice) AS Vendas_Brutas_2011,
    SUM(d.OrderQty * d.UnitPrice * (1 - d.UnitPriceDiscount)) AS Vendas_Liquidas_2011
FROM {{ ref('stg_salesorderdetail') }} d
JOIN {{ ref('stg_salesorderheader') }} h 
  ON d.SalesOrderID = h.SalesOrderID
WHERE YEAR(h.OrderDate) = 2011