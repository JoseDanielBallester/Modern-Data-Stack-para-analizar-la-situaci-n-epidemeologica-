{{
    config(
        unique_key="ID_HOSPITALES"
    )
}}

select
    ID_FECHA,
    iff(unidad <> 'Hospitalización convencional', 'UCI','Hospitalización convencional') AS Tipo,
    ID_PROVINCIA,
    SUM(TOTAL_CAMAS) AS TOTAL_CAMAS, 
    SUM(OCUPADAS_COVID19) AS OCUPADAS_COVID19,
    SUM(OCUPADAS_NOCOVID19) AS OCUPADAS_NOCOVID19,
    SUM(INGRESOS_COVID19) AS INGRESOS_COVID19,
    SUM(ALTAS_24H_COVID19) AS ALTAS_24H_COVID19,
    ID_PROVINCIA||ID_FECHA||Tipo AS ID_HOSPITALES
from {{ ref('stg_fact_hospitales')}}
GROUP BY Tipo, ID_PROVINCIA, ID_FECHA
    