with demografia_aux as(
    SELECT DISTINCT
        iff(SEXO='H', 'Hombres',iff(SEXO='M', 'Mujeres', 'Sin especificar')) AS SEXO,
        iff(GRUPO_EDAD='NC', 'Sin especificar',GRUPO_EDAD) AS GRUPO_EDAD,
        SEXO||GRUPO_EDAD AS ID_DEMOGRAFIA_AUX
    FROM {{ ref('stg_fact_casos')}}
)

SELECT
    SEXO AS SEXO,
    GRUPO_EDAD AS GRUPO_EDAD,
    iff(GRUPO_EDAD='Sin especificar', 9,left(GRUPO_EDAD,1)) AS GRUPO_EDAD_CODIGO,
    ID_DEMOGRAFIA_AUX AS ID_DEMOGRAFIA_AUX,
    ROW_NUMBER() over (order by SEXO, GRUPO_EDAD_CODIGO asc) AS ID_DEMOGRAFIA
FROM demografia_aux