/* 
 * ***************************************************************
 * DBMS name:      	ORACLE Version 10g/11i/12c                
 * Created on: 		10/01/2014
 * Last Updated:   	
 * Script name: 	crosswalk_update.sql
 * Purpose:        	Creates or updates Degree Program Crosswalk Table (SZBCCMD) and 
 *                  related database objects.
 * 
 * This script can be run to update the crosswalk table to the current u.achieve 4.2.0 format
 * no matter what state (almost) the table is currently in.  It will even create the table if
 * it does not yet exist.
 * 
 * This script only exists for Oracle database clients.  To date, there has been no need for
 * a Microsoft SQL Server or IBM DB2 equivalent.
 * 
 *  
 * Copyright(c) 2014 CollegeSource, Inc. All Rights Reserved.
 * ***************************************************************
 */

begin
    dbms_output.put_line('Create Crosswalk Table SZBCCMD');
	execute immediate 
			'CREATE TABLE SZBCCMD (
				INT_SEQ_NO				NUMBER			NOT NULL,
  				SZBCCMD_INSTCD         VARCHAR2(20)     NOT NULL,
  				SZBCCMD_DPROG          VARCHAR2(20)     NOT NULL,
  				SZBCCMD_CAMP_CODE      VARCHAR2(20),
  				SZBCCMD_COLL_CODE      VARCHAR2(20),
  				SZBCCMD_DEGC_CODE      VARCHAR2(20),
  				SZBCCMD_MAJR_CODE      VARCHAR2(20),
  				SZBCCMD_CONC_CODE      VARCHAR2(20),
  				SZBCCMD_LEVL_CODE		VARCHAR2(20)     DEFAULT ''UG'',
  				SZBCCMD_ACTIVITY_DATE  DATE              NOT NULL,
  				SZBCCMD_USER           VARCHAR2(20)      NOT NULL,
  				constraint PK_SZBCCMD primary key (INT_SEQ_NO)
			)';

exception
    when others then
        if sqlcode = -955 then
            dbms_output.put_line('szbccmd table already exists.  Skipping create statement.');
        else
            raise;
         end if;
end;
/

begin

    dbms_output.put_line('Add szbccmd_levl_code column to table SZBCCMD');
    execute immediate 'alter table SZBCCMD add (SZBCCMD_LEVL_CODE VARCHAR2(20) DEFAULT ''UG'')';

exception
    when others then
        if sqlcode = -1430 then 
            dbms_output.put_line('szbccmd_levl_code column already exists in szbccmd table.  Skipping alter statement.');
        else
            raise;
        end if;
end;
/

begin

    dbms_output.put_line('Add int_seq_no column to table SZBCCMD');
    execute immediate 'alter table SZBCCMD add (INT_SEQ_NO NUMBER NOT NULL)';

exception
    when others then
        if sqlcode = -1430 then 
            dbms_output.put_line('int_seq_no column already exists in szbccmd table.  Skipping alter statement.');
        else
            raise;
        end if;
end;
/

begin

    dbms_output.put_line('Create sequence and indexes on table SZBCCMD');

    execute immediate 'create sequence szbccmd_seq_no
                        start with 1
                        increment by 1
                        maxvalue 999999999';

    execute immediate 'create index szbccmd_dprog_idx on SZBCCMD (
                        SZBCCMD_INSTCD ASC,
                        SZBCCMD_DPROG ASC)';

    execute immediate 'create index szbccmd_codes_idx on SZBCCMD (
                        SZBCCMD_CAMP_CODE ASC,
                        SZBCCMD_COLL_CODE ASC,
                        SZBCCMD_DEGC_CODE ASC,
                        SZBCCMD_MAJR_CODE ASC,
                        SZBCCMD_LEVL_CODE ASC)';
exception
    when others then
        if sqlcode = -955 then 
            dbms_output.put_line('szbccmd_ sequence or index already exists.  Skipping create statements.');
        else
            raise;
        end if;
end;
/

create or replace trigger tib_szbccmd before insert
on szbccmd for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN	
    select szbccmd_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

if  :new.szbccmd_user IS NULL  or :new.szbccmd_activity_date IS NULL  then
    :new.szbccmd_user := user;
    :new.szbccmd_activity_date := sysdate;
end IF;
    
end;
/

CREATE OR REPLACE TRIGGER tub_szbccmd before update
on szbccmd for each row
begin
    :new.szbccmd_user := user;
    :new.szbccmd_activity_date := sysdate;
end;
/
