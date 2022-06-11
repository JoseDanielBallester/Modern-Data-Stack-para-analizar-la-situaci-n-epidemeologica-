{{
    config(
        unique_key="ID_CASOS"
    )
}}

with provincias_aux as(
    select
        ID_PROVINCIA AS PROVINCIA,
        CODIGO AS ID_PROVINCIA
    FROM {{ ref('tmp_dim_provincias')}}
)

select
    iff(provincias_aux.PROVINCIA is null, 0, provincias_aux.PROVINCIA) AS ID_PROVINCIA,
    ID_FECHA,
    NUM_CASOS,
    NUM_HOSP,
    NUM_UCI,
    NUM_DEF,
    SEXO||GRUPO_EDAD AS ID_DEMOGRAFIA,
    ID_PROVINCIA||ID_FECHA||ID_DEMOGRAFIA AS ID_CASOS
from {{ ref('stg_fact_casos')}}
left join provincias_aux using(ID_PROVINCIA)