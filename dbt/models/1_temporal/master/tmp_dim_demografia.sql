{{
    config(
        unique_key="ID_DEMOGRAFIA"
    )
}}
SELECT DISTINCT
    iff(SEXO='H', 'Hombres',iff(SEXO='M', 'Mujeres', 'Sin especificar')) AS SEXO,
    iff(GRUPO_EDAD='NC', 'Sin especificar',GRUPO_EDAD) AS GRUPO_EDAD,
    iff(GRUPO_EDAD='NC', 9,left(GRUPO_EDAD,1)) AS GRUPO_EDAD_CODIGO,
    SEXO||GRUPO_EDAD AS ID_DEMOGRAFIA
FROM {{ ref('stg_fact_casos')}}