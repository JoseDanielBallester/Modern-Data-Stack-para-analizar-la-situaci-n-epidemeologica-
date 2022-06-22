{{
    config(
        unique_key="ID_POBLACION"
    )
}}

-- depends_on: {{ ref('dim_calendario') }}

with fechas as(
    SELECT
        0 as min_fecha,
        1 as max_fecha
)

{%- call statement('fechas', fetch_result=True) -%}

    SELECT 
        MIN("AÑO"),
        MAX("AÑO")
    FROM {{ ref('dim_calendario')}}  

{%- endcall -%}

{%- set min_fecha = load_result('fechas')['data'][0][0] -%}

{%- set max_fecha = load_result('fechas')['data'][0][1] -%}

select
    LEFT(PROVINCIAS,2)::integer AS ID_PROVINCIA,
    FECHA,
    SUM(TOTAL) AS TOTAL,
    LEFT(SEXO,1)||case
        when SPLIT_PART(EDAD,' ',1)= '0-4' or SPLIT_PART(EDAD,' ',1)='5-9' then '0-9'
        {% for number in range(1,8) %}
        when SPLIT_PART(EDAD,' ',1)= '{{number}}0-{{number}}4' or SPLIT_PART(EDAD,' ',1)='{{number}}5-{{number}}9' then '{{number}}0-{{number}}9'
        {% endfor %}
        else '80+'
    end AS ID_DEMOGRAFIA,
    ID_PROVINCIA||ID_DEMOGRAFIA||FECHA AS ID_POBLACION
from {{ ref('stg_fact_poblacion')}}
where provincias <> 'TOTAL ESPAÃA' and EDAD <> 'TOTAL EDADES'
and procedencia ='TOTAL' and SEXO <> 'Ambos sexos'
and FECHA>={{ min_fecha }} and FECHA<={{ max_fecha }}GROUP BY ID_DEMOGRAFIA, ID_PROVINCIA, FECHA