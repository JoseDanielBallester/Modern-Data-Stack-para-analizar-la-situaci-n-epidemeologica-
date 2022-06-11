{{
    config(
        unique_key="ID_DEMOGRAFIA"
    )
}}
SELECT
    SEXO_ABREVIADO::varchar AS SEXO_ABREVIADO,
    SEXO::varchar AS SEXO,
    GRUPO_EDAD::varchar AS GRUPO_EDAD,
    ID_DEMOGRAFIA::varchar AS ID_DEMOGRAFIA
FROM {{ ref('tmp_dim_demografia')}}