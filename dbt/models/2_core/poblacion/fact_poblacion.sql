SELECT
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    FECHA::integer AS FECHA,
    TOTAL::integer AS TOTAL,
    ID_DEMOGRAFIA::varchar AS ID_DEMOGRAFIA
FROM {{ ref('tmp_fact_poblacion')}}
UNION
SELECT
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    FECHA::integer AS FECHA,
    TOTAL::integer AS TOTAL,
    ID_DEMOGRAFIA::varchar AS ID_DEMOGRAFIA
FROM {{ ref('tmp_fact_poblacion_actual')}}