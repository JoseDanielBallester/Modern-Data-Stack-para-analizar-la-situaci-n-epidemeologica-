{{
    config(
        unique_key="ID_HOSPITALES"
    )
}}

select
    Fecha AS ID_FECHA,
    Unidad,
    COD_CCAA,
    CCAA,
    Cod_Provincia AS ID_PROVINCIA,
    Provincia,
    TOTAL_CAMAS,
    OCUPADAS_COVID19,
    OCUPADAS_NOCOVID19,
    INGRESOS_COVID19,
    ALTAS_24H_COVID19,
    Cod_Provincia||Fecha||Unidad AS ID_HOSPITALES
from {{ source('hospitales', 'hospitals') }}