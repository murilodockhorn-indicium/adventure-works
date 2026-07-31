{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, _c4, _c5, 
        _c6, _c7, _c8, _c9, _c10, _c11, _c12
    from {{ source('adventure_works', 'person') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as BusinessEntityID,
        cast(_c1 as string) as PersonType,
        cast(_c2 as boolean) as NameStyle,
        cast(_c3 as string) as Title,
        cast(_c4 as string) as FirstName,
        cast(_c5 as string) as MiddleName,
        cast(_c6 as string) as LastName,
        cast(_c7 as string) as Suffix,
        cast(_c8 as int) as EmailPromotion,
        cast(_c9 as string) as AdditionalContactInfo,
        cast(_c10 as string) as Demographics,
        cast(_c11 as string) as rowguid,
        cast(_c12 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (BusinessEntityID).
    -- Mantemos o registro mais recente em caso de duplicidade na origem.
    qualify row_number() over (partition by BusinessEntityID order by ModifiedDate desc) = 1
)

select * from deduplicated_data
