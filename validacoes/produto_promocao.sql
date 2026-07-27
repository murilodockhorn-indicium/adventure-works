{{ config(
    catalog = 'workspace'
) }}

SELECT
    p.ProductName AS Produto,
    SUM(f.OrderQty) AS Unidades_Compradas
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('dim_product') }} p ON f.ProductID = p.ProductID
JOIN {{ ref('dim_salesreason') }} sr ON f.SalesReasonID = sr.SalesReasonID
WHERE 
    sr.ReasonName = 'On Promotion'
GROUP BY 
    p.ProductName
ORDER BY 
    Unidades_Compradas DESC