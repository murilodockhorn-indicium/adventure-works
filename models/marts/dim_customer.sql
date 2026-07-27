{{ config(catalog = 'workspace') }}

SELECT
    c.CustomerID,
    c.PersonID,
    c.StoreID,
    COALESCE(p.FirstName || ' ' || p.LastName, 'Loja/Revenda') AS CustomerName
FROM {{ ref('stg_customer') }} c
LEFT JOIN {{ ref('stg_person') }} p 
    ON c.PersonID = p.BusinessEntityID
    