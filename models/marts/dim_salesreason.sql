{{ config(catalog = 'workspace') }}

SELECT
    SalesReasonID,
    Name AS ReasonName,
    ReasonType
FROM {{ ref('stg_salesreason') }}