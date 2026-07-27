{{ config(
    catalog = 'workspace'
) }}

{% test soma_faturamento(model, column_name, ano, valor_esperado) %}

WITH calculo AS (
    SELECT 
        ROUND(CAST(SUM({{ column_name }}) AS numeric), 2) AS total_calculado
    FROM {{ model }}
    WHERE YEAR(OrderDate) = {{ ano }}
)

SELECT * 
FROM calculo 
WHERE total_calculado != {{ valor_esperado }}

{% endtest %}