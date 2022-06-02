create or replace warehouse transforming;

create or replace database raw;

create or replace database analytics;

create or replace schema raw.covid;

create or replace table cases
(
    provincia_iso varchar,
    sexo varchar,
    grupo_edad varchar,
    fecha date,
    num_casos integer,
    num_hosp integer,
    num_uci integer,
    num_def integer
);

create or replace FILE FORMAT "RAW"."COVID".CSV TYPE = 'CSV' COMPRESSION = 'AUTO' FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134'
DATE_FORMAT = 'AUTO' TIMESTAMP_FORMAT = 'AUTO' NULL_IF = ('\\N');
create or replace warehouse transforming;

create or replace database raw;

create or replace database analytics;

create or replace schema raw.covid;

create or replace table cases
(
    provincia_iso varchar,
    sexo varchar,
    grupo_edad varchar,
    fecha date,
    num_casos integer,
    num_hosp integer,
    num_uci integer,
    num_def integer
);

create or replace FILE FORMAT "RAW"."COVID".CSV TYPE = 'CSV' COMPRESSION = 'AUTO' FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134'
DATE_FORMAT = 'AUTO' TIMESTAMP_FORMAT = 'AUTO' NULL_IF = ('\\N') ENCODING = 'ISO-8859-1';

create or replace table Hospitals
(
    Fecha date,
    Unidad varchar,
    COD_CCAA integer,
    CCAA varchar,
    Cod_Provincia integer,
    Provincia varchar,
    TOTAL_CAMAS integer,
    OCUPADAS_COVID19 integer,
    OCUPADAS_NOCOVID19 integer,
    INGRESOS_COVID19 integer,
    ALTAS_24h_COVID19 integer
    
);

create or replace FILE FORMAT "RAW"."COVID".CVSSEMICOLON COMPRESSION = 'AUTO' FIELD_DELIMITER = ';'
RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134'
TIMESTAMP_FORMAT = 'AUTO' DATE_FORMAT = 'DD/MM/YYYY' NULL_IF = ('\\N') ENCODING = 'ISO-8859-1';


create or replace table Residences
(
    Fecha varchar,
    Semana integer,
    CCAA varchar,
    Nun_sem varchar,
    NumCentros integer,
    NumCasos integer,
    NumResidentes integer,
    NumResidentes_COVID integer,
    NumPlantilla_COVID integer,
    Fallecidos_COVID integer,
    NumCentros_R1 integer,
    CentrosCasos_R1 integer,
    NumResidentes_R1 integer,
    NumResidentes_COVID_R1 integer,
    NumPlantilla_COVID_R1 integer,
    Fallecidos_Covid_R1 integer    
);

create or replace FILE FORMAT "RAW"."COVID".CVSNODATE COMPRESSION = 'AUTO' FIELD_DELIMITER = ';'
RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134'
TIMESTAMP_FORMAT = 'AUTO' DATE_FORMAT = 'AUTO' NULL_IF = ('\\N') ENCODING = 'ISO-8859-1';

create or replace table Population
(
    Provincias varchar,
    "Edad (grupos quinquenales)" varchar,
    "Españoles/Extranjeros" varchar,
    Sexo varchar,
    "Año" integer,
    Total varchar
    
);
create or replace table Actual_Population
(

    Sexo varchar,
    "Total Nacional" varchar,
    Comunidades varchar,
    Provincias varchar,
    "Edad (hasta 100 y más)" varchar,
    Total varchar
    
);