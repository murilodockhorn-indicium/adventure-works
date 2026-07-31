{{ config(
    materialized = 'table'
) }}

with sales_detail as (
    select
        SalesOrderDetailID,
        SalesOrderID,
        ProductID,
        OrderQty,
        UnitPrice,
        UnitPriceDiscount,
        LineTotal
    from {{ ref('stg_salesorderdetail') }}
),

sales_header as (
    select
        SalesOrderID,
        CustomerID,
        CreditCardID,
        BillToAddressID,
        OrderDate,
        DueDate,
        ShipDate,
        Status,
        OnlineOrderFlag
    from {{ ref('stg_salesorderheader') }}
),

sales_reason_agg as (
    select 
        SalesOrderID,
        max(SalesReasonID) as PrimarySalesReasonID
    from {{ ref('stg_salesorderheadersalesreason') }}
    group by SalesOrderID
),

final as (
    select
        -- Chaves (IDs) para plugar nas Dimensões
        d.SalesOrderDetailID,
        h.SalesOrderID,
        h.CustomerID,
        h.CreditCardID,
        h.BillToAddressID as LocationID, 
        d.ProductID,
        r.PrimarySalesReasonID as SalesReasonID,

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
        (d.OrderQty * d.UnitPrice) as GrossAmount,
        
        -- Faturamento Líquido
        (d.OrderQty * d.UnitPrice * (1 - d.UnitPriceDiscount)) as NetAmount
        
    from sales_detail d
    left join sales_header h 
        on d.SalesOrderID = h.SalesOrderID
    left join sales_reason_agg r 
        on h.SalesOrderID = r.SalesOrderID
)

select * from final