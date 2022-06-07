{{
    config(
        unique_key="ID_CASOS"
    )
}}

select
    PROVINCIA_ISO AS ID_PROVINCIA,
    SEXO,
    GRUPO_EDAD,
    FECHA AS ID_FECHA,
    NUM_CASOS,
    NUM_HOSP,
    NUM_UCI,
    NUM_DEF,
    ID_PROVINCIA||GRUPO_EDAD||SEXO||ID_FECHA AS ID_CASOS
from {{ source('casos', 'cases') }}