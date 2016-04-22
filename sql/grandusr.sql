REM =============================================
REM SET echo ON feedback on;
REM SPOOL grantusr.log

DEFINE siebel_tablespace  = 'DATA01'
DEFINE index_tablespace   = 'INDEX01'
DEFINE temp_tablespace    = 'TEMP'


REM =============================================
REM Create Role sse_role

CREATE ROLE sse_role;
GRANT CREATE SESSION TO sse_role;


REM =============================================
REM Create Role tblo_role

CREATE ROLE tblo_role;
GRANT ALTER SESSION, CREATE CLUSTER, CREATE INDEXTYPE,
  CREATE OPERATOR, CREATE PROCEDURE, CREATE SEQUENCE, CREATE SESSION,
  CREATE SYNONYM, CREATE TABLE, CREATE TRIGGER, CREATE TYPE, CREATE VIEW,
  CREATE DIMENSION, CREATE MATERIALIZED VIEW, QUERY REWRITE, ON COMMIT REFRESH
TO tblo_role;


REM =============================================
REM Create db accounts for Siebel users

REM A database table owner (DBO) account

CREATE USER SIEBEL IDENTIFIED BY siebel;

ALTER  USER SIEBEL DEFAULT TABLESPACE   &siebel_tablespace;
ALTER  USER SIEBEL TEMPORARY TABLESPACE &temp_tablespace;

ALTER  USER SIEBEL QUOTA UNLIMITED ON &siebel_tablespace;
ALTER  USER SIEBEL QUOTA UNLIMITED ON &index_tablespace;

GRANT tblo_role TO SIEBEL;
GRANT sse_role TO SIEBEL;


REM Siebel administrator database account

CREATE USER SADMIN IDENTIFIED BY sadmin;
ALTER USER SADMIN TEMPORARY TABLESPACE &temp_tablespace;
GRANT sse_role TO SADMIN;


REM A database account for users who are authenticated externally

CREATE USER LDAPUSER IDENTIFIED BY ldapuser;
ALTER USER LDAPUSER TEMPORARY TABLESPACE &temp_tablespace;
GRANT sse_role TO LDAPUSER;


REM HI guest account GUESTCST (customer applications)

CREATE USER GUESTCST IDENTIFIED BY guestcst;
ALTER USER GUESTCST TEMPORARY TABLESPACE &temp_tablespace;
GRANT sse_role TO GUESTCST;


REM SI guest account GUESTCP (Siebel Partner Portal)

CREATE USER GUESTCP IDENTIFIED BY guestcp;
ALTER USER GUESTCP TEMPORARY TABLESPACE &temp_tablespace;
GRANT sse_role TO GUESTCP;


REM guest account GUESTERM (Siebel Financial Services ERM)

CREATE USER GUESTERM IDENTIFIED BY guesterm;
ALTER USER GUESTERM TEMPORARY TABLESPACE &temp_tablespace;
GRANT sse_role to GUESTERM;


REM A seed employee user record for customer users

CREATE USER PROXYE IDENTIFIED BY proxye;
ALTER USER PROXYE TEMPORARY TABLESPACE &temp_tablespace;
GRANT sse_role TO PROXYE;

REM SET echo off feedback off head off;
REM spool off;
exit;
