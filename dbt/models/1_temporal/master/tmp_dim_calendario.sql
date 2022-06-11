{{
    config(
        unique_key="ID_FECHA"
    )
}}

-- depends_on: {{ ref('tmp_fact_casos') }}
-- depends_on: {{ ref('tmp_fact_hospitales') }}
-- depends_on: {{ ref('tmp_fact_residencias') }}

with fechas as(
    SELECT
        0 as min_fecha,
        1 as max_fecha,
        2 as dias_diferencia
)

{%- call statement('fechas', fetch_result=True) -%}

    SELECT 
        MIN(ID_FECHA),
        MAX(ID_FECHA),
        datediff(day, MIN(ID_FECHA), MAX(ID_FECHA)) + 1
    FROM (
        SELECT DISTINCT
            ID_FECHA
        FROM {{ ref('tmp_fact_casos')}}
        UNION
        SELECT DISTINCT
            ID_FECHA
        FROM {{ ref('tmp_fact_hospitales')}}
        UNION
        SELECT DISTINCT
            ID_FECHA
        FROM {{ ref('tmp_fact_residencias')}}
        )
        
{%- endcall -%}

{%- set min_fecha = load_result('fechas')['data'][0][0] -%}

{%- set max_fecha = load_result('fechas')['data'][0][1] -%}

{%- set dias_diferencia = load_result('fechas')['data'][0][2] -%}

SELECT
    DATEADD(DAY,calendario.dias_diferencia,'{{ min_fecha }}') as ID_FECHA,
    YEAR(ID_FECHA) AS "AÑO",
    case
        when MONTH(ID_FECHA)= 1 then 'ENERO'
        when MONTH(ID_FECHA)= 2 then 'FEBRERO'
        when MONTH(ID_FECHA)= 3 then 'MARZO'
        when MONTH(ID_FECHA)= 4 then 'ABRIL'
        when MONTH(ID_FECHA)= 5 then 'MAYO'
        when MONTH(ID_FECHA)= 6 then 'JUNIO'
        when MONTH(ID_FECHA)= 7 then 'JULIO'
        when MONTH(ID_FECHA)= 8 then 'AGOSTO'
        when MONTH(ID_FECHA)= 9 then 'SEPTIEMBRE'
        when MONTH(ID_FECHA)= 10 then 'OCTUBRE'
        when MONTH(ID_FECHA)= 11 then 'NOVIEMBRE'
        else 'DICIEMBRE'
    end AS MES,
    MONTH(ID_FECHA) AS MES_NUMERICO,
    "AÑO"||'-'||MES AS "MES_AÑO",
    "AÑO"||'-'||MES_NUMERICO AS "MES_AÑO_NUMERICO",
    case
        when dayofweekiso(ID_FECHA)= 1 then 'LUNES'
        when dayofweekiso(ID_FECHA)= 2 then 'MARTES'
        when dayofweekiso(ID_FECHA)= 3 then 'MIERCOLES'
        when dayofweekiso(ID_FECHA)= 4 then 'JUEVES'
        when dayofweekiso(ID_FECHA)= 5 then 'VIERNES'
        when dayofweekiso(ID_FECHA)= 6 then 'SABADO'
        else 'DOMINGO'
    end AS DIA_SEMANA,
    case
        when iff(iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7 )>4,
            TRUNCATE((DAY(ID_FECHA)-2+iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7))/7),
            TRUNCATE((DAY(ID_FECHA)-2+iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7))/7+1)) = 0
            then iff(iff(dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7)>0,
                    dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7),
                    (dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7))+7 )>4,
                TO_VARCHAR(TRUNCATE((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-2+iff(dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7)>0,
                    dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7),
                    (dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7))+7))/7))||'ª SEMANA DE '|| case
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 1 then 'ENERO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 2 then 'FEBRERO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 3 then 'MARZO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 4 then 'ABRIL'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 5 then 'MAYO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 6 then 'JUNIO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 7 then 'JULIO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 8 then 'AGOSTO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 9 then 'SEPTIEMBRE'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 10 then 'OCTUBRE'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 11 then 'NOVIEMBRE'
                        else 'DICIEMBRE'
                    end,
                TO_VARCHAR(TRUNCATE((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-2+iff(dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7)>0,
                    dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7),
                    (dayofweekiso(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-((DAY(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))-1)%7))+7))/7+1))||'ª SEMANA DE '|| case
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 1 then 'ENERO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 2 then 'FEBRERO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 3 then 'MARZO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 4 then 'ABRIL'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 5 then 'MAYO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 6 then 'JUNIO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 7 then 'JULIO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 8 then 'AGOSTO'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 9 then 'SEPTIEMBRE'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 10 then 'OCTUBRE'
                        when MONTH(DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA))= 11 then 'NOVIEMBRE'
                        else 'DICIEMBRE'
                    end)
        when (iff(iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7 )>4,
            TRUNCATE((DAY(ID_FECHA)-2+iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7))/7),
            TRUNCATE((DAY(ID_FECHA)-2+iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7))/7+1)) = 5) AND
            dayofweekiso(DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA)))<4
            then iff(iff(dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7)>0,
                    dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7),
                    (dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7))+7 )>4,
                TO_VARCHAR(TRUNCATE((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-2+iff(dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7)>0,
                    dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7),
                    (dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7))+7))/7))||'ª SEMANA DE '|| case
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 1 then 'ENERO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 2 then 'FEBRERO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 3 then 'MARZO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 4 then 'ABRIL'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 5 then 'MAYO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 6 then 'JUNIO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 7 then 'JULIO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 8 then 'AGOSTO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 9 then 'SEPTIEMBRE'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 10 then 'OCTUBRE'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 11 then 'NOVIEMBRE'
                        else 'DICIEMBRE'
                    end,
                TO_VARCHAR(TRUNCATE((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-2+iff(dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7)>0,
                    dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7),
                    (dayofweekiso(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-((DAY(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))-1)%7))+7))/7+1))||'ª SEMANA DE '|| case
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 1 then 'ENERO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 2 then 'FEBRERO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 3 then 'MARZO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 4 then 'ABRIL'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 5 then 'MAYO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 6 then 'JUNIO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 7 then 'JULIO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 8 then 'AGOSTO'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 9 then 'SEPTIEMBRE'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 10 then 'OCTUBRE'
                        when MONTH(DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))))= 11 then 'NOVIEMBRE'
                        else 'DICIEMBRE'
                    end)
        else iff(iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7 )>4,
            TO_VARCHAR(TRUNCATE((DAY(ID_FECHA)-2+iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7))/7))||'ª SEMANA DE '|| case
                    when MONTH(ID_FECHA)= 1 then 'ENERO'
                    when MONTH(ID_FECHA)= 2 then 'FEBRERO'
                    when MONTH(ID_FECHA)= 3 then 'MARZO'
                    when MONTH(ID_FECHA)= 4 then 'ABRIL'
                    when MONTH(ID_FECHA)= 5 then 'MAYO'
                    when MONTH(ID_FECHA)= 6 then 'JUNIO'
                    when MONTH(ID_FECHA)= 7 then 'JULIO'
                    when MONTH(ID_FECHA)= 8 then 'AGOSTO'
                    when MONTH(ID_FECHA)= 9 then 'SEPTIEMBRE'
                    when MONTH(ID_FECHA)= 10 then 'OCTUBRE'
                    when MONTH(ID_FECHA)= 11 then 'NOVIEMBRE'
                    else 'DICIEMBRE'
                end,
            TO_VARCHAR(TRUNCATE((DAY(ID_FECHA)-2+iff(dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7)>0,
                dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7),
                (dayofweekiso(ID_FECHA)-((DAY(ID_FECHA)-1)%7))+7))/7+1))||'ª SEMANA DE '|| case
                    when MONTH(ID_FECHA)= 1 then 'ENERO'
                    when MONTH(ID_FECHA)= 2 then 'FEBRERO'
                    when MONTH(ID_FECHA)= 3 then 'MARZO'
                    when MONTH(ID_FECHA)= 4 then 'ABRIL'
                    when MONTH(ID_FECHA)= 5 then 'MAYO'
                    when MONTH(ID_FECHA)= 6 then 'JUNIO'
                    when MONTH(ID_FECHA)= 7 then 'JULIO'
                    when MONTH(ID_FECHA)= 8 then 'AGOSTO'
                    when MONTH(ID_FECHA)= 9 then 'SEPTIEMBRE'
                    when MONTH(ID_FECHA)= 10 then 'OCTUBRE'
                    when MONTH(ID_FECHA)= 11 then 'NOVIEMBRE'
                    else 'DICIEMBRE'
                end
        )
    end AS SEMANA_MES,
    DAY(ID_FECHA) AS DIA,
    'T'||QUARTER(ID_FECHA) AS TRIMESTRE,
    "AÑO"||'-'||TRIMESTRE AS "TRIMESTRE_AÑO",
    weekiso(ID_FECHA) AS SEMANA
FROM(
    SELECT
        ROW_NUMBER() OVER (ORDER BY 1) - 1 
    FROM TABLE (
        generator(rowcount=>{{ dias_diferencia }}))
    ) calendario(dias_diferencia)

limit 1500