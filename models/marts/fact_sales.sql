{{ config(
    catalog = 'workspace'
) }}

WITH sales_detail AS (
    SELECT * FROM {{ ref('stg_salesorderdetail') }}
),

sales_header AS (
    SELECT * FROM {{ ref('stg_salesorderheader') }}
),

-- Trazendo o motivo da venda (Sales Reason)
-- Como um pedido pode ter mais de um motivo, usamos LISTAGG (ou string_agg dependendo do banco) 
-- para não duplicar linhas e bagunçar as métricas financeiras.
sales_reason AS (
    SELECT 
        SalesOrderID,
        MAX(SalesReasonID) AS PrimarySalesReasonID
    FROM {{ ref('stg_salesorderheadersalesreason') }}
    GROUP BY SalesOrderID
)

SELECT
    -- Chaves (IDs) para plugar nas Dimensões
    d.SalesOrderDetailID,
    h.SalesOrderID,
    h.CustomerID,
    h.CreditCardID,
    h.BillToAddressID AS LocationID, -- Chave para a dim_location
    d.ProductID,
    r.PrimarySalesReasonID AS SalesReasonID,

    -- Datas
    h.OrderDate,
    h.DueDate,
    h.ShipDate,

    -- Categorias da Fato
    h.Status,
    h.OnlineOrderFlag,

    -- Métricas (O que vamos somar e fazer médias no BI)
    d.OrderQty,
    d.UnitPrice,
    d.UnitPriceDiscount,
    d.LineTotal,
    -- Faturamento Bruto (Quantidade * Preço Unitário sem considerar desconto)
    (d.OrderQty * d.UnitPrice) AS GrossAmount,
    -- Faturamento Líquido
    (d.OrderQty * d.UnitPrice * (1 - d.UnitPriceDiscount)) AS NetAmount

FROM sales_detail d
LEFT JOIN sales_header h 
    ON d.SalesOrderID = h.SalesOrderID
LEFT JOIN sales_reason r 
    ON h.SalesOrderID = r.SalesOrderID