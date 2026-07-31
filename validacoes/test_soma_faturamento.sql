{{ config(
    catalog = 'workspace'
) }}

WITH calculo AS (
    SELECT
        ROUND(CAST(SUM(GrossAmount) AS numeric), 2) AS total_calculado
    FROM {{ ref('fact_sales') }}
    WHERE YEAR(OrderDate) = 2011
)

SELECT *
FROM calculo
WHERE total_calculado != 12646112.16