{{
    config(
        unique_key="ID_POBLACION_ACTUAL"
    )
}}

select distinct
    Sexo AS SEXO,
    Comunidades AS COMUNIDADES,
    Provincias AS PROVINCIAS,
    "Edad (hasta 100 y más)" AS EDAD,
    REPLACE(Total,'.')::integer AS TOTAL,
    iff(COMUNIDADES is null,'', COMUNIDADES)||iff(PROVINCIAS is null,'', PROVINCIAS)||EDAD||SEXO AS ID_POBLACION_ACTUAL
from {{ source('poblacion', 'actual_population') }}