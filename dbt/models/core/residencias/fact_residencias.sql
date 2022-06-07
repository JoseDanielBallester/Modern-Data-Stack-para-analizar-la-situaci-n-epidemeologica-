{{
    config(
        unique_key="ID_RESIDENCIAS"
    )
}}

select
    ID_FECHA,
    ID_COMUNIDAD,
    NumCentros_R1,
    CentrosCasos_R1,
    NumResidentes_R1,
    NumResidentes_COVID_R1,
    NumPlantilla_COVID_R1,
    Fallecidos_Covid_R1,
    ID_RESIDENCIAS
from {{ ref('tmp_fact_residencias')}}