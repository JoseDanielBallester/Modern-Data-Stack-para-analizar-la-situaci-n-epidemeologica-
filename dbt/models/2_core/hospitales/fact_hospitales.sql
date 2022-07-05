select
    ID_FECHA_UNION::integer AS ID_FECHA_NUMERICO,
    Tipo::varchar AS TIPO,
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    TOTAL_CAMAS::integer AS TOTAL_CAMAS, 
    OCUPADAS_COVID19::integer AS OCUPADAS_COVID19,
    OCUPADAS_NOCOVID19::integer AS OCUPADAS_NOCOVID19,
    INGRESOS_COVID19::integer AS INGRESOS_COVID19,
    ALTAS_24H_COVID19::integer AS ALTAS_24H_COVID19
from {{ ref('tmp_fact_hospitales')}}