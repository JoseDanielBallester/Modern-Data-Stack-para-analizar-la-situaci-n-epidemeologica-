{{
    config(
        unique_key="ID_POBLACION"
    )
}}

select
    Provincias AS PROVINCIAS,
    "Edad (grupos quinquenales)" AS EDAD,
    "Españoles/Extranjeros" AS PROCEDENCIA,
    Sexo AS SEXO,
    "Año" AS FECHA,
    REPLACE(Total,'.')::integer AS TOTAL,
    FECHA||PROVINCIAS||EDAD||PROCEDENCIA||SEXO||FECHA AS ID_POBLACION
from {{ source('master', 'population') }}