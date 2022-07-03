{{
    config(
        unique_key="ID_CASOS"
    )
}}

select
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    ID_FECHA,
    NUM_CASOS::integer AS NUM_CASOS,
    NUM_HOSP::integer AS NUM_HOSP,
    NUM_UCI::integer AS NUM_UCI,
    NUM_DEF::integer AS NUM_DEF,
    ID_DEMOGRAFIA::varchar AS ID_DEMOGRAFIA,
    ID_CASOS::varchar AS ID_CASOS
from {{ ref('tmp_fact_casos')}}