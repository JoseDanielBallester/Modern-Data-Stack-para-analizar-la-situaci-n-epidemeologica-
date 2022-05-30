create warehouse transforming;

create database raw;

create database analytics;

create schema raw.covid;

create table cases
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

CREATE FILE FORMAT "RAW"."COVID".CSV TYPE = 'CSV' COMPRESSION = 'AUTO' FIELD_DELIMITER = ','
RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134'
DATE_FORMAT = 'AUTO' TIMESTAMP_FORMAT = 'AUTO' NULL_IF = ('\\N');

create table Hospitals
(
    Fecha date,
    Unidad varchar,
    COD_CCAA integer,
    CAA varchar,
    Cod_Provincia integer,
    Provincia varchar,
    TOTAL_CAMAS integer,
    OCUPADAS_COVID19 integer,
    OCUPADAS_NOCOVID19 integer,
    INGRESOS_COVID19 integer,
    ALTAS_24h_COVID19 integer
    
);

CREATE FILE FORMAT "RAW"."COVID".CVSSEMICOLON COMPRESSION = 'AUTO' FIELD_DELIMITER = ';'
RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134'
TIMESTAMP_FORMAT = 'AUTO' DATE_FORMAT = 'DD/MM/YYYY' NULL_IF = ('\\N') VALIDATE_UTF8=FALSE;AT "RAW"."COVID".CVSSEMICOLON COMPRESSION = 'AUTO' FIELD_DELIMITER = ';' RECORD_DELIMITER = '\n' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE' TRIM_SPACE = FALSE ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE ESCAPE = 'NONE' ESCAPE_UNENCLOSED_FIELD = '\134' TIMESTAMP_FORMAT = 'AUTO' DATE_FORMAT = 'DD/MM/YYYY' NULL_IF = ('\\N') VALIDATE_UTF8=FALSE;