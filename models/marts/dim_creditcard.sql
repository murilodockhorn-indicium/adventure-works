{{ config(catalog = 'workspace') }}

SELECT
    CreditCardID,
    CardType
FROM {{ ref('stg_creditcard') }}