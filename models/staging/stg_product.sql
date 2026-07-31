{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, 
        _c11, _c12, _c13, _c14, _c15, _c16, _c17, _c18, _c19, 
        _c20, _c21, _c22, _c23, _c24
    from {{ source('adventure_works', 'product') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as ProductID,
        cast(_c1 as string) as Name,
        cast(_c2 as string) as ProductNumber,
        cast(_c3 as boolean) as MakeFlag,
        cast(_c4 as boolean) as FinishedGoodsFlag,
        cast(_c5 as string) as Color,
        cast(_c6 as int) as SafetyStockLevel,
        cast(_c7 as int) as ReorderPoint,
        cast(_c8 as decimal(18,4)) as StandardCost,
        cast(_c9 as decimal(18,4)) as ListPrice,
        cast(_c10 as string) as Size,
        cast(_c11 as string) as SizeUnitMeasureCode,
        cast(_c12 as string) as WeightUnitMeasureCode,
        cast(_c13 as decimal(18,2)) as Weight,
        cast(_c14 as int) as DaysToManufacture,
        cast(_c15 as string) as ProductLine,
        cast(_c16 as string) as Class,
        cast(_c17 as string) as Style,
        cast(_c18 as int) as ProductSubcategoryID,
        cast(_c19 as int) as ProductModelID,
        cast(_c20 as timestamp) as SellStartDate,
        cast(_c21 as timestamp) as SellEndDate,
        cast(_c22 as timestamp) as DiscontinuedDate,
        cast(_c23 as string) as rowguid,
        cast(_c24 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (ProductID).
    -- Mantemos o registro mais recente em caso de duplicidade na origem.
    qualify row_number() over (partition by ProductID order by ModifiedDate desc) = 1
)

select * from deduplicated_data
