SELECT
    ID_FECHA_UNION::integer AS ID_FECHA_NUMERICO,
    ID_FECHA::DATE AS ID_FECHA,
    "AÑO"::integer AS "AÑO",
    "SEMANA_MES_AÑO"::varchar AS "SEMANA_MES_AÑO",
    FECHA_SEMANAL::DATE AS FECHA_SEMANAL
FROM {{ ref('tmp_dim_calendario')}}