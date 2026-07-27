{{ config(
    catalog = 'workspace'
) }}

SELECT
    l.City AS Cidade,
    ROUND(SUM(f.NetAmount), 2) AS Valor_Total_Transacao
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('dim_location') }} l ON f.LocationID = l.AddressID
GROUP BY 
    l.City
ORDER BY 
    Valor_Total_Transacao DESC