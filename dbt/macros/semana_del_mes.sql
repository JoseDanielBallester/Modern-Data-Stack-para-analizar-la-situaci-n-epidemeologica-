{%- macro semana_del_mes() -%}

{%- set ultimo_dia_mes_anterior = 'DATEADD(Day ,-DAY(ID_FECHA), ID_FECHA)' -%}
{%- set primer_dia_mes_siguiente = 'DATEADD(Day,1,DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA)))' -%}
{%- set ultimo_dia_mes = 'DATEADD(Day ,-DAY(DATEADD(week,3,ID_FECHA)), DATEADD(week,3,ID_FECHA))' -%}

case
    when {{ posicion_semana() }} = 0
        then {{ calculo_semana(ultimo_dia_mes_anterior) }}
    when ({{ posicion_semana() }} = 5) AND dayofweekiso({{ ultimo_dia_mes }})<4
        then {{ calculo_semana(primer_dia_mes_siguiente) }}
    else {{ calculo_semana('ID_FECHA') }}
end 
{%- endmacro -%}

{%- macro posicion_semana() -%}
iff({{ posicion_dia_semana('ID_FECHA') }}>4,
        TRUNCATE({{calculo_numero_semana('ID_FECHA')}}),
        TRUNCATE({{calculo_numero_semana('ID_FECHA')}}+1))
{%- endmacro -%}

{%- macro calculo_semana(FECHA) -%}
iff({{ posicion_dia_semana(FECHA) }}>4,
    TO_VARCHAR(TRUNCATE({{calculo_numero_semana(FECHA)}}))||'ª semana de '|| {{numero_en_mes(FECHA)}} || ' de '|| YEAR({{ FECHA }}),
    TO_VARCHAR(TRUNCATE({{calculo_numero_semana(FECHA)}}+1))||'ª semana de '|| {{numero_en_mes(FECHA)}} || ' de '|| YEAR({{ FECHA }})
)
{%- endmacro -%}

{%- macro posicion_dia_semana(DIA) -%}
iff(dayofweekiso({{ DIA }})-((DAY({{ DIA }})-1)%7)>0,
    dayofweekiso({{ DIA }})-((DAY({{ DIA }})-1)%7),
    (dayofweekiso({{ DIA }})-((DAY({{ DIA }})-1)%7))+7)
{%- endmacro -%}

{%- macro calculo_numero_semana(FECHA) -%}
(DAY({{FECHA}})-2+iff(dayofweekiso({{FECHA}})-((DAY({{FECHA}})-1)%7)>0,
            dayofweekiso({{FECHA}})-((DAY({{FECHA}})-1)%7),
            (dayofweekiso({{FECHA}})-((DAY({{FECHA}})-1)%7))+7))/7
{%- endmacro -%}

{%- macro numero_en_mes(numero) -%}
 case
    when MONTH({{ numero }})= 1 then 'Enero'
    when MONTH({{ numero }})= 2 then 'Febrero'
    when MONTH({{ numero }})= 3 then 'Marzo'
    when MONTH({{ numero }})= 4 then 'Abril'
    when MONTH({{ numero }})= 5 then 'Mayo'
    when MONTH({{ numero }})= 6 then 'Junio'
    when MONTH({{ numero }})= 7 then 'Julio'
    when MONTH({{ numero }})= 8 then 'Agosto'
    when MONTH({{ numero }})= 9 then 'Septiembre'
    when MONTH({{ numero }})= 10 then 'Octubre'
    when MONTH({{ numero }})= 11 then 'Noviembre'
    else 'Diciembre'
end
{%- endmacro -%}