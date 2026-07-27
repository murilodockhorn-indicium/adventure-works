{{ config(
    catalog = 'workspace'
) }}

SELECT 
    l.City AS Cidade,
    l.StateProvinceName AS Estado,
    l.CountryRegionName AS Pais,
    ROUND(SUM(f.NetAmount), 2) AS Faturamento_Liquido
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('dim_location') }} l 
    ON f.LocationID = l.AddressID
GROUP BY 
    l.City, 
    l.StateProvinceName, 
    l.CountryRegionName
ORDER BY 
    Faturamento_Liquido DESC
