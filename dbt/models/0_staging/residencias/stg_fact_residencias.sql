{{
    config(
        unique_key="ID_RESIDENCIAS"
    )
}}

select distinct
    Fecha,
    UPPER(CCAA) AS CCAA,
    NUM_CENTROS AS NumCentros,
    CENTROS_CASOS AS NumCasos,
    NUM_RESIDENTES AS NumResidentes,
    NUM_RESIDENTES_COVID AS NumResidentes_COVID,
    NUM_PLANTILLA_COVID AS NumPlantilla_COVID,
    FALLECIDOS_COVID AS Fallecidos_COVID,
    NUM_CENTROS_R_1 AS NumCentros_R1,
    CENTROS_CASOS_R_1 AS CentrosCasos_R1,
    NUM_RESIDENTES_R_1 AS NumResidentes_R1,
    NUM_RESIDENTES_COVID_R_1 AS NumResidentes_COVID_R1,
    NUM_PLANTILLA_COVID_R_1 AS NumPlantilla_COVID_R1,
    FALLECIDOS_COVID_R_1 AS Fallecidos_Covid_R1,
    CCAA||FECHA AS ID_RESIDENCIAS
from {{ source('residencias', 'residences') }}