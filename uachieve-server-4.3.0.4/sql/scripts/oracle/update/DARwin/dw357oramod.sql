/*==============================================================*/
/* DARwin Release: DARwin 3.5.7                                 */
/* DBMS name:      Oracle 10g			                        */
/* Created on:     04/03/2007 1:33 PM                           */
/*                                                              */
/* Script name:    dw357oramod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.7 format from a 3.5.6 format      */
/*                                                              */
/* Copyright(c) 2006-2008 Miami University, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/*table alters, add new columns                                 */
/*==============================================================*/


alter table job_queue_subreq
	add stitle varchar2(55);

ALTER TABLE REQ_MAIN
 ADD AUTH_CODE1  VARCHAR2(10);
 
ALTER TABLE REQ_MAIN
 ADD  AUTH_CODE2  VARCHAR2(10);
 
ALTER TABLE STU_EXCEPTIONS
 ADD  AUTH_CODE  VARCHAR2(10);

CREATE TABLE ADV_AUTHCODES(
 ADV_ID CHAR(20) not null CONSTRAINT PK_ADV_AUTHCODES PRIMARY KEY,
 AUTH_CODE VARCHAR(10), 
 CONSTRAINT FK_ADV_AUTH_CDS  FOREIGN KEY(ADV_ID)
 REFERENCES ADV_MASTER(ADV_ID));
 
--Trigger Updated to check for existing :new.int_seq_no (from INB)
--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_master" for table "stu_master"
create or replace trigger tib_stu_master before insert
on stu_master for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stumast_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

IF  :new.last_mod_user IS NULL  or :new.last_mod_date IS NULL  THEN
    :new.last_mod_user := user;
  :new.last_mod_date := sysdate;
END IF;
    
end;
/