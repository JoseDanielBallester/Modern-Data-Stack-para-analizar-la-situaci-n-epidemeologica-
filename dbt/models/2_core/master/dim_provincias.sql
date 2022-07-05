select 
    ID_PROVINCIA::integer AS ID_PROVINCIA,
    PROVINCIA::varchar AS PROVINCIA,
    COMUNIDAD_AUTONOMA::varchar AS CCAA,
    PROVINCIA_COMPLETA::varchar AS PROVINCIA_COMPLETA,
    CAPITAL_CCAA_ID::integer AS CAPITAL_CCAA_ID
from {{ ref('tmp_dim_provincias')}}