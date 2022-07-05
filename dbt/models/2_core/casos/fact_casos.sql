select
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    ID_FECHA_UNION::integer AS ID_FECHA_NUMERICO,
    NUM_CASOS::integer AS NUM_CASOS,
    NUM_HOSP::integer AS NUM_HOSP,
    NUM_UCI::integer AS NUM_UCI,
    NUM_DEF::integer AS NUM_DEF,
    ID_DEMOGRAFIA::integer AS ID_DEMOGRAFIA
from {{ ref('tmp_fact_casos')}}