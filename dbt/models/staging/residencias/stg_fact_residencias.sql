{{
    config(
        unique_key="ID_RESIDENCIAS"
    )
}}

select
    Fecha,
    Semana,
    CCAA,
    Nun_sem,
    NumCentros,
    NumCasos,
    NumResidentes,
    NumResidentes_COVID,
    NumPlantilla_COVID,
    Fallecidos_COVID,
    NumCentros_R1,
    CentrosCasos_R1,
    NumResidentes_R1,
    NumResidentes_COVID_R1,
    NumPlantilla_COVID_R1,
    Fallecidos_Covid_R1,
    CCAA||Nun_sem AS ID_RESIDENCIAS
from {{ source('residencias', 'residences') }}