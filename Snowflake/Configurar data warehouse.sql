begin;
 
   set role_name = 'ROLE';
   set user_name = 'FIVETRAN';
   --contraseña eliminada por motivos de seguridad
   set user_password = ;
   set warehouse_name = 'FIVETRAN_WAREHOUSE';
   set database_name = 'RAW';

   use role securityadmin;
 
   create role if not exists identifier($role_name);
   grant role identifier($role_name) to role SYSADMIN;
 
   create user if not exists identifier($user_name)
   password = $user_password
   default_role = $role_name
   default_warehouse = $warehouse_name;
 
   grant role identifier($role_name) to user identifier($user_name);
 
   use role sysadmin;
 
   create warehouse if not exists identifier($warehouse_name)
   warehouse_size = xsmall
   warehouse_type = standard
   auto_suspend = 60
   auto_resume = true
   initially_suspended = true;
 
   create database if not exists identifier($database_name);
 
   grant USAGE
   on warehouse identifier($warehouse_name)
   to role identifier($role_name);
 
   grant CREATE SCHEMA, MONITOR, USAGE
   on database identifier($database_name)
   to role identifier($role_name);

   use role ACCOUNTADMIN;
   grant CREATE INTEGRATION on account to role identifier($role_name);
   use role sysadmin;
 
commit; 

create or replace database analytics;
create or replace schema analytics;

create user if not exists identifier('Tribunal_UBU')
--contraseña eliminada por motivos de seguridad
password = ;
default_role = 'ROLE_TRIBUNAL_UBU'
default_warehouse = 'COMPUTE_WH';

grant role ACCOUNTADMIN to user identifier('Tribunal_UBU');

ALTER USER identifier('Tribunal_UBU') SET DEFAULT_ROLE = ACCOUNTADMIN;