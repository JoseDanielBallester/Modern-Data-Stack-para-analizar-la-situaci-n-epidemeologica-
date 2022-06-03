{{
    config(
        unique_key="DATE"
    )
}}

SELECT
    DATEADD(DAY,calendario.dias_diferencia,'2020-01-01')::DATE as DATE,
    MONTH(DATE) AS MONTH,
    DAY(DATE) AS DAY,
    YEAR(DATE) AS YEAR
FROM(SELECT ROW_NUMBER() OVER (ORDER BY 1) - 1 FROM TABLE (generator(rowcount=>800))) calendario(dias_diferencia)