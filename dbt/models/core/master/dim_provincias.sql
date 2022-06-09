{{
    config(
        unique_key="ID_PROVINCIA"
    )
}}

select 
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    CODIGO::varchar AS CODIGO,
    PROVINCIA::varchar AS PROVINCIA,
    ID_COMUNIDAD::integer AS ID_COMUNIDAD,
    CCAA::varchar AS CCAA
from {{ ref('tmp_dim_provincias')}}