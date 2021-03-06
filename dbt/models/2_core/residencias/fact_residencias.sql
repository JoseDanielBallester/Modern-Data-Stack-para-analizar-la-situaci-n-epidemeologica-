select
    ID_FECHA_UNION::integer AS ID_FECHA_NUMERICO,
    NumCentros_R1::integer AS NumCentros_R1,
    CentrosCasos_R1::integer AS CentrosCasos_R1,
    NumResidentes_R1::integer AS NumResidentes_R1,
    NumResidentes_COVID_R1::integer AS NumResidentes_COVID_R1,
    NumPlantilla_COVID_R1::integer AS NumPlantilla_COVID_R1,
    Fallecidos_Covid_R1::integer AS Fallecidos_Covid_R1,
    CAPITAL_CCAA_ID::integer AS CAPITAL_CCAA_ID
from {{ ref('tmp_fact_residencias')}}