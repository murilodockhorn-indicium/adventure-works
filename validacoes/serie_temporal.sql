{{ config(
    catalog = 'workspace'
) }}

SELECT
    YEAR(OrderDate) AS Ano,
    MONTH(OrderDate) AS Mes,
    COUNT(DISTINCT SalesOrderID) AS Numero_de_Pedidos,
    SUM(OrderQty) AS Quantidade_Comprada,
    ROUND(SUM(NetAmount), 2) AS Valor_Total_Transacao
FROM {{ ref('fact_sales') }}
GROUP BY 
    YEAR(OrderDate), MONTH(OrderDate)
ORDER BY 
    Ano, Mes