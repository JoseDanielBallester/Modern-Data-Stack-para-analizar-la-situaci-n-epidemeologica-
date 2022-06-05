{{
    config(
        unique_key="ID_RESIDENCIAS"
    )
}}

with provincias_aux as(
    select distinct
        case
        when CCAA='ISLAS BALEARES' then 'BALEARS, ILLES'
        when CCAA='ASTURIAS' then  'ASTURIAS, PRINCIPADO DE'
        when CCAA= 'ISLAS CANARIAS'then 'CANARIAS'
        when CCAA= 'CASTILLA LA MANCHA' then'CASTILLA - LA MANCHA'
        when CCAA= 'COMUNIDAD VALENCIANA' then  'COMUNITAT VALENCIANA'
        when CCAA=  'MADRID'then'MADRID, COMUNIDAD DE'
        when CCAA='NAVARRA' then 'NAVARRA, COMUNIDAD FORAL DE'
        when CCAA='LA RIOJA' then 'RIOJA, LA'
        when CCAA='MURCIA' then 'MURCIA, REGIÓN DE'
        else CCAA
    end as CCAA,
        ID_COMUNIDAD
    FROM {{ ref('tmp_dim_provincias')}}
)
select
    DATE(TO_VARCHAR(DATE(SPLIT_PART(SPLIT_PART(Fecha,'al',1),' ',2),'DD/MM/YY'),'YYYY-MM-DD')) as ID_FECHA,
    provincias_aux.ID_COMUNIDAD AS ID_COMUNIDAD,
    NumCentros_R1,
    CentrosCasos_R1,
    NumResidentes_R1,
    NumResidentes_COVID_R1,
    NumPlantilla_COVID_R1,
    Fallecidos_Covid_R1,
    WEEK(ID_FECHA)||YEAR(ID_FECHA)||ID_COMUNIDAD AS ID_RESIDENCIAS
from {{ ref('stg_fact_residencias')}}
left join provincias_aux using(CCAA)