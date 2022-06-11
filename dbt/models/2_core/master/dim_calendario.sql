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
    "MES_AÑO_NUMERICO"::varchar AS "MES_AÑO_NUMERICO",
    DIA_SEMANA::varchar AS DIA_SEMANA,
    SEMANA_MES::varchar AS SEMANA_MES,
    DIA::integer AS DIA,
    TRIMESTRE::varchar AS TRIMESTRE,
    "TRIMESTRE_AÑO"::varchar AS "TRIMESTRE_AÑO",
    SEMANA::integer AS SEMANA
FROM {{ ref('tmp_dim_calendario')}}
limit 1500