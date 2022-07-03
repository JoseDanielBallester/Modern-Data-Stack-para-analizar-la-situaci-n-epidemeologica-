{{
    config(
        unique_key="ID_POBLACION"
    )
}}

SELECT
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    FECHA::integer AS FECHA,
    DATE(FECHA||'-01-01') AS FECHA_UNION,
    TOTAL::integer AS TOTAL,
    ID_DEMOGRAFIA::varchar AS ID_DEMOGRAFIA,
    ID_POBLACION::varchar AS ID_POBLACION
    
FROM {{ ref('tmp_fact_poblacion')}}
UNION
SELECT
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    FECHA::integer AS FECHA,
    DATE(FECHA||'-01-01') AS FECHA_UNION,
    TOTAL::integer AS TOTAL,
    ID_DEMOGRAFIA::varchar AS ID_DEMOGRAFIA,
    ID_POBLACION::varchar AS ID_POBLACION
FROM {{ ref('tmp_fact_poblacion_actual')}}

LIMIT 5000