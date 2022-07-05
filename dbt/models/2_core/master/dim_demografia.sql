SELECT
    SEXO::varchar AS SEXO,
    GRUPO_EDAD::varchar AS GRUPO_EDAD,
    GRUPO_EDAD_CODIGO::integer AS GRUPO_EDAD_CODIGO,
    ID_DEMOGRAFIA::varchar AS ID_DEMOGRAFIA
FROM {{ ref('tmp_dim_demografia')}}