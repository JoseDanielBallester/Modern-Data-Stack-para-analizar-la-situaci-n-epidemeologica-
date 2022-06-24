{{
    config(
        unique_key="ID_POBLACION"
    )
}}

select distinct
    Provincias AS PROVINCIAS,
    EDAD_GRUPOS_QUINQUENALES_ AS EDAD,
    ESPANOLES_EXTRANJEROS AS PROCEDENCIA,
    Sexo AS SEXO,
    ANO AS FECHA,
    REPLACE(Total,'.')::integer AS TOTAL,
    FECHA||PROVINCIAS||EDAD||PROCEDENCIA||SEXO||FECHA AS ID_POBLACION
from {{ source('poblacion', 'population') }}