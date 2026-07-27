{{ config(
    catalog = 'workspace'
) }}

SELECT
    p.ProductName AS Produto,
    MONTH(f.OrderDate) AS Mes,
    YEAR(f.OrderDate) AS Ano,
    l.City AS Cidade,
    l.StateProvinceName AS Estado,
    l.CountryRegionName AS Pais,
    ROUND(SUM(f.NetAmount) / COUNT(DISTINCT f.SalesOrderID), 2) AS Ticket_Medio
FROM {{ ref('fact_sales') }} f
JOIN {{ ref('dim_product') }} p ON f.ProductID = p.ProductID
JOIN {{ ref('dim_location') }} l ON f.LocationID = l.AddressID
GROUP BY 
    p.ProductName, MONTH(f.OrderDate), YEAR(f.OrderDate), 
    l.City, l.StateProvinceName, l.CountryRegionName
ORDER BY 
    Ticket_Medio DESC