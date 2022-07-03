{{
    config(
        unique_key="ID_POBLACION_ACTUAL"
    )
}}

select distinct
    Sexo AS SEXO,
    COMUNIDADES_Y_CIUDADES_AUTONOMAS AS COMUNIDADES,
    Provincias AS PROVINCIAS,
    EDAD_HASTA_100_Y_MAS_ AS EDAD,
    REPLACE(Total,'.')::integer AS TOTAL,
    iff(COMUNIDADES is null,'', COMUNIDADES)||iff(PROVINCIAS is null,'', PROVINCIAS)||EDAD||SEXO AS ID_POBLACION_ACTUAL
from {{ source('poblacion', 'actual_population') }}