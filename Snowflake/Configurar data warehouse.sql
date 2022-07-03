begin;
 
   -- create variables for user / password / role / warehouse / database (needs to be uppercase for objects)
   set role_name = 'ROLE';
   set user_name = 'FIVETRAN';
   set user_password = 'Postre00';
   set warehouse_name = 'FIVETRAN_WAREHOUSE';
   set database_name = 'RAW';

   -- change role to securityadmin for user / role steps
   use role securityadmin;
 
   -- create role for fivetran
   create role if not exists identifier($role_name);
   grant role identifier($role_name) to role SYSADMIN;
 
   -- create a user for fivetran
   create user if not exists identifier($user_name)
   password = $user_password
   default_role = $role_name
   default_warehouse = $warehouse_name;
 
   grant role identifier($role_name) to user identifier($user_name);
 
   -- change role to sysadmin for warehouse / database steps
   use role sysadmin;
 
   -- create a warehouse for fivetran
   create warehouse if not exists identifier($warehouse_name)
   warehouse_size = xsmall
   warehouse_type = standard
   auto_suspend = 60
   auto_resume = true
   initially_suspended = true;
 
   -- create database for fivetran
   create database if not exists identifier($database_name);
 
   -- grant fivetran role access to warehouse
   grant USAGE
   on warehouse identifier($warehouse_name)
   to role identifier($role_name);
 
   -- grant fivetran access to database
   grant CREATE SCHEMA, MONITOR, USAGE
   on database identifier($database_name)
   to role identifier($role_name);

   -- change role to ACCOUNTADMIN for STORAGE INTEGRATION support (only needed for Snowflake on GCP)
   use role ACCOUNTADMIN;
   grant CREATE INTEGRATION on account to role identifier($role_name);
   use role sysadmin;
 
commit; 

create or replace database analytics;
create or replace schema analytics;

-- create role for Tribunal_UBU
create role if not exists identifier('ROLE_TRIBUNAL_UBU');
grant role identifier('ROLE_TRIBUNAL_UBU') to role SYSADMIN;


-- create a user for Tribunal_UBU
create user if not exists identifier('Tribunal_UBU')
password = '1TGJ2[\'n5m}a\'s#'
default_role = 'ROLE_TRIBUNAL_UBU'
default_warehouse = 'COMPUTE_WH';

grant role identifier('ROLE_TRIBUNAL_UBU') to user identifier('Tribunal_UBU');


grant USAGE
on warehouse identifier('COMPUTE_WH')
to role identifier('ROLE_TRIBUNAL_UBU');


grant ALL PRIVILEGES
on database identifier('RAW')
to role identifier('ROLE_TRIBUNAL_UBU');

grant ALL PRIVILEGES
on ALL SCHEMAS IN DATABASE identifier('RAW')
to role identifier('ROLE_TRIBUNAL_UBU');

grant ALL PRIVILEGES
on database identifier('ANALYTICS')
to role identifier('ROLE_TRIBUNAL_UBU');

grant ALL PRIVILEGES
on ALL SCHEMAS IN DATABASE identifier('ANALYTICS')
to role identifier('ROLE_TRIBUNAL_UBU');
