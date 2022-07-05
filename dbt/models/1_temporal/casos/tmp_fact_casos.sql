with provincias_aux as(
    select
        ID_PROVINCIA AS PROVINCIA,
        CODIGO AS ID_PROVINCIA
    FROM {{ ref('tmp_dim_provincias')}}
)

select
    iff(provincias_aux.PROVINCIA is null, 0, provincias_aux.PROVINCIA) AS ID_PROVINCIA,
    ID_FECHA,
    NUM_CASOS,
    NUM_HOSP,
    NUM_UCI,
    NUM_DEF,
    ID_DEMOGRAFIA_AUX,
    calendario_aux.ID_FECHA_UNION AS ID_FECHA_UNION,
    demografia_aux.ID_DEMOGRAFIA AS ID_DEMOGRAFIA,
    ID_PROVINCIA||ID_FECHA||ID_DEMOGRAFIA AS ID_CASOS
from {{ ref('stg_fact_casos')}}
left join provincias_aux using(ID_PROVINCIA)
left join {{ ref('tmp_dim_demografia')}} demografia_aux using(ID_DEMOGRAFIA_AUX)
left join {{ ref('tmp_dim_calendario')}} calendario_aux using(ID_FECHA)