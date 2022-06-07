{{
    config(
        unique_key="ID_PROVINCIA"
    )
}}

select 
    ID_PROVINCIA,
    CODIGO,
    PROVINCIA,
    ID_COMUNIDAD,
    CCAA
from {{ ref('tmp_dim_provincias')}}