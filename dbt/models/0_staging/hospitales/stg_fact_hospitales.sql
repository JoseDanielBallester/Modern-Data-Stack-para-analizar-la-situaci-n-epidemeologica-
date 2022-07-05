select distinct
    DATE(RIGHT(Fecha,4)||'-'||RIGHT(LEFT(Fecha,5),2)||'-'||LEFT(Fecha,2)) AS ID_FECHA,
    Unidad,
    COD_CCAA,
    CCAA,
    Cod_Provincia AS ID_PROVINCIA,
    Provincia,
    TOTAL_CAMAS,
    OCUPADAS_COVID_19 AS OCUPADAS_COVID19,
    OCUPADAS_NO_COVID_19 AS OCUPADAS_NOCOVID19,
    INGRESOS_COVID_19 AS INGRESOS_COVID19,
    ALTAS_24_H_COVID_19 AS ALTAS_24H_COVID19,
    Cod_Provincia||Fecha||Unidad AS ID_HOSPITALES
from {{ source('hospitales', 'hospitals') }}
