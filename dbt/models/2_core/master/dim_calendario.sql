{{
    config(
        unique_key="ID_FECHA"
    )
}}

SELECT
    ID_FECHA::DATE as ID_FECHA,
    "AÑO"::integer AS "AÑO",
    MES::varchar AS MES,
    MES_NUMERICO::integer AS MES_NUMERICO,
    "MES_AÑO"::varchar AS "MES_AÑO",
    "MES_AÑO_NUMERICO"::integer AS "MES_AÑO_NUMERICO",
    DIA_SEMANA::varchar AS DIA_SEMANA,
    DIA::integer AS DIA,
    TRIMESTRE::varchar AS TRIMESTRE,
    "TRIMESTRE_AÑO"::varchar AS "TRIMESTRE_AÑO",
    SEMANA::integer AS SEMANA,
    "SEMANA_MES_AÑO"::varchar AS "SEMANA_MES_AÑO",
    "SEMANA_AÑO"::integer AS "SEMANA_AÑO"

FROM {{ ref('tmp_dim_calendario')}}
limit 1500