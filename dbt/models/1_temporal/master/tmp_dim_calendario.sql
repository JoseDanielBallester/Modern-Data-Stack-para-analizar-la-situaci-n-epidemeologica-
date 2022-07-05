-- depends_on: {{ ref('stg_fact_casos') }}
-- depends_on: {{ ref('stg_fact_hospitales') }}
-- depends_on: {{ ref('stg_fact_residencias') }}

with fechas as(
    SELECT
        0 as min_fecha,
        1 as max_fecha,
        2 as dias_diferencia
)

{%- call statement('fechas', fetch_result=True) -%}

    SELECT 
        MIN(ID_FECHA),
        MAX(ID_FECHA),
        datediff(day, MIN(ID_FECHA), MAX(ID_FECHA)) + 1
    FROM (
        SELECT DISTINCT
            ID_FECHA
        FROM {{ ref('stg_fact_casos')}}
        UNION
        SELECT DISTINCT
            ID_FECHA
        FROM {{ ref('stg_fact_hospitales')}}
        UNION
        SELECT DISTINCT
            ID_FECHA
        FROM {{ ref('stg_fact_residencias')}}
        )
        
{%- endcall -%}

{%- set min_fecha = load_result('fechas')['data'][0][0] -%}

{%- set max_fecha = load_result('fechas')['data'][0][1] -%}

{%- set dias_diferencia = load_result('fechas')['data'][0][2] -%}

, calendario as(
    SELECT DISTINCT
        DATEADD(DAY,calendario.dias_diferencia,'{{ min_fecha }}')::DATE as ID_FECHA,
        YEAR(ID_FECHA) AS "AÑO",
        {{ semana_del_mes() }} AS "SEMANA_MES_AÑO",
        ROW_NUMBER() over (order by ID_FECHA asc) AS ID_FECHA_UNION
    FROM(
        SELECT
            ROW_NUMBER() OVER (ORDER BY 1) - 1 
        FROM TABLE (
            generator(rowcount=>{{ dias_diferencia }}))
        ) calendario(dias_diferencia)
)

SELECT DISTINCT
    ID_FECHA,
    "AÑO",
    "SEMANA_MES_AÑO",
    ID_FECHA_UNION,
    residencias_fecha.ID_FECHA AS FECHA_SEMANAL
FROM calendario left join {{ ref('stg_fact_residencias')}} residencias_fecha using(ID_FECHA)
order by ID_FECHA desc
limit 15000