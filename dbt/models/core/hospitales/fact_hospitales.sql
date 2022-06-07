{{
    config(
        unique_key="ID_HOSPITALES"
    )
}}

select
    ID_FECHA,
    Tipo,
    ID_PROVINCIA,
    TOTAL_CAMAS, 
    OCUPADAS_COVID19,
    OCUPADAS_NOCOVID19,
    INGRESOS_COVID19,
    ALTAS_24H_COVID19,
    ID_HOSPITALES
from {{ ref('tmp_fact_hospitales')}}