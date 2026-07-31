{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, _c4, _c5, 
        _c6, _c7, _c8, _c9, _c10
    from {{ source('adventure_works', 'salesorderdetail') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as SalesOrderID,
        cast(_c1 as int) as SalesOrderDetailID,
        cast(_c2 as string) as CarrierTrackingNumber,
        cast(_c3 as int) as OrderQty,
        cast(_c4 as int) as ProductID,
        cast(_c5 as int) as SpecialOfferID,
        cast(_c6 as decimal(18,4)) as UnitPrice,
        cast(_c7 as decimal(18,4)) as UnitPriceDiscount,
        cast(_c8 as decimal(18,4)) as LineTotal, 
        cast(_c9 as string) as rowguid,          
        cast(_c10 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (SalesOrderDetailID).
    -- Mantemos o registro mais recente em caso de duplicidade na origem.
    qualify row_number() over (partition by SalesOrderDetailID order by ModifiedDate desc) = 1
)

select * from deduplicated_data