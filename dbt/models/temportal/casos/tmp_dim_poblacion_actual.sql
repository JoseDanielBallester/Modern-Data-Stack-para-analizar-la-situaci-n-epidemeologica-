{{
    config(
        unique_key="ID_POBLACION"
    )
}}

with poblacion_actual_aux as( 
    select
        LEFT(SEXO,1) AS SEXO,
        LEFT(PROVINCIAS,2)::integer AS ID_PROVINCIA_AUX,
        LEFT(COMUNIDADES,2)::integer AS ID_COMUNIDAD,
        case
            when SPLIT_PART(EDAD,' ',1)= '0-4' or SPLIT_PART(EDAD,' ',1)='5-9' then '0-9'
            {% for number in range(1,8) %}
            when SPLIT_PART(EDAD,' ',1)= '{{number}}0-{{number}}4' or SPLIT_PART(EDAD,' ',1)='{{number}}5-{{number}}9' then '{{number}}0-{{number}}9'
            {% endfor %}
            else '80+'
        end as GRUPO_EDAD,
        2022 AS FECHA,
        SUM(TOTAL) AS TOTAL
    from {{ ref('stg_dim_poblacion_actual')}}
    WHERE SEXO <> 'Ambos sexos' and ID_COMUNIDAD is not null and EDAD <> 'Total'
    GROUP BY GRUPO_EDAD, ID_PROVINCIA_AUX, ID_COMUNIDAD, SEXO, FECHA
)
, provincias_aux as(
    select
        ID_PROVINCIA,
        ID_COMUNIDAD
    FROM {{ ref('tmp_dim_provincias')}}
    WHERE ID_COMUNIDAD IN (
        SELECT 
            ID_COMUNIDAD
        FROM poblacion_actual_aux
        WHERE ID_PROVINCIA_AUX IS null
    )
)

SELECT
    iff(ID_PROVINCIA_AUX is null, provincias_aux.ID_PROVINCIA, ID_PROVINCIA_AUX) AS ID_PROVINCIA,
    ID_COMUNIDAD,
    GRUPO_EDAD,
    SEXO,
    FECHA,
    TOTAL,
    iff(ID_PROVINCIA_AUX is null, provincias_aux.ID_PROVINCIA, ID_PROVINCIA_AUX)||GRUPO_EDAD||SEXO||FECHA AS ID_POBLACION
FROM poblacion_actual_aux
LEFT JOIN provincias_aux USING(ID_COMUNIDAD)
