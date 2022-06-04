{{
    config(
        unique_key="ID_PROVINCIA"
    )
}}

with comunidades_aux as(
    select distinct
        ID_PROVINCIA::integer AS ID,
        COD_CCAA::integer AS CCAA
    from {{ ref('stg_fact_hospitales')}}
)
select 
    ID::integer AS ID_PROVINCIA,
    CODIGO,
    comunidades_aux.CCAA AS ID_COMUNIDAD
from {{ ref('stg_dim_provincias')}}
left join comunidades_aux using(ID)