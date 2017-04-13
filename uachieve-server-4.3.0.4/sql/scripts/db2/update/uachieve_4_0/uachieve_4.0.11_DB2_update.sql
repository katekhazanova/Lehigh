--==============================================================
-- DBMS name:      DB2       				
-- Created on:     11/24/2009                        
--==============================================================
Alter table CHART_CATEGORIES ADD column FORCE_SCHEMA_INCLUDE char(1)
;

Alter table JOB_QUEUE_REQ ADD column FORCE_SCHEMA_INCLUDE char(1)
;