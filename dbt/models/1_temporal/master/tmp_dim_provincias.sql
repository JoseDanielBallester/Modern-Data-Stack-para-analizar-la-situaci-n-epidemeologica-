{{
    config(
        unique_key="ID_PROVINCIA"
    )
}}

with comunidades_aux as(
    select distinct
        ID_PROVINCIA::integer AS ID,
        PROVINCIA,
        CCAA,
        COD_CCAA::integer AS CCAA_ID

    from {{ ref('stg_fact_hospitales')}}
)
select 
    ID::integer AS ID_PROVINCIA,
    CODIGO,
    SPLIT_PART(SPLIT_PART(comunidades_aux.PROVINCIA,'/',1),',',1) AS PROVINCIA,
    comunidades_aux.CCAA_ID AS ID_COMUNIDAD,
    comunidades_aux.CCAA AS CCAA,
    CAPITAL_CCAA_ID
from {{ ref('stg_dim_provincias')}}
left join comunidades_aux using(ID)