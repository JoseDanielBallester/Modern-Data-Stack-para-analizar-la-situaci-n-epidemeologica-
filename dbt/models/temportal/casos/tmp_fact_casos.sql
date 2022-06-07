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
    iff(SEXO='NC' OR ID_PROVINCIA='NC' OR GRUPO_EDAD='NC', null, provincias_aux.PROVINCIA||GRUPO_EDAD||SEXO||YEAR(ID_FECHA)) AS ID_POBLACION,
    ID_PROVINCIA||GRUPO_EDAD||SEXO||ID_FECHA AS ID_CASOS
from {{ ref('stg_fact_casos')}}
left join provincias_aux using(ID_PROVINCIA)
WHERE (NUM_CASOS<>0 OR NUM_HOSP<>0 OR NUM_UCI<>0 OR NUM_DEF<>0)