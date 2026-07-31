{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, 
        _c11, _c12, _c13, _c14, _c15, _c16, _c17, _c18, _c19, 
        _c20, _c21, _c22, _c23, _c24, _c25
    from {{ source('adventure_works', 'salesorderheader') }}
),

renamed_and_casted as (
    select
        cast(_c0  as int) as SalesOrderID,
        cast(_c1  as int) as RevisionNumber,
        cast(_c2  as timestamp) as OrderDate,
        cast(_c3  as timestamp) as DueDate,
        cast(_c4  as timestamp) as ShipDate,
        cast(_c5  as int) as Status,
        cast(_c6  as boolean) as OnlineOrderFlag,
        cast(_c7  as string) as SalesOrderNumber,
        cast(_c8  as string) as PurchaseOrderNumber,
        cast(_c9  as string) as AccountNumber,
        cast(_c10 as int) as CustomerID,
        cast(_c11 as int) as SalesPersonID,
        cast(_c12 as int) as TerritoryID,
        cast(_c13 as int) as BillToAddressID,
        cast(_c14 as int) as ShipToAddressID,
        cast(_c15 as int) as ShipMethodID,
        cast(_c16 as int) as CreditCardID,
        cast(_c17 as string) as CreditCardApprovalCode,
        cast(_c18 as int) as CurrencyRateID,
        cast(_c19 as decimal(18,4)) as SubTotal,
        cast(_c20 as decimal(18,4)) as TaxAmt,
        cast(_c21 as decimal(18,4)) as Freight,
        cast(_c22 as decimal(18,4)) as TotalDue,
        cast(_c23 as string) as Comment,
        cast(_c24 as string) as rowguid,
        cast(_c25 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (SalesOrderID).
    -- Mantemos o registro mais recente (última modificação) em caso de atualização/duplicidade pelo ERP.
    qualify row_number() over (partition by SalesOrderID order by ModifiedDate desc) = 1
)

select * from deduplicated_data
