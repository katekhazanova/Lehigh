/*==============================================================*/
/* uAchieve Release: uAchieve 4.0                               */
/* DBMS name:      Oracle                                       */
/* Created on:     7/1/2008 11:14:14 PM                         */
/*                                                              */
/* Script name:    ua40oramod.sql                               */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 uAchieve 4.0  format from a 3.5.8 format     */
/*                                                              */
/* Copyright(c) 2006-2008 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/
truncate table job_queue_accept
/
truncate table job_queue_course
/
commit
/
drop table job_queue_out
/
update job_queue_run set rundate = ''
/
commit
/
alter table job_queue_run modify (rundate date)
/
alter table job_queue_run drop column runtime
/
alter table job_queue_run add  altstuno    char(13)   null
/
alter table job_queue_run add  firstname    varchar2(30)      null
/
alter table job_queue_run add  middlename varchar2(15)           null
/
alter table job_queue_run add  lastname  varchar2(30)  null
/      
alter table job_queue_run add  prefixname  varchar2(4)   null
/
alter table job_queue_run add  suffixname varchar2(6) null
/
alter table job_queue_run add   stuname  varchar2(60)  null
/
alter table job_queue_run add  listall char(1)  null
/
alter table job_queue_run add  teststatus  char(1) null
/
alter table job_queue_run add  report_type  char(3) null
/
alter table job_queue_list add  comkey CHAR(5)
/
alter table job_queue_list add  log_level char(1)
/
alter table job_queue_list add  report_type char(3)
/
alter table job_queue_list add  IGNORE_CACHE    char(1)   null
/
alter table job_queue_detail add  status char(1)
/
alter table job_queue_accept drop constraint PK_JOB_QUEUE_ACCEPT
/
alter table job_queue_accept add  int_seq_no  numeric(9) not null
/
alter table job_queue_accept add constraint  PK_JOB_QUEUE_ACCEPT primary key(int_seq_no)
/
alter table job_queue_accept drop column ctabx
/
alter table job_queue_accept add  user_seq_no  numeric(9) null
/
alter table job_queue_accept add    dept char(15)  null
/
alter table job_queue_accept add     crsno  char(15) null
/
alter table job_queue_accept add   pseudo_flag  char(1)  null
/
alter table job_queue_course drop constraint PK_JOB_QUEUE_COURSE
/
alter table job_queue_course add  int_seq_no  numeric(9) not null
/
alter table job_queue_course add Constraint PK_JOB_QUEUE_COURSE primary key(int_seq_no)
/
alter table job_queue_course drop column etabx
/
alter table job_queue_course add  user_seq_no      numeric(9)  null
/
create   index jobq_course_idx on job_queue_course (jobq_seq_no, rtabx, stabx)
/
alter table stu_exceptions add   auth_code  varchar2(10)  null
/
alter table req_main add   auth_code1  varchar2(10)  null
/
alter table req_main add   auth_code2  varchar2(10)  null
/
alter Table job_queue_req add hideheadtitle char(1)
/
alter Table job_queue_req add hideneedssummary char(1)
/
alter Table job_queue_req add hideselfrmcrs char(1)
/
alter Table job_queue_req add hidemtchdcrs char(1)
/
alter Table job_queue_subreq add hidetitle char(1)
/
alter Table job_queue_subreq add hidesummary char(1)
/
alter Table job_queue_subreq add hideselfrmcrs char(1)
/
alter Table job_queue_subreq add hidestucrs char(1)
/
alter Table job_queue_subreq add stitle varchar2(55)
/

CREATE SEQUENCE JOBQMRK_SEQ_NO
  START WITH 1
  MAXVALUE 999999999
  MINVALUE 1
  CYCLE
  CACHE 20
  NOORDER
  /


CREATE SEQUENCE JOBQEXC_SEQ_NO
  START WITH 1
  MAXVALUE 999999999
  MINVALUE 1
  CYCLE
  CACHE 20
  NOORDER
  /


CREATE SEQUENCE JOBQRPT_SEQ_NO
  START WITH 1
  MAXVALUE 999999999
  MINVALUE 1
  CYCLE
  CACHE 20
  NOORDER
  /
  
create sequence jobqcrs_seq_no
  start with 1
  maxvalue 999999999
  minvalue 1
  cycle
  cache 20
  noorder
  /


create sequence jobqacpt_seq_no
  start with 1
  maxvalue 999999999
  minvalue 1
  cycle
  cache 20
  noorder
  /


create table JOB_QUEUE_MARKERS  (
   INT_SEQ_NO           NUMBER   not null,
   JOBQ_SEQ_NO          NUMBER,
   USER_SEQ_NO          NUMBER,
   RNAME                CHAR(9),
   DRVAL                CHAR(15),
   DRTYPE               CHAR,
   CATLYT               CHAR(6),
   TITLE1               VARCHAR2(80),
   TITLE2               VARCHAR2(80),
   WEBTITLE             VARCHAR2(80),
   constraint PK_J_Q_MARKER primary key (INT_SEQ_NO)
)
/
alter table job_queue_markers
   add constraint FK_JQMRK_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
/
/*==============================================================*/
/* Index: jq_markers_idx                                        */
/*==============================================================*/
create index jq_markers_idx on job_queue_markers (
    jobq_seq_no ASC
)
/
create table JOB_QUEUE_EXCEPTIONS  (
   INT_SEQ_NO           NUMBER                          not null,
   JOBQ_SEQ_NO          NUMBER,
   USER_SEQ_NO          NUMBER,
   CTLCD                CHAR(2),
   ACTION               CHAR,
   RUFLG                CHAR,
   MEMO                 VARCHAR2(255),
   LAST_MOD_USER        VARCHAR2(30),
   LAST_MOD_DATE        DATE,
   constraint PK_J_Q_EXCEPTION primary key (INT_SEQ_NO)
)
/
alter table job_queue_exceptions
   add constraint FK_JQEXC_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
/
/*==============================================================*/
/* Index: jq_exceptions_idx                                        */
/*==============================================================*/
create index jq_exceptions_idx on job_queue_exceptions (
    jobq_seq_no ASC
)
/
create table JOB_QUEUE_REQ_TEXT  (
   JOBQ_SEQ_NO          NUMBER							not null,
   TEXT_TYPE             CHAR                            default 'T' not null,
   RTABX                CHAR(3)							not null,
   TEXT                 NCLOB,
   constraint PK_J_Q_REQ_TEXT primary key (JOBQ_SEQ_NO, TEXT_TYPE, RTABX)
)
/
alter table job_queue_req_text
   add constraint FK_JQRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (JOBQ_SEQ_NO, rtabx)
/
/*==============================================================*/
/* Index: jq_req_text_idx                                        */
/*==============================================================*/
create index jq_req_text_idx on job_queue_req_text (
    jobq_seq_no ASC,
    rtabx ASC
)
/
create table JOB_QUEUE_SUBREQ_TEXT  (
   JOBQ_SEQ_NO          NUMBER							not null,
   TEXT_TYPE             CHAR                           default 'T' not null,
   RTABX                CHAR(3)							not null,
   STABX                CHAR(3)							not null,
   TEXT                 NCLOB,
   constraint PK_J_Q_SUBREQ_TEXT primary key (JOBQ_SEQ_NO, TEXT_TYPE, RTABX, STABX)
)
/
alter table job_queue_subreq_text
   add constraint FK_JQSRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (JOBQ_SEQ_NO, rtabx, stabx)
/
/*==============================================================*/
/* Index: jq_subreq_text_idx                                        */
/*==============================================================*/
create index jq_subreq_text_idx on job_queue_subreq_text (
    jobq_seq_no ASC,
    rtabx ASC,
    stabx ASC
)
/
CREATE TABLE job_queue_report(
	int_seq_no number,
	jobq_seq_no number,
	report_type char(3),
	report blob,
	constraint PK_J_Q_REPORT primary key (int_seq_no)) 
/
alter table job_queue_report
   add constraint FK_JQREP_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
/
/*==============================================================*/
/* Index: jq_report_idx                                        */
/*==============================================================*/
create index jq_report_idx on job_queue_report (
    jobq_seq_no ASC
)
/

CREATE TABLE job_queue_incl_text(
int_seq_no numeric(9, 0),
jobq_seq_no numeric(9, 0),
TEXT_TYPE CHAR(1),
TEXT NCLOB,
CONSTRAINT PK_queue_incl_text
PRIMARY KEY
(INT_SEQ_NO)
)
/

alter table job_queue_incl_text
add constraint FK_JQINCL_REF_JQRUN foreign key (jobq_seq_no)
references job_queue_run (int_seq_no)
/

create sequence jobq_inclt_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    /
/*==============================================================*/
/* Index: jq_incl_text_idx                                        */
/*==============================================================*/
create index jq_incl_text_idx on job_queue_incl_text (
    jobq_seq_no ASC
)
/

create table include_text
(instidq char(2 byte) default ' ' not null,
instid char(8 byte) default ' ' not null,
instcd char(3 byte) default ' ' not null,
text_key varchar2(20) default ' ' not null,
text_type char(1),
text nclob,
last_mod_user varchar2(30 byte),
last_mod_date date)
/

alter table include_text add (
constraint pk_incl_text
primary key
(instidq, instid, instcd, text_key, text_type))
/

/*==============================================================*/
/* Table: current_jobs                                      */
/*==============================================================*/
CREATE TABLE current_jobs(
	instcd 			varchar2(3)  		NOT NULL,
	instid 			varchar2(8)  		NOT NULL,
	instidq 		varchar2(2)  		NOT NULL,
	stuno 			varchar2(15),
	starttime 		TIMESTAMP,
 CONSTRAINT PK_CURRENT_JOBS PRIMARY KEY (instcd, instid , instidq, stuno)
)
/
/*==============================================================*/
/* Table: job_queue_destination                                     */
/*==============================================================*/
CREATE TABLE JOB_QUEUE_DESTINATION(
	JOBID 					char(16)  				NOT NULL,
	USERID 					char(30) 				NOT NULL,
	DESTINATION_URL 		varchar2(255)  			NOT NULL,
	OUTPUT_FORMAT 			char(1),
	SEND_ERROR_COUNT 		INTEGER 					DEFAULT '0' NOT NULL ,
	SEND_ERROR_MESSAGE 		varchar2(255),
	STATUS 					char(1) 				NOT NULL,
	SEND_DATE 				TIMESTAMP,
	NEXT_SEND_DATE 			TIMESTAMP,
 CONSTRAINT PK_JOB_QUEUE_DESTINATION PRIMARY KEY (JOBID,USERID) 
)
/
CREATE OR REPLACE TRIGGER tib_job_queue_markers before insert
on job_queue_markers for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select JOBQMRK_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/

CREATE OR REPLACE TRIGGER tib_job_queue_exceptions before insert
on job_queue_exceptions for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select JOBQEXC_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/
CREATE OR REPLACE TRIGGER TIB_JOB_QUEUE_INCL_TEXT before insert
on job_queue_incl_text for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select jobq_inclt_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/

CREATE OR REPLACE TRIGGER tib_job_queue_report before insert
on job_queue_report for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select JOBQRPT_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/
CREATE OR REPLACE TRIGGER tib_job_queue_accept before insert
on job_queue_accept for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select JOBQACPT_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/
CREATE OR REPLACE TRIGGER tib_job_queue_course before insert
on job_queue_course for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select JOBQCRS_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/
drop index job_q_list_idx
/
create index job_q_list_idx on JOB_QUEUE_LIST (
SERVERNAME ASC,
STATUS ASC,
STARTDATE ASC,
STARTTIME ASC,
PRIORITY ASC,
JOBID ASC
)
/
alter table analysis_courses modify (credit numeric(10,5))
/

alter table analysis_req modify (reqhrs numeric(10,5))
/
alter table analysis_req modify (gothrs numeric(10,5))
/
alter table analysis_req modify (reqgpa numeric(10,5))
/
alter table analysis_req modify (gotgpa numeric(10,5))
/
alter table analysis_req modify (gotgpahrs numeric(10,5))
/
alter table analysis_req modify (gotgpapts numeric(10,5))
/

alter table gmaster modify (gpapt numeric(10,5))
/
alter table gmaster modify (lcredit numeric(10,5))
/
alter table gmaster modify (hcredit numeric(10,5))
/

alter table job_queue_course modify (rcredit numeric(10,5))
/
alter table job_queue_course modify (credit numeric(10,5))
/
alter table job_queue_course modify (gpahrs numeric(10,5))
/
alter table job_queue_course modify (gpapts numeric(10,5))
/
alter table job_queue_course modify (gpa numeric(10,5))
/

alter table job_queue_req modify (maxhrs numeric(10,5))
/
alter table job_queue_req modify (reqhrs numeric(10,5))
/
alter table job_queue_req modify (est_reqhrs numeric(10,5))
/
alter table job_queue_req modify (gothrs numeric(10,5))
/
alter table job_queue_req modify (iphrs numeric(10,5))
/
alter table job_queue_req modify (whatifhrs numeric(10,5))
/
alter table job_queue_req modify (needhrs numeric(10,5))
/
alter table job_queue_req modify (gotgpahrs numeric(10,5))
/
alter table job_queue_req modify (gotgpapts numeric(10,5))
/
alter table job_queue_req modify (reqgpa numeric(10,5))
/
alter table job_queue_req modify (gotgpa numeric(10,5))
/
alter table job_queue_req modify (needgpa numeric(10,5))
/

alter table job_queue_subreq modify (maxhrs numeric(10,5))
/
alter table job_queue_subreq modify (reqhrs numeric(10,5))
/
alter table job_queue_subreq modify (est_reqhrs numeric(10,5))
/
alter table job_queue_subreq modify (gothrs numeric(10,5))
/
alter table job_queue_subreq modify (iphrs numeric(10,5))
/
alter table job_queue_subreq modify (whatifhrs numeric(10,5))
/
alter table job_queue_subreq modify (needhrs numeric(10,5))
/
alter table job_queue_subreq modify (reqgpa numeric(10,5))
/
alter table job_queue_subreq modify (gotgpa numeric(10,5))
/
alter table job_queue_subreq modify (needgpa numeric(10,5))
/
alter table job_queue_subreq modify (gotgpahrs numeric(10,5))
/
alter table job_queue_subreq modify (gotgpapts numeric(10,5))
/

alter table mastref_seg modify (gpapt numeric(10,5))
/

alter table req_main modify (reqhrs numeric(10,5))
/
alter table req_main modify (reqgpa numeric(10,5))
/
alter table req_main modify (maxhrs numeric(10,5))
/
alter table req_main modify (estreqhrs numeric(10,5))
/

alter table string modify (limhrs numeric(10,5))
/

alter table stu_acadrec modify (rcredit numeric(10,5))
/
alter table stu_acadrec modify (ecredit numeric(10,5))
/
alter table stu_acadrec modify (gpahrs numeric(10,5))
/
alter table stu_acadrec modify (gpapts numeric(10,5))
/

alter table stu_exceptions modify (reqhrs numeric(10,5))
/
alter table stu_exceptions modify (maxhrs numeric(10,5))
/
alter table stu_exceptions modify (reqgpa numeric(10,5))
/

alter table sub_req modify (reqhrs numeric(10,5))
/
alter table sub_req modify (reqgpa numeric(10,5))
/
alter table sub_req modify (maxhrs numeric(10,5))
/
alter table sub_req modify (esthrs numeric(10,5))
/

alter table tca_rule modify (limhrs numeric(10,5))
/

alter table tca_source modify (limhrs numeric(10,5))
/

alter table tca_target modify (limhrs numeric(10,5))
/

alter table whatif_courses modify (rcredit numeric(10,5))
/
