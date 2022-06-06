{{
    config(
        unique_key="ID_POBLACION"
    )
}}

SELECT
    ID_PROVINCIA,
    GRUPO_EDAD,
    SEXO,
    FECHA,
    TOTAL,
    ID_POBLACION
FROM {{ ref('tmp_dim_poblacion')}}
UNION
SELECT
    ID_PROVINCIA,
    GRUPO_EDAD,
    SEXO,
    FECHA,
    TOTAL,
    ID_POBLACION
FROM {{ ref('tmp_dim_poblacion')}}