{{ config(
    materialized = 'view'
) }}

with source_data as (
    select 
        _c0, _c1, _c2, _c3, _c4, _c5
    from {{ source('adventure_works', 'creditcard') }}
),

renamed_and_casted as (
    select
        cast(_c0 as int) as CreditCardID,
        cast(_c1 as string) as CardType,
        cast(_c2 as string) as CardNumber,
        cast(_c3 as int) as ExpMonth,
        cast(_c4 as int) as ExpYear,
        cast(_c5 as timestamp) as ModifiedDate
    from source_data
),

deduplicated_data as (
    select 
        *
    from renamed_and_casted
    -- DOCUMENTAÇÃO/SEGURANÇA: Aplicação de dedup para garantir a unicidade da PK (CreditCardID).
    -- Mantemos o registro mais recente em caso de duplicidade na origem.
    qualify row_number() over (partition by CreditCardID order by ModifiedDate desc) = 1
)

select * from deduplicated_data
