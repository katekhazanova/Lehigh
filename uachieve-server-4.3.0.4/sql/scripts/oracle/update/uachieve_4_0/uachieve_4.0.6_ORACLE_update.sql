drop sequence jobqo_seq_no
/
drop sequence jobqr_seq_no
/
drop sequence jobqcrs_seq_no
/
drop sequence jobqacpt_seq_no
/
drop sequence jobqmrk_seq_no
/
drop sequence jobqexc_seq_no
/
drop sequence jobqrpt_seq_no
/

ALTER TABLE JOB_QUEUE_OUT
    drop CONSTRAINT FK_JOBQ_OUT_REF_JOBQ_RUN
/
alter table JOB_QUEUE_EXCEPTIONS
   drop constraint FK_JQEXC_REF_JQRUN
/

alter table JOB_QUEUE_INCL_TEXT
   drop constraint FK_JQINCL_REF_JQRUN
/

alter table JOB_QUEUE_MARKERS
   drop constraint FK_JQMRK_REF_JQRUN
/

alter table JOB_QUEUE_REPORT
   drop constraint FK_JQREP_REF_JQRUN
/
alter table JOB_QUEUE_REQ
   drop constraint FK_JOBQ_REQ_REF_JOBQ_RUN
/

alter table JOB_QUEUE_REQ_TEXT
   drop constraint FK_JQRTXT_REF_JQREQ
/

alter table JOB_QUEUE_SUBREQ
   drop constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ
/

alter table JOB_QUEUE_SUBREQ_TEXT
   drop constraint FK_JQSRTXT_REF_JQREQ
/
alter table job_queue_accept
   drop constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU
/
alter table job_queue_course
   drop constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ
/
delete from job_queue_course
/
delete from job_queue_accept
/
delete from job_queue_subreq_text
/
delete from job_queue_subreq
/
delete from job_queue_req_text
/
delete from job_queue_req
/
delete from job_queue_markers
/
delete from job_queue_exceptions
/
delete from job_queue_destination
/
delete from job_queue_out
/
delete from job_queue_incl_text
/
delete from job_queue_report
/
delete from job_queue_run
/
drop table job_queue_course
/
drop table job_queue_accept
/
drop table job_queue_subreq_text
/
drop table job_queue_subreq
/
drop table job_queue_req_text
/
drop table job_queue_req
/
drop table job_queue_markers
/
drop table job_queue_exceptions
/
drop table job_queue_destination
/
drop table job_queue_out
/
drop table job_queue_incl_text
/
drop table job_queue_report
/
drop table job_queue_run
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
/* Table: JOB_QUEUE_RUN                                         */
/*==============================================================*/
create table JOB_QUEUE_RUN  (
   INT_SEQ_NO           NUMBER                          not null,
   INSTIDQ              CHAR(2)                        default ' ',
   INSTID               CHAR(8)                        default ' ',
   INSTCD               CHAR(3)                        default ' ',
   JOBID                CHAR(16)                       default ' ',
   USERID               CHAR(30)                       default ' ',
   SOPRID               CHAR(8)                        default ' ',
   STUNO                CHAR(13)                       default ' ',
   DPROG                CHAR(15)                       default ' ',
   DPMASK               CHAR(15)                       default ' ',
   CATLYT               CHAR(6)                        default ' ',
   BINSTID              CHAR(8),
   BINSTCD              CHAR(3),
   JOBQ_SYSOUT_USED     CHAR,
   NCOL                 CHAR,
   COMPLETE             CHAR,
   IP                   CHAR,
   DPTITLE1             VARCHAR(65),
   DPTITLE2             VARCHAR(65),
   WEBTITLE             VARCHAR(50),
   DETAIL_SEQ_NO        NUMBER(9),
   RUNDATE              DATE,
   ALTSTUNO             CHAR(13),
   FIRSTNAME            VARCHAR2(30),
   MIDDLENAME           VARCHAR2(15),
   LASTNAME             VARCHAR2(30),
   PREFIXNAME           VARCHAR2(4),
   SUFFIXNAME           VARCHAR2(6),
   STUNAME              VARCHAR2(60),
   LISTALL              CHAR(1),
   TESTSTATUS           CHAR(1),
   REPORT_TYPE			CHAR(3),
   constraint PK_JOB_QUEUE_RUN primary key (INT_SEQ_NO)
)
/

/*==============================================================*/
/* Index: jobq_run_idx                                        */
/*==============================================================*/
create index jobq_run_idx on JOB_QUEUE_RUN (
   STUNO ASC,
   INSTIDQ ASC,
   INSTID ASC,
   INSTCD ASC,
   SOPRID ASC,
   DPROG ASC,
   DPMASK ASC,
   CATLYT ASC,
   USERID ASC
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
/*==============================================================*/
/* Table: JOB_QUEUE_OUT                                      */
/*==============================================================*/
CREATE TABLE JOB_QUEUE_OUT ( 
    INT_SEQ_NO 	NUMBER NOT NULL,
    JOBQ_SEQ_NO	NUMBER NOT NULL,
    USER_SEQ_NO	NUMBER NULL,
    RTABX      	CHAR(3) NULL,
    STABX      	CHAR(3) NULL,
    REQSTATUS  	CHAR(1) NULL,
    SRNO       	CHAR(2) NULL,
    SRSTATUS   	CHAR(1) NULL,
    OPTLINE    	CHAR(1) NULL,
    LASERA     	CHAR(1) NULL,
    LASERB     	CHAR(1) NULL,
    DAROUT     	VARCHAR2(255) NULL,
    CONSTRAINT PK_JOB_QUEUE_OUT PRIMARY KEY(INT_SEQ_NO)
)
/
create index jobq_out_idx on job_queue_out (jobq_seq_no)
/
ALTER TABLE JOB_QUEUE_OUT
    ADD ( CONSTRAINT FK_JOBQ_OUT_REF_JOBQ_RUN
	FOREIGN KEY(JOBQ_SEQ_NO)
	REFERENCES JOB_QUEUE_RUN(INT_SEQ_NO)
	)

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

create sequence jobqo_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
 minvalue 1
  cycle
  cache 20
  noorder
  /

create sequence jobqr_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
 minvalue 1
  cycle
  cache 20
  noorder
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