{{ config(
    catalog = 'workspace'
) }}

SELECT
    c.CustomerName AS Cliente,
    ROUND(SUM(f.NetAmount), 2) AS Valor_Total_Transacao
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('dim_customer') }} c ON f.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerName
ORDER BY 
    Valor_Total_Transacao DESC