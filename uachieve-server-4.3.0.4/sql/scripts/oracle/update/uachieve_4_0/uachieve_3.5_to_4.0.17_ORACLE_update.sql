/*==============================================================*/
/* uAchieve Release: uAchieve 4.0                               */
/* DBMS name:      Oracle                                       */
/* Created on:     7/1/2008 11:14:14 PM                         */
/*                                                              */
/* Script name:    ua40oramod.sql                               */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 uAchieve 4.0  format from a 3.5.6 format     */
/*                                                              */
/* Copyright(c) 2006-2008 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

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

-- columns included in 3.5.7 update script
begin
    execute immediate 'alter table stu_exceptions add   auth_code  varchar2(10)  null';
    execute immediate 'alter table req_main add   auth_code1  varchar2(10)  null';
    execute immediate 'alter table req_main add   auth_code2  varchar2(10)  null';
exception
    when others then
        if sqlcode not in(-1430) then
            raise;
        end if;
end;
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

alter table gmaster modify (gpapt numeric(10,5))
/
alter table gmaster modify (lcredit numeric(10,5))
/
alter table gmaster modify (hcredit numeric(10,5))
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

/*==============================================================*/
/* DBMS name:      Oracle                                       */
/* Created on:     10/09/2008                                   */
/* Database Modification Script to                              */
/* Update u.achieve 4.0.[2-3] to u.achieve 4.0.4                */
/*==============================================================*/
begin
    execute immediate 'alter table job_queue_run add ncol char(1)';
exception
    when others then
        if sqlcode not in(-1430) then
            raise;
        end if;
end;
/

-- 4.0.6 update
-- 05/16/14	DAP	UACH-3241
-- The original 4.0.6 update script drops and recreates the job_queue_out and job_queue_run tables.
-- In order to preserve previously run audits, those tables should not be removed, and were
-- not included in this combined update script.  However, the sequence objects for those were dropped
-- by mistake.  That has now been corrected.

alter table job_queue_out modify (rtabx char(3) default '   ' not null)
/

-- removing job_queue_course before re-creating
-- sequence may not exist yet.  try dropping sequence before dropping table
begin
    execute immediate 'drop sequence jobqcrs_seq_no';
exception
    when others then
        if sqlcode not in(-2289) then
            raise;
        end if;
end;
/

begin
    execute immediate 'alter table job_queue_course drop constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ';
    execute immediate 'truncate table  job_queue_course';
    execute immediate 'drop table job_queue_course cascade constraints';
exception
    when others then
        if sqlcode not in(-2289, -942) then
            raise;
        end if;
end;
/

-- removing job_queue_accept before re-creating
-- sequence may not exist yet.  try dropping sequence before dropping table
begin
    execute immediate 'drop sequence jobqacpt_seq_no';
exception
    when others then
        if sqlcode not in(-2289) then
            raise;
        end if;
end;
/

-- removing job_queue_accept before re-creating
begin
    execute immediate 'alter table job_queue_accept drop constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU';
    execute immediate 'truncate table  job_queue_accept';
    execute immediate 'drop table job_queue_accept cascade constraints';
exception
    when others then
        if sqlcode not in(-942) then
            raise;
        end if;
end;
/

-- removing job_queue_subreq_text before re-creating
begin
    execute immediate 'alter table JOB_QUEUE_SUBREQ_TEXT drop constraint FK_JQSRTXT_REF_JQREQ';
    execute immediate 'truncate table  job_queue_subreq_text';
    execute immediate 'drop table job_queue_subreq_text cascade constraints';
exception
    when others then
        if sqlcode not in(-942) then
            raise;
        end if;
end;
/

-- removing job_queue_subreq before re-creating
begin
    execute immediate 'alter table JOB_QUEUE_SUBREQ drop constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ';
    execute immediate 'truncate table  job_queue_subreq';
    execute immediate 'drop table job_queue_subreq cascade constraints';
exception
    when others then
        if sqlcode not in(-942) then
            raise;
        end if;
end;
/

-- removing job_queue_req_text before re-creating
begin
    execute immediate 'alter table JOB_QUEUE_REQ_TEXT drop constraint FK_JQRTXT_REF_JQREQ';
    execute immediate 'truncate table  job_queue_req_text';
    execute immediate 'drop table job_queue_req_text cascade constraints';
exception
    when others then
        if sqlcode not in(-942) then
            raise;
        end if;
end;
/

-- removing job_queue_req before re-creating
begin
    execute immediate 'alter table JOB_QUEUE_REQ drop constraint FK_JOBQ_REQ_REF_JOBQ_RUN';
    execute immediate 'truncate table  job_queue_req';
    execute immediate 'drop table job_queue_req cascade constraints';
exception
    when others then
        if sqlcode not in(-942) then
            raise;
        end if;
end;
/

-- removing job_queue_markers before re-creating
begin
    execute immediate 'drop sequence jobqmrk_seq_no';
    execute immediate 'alter table JOB_QUEUE_MARKERS drop constraint FK_JQMRK_REF_JQRUN';
    execute immediate 'truncate table  job_queue_markers';
    execute immediate 'drop table job_queue_markers cascade constraints';
exception
    when others then
        if sqlcode not in(-2289, -942) then
            raise;
        end if;
end;
/


-- removing job_queue_exceptions before re-creating
begin
    execute immediate 'drop sequence jobqexc_seq_no';
    execute immediate 'alter table JOB_QUEUE_EXCEPTIONS drop constraint FK_JQEXC_REF_JQRUN';
    execute immediate 'truncate table  job_queue_exceptions';
    execute immediate 'drop table job_queue_exceptions cascade constraints';
exception
    when others then
        if sqlcode not in(-2289, -942) then
            raise;
        end if;
end;
/

-- removing job_queue_report before re-creating
begin
    execute immediate 'drop sequence jobqrpt_seq_no';
    execute immediate 'alter table JOB_QUEUE_REPORT drop constraint FK_JQREP_REF_JQRUN';
    execute immediate 'truncate table  job_queue_report';
    execute immediate 'drop table job_queue_report cascade constraints';
exception
    when others then
        if sqlcode not in(-2289, -942) then
            raise;
        end if;
end;
/

-- removing job_queue_incl_text before re-creating
begin
    execute immediate 'alter table JOB_QUEUE_INCL_TEXT drop constraint FK_JQINCL_REF_JQRUN';
    execute immediate 'truncate table  job_queue_incl_text';
    execute immediate 'drop table job_queue_incl_text cascade constraints';
exception
    when others then
        if sqlcode not in(-942) then
            raise;
        end if;
end;
/

-- removing job_queue_destination before re-creating
begin
    execute immediate 'truncate table  job_queue_destination';
    execute immediate 'drop table job_queue_destination cascade constraints';
exception
    when others then
        if sqlcode not in (-942) then
            raise;
        end if;
end;
/


CREATE TABLE JOB_QUEUE_DESTINATION(
	JOBID 					char(16)  				NOT NULL,
	USERID 					char(30) 				NOT NULL,
	DESTINATION_URL 		varchar2(255)  			NOT NULL,
	OUTPUT_FORMAT 			char(1),
	SEND_ERROR_COUNT 		INTEGER 				DEFAULT '0' NOT NULL ,
	SEND_ERROR_MESSAGE 		varchar2(255),
	STATUS 					char(1) 				NOT NULL,
	SEND_DATE 				TIMESTAMP,
	NEXT_SEND_DATE 			TIMESTAMP,
 CONSTRAINT PK_JOB_QUEUE_DESTINATION PRIMARY KEY (JOBID,USERID) 
)
/
/*==============================================================*/
/* Table: JOB_QUEUE_EXCEPTIONS                                  */
/*==============================================================*/
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
/*==============================================================*/
/* Index: jq_exceptions_idx                                        */
/*==============================================================*/
create index jq_exceptions_idx on job_queue_exceptions (
    jobq_seq_no ASC
)
/
/*==============================================================*/
/* Table: JOB_QUEUE_INCL_TEXT                                   */
/*==============================================================*/
create table JOB_QUEUE_INCL_TEXT  (
   INT_SEQ_NO           NUMBER(9)                       not null,
   JOBQ_SEQ_NO          NUMBER(9),
   TEXT_TYPE            CHAR,
   TEXT                 NCLOB,
   constraint PK_QUEUE_INCL_TEXT primary key (INT_SEQ_NO)
)
/
/*==============================================================*/
/* Index: jq_incl_text_idx                                        */
/*==============================================================*/
create index jq_incl_text_idx on job_queue_incl_text (
    jobq_seq_no ASC
)
/
/*==============================================================*/
/* Table: JOB_QUEUE_MARKERS                                     */
/*==============================================================*/
create table JOB_QUEUE_MARKERS  (
   INT_SEQ_NO           NUMBER                          not null,
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
/*==============================================================*/
/* Index: jq_markers_idx                                        */
/*==============================================================*/
create index jq_markers_idx on job_queue_markers (
    jobq_seq_no ASC
)
/
/*==============================================================*/
/* Table: JOB_QUEUE_REPORT                                      */
/*==============================================================*/
create table JOB_QUEUE_REPORT  (
   INT_SEQ_NO           NUMBER                          not null,
   JOBQ_SEQ_NO          NUMBER,
   REPORT_TYPE          CHAR(3),
   REPORT               BLOB,
   constraint PK_J_Q_REPORT primary key (INT_SEQ_NO)
)
/
/*==============================================================*/
/* Index: jq_report_idx                                        */
/*==============================================================*/
create index jq_report_idx on job_queue_report (
    jobq_seq_no ASC
)
/

/*==============================================================*/
/* Table: JOB_QUEUE_REQ                                         */
/*==============================================================*/
create table JOB_QUEUE_REQ  (
   JOBQ_SEQ_NO          NUMBER                          not null,
   RTABX                char(3)                         not null,
   RNO                  CHAR(3),
   RNAME                VARCHAR2(9),
   PSNAME               VARCHAR2(15),
   CATEGORY             VARCHAR2(15),
   SUMMARY_GRP          VARCHAR2(15),
   TRANSCRIPT           CHAR,
   TOTAL_HOUR           CHAR,
   TOTAL_GPA            CHAR,
   HIDEFROMCHART        CHAR,
   SATISFIED            CHAR,
   SUMMARY              CHAR,
   SORTFLG              CHAR,
   ORREQ                CHAR,
   OPTREQ               CHAR,
   REQSRQ               INTEGER,
   GOTSRQ               INTEGER,
   NEEDSRQ              INTEGER,
   REQCT                INTEGER,
   GOTCT                INTEGER,
   IPCT                 INTEGER,
   WHATIFCT             INTEGER,
   NEEDCT               INTEGER,
   MAXHRS               NUMBER(10,5),
   REQHRS               NUMBER(10,5),
   EST_REQHRS           NUMBER(10,5),
   GOTHRS               NUMBER(10,5),
   IPHRS                NUMBER(10,5),
   WHATIFHRS            NUMBER(10,5),
   NEEDHRS              NUMBER(10,5),
   GOTGPAHRS            NUMBER(10,5),
   GOTGPAPTS            NUMBER(10,5),
   REQGPA               NUMBER(10,5),
   GOTGPA               NUMBER(10,5),
   NEEDGPA              NUMBER(10,5),
   REQGPAF              CHAR,
   GPANAME              CHAR(15),
   GPALOWYT             CHAR(6),
   GPAHIGHYT            CHAR(6),
   HIDDEN               CHAR,
   HIDECATEGORYGPA      CHAR,
   GROUP1               CHAR,
   GROUP2               CHAR,
   REUSE                CHAR,
   LABEL                VARCHAR(25),
   HIDEHEADTITLE 		CHAR(1),
   HIDENEEDSSUMMARY 	CHAR(1),
   HIDESELFRMCRS 		CHAR(1),
   HIDEMTCHDCRS         CHAR(1),
   constraint PK_JOB_QUEUE_REQ primary key (JOBQ_SEQ_NO, RTABX)
)
/

/*==============================================================*/
/* Index: jobq_req_idx                                        */
/*==============================================================*/
create index jobq_req_idx on JOB_QUEUE_REQ (
   JOBQ_SEQ_NO ASC,
   RTABX ASC,
   RNAME ASC,
   CATEGORY ASC,
   SUMMARY_GRP ASC,
   TRANSCRIPT ASC,
   TOTAL_HOUR ASC,
   HIDEFROMCHART ASC,
   SUMMARY ASC
)
/

/*==============================================================*/
/* Table: JOB_QUEUE_REQ_TEXT                                    */
/*==============================================================*/
create table JOB_QUEUE_REQ_TEXT  (
   JOBQ_SEQ_NO          NUMBER							not null,
   TEXT_TYPE             CHAR(1)                         default 'T' not null,
   RTABX                char(3)							not null,
   TEXT                 NCLOB,
   constraint PK_J_Q_REQ_TEXT primary key (JOBQ_SEQ_NO, TEXT_TYPE, RTABX)
)
/
/*==============================================================*/
/* Index: jq_req_text_idx                                        */
/*==============================================================*/
create index jq_req_text_idx on job_queue_req_text (
    jobq_seq_no ASC,
    rtabx ASC
)
/

/*==============================================================*/
/* Table: JOB_QUEUE_SUBREQ                                      */
/*==============================================================*/
create table JOB_QUEUE_SUBREQ  (
   JOBQ_SEQ_NO          NUMBER                          not null,
   RTABX                char(3)                         not null,
   STABX                CHAR(3)                        not null,
   SNO                  CHAR(3),
   SATISFIED            CHAR,
   SORTFLG              CHAR,
   ORSUB                CHAR,
   OPTSUB               CHAR,
   REQCT                INTEGER,
   GOTCT                INTEGER,
   NEEDCT               INTEGER,
   IPCT                 INTEGER,
   WHATIFCT             INTEGER,
   MAXHRS               NUMBER(10,5),
   REQHRS               NUMBER(10,5),
   EST_REQHRSFLG        CHAR,
   EST_REQHRS           NUMBER(10,5),
   GOTHRS               NUMBER(10,5),
   IPHRS                NUMBER(10,5),
   WHATIFHRS            NUMBER(10,5),
   NEEDHRS              NUMBER(10,5),
   REQGPA               NUMBER(10,5),
   GOTGPA               NUMBER(10,5),
   NEEDGPA              NUMBER(10,5),
   GOTGPAHRS            NUMBER(10,5),
   GOTGPAPTS            NUMBER(10,5)                   default 0,
   REQGPAF              CHAR,
   GPANAME              CHAR(15),
   GPALOWYT             CHAR(6),
   GPAHIGHYT            CHAR(6),
   HIDDEN               CHAR,
   SUBREQ_ID            NUMBER(9),
   REUSE                CHAR,
   LABEL                VARCHAR(25), 
   STITLE               VARCHAR(55),
   HIDETITLE 			CHAR(1),
   HIDESUMMARY 			CHAR(1),
   HIDESELFRMCRS 		CHAR(1),
   HIDESTUCRS 			CHAR(1),
   constraint PK_JOB_QUEUE_SUBREQ primary key (JOBQ_SEQ_NO, RTABX, STABX)
)
/

/*==============================================================*/
/* Table: JOB_QUEUE_SUBREQ_TEXT                                 */
/*==============================================================*/
create table JOB_QUEUE_SUBREQ_TEXT  (
   JOBQ_SEQ_NO          NUMBER							not null,
   TEXT_TYPE             CHAR                           default 'T' not null,
   RTABX                char(3)							not null,
   STABX                CHAR(3)							not null,
   TEXT                 NCLOB,
   constraint PK_J_Q_SUBREQ_TEXT primary key (JOBQ_SEQ_NO, TEXT_TYPE, RTABX, STABX)
)
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
/*==============================================================*/
/* Table: JOB_QUEUE_ACCEPT                                      */
/*==============================================================*/
create table JOB_QUEUE_ACCEPT  (
   INT_SEQ_NO           NUMBER							not null,
   JOBQ_SEQ_NO          NUMBER                          default 0 not null,
   RTABX                char(3)                         not null,
   STABX                CHAR(3)                         not null,  
   COURSE               VARCHAR2(15),
   TITLE                VARCHAR2(29),
   REJECT               CHAR(1),
   USED                 CHAR(1),
   LOGIC                CHAR(1),
   REQUIRED             CHAR(1),
   CMPRTITLE            CHAR(1),
   RANGECOURSE          CHAR(15),
   LOWYT                CHAR(6),
   HIGHYT               CHAR(6),
   HIDDEN               CHAR(1),
   INNER_MEM 			CHAR(1),
   INNER_BGN 			CHAR(1),
   INNER_END 			CHAR(1),
   OUTER_MEM 			CHAR(1),
   OUTER_BGN 			CHAR(1),
   OUTER_END 			CHAR(1),
   SYMBOL_BEFORE 		CHAR(5),
   USER_SEQ_NO          NUMERIC(9),
   DEPT                 CHAR(15),
   CRSNO                CHAR(15),
   PSEUDO_FLAG          CHAR(1),
   constraint PK_JOB_QUEUE_ACCEPT primary key (INT_SEQ_NO)
)
/
/*==============================================================*/
/* Index: jobq_accept_idx                                       */
/*==============================================================*/
create index jobq_accept_idx on job_queue_accept (
   jobq_seq_no ASC,
   rtabx ASC,
   stabx ASC,
   reject ASC
)
/
/*==============================================================*/
/* Table: JOB_QUEUE_COURSE                                      */
/*==============================================================*/
create table JOB_QUEUE_COURSE  (
   INT_SEQ_NO           NUMBER							not null,
   JOBQ_SEQ_NO          NUMBER                          not null,
   RTABX                char(3)                         not null,
   STABX                CHAR(3)                         not null,   
   YT                   CHAR(6),
   EDIT_YT              CHAR(4),
   COURSE               VARCHAR2(15),
   XCOURSE              VARCHAR2(15),
   RCREDIT              NUMBER(10,5),
   CREDIT               NUMBER(10,5),
   GPAHRS               NUMBER(10,5),
   GPAPTS               NUMBER(10,5),
   GPA                  NUMBER(10,5),
   GRADE                CHAR(4),
   RGRADE               CHAR(4),
   IP                   CHAR(1),
   WHATIF               CHAR(1),
   CTITLE               VARCHAR2(29),
   RTITLE               VARCHAR2(29),
   STITLE               VARCHAR2(29),
   CVTTITLE             VARCHAR2(29),
   ALTTITLE             VARCHAR2(29),
   USER_SEQ_NO          NUMERIC(9),
   constraint PK_JOB_QUEUE_COURSE primary key (INT_SEQ_NO)
)
/
create   index jobq_course_idx on job_queue_course (jobq_seq_no, rtabx, stabx)
/

alter table JOB_QUEUE_EXCEPTIONS
   add constraint FK_JQEXC_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
      not deferrable
/

alter table JOB_QUEUE_INCL_TEXT
   add constraint FK_JQINCL_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
      not deferrable
/

alter table JOB_QUEUE_MARKERS
   add constraint FK_JQMRK_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
      not deferrable
/

alter table JOB_QUEUE_REPORT
   add constraint FK_JQREP_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
      not deferrable
/

alter table JOB_QUEUE_REQ
   add constraint FK_JOBQ_REQ_REF_JOBQ_RUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
/

alter table JOB_QUEUE_REQ_TEXT
   add constraint FK_JQRTXT_REF_JQREQ foreign key (JOBQ_SEQ_NO, RTABX)
      references JOB_QUEUE_REQ (JOBQ_SEQ_NO, RTABX)
      not deferrable
/

alter table JOB_QUEUE_SUBREQ
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (JOBQ_SEQ_NO, RTABX)
      references JOB_QUEUE_REQ (JOBQ_SEQ_NO, RTABX)
/

alter table JOB_QUEUE_SUBREQ_TEXT
   add constraint FK_JQSRTXT_REF_JQREQ foreign key (JOBQ_SEQ_NO, RTABX, STABX)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
      not deferrable
/
alter table job_queue_accept
   add constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
/


alter table job_queue_course
   add constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
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


create sequence jobqmrk_seq_no
  start with 1
  maxvalue 999999999
  minvalue 1
  cycle
  cache 20
  noorder
/


create sequence jobqexc_seq_no
  start with 1
  maxvalue 999999999
  minvalue 1
  cycle
  cache 20
  noorder
/


create sequence jobqrpt_seq_no
  start with 1
  maxvalue 999999999
  minvalue 1
  cycle
  cache 20
  noorder
/

 create sequence jobq_inclt_seq_no
  start with 1
  maxvalue 999999999
  minvalue 1
  cycle
  cache 20
  noorder
/

--  INSERT WITH int_seq_no, WITHOUT last_mod_user, date
--  Before insert trigger "tib_job_queue_run" for table "job_queue_run"
create or replace trigger tib_job_queue_run before insert
on job_queue_run for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select jobqr_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/
create or replace trigger tib_job_queue_out before insert
on job_queue_out for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select jobqo_seq_no.nextval
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

--==============================================================
-- u.achieve:      4.0.8
-- DBMS name:      Oracle       				
-- Created on:     4/14/2008 12:55:40 PM                        
--==============================================================
--======================================================================================================
-- CREATE TABLES
--======================================================================================================


create table RED_APP_FN (
   APP_FN               varchar(255)         not null,
   APP_ID               varchar(255)         null,
   FN_DESC              varchar(1024)        null,
   constraint PK_RED_APP_FN primary key (APP_FN)
)
/

create table RED_GROUP (
   GROUP_ID             varchar(255)         not null,
   GROUP_DESC           varchar(1024)        null,
   constraint PK_RED_GROUP primary key (GROUP_ID)
)
/

create table RED_ORG_DOMAIN_MAPPING (
   MAPPING_ID           numeric(9)           not null,
   USER_ID		varchar(40)          null,
   GROUP_ID             varchar(255)         null,
   LEVEL_1          	varchar(255)         null,
   LEVEL_2              varchar(255)         null,
   LEVEL_3              varchar(255)         null,
   LEVEL_4             	varchar(255)         null,
   LEVEL_5              varchar(255)         null,
   LEVEL_6              varchar(255)         null,
   PROGRAM_NAME varchar(255)		  null,
   constraint PK_RED_ORG_DOMAIN_MAPPING primary key (MAPPING_ID)
)
/

create table RED_PROPERTY_DESC 
(
	property_id	varchar(20)				not null,
	description	varchar(100)			not null,
	constraint 	PK_RED_PROPERTY_DESC 	primary key (property_id)
)
/

create table red_property_domain_mapping (
   mapping_id           numeric(9)           not null,
   entity_id            varchar(20)          null,
   entity_type          varchar(20)          null,
   property_id          varchar(20)          null,
   value                varchar(255)         null,
   instidq              varchar(2)           null,
   instid               varchar(8)           null,
   instcd               varchar(3)           null,
   description			varchar(100)		 null,
   constraint 		PK_RED_PROPERTY_DOMAIN_MAPPING primary key (mapping_id)
)
/

create table RED_REALM (
   USER_ID              varchar(40)          not null,
   MEMBER_ID            varchar(40)          not null,
   IS_GROUP             char(1)                  null,
   constraint PK_RED_REALM primary key (USER_ID, MEMBER_ID)
)
/

create table RED_ROLES (
   ROLE_ID			varchar(255)         	not null,
   APP_FN			varchar(255)         	not null,
   CAN_READ			char(1)				default 0 not null,
   CAN_UPDATE		char(1)					default 0 not null,
   CAN_CREATE		char(1)					default 0 not null,
   CAN_DELETE		char(1)					default 0 not null,
   constraint PK_RED_ROLES primary key (ROLE_ID, APP_FN),
   constraint FK_ROLE_TO_APP_FN foreign key (APP_FN) references RED_APP_FN (APP_FN)
)
/

create table RED_ROLE_MAPPING (
   GROUP_ID             varchar(255)         not null,
   ROLE_ID              varchar(255)         not null,
   constraint PK_RED_ROLE_MAPPING primary key (GROUP_ID, ROLE_ID)
)
/

create table RED_USER (
   USER_ID              varchar(40)          not null,
   FIRST_NAME           varchar(40)          null,
   LAST_NAME            varchar(40)          null,
   PASSWORD             varchar(40)          not null,
   STU_ID               varchar(40)          null,
   EMAIL                varchar(255)         null,
   NOTES                varchar2(4000)		 null,
   constraint PK_RED_USER primary key (USER_ID)
)
/

create table RED_USER_GROUP (
   USER_ID              varchar(40)          not null,
   GROUP_ID             varchar(40)          not null,
   constraint PK_RED_USER_GROUP primary key (USER_ID, GROUP_ID)
)
/


--======================================================================================================
-- CREATE INDEXES
--======================================================================================================
create index red_property_dom_map_idx on red_property_domain_mapping (
   entity_id,
   entity_type,
   property_id
)
/


--======================================================================================================
-- CREATE SEQUENCES
--======================================================================================================
create sequence s_red_org_domain_mapping
/
create sequence s_red_property_domain_mapping
/

--======================================================================================================
-- CREATE TRIGGERS
--======================================================================================================
create or replace trigger TIB_RED_ORG_DOMAIN_MAPPING before insert
on RED_ORG_DOMAIN_MAPPING for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "MAPPING_ID" uses sequence S_RED_ORG_DOMAIN_MAPPING
    if :new.mapping_id is null then
	    select S_RED_ORG_DOMAIN_MAPPING.NEXTVAL INTO :new.MAPPING_ID from dual;
	end if;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create or replace trigger TIB_RED_PROP_DOMAIN_MAPPING before insert
on RED_PROPERTY_DOMAIN_MAPPING for each row
declare
    next_seq_no		 numeric(9);
begin
	
    --  Column "MAPPING_ID" uses sequence S_RED_PROPERTY_DOMAIN_MAPPING
    if :new.mapping_id is null then
	    select S_RED_PROPERTY_DOMAIN_MAPPING.NEXTVAL INTO next_seq_no from dual;
	    :new.mapping_id := next_seq_no;
	end if;
       
end;
/


/*==============================================================*/
/* Database name:  u.achieve 4.0.11                             */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     6/27/2008 1:18:54 PM                         */
/*==============================================================*/

alter table job_queue_req 
	add force_schema_include char(1) null
/

alter table chart_categories 
	add force_schema_include char(1) null
/

/*==============================================================*/
/* Database name:  u.achieve 4.0.12                             */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     6/27/2008 1:18:54 PM                         */
/*==============================================================*/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_job_queue_list" for table "job_queue_list"
create or replace trigger tib_job_queue_list before insert
on job_queue_list for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_acadrec" for table "stu_acadrec"
create or replace trigger tib_stu_acadrec before insert
on stu_acadrec for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_demo" for table "stu_demo"
create or replace trigger tib_stu_demo before insert
on stu_demo for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_dprog" for table "stu_dprog"
create or replace trigger tib_stu_dprog before insert
on stu_dprog for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_evalgrp" for table "stu_evalgrp"
create or replace trigger tib_stu_evalgrp before insert
on stu_evalgrp for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_exc_courses" for table "stu_exc_courses"
create or replace trigger tib_stu_exc_courses before insert
on stu_exc_courses for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stuexc_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_exceptions" for table "stu_exceptions"
create or replace trigger tib_stu_exceptions before insert
on stu_exceptions for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stuexc_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_marker_req" for table "stu_marker_req"
create or replace trigger tib_stu_marker_req before insert
on stu_marker_req for each row
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_whatif_courses" for table "whatif_courses"
create or replace trigger tib_whatif_courses before insert
on whatif_courses for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_req_main" for table "req_main"
create or replace trigger tib_req_main before insert
on req_main for each row

begin
--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_mastref_address" for table "mastref_address"
create or replace trigger tib_mastref_address before insert
on mastref_address for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select mref_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_gmaster" for table "gmaster"
create or replace trigger tib_gmaster before insert
on gmaster for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select seq_int_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_com" for table "com"
create or replace trigger tib_com before insert
on com for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_string" for table "string"
create or replace trigger tib_string before insert
on string for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select seq_int_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_gmaster" for table "gmaster"
create or replace trigger tub_gmaster before update
on gmaster for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_req_main" for table "req_main"
create or replace trigger tub_req_main before update
on req_main for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_mastref_address" for table "mastref_address"
create or replace trigger tub_mastref_address before update
on mastref_address for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;
end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_job_queue_list" for table "job_queue_list"
create or replace trigger tub_job_queue_list before update
on job_queue_list for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_demo" for table "stu_demo"
create or replace trigger tub_stu_demo before update
on stu_demo for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_dprog" for table "stu_dprog"
create or replace trigger tub_stu_dprog before update
on stu_dprog for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_evalgrp" for table "stu_evalgrp"
create or replace trigger tub_stu_evalgrp before update
on stu_evalgrp for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_exc_courses" for table "stu_exc_courses"
create or replace trigger tub_stu_exc_courses before update
on stu_exc_courses for each row

begin
IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_exceptions" for table "stu_exceptions"
create or replace trigger tub_stu_exceptions before update
on stu_exceptions for each row

begin
--  update "Last Saved" information
IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_marker_req" for table "stu_marker_req"
create or replace trigger tub_stu_marker_req before update
on stu_marker_req for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_master" for table "stu_master"
create or replace trigger tub_stu_master before update
on stu_master for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_whatif_courses" for table "whatif_courses"
create or replace trigger tub_whatif_courses before update
on whatif_courses for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_com" for table "com"
create or replace trigger tub_com before update
on com for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_string" for table "string"
create or replace trigger tub_string before update
on string for each row

begin
--  update "Last Saved" information

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

/*==============================================================*/
/* Database name:  u.achieve 4.0.13                                */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     9/29/2011 1:36:22 PM                         */
/*==============================================================*/

/* 
   Previous versions of u.achieve Server converted null values in sub_req.skipbct to -1
   and then saved the -1 back to the database table.  Saving the data was not intended,
   and the save has been removed from the Server.  This script resets -1 skipbct values
   back to null.
   
   This issue has no effect on audit results, but a -1 value is not represented well
   in the u.achieve Client.
   
*/

update sub_req
set skipbct = null
where skipbct = -1
/

-- removed TIB_SUB_REQ because it was bad, is now fixed in 4.0.14 script

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_sub_req" for table "sub_req"
CREATE OR REPLACE TRIGGER TUB_SUB_REQ before update 
on sub_req for each row 
 
begin 
--  update "Last Saved" information 
IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
 
end;
/

/*==============================================================*/
/* Database name:  u.achieve 4.0.14                             */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     12/19/2011 11:47:32 AM                         */
/*==============================================================*/
alter table job_queue_course add PASSFAIL CHAR(1)  NULL
/
alter table job_queue_course add ADDCT    INTEGER  NULL
/


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_sub_req" for table "sub_req"
CREATE OR REPLACE TRIGGER TIB_SUB_REQ before insert 
on sub_req for each row 
declare 
    next_seq_no numeric; 
begin 
 
--  set generated int_seq_no 

	if :new.int_seq_no is null THEN
    select req_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
	end if;
 
--  update "Last Saved" information 
 
IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
     
end;

/

/*==============================================================*/
/* Database name:  u.achieve 4.0.16                             */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     5/11/2012 2:24:22 PM                         */
/*==============================================================*/
alter table dprog add type_code CHAR(3)  NULL
/

-- column may exist in correct format already, in which case no changes are necessary
begin
    execute immediate 'alter table sub_req modify skipbct NUMBER(1) NULL';
exception
    when others then
        if sqlcode not in(-1451) then
            raise;
        end if;
end;
/

--==============================================================
-- Table: DPROG_TYPE                                            
--==============================================================
CREATE TABLE dprog_type (
   instidq              char(2)               not null,
   instid               char(8)               not null,
   instcd               char(3)               not null,
   type_code            char(3)               not null,
   label	            varchar2(30)           null,
   type_order           integer               not null,
   constraint PK_dprog_type primary key (instidq, instid, instcd, type_code)
)
/

ALTER TABLE dprog_type
	ADD CONSTRAINT uc_dprog_type
	UNIQUE (instidq, instid, instcd, type_order)
/

--==============================================================
-- Table: WHATIF_ELEMENT_TYPE_ASSOC                             
--==============================================================
CREATE TABLE whatif_element_type_assoc ( 
	int_seq_no    		NUMBER(9) 				NOT NULL,
	instidq		       	char(2) 				NOT NULL,
	instid		       	char(8) 				NOT NULL,
	instcd	        	char(3) 				NOT NULL,
	element		       	char(15)				NOT NULL,
	dprog_type		   	char(3) 				NOT NULL,
	label	         	varchar2(30) 			NULL,
	forced_mapping		char(1) 				DEFAULT 'N' NOT NULL,
	reqd_values		   	integer					DEFAULT 0 NOT NULL,
	max_values	    	integer					DEFAULT 0 NOT NULL,
	parent_element		char(15) 				NOT NULL,
	fyt		           	char(6) 				NOT NULL,
	lyt		           	char(6) 				NOT NULL,
	group_order		   	integer					NOT NULL,
	forced_catalog_year	char(1)					DEFAULT 'N' NOT NULL,
	CONSTRAINT pk_weta PRIMARY KEY (int_seq_no)
)
/

--==============================================================
-- Include to drop constraint, alter column, and re-add the 	
-- constraint in-case WHATIF_ELEMENT_TYPE_ASSOC already existed.
--==============================================================

-- only drop constraint if it already existed
begin
    execute immediate 'ALTER TABLE whatif_element_type_assoc DROP CONSTRAINT uc_wi_element_type_assoc';
exception
    when others then
        if sqlcode not in(-2443) then
            raise;
        end if;
end;
/

-- column may exist in correct format already, in which case no changes are necessary
begin
    execute immediate 'ALTER TABLE whatif_element_type_assoc MODIFY ( parent_element CHAR(15) NOT NULL)';
exception
    when others then
        if sqlcode not in(-1442) then
            raise;
        end if;
end;
/


ALTER TABLE whatif_element_type_assoc
	ADD CONSTRAINT uc_wi_element_type_assoc
	UNIQUE (instidq, instid, instcd, element, dprog_type, fyt, parent_element)	
/

ALTER TABLE whatif_element_type_assoc
	ADD CONSTRAINT fk_weta_relation_dprog_type
	FOREIGN KEY(instidq, instid, instcd, dprog_type)
	REFERENCES dprog_type(instidq, instid, instcd, type_code)
/

--==============================================================
-- Table: WHATIF_FORCED_MARKER	                                
--==============================================================
CREATE TABLE whatif_forced_marker  ( 
	int_seq_no	     	NUMBER(9)	 		NOT NULL,
	weta_int_seq_no		NUMBER(9)	 		NOT NULL,
	element_value	  	char(15) 			NOT NULL,
	forced_marker	  	char(9) 			NOT NULL,
	forced_val	     	char(15)			NOT NULL,
	forced_type	    	char(1) 			NOT NULL,
	fyt	            	char(6) 			NOT NULL,
	lyt	            	char(6) 			NOT NULL,
	exclude 	       	char(1) 			NOT NULL,
	ref_instidq	    	varchar2(2) 			NOT NULL,
	ref_instid 	    	varchar2(8) 			NOT NULL,
	ref_instcd	     	varchar2(3) 			NOT NULL,
	CONSTRAINT pk_wi_forced_marker PRIMARY KEY(int_seq_no)
	)
/

ALTER TABLE whatif_forced_marker
	ADD CONSTRAINT fk_wi_ele_type_assoc
	FOREIGN KEY(weta_int_seq_no)
	REFERENCES whatif_element_type_assoc(int_seq_no)
/

--==============================================================
-- Table: WHATIF_ELEMENT_FILTER	                                
--==============================================================
CREATE TABLE whatif_element_filter  ( 
	int_seq_no    	NUMBER(9) 			NOT NULL,
	instidq       	char(2) 			NOT NULL,
	instid        	char(8) 			NOT NULL,
	instcd        	char(3) 			NOT NULL,
	dprog         	char(15) 			NOT NULL,
	element       	char(15) 			NOT NULL,
	filter_pattern	char(25) 			NOT NULL,
	fyt           	char(6) 			NOT NULL,
	lyt           	char(6) 			NOT NULL,
	exclude       	char(1) 			NOT NULL,
	ref_instidq   	varchar2(2) 			NOT NULL,
	ref_instid    	varchar2(8) 			NOT NULL,
	ref_instcd    	varchar2(3) 			NOT NULL,
	CONSTRAINT pk_wi_element_filter PRIMARY KEY (int_seq_no)
	)
/

--============================================================
-- CREATE INDEXES
--============================================================

create sequence weta_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence forced_marker_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence element_filter_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/
--==============================================================
-- CREATE TRIGGERS												
--==============================================================
--  Before insert trigger "tib_whatif_ele_type_assoc" for table "WHATIF_ELEMENT_TYPE_ASSOC"
create or replace trigger tib_whatif_ele_type_assoc before insert
on whatif_element_type_assoc for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select weta_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/

--  Before insert trigger "tib_whatif_forced_marker" for table "WHATIF_FORCED_MARKER"
create or replace trigger tib_whatif_forced_marker before insert
on whatif_forced_marker for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select forced_marker_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/

--  Before insert trigger "tib_whatif_element_filter" for table "WHATIF_ELEMENT_FILTER"
create or replace trigger tib_whatif_element_filter before insert
on whatif_element_filter for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select element_filter_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/
