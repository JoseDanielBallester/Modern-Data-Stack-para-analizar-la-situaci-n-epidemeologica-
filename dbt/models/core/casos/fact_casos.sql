{{
    config(
        unique_key="ID_CASOS"
    )
}}

select
    ID_PROVINCIA,
    ID_FECHA,
    NUM_CASOS,
    NUM_HOSP,
    NUM_UCI,
    NUM_DEF,
    ID_POBLACION,
    ID_CASOS
from {{ ref('tmp_fact_casos')}}