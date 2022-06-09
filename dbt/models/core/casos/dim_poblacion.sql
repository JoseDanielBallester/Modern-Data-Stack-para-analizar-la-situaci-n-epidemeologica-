{{
    config(
        unique_key="ID_POBLACION"
    )
}}

SELECT
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    GRUPO_EDAD::varchar AS GRUPO_EDAD,
    SEXO::varchar AS SEXO,
    FECHA::integer AS FECHA,
    TOTAL::integer AS TOTAL,
    ID_POBLACION::varchar AS ID_POBLACION
FROM {{ ref('tmp_dim_poblacion')}}
UNION
SELECT
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    GRUPO_EDAD::varchar AS GRUPO_EDAD,
    SEXO::varchar AS SEXO,
    FECHA::integer AS FECHA,
    TOTAL::integer AS TOTAL,
    ID_POBLACION::varchar AS ID_POBLACION
FROM {{ ref('tmp_dim_poblacion_actual')}}