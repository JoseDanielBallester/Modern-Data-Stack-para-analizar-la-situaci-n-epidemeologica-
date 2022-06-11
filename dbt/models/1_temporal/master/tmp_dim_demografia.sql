{{
    config(
        unique_key="ID_DEMOGRAFIA"
    )
}}
SELECT DISTINCT
    SEXO AS SEXO_ABREVIADO,
    iff(SEXO='H', 'Hombres',iff(SEXO='M', 'Mujeres', 'Sin especificar')) AS SEXO,
    iff(GRUPO_EDAD='NC', 'Sin especificar',GRUPO_EDAD) AS GRUPO_EDAD,
    SEXO||GRUPO_EDAD AS ID_DEMOGRAFIA
FROM {{ ref('stg_fact_casos')}}