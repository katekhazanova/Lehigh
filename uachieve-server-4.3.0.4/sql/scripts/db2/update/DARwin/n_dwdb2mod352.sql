 
drop  view VW_ADV_CTLCD  
;
drop  view VW_ADV_DPROGS  
;
drop  view VW_ADV_FUNCTIONS  
;
drop  view VW_ADV_INST  
;
drop  view VW_ADV_MASTER  
;
drop  view VW_ADV_REQ  
; 
drop  view VW_STU_DEMO  
; 
drop  view VW_STU_MASTER  
; 


--- drop all triggers
drop trigger tD_DPROG;
 drop trigger  tD_REQ_MAIN
 ;
 drop trigger  tD_STU_MASTER
 ;
 drop trigger  tD_STU_MASTER2
 ;
 drop trigger   tD_STU_MASTER3 
 ;
 drop trigger   tD_STU_MASTER4 
 ;
 drop trigger ti_com
 ;
drop trigger   ti_cond_condes
;
drop trigger   ti_crse_bank 
;
drop trigger   ti_crs_convert
;
drop trigger   ti_dprog 
;
drop trigger   ti_dprog_req 
;
drop trigger   ti_gmaster
;
drop trigger   ti_job_queue_list
;
drop trigger   ti_mastref 
;
drop trigger   ti_mastref_address 
;
drop trigger   ti_mastref_seg
;
drop trigger   ti_repeat
;
drop trigger   ti_req_main
;
drop trigger   ti_req_text
;
drop trigger   ti_req_xy
;
drop trigger   ti_secure_mas
;
drop trigger   ti_string
;
drop trigger   ti_string_crse
;
drop trigger   ti_stu_acadrec
;
drop trigger   ti_stu_address
;
drop trigger   ti_stu_demo
;
drop trigger   ti_stu_dprog
;
drop trigger   ti_stu_evalgrp
;
drop trigger   ti_stu_exceptions
;
drop trigger   ti_stu_exc_courses
;
drop trigger   ti_stu_info
;
drop trigger   ti_stu_marker_req
;
drop trigger    ti_stu_trans_deg
;
drop trigger    ti_sub_req
;
drop trigger    ti_sub_req_ar
;
drop trigger    ti_sub_req_text
;
drop trigger    ti_tca_master
;
drop trigger    ti_tca_rule
;
drop trigger    ti_tca_source
;
drop trigger    ti_tca_target
; 
drop trigger    tk_analysis
;
drop trigger    tk_ana_crse
;
drop trigger    tk_ana_req 
;
drop trigger    tk_job_queue_out
;
drop trigger    tk_job_queue_run
;
drop trigger    tk_job_que_crse 
;
drop trigger    tk_job_que_dtl
;
drop trigger    tk_job_que_sysout
;
drop trigger    TK_JOB_Q_SIN
;
drop trigger tk_ana2lysis
;
drop trigger  tk_ana2_crse
;
drop trigger tk_ana2_req 
;
drop trigger tk_crs2_conv
;
drop trigger tk_dprog2_req
;
drop trigger tk_gmaster2
;
drop trigger tk_job2_queue_out
;
drop trigger tk_job2_queue_run 
;
drop trigger tk_job2_que_crse 
;
drop trigger tk_job2_que_dtl 
;
drop trigger tk_job2_que_sysout
;
drop trigger tk_job2_q_sin
;
drop trigger tk_mastref2_addres 
;
drop trigger tk_mastref2_seg	
;
drop trigger tk_repeat2
;
drop trigger tk_req2_text
;
drop trigger tk_req2_xy 
;
drop trigger tk_string2 
;
drop trigger tk_string2_crse
;
drop trigger tk_stu2_address
;
drop trigger tk_stu2_exceptions 
;
drop trigger tk_stu2_exc_crse
;
drop trigger tk_stu2_marker_req
;
drop trigger tk_stu2_master
;
drop trigger tk_stu2_trans
;
drop trigger tk_sub2_req
;
drop trigger tk_sub2_req_ar
;
drop trigger tk_sub2_req_text
;
drop trigger tk_tca2_rule
;
drop trigger tk_tca2_source
;
drop trigger tk_tca2_target
;
drop trigger  tU_com
;
drop trigger  tU_crs_convert
;
drop trigger  tU_dprog
;
drop trigger  tU_dprog_req
;
drop trigger  tU_gmaster
;
drop trigger  tU_mastref
;
drop trigger  tU_mastref_address
;
drop trigger  tU_mastref_seg
;
drop trigger  tU_repeat
;
drop trigger  tU_req_main
;
drop trigger  tU_req_text
;


alter table JOB_QUEUE_OUT
    drop foreign key FK_Reference_902
;

alter table JOB_QUEUE_REQ
    drop foreign key FK_Reference_903
;
alter table JOB_QUEUE_SUBREQ
    drop foreign key FK_Reference_904
;


alter table JOB_QUEUE_COURSE
   drop foreign key F_REF_55630
;
alter table JOB_QUEUE_COURSE
   drop foreign key FK_Reference_901
;

alter table JOB_QUEUE_SYSOUT
   drop foreign key F_REF_58209
;

alter table ANALYSIS_REQ
   drop foreign key FK_ANAL_2_REQ
;

alter table ANALYSIS_COURSES
   drop foreign key FK_ANAL_REQ_2_CRS
;

alter table DPROG_REQ
   drop foreign key F_RELATION_183
;

alter table JOB_QUEUE_DETAIL
   drop foreign key F_RELATION_4493
;

alter table JOB_QUEUE_SYSIN
   drop foreign key F_REF_56906
;

alter table MASTREF_ADDRESS
   drop foreign key F_REF_16608
;

alter table MASTREF_SEG
   drop foreign key F_REF_15108
;

alter table REQ_TEXT
   drop foreign key F_RELATION_2589
;

alter table REQ_XY
   drop foreign key F_RELATION_2607
;

alter table SUB_REQ
   drop foreign key F_RELATION_2577
;

alter table SECURE_IMPORT
   drop foreign key FK_SIMP_2_SMAST
;

alter table SECURE_INST
   drop foreign key FK_SINST_2_SMAST
;

alter table STRING_CRSE
   drop foreign key F_RELATION_1118
;

alter table STU_EGRP_COURSES
   drop foreign key F_REF_46007
;

alter table STU_ACADREC
   drop foreign key F_REF_23073
;

alter table STU_ADDRESS
   drop foreign key F_REF_12130
;

alter table STU_DEMO
   drop foreign key F_REF_23034
;

alter table STU_MARKER_REQ
   drop foreign key F_RELATION_3307
;

alter table STU_DPROG
   drop foreign key F_REF_23053
;

alter table STU_EGRP_COURSES
   drop foreign key FK_EGRP_2_EGRP_CRS
;

alter table STU_EVALGRP
   drop foreign key FK_STU_EVAL_2_MAST
;

alter table STU_EXC_COURSES
   drop foreign key F_REF_14062
;

alter table STU_EXCEPTIONS
   drop foreign key F_REF_23068
;

alter table STU_TRANS_DEGREE
   drop foreign key F_REF_23058
;

alter table SUB_REQ_AR
   drop foreign key SREQ_TO_SREQ_AR
;

alter table SUB_REQ_TEXT
   drop foreign key SREQ_TO_SREQ_TEXT
;

alter table TCA_RULE
   drop foreign key F_REF_10199
;

alter table TCA_SOURCE
   drop foreign key F_REF_11057
;

alter table TCA_TARGET
   drop foreign key F_REF_11060
;

alter table ANALYSIS
   drop primary key
;

alter table ANALYSIS_COURSES
   drop primary key
;

alter table ANALYSIS_REQ
   drop primary key
;

alter table COM
   drop primary key
;

alter table COND_CODES
   drop primary key
;

alter table COURSE_BANK
   drop primary key
;

alter table CRS_CONVERT
   drop primary key
;

alter table DPROG
   drop primary key
;

alter table DPROG_REQ
   drop primary key
;

alter table GMASTER
   drop primary key
;

alter table JOB_QUEUE_COURSE
   drop primary key
;

alter table JOB_QUEUE_DETAIL
   drop primary key
;

alter table JOB_QUEUE_LIST
   drop primary key
;

alter table JOB_QUEUE_OUT
   drop primary key
;

alter table JOB_QUEUE_RUN
   drop primary key
;

alter table JOB_QUEUE_SYSIN
   drop primary key
;

alter table MASTREF
   drop primary key
;

alter table MASTREF_ADDRESS
   drop primary key
;

alter table MASTREF_SEG
   drop primary key
;

alter table REPEAT
   drop primary key
;

alter table REQ_MAIN
   drop primary key
;

alter table REQ_TEXT
   drop primary key
;

alter table REQ_XY
   drop primary key
;

alter table SECURE_MASTER
   drop primary key
;

alter table STRING
   drop primary key
;

alter table STRING_CRSE
   drop primary key
;

alter table STU_ACADREC
   drop primary key
;

alter table STU_ADDRESS
   drop primary key
;

alter table STU_DEMO
   drop primary key
;

alter table STU_DPROG
   drop primary key
;

alter table STU_EGRP_COURSES
   drop primary key
;

alter table STU_EVALGRP
   drop primary key
;

alter table STU_EXC_COURSES
   drop primary key
;

alter table STU_EXCEPTIONS
   drop primary key
;

alter table STU_MARKER_REQ
   drop primary key
;

alter table STU_MASTER
   drop primary key
;

alter table STU_TRANS_DEGREE
   drop primary key
;

alter table SUB_REQ
   drop primary key
;

alter table SUB_REQ_AR
   drop primary key
;

alter table SUB_REQ_TEXT
   drop primary key
;

alter table TCA_MASTER
   drop primary key
;

alter table TCA_RULE
   drop primary key
;

alter table TCA_SOURCE
   drop primary key
;

alter table TCA_TARGET
   drop primary key
;

drop table tmp_ANALYSIS
;

rename table ANALYSIS to tmp_ANALYSIS
;

drop table tmp_ANALYSIS_COURSES
;

rename table ANALYSIS_COURSES to tmp_ANALYSIS_COURSES
;

drop table tmp_ANALYSIS_REQ
;

rename table ANALYSIS_REQ to tmp_ANALYSIS_REQ
;

drop table tmp_COM
;

rename table COM to tmp_COM
;

drop table tmp_COND_CODES
;

rename table COND_CODES to tmp_COND_CODES
;

drop table tmp_COURSE_BANK
;

rename table COURSE_BANK to tmp_COURSE_BANK
;

drop table tmp_CRS_CONVERT
;

rename table CRS_CONVERT to tmp_CRS_CONVERT
;

drop table tmp_DPROG
;

rename table DPROG to tmp_DPROG
;

drop table tmp_DPROG_REQ
;

rename table DPROG_REQ to tmp_DPROG_REQ
;

drop table tmp_GMASTER
;

rename table GMASTER to tmp_GMASTER
;

-- removed we are not converting data from job_queue_course
--drop table tmp_JOB_QUEUE_COURSE
--;

drop table JOB_QUEUE_COURSE 
;

drop table tmp_JOB_QUEUE_DETAIL
;

rename table JOB_QUEUE_DETAIL to tmp_JOB_QUEUE_DETAIL
;

drop table tmp_JOB_QUEUE_LIST
;

rename table JOB_QUEUE_LIST to tmp_JOB_QUEUE_LIST
;

drop table tmp_JOB_QUEUE_OUT
;

rename table JOB_QUEUE_OUT to tmp_JOB_QUEUE_OUT
;

drop table tmp_JOB_QUEUE_RUN
;

rename table JOB_QUEUE_RUN to tmp_JOB_QUEUE_RUN
;

drop table tmp_JOB_QUEUE_SYSIN
;

rename table JOB_QUEUE_SYSIN to tmp_JOB_QUEUE_SYSIN
;

drop table JOB_QUEUE_SYSOUT
;

drop table tmp_MASTREF
;

rename table MASTREF to tmp_MASTREF
;

drop table tmp_MASTREF_ADDRESS
;

rename table MASTREF_ADDRESS to tmp_MASTREF_ADDRESS
;

drop table tmp_MASTREF_SEG
;

rename table MASTREF_SEG to tmp_MASTREF_SEG
;

drop table tmp_REPEAT
;

rename table REPEAT to tmp_REPEAT
;

drop table tmp_REQ_MAIN
;

rename table REQ_MAIN to tmp_REQ_MAIN
;

drop table tmp_REQ_TEXT
;

rename table REQ_TEXT to tmp_REQ_TEXT
;

drop table tmp_REQ_XY
;

rename table REQ_XY to tmp_REQ_XY
;

drop table tmp_SECURE_MASTER
;

rename table SECURE_MASTER to tmp_SECURE_MASTER
;

drop table tmp_STRING
;

rename table STRING to tmp_STRING
;

drop table tmp_STRING_CRSE
;

rename table STRING_CRSE to tmp_STRING_CRSE
;

drop table tmp_STU_ACADREC
;

rename table STU_ACADREC to tmp_STU_ACADREC
;

drop table tmp_STU_ADDRESS
;

rename table STU_ADDRESS to tmp_STU_ADDRESS
;

drop table tmp_STU_DEMO
;

rename table STU_DEMO to tmp_STU_DEMO
;

drop table tmp_STU_DPROG
;

rename table STU_DPROG to tmp_STU_DPROG
;

drop table tmp_STU_EGRP_COURSES
;

rename table STU_EGRP_COURSES to tmp_STU_EGRP_COURSES
;

drop table tmp_STU_EVALGRP
;

rename table STU_EVALGRP to tmp_STU_EVALGRP
;

drop table tmp_STU_EXCEPTIONS
;

rename table STU_EXCEPTIONS to tmp_STU_EXCEPTIONS
;

drop table tmp_STU_EXC_COURSES
;

rename table STU_EXC_COURSES to tmp_STU_EXC_COURSES
;

drop table tmp_STU_MARKER_REQ
;

rename table STU_MARKER_REQ to tmp_STU_MARKER_REQ
;

drop table tmp_STU_MASTER
;

rename table STU_MASTER to tmp_STU_MASTER
;

drop table tmp_STU_TRANS_DEGREE
;

rename table STU_TRANS_DEGREE to tmp_STU_TRANS_DEGREE
;

drop table tmp_SUB_REQ
;

rename table SUB_REQ to tmp_SUB_REQ
;

drop table tmp_SUB_REQ_AR
;

rename table SUB_REQ_AR to tmp_SUB_REQ_AR
;

drop table tmp_SUB_REQ_TEXT
;

rename table SUB_REQ_TEXT to tmp_SUB_REQ_TEXT
;

drop table tmp_TCA_MASTER
;

rename table TCA_MASTER to tmp_TCA_MASTER
;

drop table tmp_TCA_RULE
;

rename table TCA_RULE to tmp_TCA_RULE
;

drop table tmp_TCA_SOURCE
;

rename table TCA_SOURCE to tmp_TCA_SOURCE
;

drop table tmp_TCA_TARGET
;

rename table TCA_TARGET to tmp_TCA_TARGET
;

--==============================================================
-- Table: ADV_CTLCD
--==============================================================
create table ADV_CTLCD
(
   ADV_ID               CHAR(20)               not null,
   CTLCD                CHAR(2)                not null,
   constraint P_KEY_1 primary key (ADV_ID, CTLCD)
)
;

--==============================================================
-- Table: ADV_DPROGS
--==============================================================
create table ADV_DPROGS
(
   ADV_ID               CHAR(20)               not null,
   DPROG                CHAR(15)               not null,
   constraint P_KEY_1 primary key (ADV_ID, DPROG)
)
;

--==============================================================
-- Table: ADV_FUNCTIONS
--==============================================================
create table ADV_FUNCTIONS
(
   ADV_FUNCTION         CHAR(40)               not null,
   ADV_ID               CHAR(20)               not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   AUTHORITY            CHAR(1)                not null,
   constraint P_KEY_1 primary key (ADV_ID, ADV_FUNCTION, INSTIDQ, INSTID, INSTCD)
)
;

--==============================================================
-- Table: ADV_INST
--==============================================================
create table ADV_INST
(
   ADV_ID               CHAR(20)               not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   constraint P_KEY_1 primary key (ADV_ID, INSTIDQ, INSTID, INSTCD)
)
;

--==============================================================
-- Table: ADV_MASTER
--==============================================================
create table ADV_MASTER
(
   ADV_ID               CHAR(20)               not null,
   PIN                  CHAR(20),
   ENCRYPTED_PIN        VARCHAR(80),
   name               VARCHAR(40),
   DEPT                 VARCHAR(40),
   REF_ADV_ID           VARCHAR(20),
   constraint P_KEY_1 primary key (ADV_ID)
)
;

--==============================================================
-- Table: ADV_REQ
--==============================================================
create table ADV_REQ
(
   ADV_ID               CHAR(20)               not null,
   RNAME                CHAR(9)                not null,
   constraint P_KEY_1 primary key (ADV_ID, RNAME)
)
;

--==============================================================
-- Table: ANALYSIS
--==============================================================
create table ANALYSIS
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   COMPLETE             VARCHAR(1),
   IP                   VARCHAR(1),
   SEQOUT               VARCHAR(1),
   REQCT                INTEGER,
   SREQCT               NUMERIC,
   USERID               CHAR(30),
   SOPRID               CHAR(8),
   STUNO                VARCHAR(13),
   STUNAME              VARCHAR(35),
   DPROG                VARCHAR(15),
   INSTCD               VARCHAR(3)             default ' ',
   DPMASK               CHAR(15),
   DEGREE_DATE          VARCHAR(10),
   CATLYT               VARCHAR(6),
   RUNTIME              CHAR(9),
   RUNDATE              CHAR(10),
   INSTID               CHAR(8)                default ' ',
   JOBID                CHAR(16),
   INSTIDQ              CHAR(2)                default ' ',
   constraint P_KEY_36 primary key (INT_SEQ_NO)
)
;

insert into ANALYSIS (INT_SEQ_NO,
COMPLETE,
IP,
SEQOUT,
REQCT,
SREQCT,
USERID,
SOPRID,
STUNO,
STUNAME,
DPROG,
INSTCD,
DPMASK,
DEGREE_DATE,
CATLYT,
RUNTIME,
RUNDATE,
INSTID,
JOBID,
INSTIDQ )
select INT_SEQ_NO,
COMPLETE,
IP,
SEQOUT,
REQCT,
SREQCT,
USERID,
SOPRID,
STUNO,
STUNAME,
DPROG,
INSTCD,
DPMASK,
DEGREE_DATE,
CATLYT,
RUNTIME,
RUNDATE,
INSTID,
JOBID,
INSTIDQ 
from tmp_ANALYSIS
;

drop table tmp_ANALYSIS
;

--==============================================================
-- Index: ANALYSIS_IDX
--==============================================================
create index ANALYSIS_IDX on ANALYSIS (
   STUNO                ASC,
   DPROG                ASC,
   DPMASK               ASC,
   CATLYT               ASC,
   JOBID                ASC
)
;

--==============================================================
-- Table: ANALYSIS_COURSES
--==============================================================
create table ANALYSIS_COURSES
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   JOBQ_SEQ_NO          NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   COURSE               VARCHAR(15),
   PASSFAIL             VARCHAR(1),
   YEARTM               CHAR(6)                default '0000',
   CREDIT               NUMERIC(7,5)           default 0,
   constraint P_KEY_38 primary key (INT_SEQ_NO)
)
;

insert into ANALYSIS_COURSES (INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, COURSE, PASSFAIL, YEARTM, CREDIT)
select INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, COURSE, PASSFAIL, YEARTM, CREDIT
from tmp_ANALYSIS_COURSES
;

drop table tmp_ANALYSIS_COURSES
;

--==============================================================
-- Index: ANALYSIS_CRS_IDX
--==============================================================
create index ANALYSIS_CRS_IDX on ANALYSIS_COURSES (
   JOBQ_SEQ_NO          ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: ANALYSIS_REQ
--==============================================================
create table ANALYSIS_REQ
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   JOBQ_SEQ_NO          NUMERIC(9)             not null default 0,
   RCT                  NUMERIC(2),
   SRCT                 NUMERIC(3),
   RNAME                VARCHAR(9),
   PSNAME               VARCHAR(15),
   RNO                  NUMERIC(2),
   SNO                  NUMERIC(3),
   MET                  VARCHAR(1),
   FMET                 VARCHAR(1),
   SEQOUT               VARCHAR(1),
   REQCT                NUMERIC(2),
   GOTCT                NUMERIC(3),
   REQHRS               NUMERIC(5,2),
   GOTHRS               NUMERIC(5,2),
   REQGPA               NUMERIC(4,3),
   GOTGPA               NUMERIC(4,3),
   GOTGPAHRS            NUMERIC(5,2),
   GOTGPAPTS            NUMERIC(9,5)           default 0,
   constraint P_KEY_37 primary key (INT_SEQ_NO)
)
;

insert into ANALYSIS_REQ (INT_SEQ_NO, JOBQ_SEQ_NO, RCT, SRCT, RNAME, PSNAME, RNO, SNO, MET, FMET, SEQOUT, REQCT, GOTCT, REQHRS, GOTHRS, REQGPA, GOTGPA, GOTGPAHRS, GOTGPAPTS)
select INT_SEQ_NO, JOBQ_SEQ_NO, RCT, SRCT, RNAME, PSNAME, RNO, SNO, MET, FMET, SEQOUT, REQCT, GOTCT, REQHRS, GOTHRS, REQGPA, GOTGPA, GOTGPAHRS, GOTGPAPTS
from tmp_ANALYSIS_REQ
;

drop table tmp_ANALYSIS_REQ
;

--==============================================================
-- Index: ANALYSIS_REQ_IDX
--==============================================================
create index ANALYSIS_REQ_IDX on ANALYSIS_REQ (
   JOBQ_SEQ_NO          ASC,
   RCT                  ASC,
   SRCT                 ASC,
   RNAME                ASC,
   PSNAME               ASC
)
;

--==============================================================
-- Index: ANALYSIS_REQ_IDX2
--==============================================================
create index ANALYSIS_REQ_IDX2 on ANALYSIS_REQ (
   JOBQ_SEQ_NO          ASC,
   RNO                  ASC,
   SNO                  ASC,
   RNAME                ASC,
   PSNAME               ASC
)
;

--==============================================================
-- Table: CHART_CATEGORIES
--==============================================================
create table CHART_CATEGORIES
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   CATEGORY_CODE        CHAR(1)                not null,
   CATEGORY_NAME        CHAR(15),
   CATEGORY_DESC        VARCHAR(255),
   TRANSCRIPT           CHAR(1),
   TOTAL_HOUR           CHAR(1),
   TOTAL_GPA            CHAR(1),
   HIDEFROMCHART        CHAR(1),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_1 primary key (INSTIDQ, INSTID, INSTCD, CATEGORY_CODE)
)
;

--==============================================================
-- Index: CHART_CAT_IDX
--==============================================================
create index CHART_CAT_IDX on CHART_CATEGORIES (
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   CATEGORY_CODE        ASC,
   TRANSCRIPT           ASC,
   HIDEFROMCHART        ASC,
   TOTAL_HOUR           ASC
)
;

--==============================================================
-- Table: COM
--==============================================================
create table COM
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   COMKEY               CHAR(5)                not null default ' ',
   COMFIELD             CHAR(10)               not null,
   COMVALUE             VARCHAR(255),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_14 primary key (INSTIDQ, INSTID, INSTCD, COMKEY, COMFIELD)
)
;

insert into COM (INSTIDQ, INSTID, INSTCD, COMKEY, COMFIELD, COMVALUE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, COMKEY, COMFIELD, COMVALUE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_COM
;

drop table tmp_COM
;

--==============================================================
-- Index: COM_IDX
--==============================================================
create unique index COM_IDX on COM (
   COMKEY               ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   COMFIELD             ASC
)
;

--==============================================================
-- Table: COND_CODES
--==============================================================
create table COND_CODES
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   COMKEY               CHAR(5)                not null default ' ',
   SEQ_NO               INTEGER                not null default 0,
   COND_CODE            CHAR(1),
   COURSE_CC_DESC       CHAR(80),
   SYSTEM_CC_DESC       CHAR(80),
   LAST_MOD_DATE        TIMESTAMP,
   LAST_MOD_USER        VARCHAR(30),
   constraint P_KEY_41 primary key (INSTIDQ, INSTID, INSTCD, COMKEY, SEQ_NO)
)
;

insert into COND_CODES (INSTIDQ, INSTID, INSTCD, COMKEY, SEQ_NO, COND_CODE, COURSE_CC_DESC, SYSTEM_CC_DESC, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, COMKEY, SEQ_NO, COND_CODE, COURSE_CC_DESC, SYSTEM_CC_DESC, LAST_MOD_USER, LAST_MOD_DATE
from tmp_COND_CODES
;

drop table tmp_COND_CODES
;

--==============================================================
-- Table: COURSE_BANK
--==============================================================
create table COURSE_BANK
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   COURSE               CHAR(15)               not null,
   PFLG                 CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_44 primary key (INSTIDQ, INSTID, INSTCD, COURSE)
)
;

insert into COURSE_BANK (INSTIDQ, INSTID, INSTCD, COURSE, PFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, COURSE, PFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_COURSE_BANK
;

drop table tmp_COURSE_BANK
;

--==============================================================
-- Table: CRS_CONVERT
--==============================================================
create table CRS_CONVERT
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                default ' ',
   INSTID               CHAR(8)                default ' ',
   INSTCD               CHAR(3)                default ' ',
   USER_SEQ_NO          INTEGER                default 0,
   OLDCRSE              CHAR(15),
   NEWCRSE              CHAR(15),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_4 primary key (INT_SEQ_NO)
)
;

insert into CRS_CONVERT (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, OLDCRSE, NEWCRSE, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, OLDCRSE, NEWCRSE, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_CRS_CONVERT
;

drop table tmp_CRS_CONVERT
;

--==============================================================
-- Index: CONVERT_IDX
--==============================================================
create index CONVERT_IDX on CRS_CONVERT (
   INSTID               ASC,
   INSTCD               ASC,
   INSTIDQ              ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: DPROG
--==============================================================
create table DPROG
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   DPROG                CHAR(15)               not null,
   DPFYT                CHAR(6)                not null default '0000',
   LYT                  CHAR(6)                default '9999',
   DPTITLE1             VARCHAR(65),
   DPTITLE2             VARCHAR(65),
   WEBTITLE             VARCHAR(50),
   COLLEGE              VARCHAR(10),
   MAJOR                VARCHAR(10),
   DEGREE               VARCHAR(10),
   LOCATION             VARCHAR(10),
   DPCIPS               CHAR(6),
   DPMASK               CHAR(15),
   DPSTATUS             CHAR(1),
   EFILTER              CHAR(15),
   INSTPAD              VARCHAR(44),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   DPTYPE               CHAR(1),
   constraint P_KEY_1 primary key (INSTIDQ, INSTID, INSTCD, DPROG, DPFYT)
)
;

insert into DPROG (INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, LYT, DPTITLE1, DPTITLE2, WEBTITLE, COLLEGE, MAJOR, DEGREE, LOCATION, DPCIPS, DPMASK, DPSTATUS, EFILTER, INSTPAD, MEMO, LAST_MOD_USER,   LAST_MOD_DATE, DPTYPE)
select INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, LYT, DPTITLE1, DPTITLE2, WEBTITLE, COLLEGE, MAJOR, DEGREE, LOCATION, DPCIPS, DPMASK, DPSTATUS, EFILTER, INSTPAD, MEMO, LAST_MOD_USER,   LAST_MOD_DATE, DPTYPE
from tmp_DPROG
;

drop table tmp_DPROG
;

--==============================================================
-- Index: DPROG_IDX
--==============================================================
create unique index DPROG_IDX on DPROG (
   DPROG                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   DPFYT                ASC,
   LYT                  ASC
)
;

--==============================================================
-- Index: WEBTITLE_IDX
--==============================================================
create index WEBTITLE_IDX on DPROG (
   WEBTITLE             ASC,
   DPROG                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   DPFYT                ASC,
   LYT                  ASC
)
;

--==============================================================
-- Table: DPROG_REQ
--==============================================================
create table DPROG_REQ
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   DPROG                CHAR(15)               not null,
   DPFYT                CHAR(6)                not null default '0000',
   USER_SEQ_NO          INTEGER                default 0,
   DPRNAME              CHAR(9)                not null,
   GRP1                 CHAR(1),
   GRP2                 CHAR(1),
   ORFLG                CHAR(1),
   OPTFLG               CHAR(1),
   SUMGRP               CHAR(1),
   CRLINK               CHAR(1),
   ALTCFLG              CHAR(1),
   SORTFLG              CHAR(1),
   EXTEND               CHAR(1),
   CALCGRP              CHAR(1),
   CALCFLG              CHAR(1),
   RUNSTATUS            CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   CATEGORY             CHAR(1),
   constraint P_KEY_2 primary key (INT_SEQ_NO)
)
;

insert into DPROG_REQ (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, USER_SEQ_NO, DPRNAME, GRP1, GRP2, ORFLG, OPTFLG, SUMGRP, CRLINK, ALTCFLG, SORTFLG, EXTEND, CALCGRP, CALCFLG, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, USER_SEQ_NO, DPRNAME, GRP1, GRP2, ORFLG, OPTFLG, SUMGRP, CRLINK, ALTCFLG, SORTFLG, EXTEND, CALCGRP, CALCFLG, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_DPROG_REQ
;

drop table tmp_DPROG_REQ
;

--==============================================================
-- Index: DPROG_REQ_IDX
--==============================================================
create index DPROG_REQ_IDX on DPROG_REQ (
   DPROG                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   DPFYT                ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: GMASTER
--==============================================================
create table GMASTER
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                default ' ',
   INSTID               CHAR(8)                default ' ',
   INSTCD               CHAR(3)                default ' ',
   LINE_TYPE            CHAR(1)                default ' ',
   USER_SEQ_NO          INTEGER                default 0,
   GRADE                CHAR(4),
   RGRADE               CHAR(4),
   GPAPT                NUMERIC(4,3)           default 0,
   GPACAL               CHAR(1),
   ADDCR                CHAR(1),
   ADDCT                CHAR(1),
   PSEUDO               CHAR(1),
   FORCE                CHAR(1),
   IP                   CHAR(1),
   CTLCD                CHAR(2),
   ACTION               CHAR(1),
   RUFLG                CHAR(1),
   CONDG                CHAR(6),
   DELIG                CHAR(1),
   REPLAC               CHAR(1),
   CREDITCK             CHAR(1),
   LCREDIT              NUMERIC(4,2)           default 0,
   HCREDIT              NUMERIC(4,2)           default 0,
   AC                   CHAR(1),
   RC                   CHAR(1),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_3 primary key (INT_SEQ_NO)
)
;

insert into GMASTER (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, LINE_TYPE, USER_SEQ_NO, GRADE, RGRADE, GPAPT, GPACAL, ADDCR, ADDCT, PSEUDO, FORCE, IP, CTLCD, ACTION, RUFLG, CONDG, DELIG, REPLAC, CREDITCK, LCREDIT, HCREDIT, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, LINE_TYPE, USER_SEQ_NO, GRADE, RGRADE, GPAPT, GPACAL, ADDCR, ADDCT, PSEUDO, FORCE, IP, CTLCD, ACTION, RUFLG, CONDG, DELIG, REPLAC, CREDITCK, LCREDIT, HCREDIT, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_GMASTER
;

drop table tmp_GMASTER
;

--==============================================================
-- Index: GMASTER_IDX
--==============================================================
create index GMASTER_IDX on GMASTER (
   INSTID               ASC,
   INSTCD               ASC,
   INSTIDQ              ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: JOB_QUEUE_ACCEPT
--==============================================================
create table JOB_QUEUE_ACCEPT
(
   JOBQ_SEQ_NO          NUMERIC(9)             not null default 0,
   RTABX                CHAR(3)                not null,
   STABX                CHAR(3)                not null,
   CTABX                CHAR(4)                not null,
   COURSE               VARCHAR(15),
   TITLE                VARCHAR(29),
   REJECT               CHAR(1),
   USED                 CHAR(1),
   LOGIC                CHAR(1),
   REQUIRED             CHAR(1),
   CMPRTITLE            CHAR(1),
   RANGECOURSE          CHAR(15),
   LOWYT                CHAR(6),
   HIGHYT               CHAR(6),
   constraint P_KEY_1 primary key (JOBQ_SEQ_NO, RTABX, STABX, CTABX)
)
;

--==============================================================
-- Index: JOBQ_ACCEPT_IDX
--==============================================================
create index JOBQ_ACCEPT_IDX on JOB_QUEUE_ACCEPT (
   JOBQ_SEQ_NO          ASC,
   RTABX                ASC,
   STABX                ASC,
   CTABX                ASC,
   REJECT               ASC
)
;

--==============================================================
-- Table: JOB_QUEUE_COURSE
--==============================================================
create table JOB_QUEUE_COURSE
(
   JOBQ_SEQ_NO          NUMERIC(9)             not null,
   RTABX                CHAR(3)                not null,
   STABX                CHAR(3)                not null,
   ETABX                CHAR(3)                not null,
   YT                   CHAR(6),
   EDIT_YT              CHAR(4),
   COURSE               VARCHAR(15),
   XCOURSE              VARCHAR(15),
   RCREDIT              NUMERIC(10,5),
   CREDIT               NUMERIC(10,5),
   GPAHRS               NUMERIC(10,5),
   GPAPTS               NUMERIC(10,5),
   GPA                  NUMERIC(10,5),
   GRADE                CHAR(4),
   RGRADE               CHAR(4),
   IP                   CHAR(1),
   WHATIF               CHAR(1),
   CTITLE               VARCHAR(29),
   RTITLE               VARCHAR(29),
   STITLE               VARCHAR(29),
   CVTTITLE             VARCHAR(29),
   ALTTITLE             VARCHAR(29),
   constraint P_KEY_1 primary key (JOBQ_SEQ_NO, RTABX, STABX, ETABX)
)
;
--- DARS NOTES - Warning here was generated by the design tool, but this table
---              was not used in the 3.0 darwin and has undergone significant design
---              changes in 3.5 with new columns, name changes etc.  3.0 did not
---              really use this data so there is nothing to convert so the process
---              is drop the job_queue_course table, then recreate it with the new
---              definition without moving any data (because there should be none to move)
--WARNING: The following insert order will fail because it cannot give value to mandatory columns
---insert into JOB_QUEUE_COURSE (JOBQ_SEQ_NO, RTABX, STABX, ETABX, RCREDIT, GRADE, CTITLE)
---select ?, ?, ?, ?, RCREDIT, GRADE, CTITLE
---from tmp_JOB_QUEUE_COURSE
;
--WARNING: Drop canceled because mandatory columns must have a value
--drop table tmp_JOB_QUEUE_COURSE
--;
--==============================================================
-- Table: JOB_QUEUE_DETAIL
--==============================================================
create table JOB_QUEUE_DETAIL
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   JOBID                CHAR(16)               not null,
   USERID               CHAR(30)               not null,
   USER_SEQ_NO          INTEGER                not null default 0,
   STUNO                CHAR(13),
   COMKEY               CHAR(5),
   EVALSW               CHAR(1),
   F1OR2                CHAR(1),
   REPORT               CHAR(1),
   PNTREQ               CHAR(1),
   LISTALL              CHAR(1),
   TEST                 CHAR(1),
   FDPROG               CHAR(15),
   FCATLYT              CHAR(6),
   SINSTID              CHAR(8),
   SINSTCD              CHAR(3),
   FDPMASK              CHAR(15),
   TIME_TOKEN           CHAR(6),
   LASERTEXT            CHAR(1),
   FORMAT               CHAR(1),
   PARSEFLG             CHAR(8),
   REVART               CHAR(1),
   BINSTID              CHAR(8),
   BINSTCD              CHAR(3),
   BYTAKEN              CHAR(6),
   SOPRID               CHAR(8),
   constraint P_KEY_17 primary key (INT_SEQ_NO)
)
;

insert into JOB_QUEUE_DETAIL (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, STUNO, COMKEY, EVALSW, F1OR2, REPORT, PNTREQ, LISTALL, TEST, FDPROG, FCATLYT, SINSTID, SINSTCD, FDPMASK, TIME_TOKEN, LASERTEXT, FORMAT, PARSEFLG, REVART, BINSTID, BINSTCD, BYTAKEN, SOPRID)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, STUNO, COMKEY, EVALSW, F1OR2, REPORT, PNTREQ, LISTALL, TEST, FDPROG, FCATLYT, SINSTID, SINSTCD, FDPMASK, TIME_TOKEN, LASERTEXT, FORMAT, PARSEFLG, REVART, BINSTID, BINSTCD, BYTAKEN, SOPRID
from tmp_JOB_QUEUE_DETAIL
;

drop table tmp_JOB_QUEUE_DETAIL
;

--==============================================================
-- Index: JOB_Q_DETAIL_IDX
--==============================================================
create index JOB_Q_DETAIL_IDX on JOB_QUEUE_DETAIL (
   JOBID                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   USERID               ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: JOB_QUEUE_LIST
--==============================================================
create table JOB_QUEUE_LIST
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   JOBID                CHAR(16)               not null,
   USERID               CHAR(30)               not null,
   STATUS               CHAR(1)                default 'N',
   PRIORITY             INTEGER                default 100,
   STARTDATE            CHAR(10),
   STARTTIME            CHAR(5),
   EXTERNAL_EVAL        CHAR(1),
   READ_SYSIN           CHAR(1),
   SERVERNAME           CHAR(10),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_16 primary key (INSTIDQ, INSTID, INSTCD, JOBID, USERID)
)
;

insert into JOB_QUEUE_LIST (INSTIDQ, INSTID, INSTCD, JOBID, USERID, STATUS, PRIORITY, STARTDATE, STARTTIME, EXTERNAL_EVAL, READ_SYSIN, SERVERNAME, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, JOBID, USERID, STATUS, PRIORITY, STARTDATE, STARTTIME, EXTERNAL_EVAL, READ_SYSIN, SERVERNAME, LAST_MOD_USER, LAST_MOD_DATE
from tmp_JOB_QUEUE_LIST
;

drop table tmp_JOB_QUEUE_LIST
;

--==============================================================
-- Index: JOB_Q_LIST_IDX
--==============================================================
create index JOB_Q_LIST_IDX on JOB_QUEUE_LIST (
   STATUS               ASC,
   STARTDATE            ASC,
   STARTTIME            ASC,
   PRIORITY             ASC
)
;

--==============================================================
-- Index: JOB_Q_LIST_JOBIDX
--==============================================================
create index JOB_Q_LIST_JOBIDX on JOB_QUEUE_LIST (
   JOBID                ASC
)
;

--==============================================================
-- Table: JOB_QUEUE_OUT
--==============================================================
create table JOB_QUEUE_OUT
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   JOBQ_SEQ_NO          NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   RTABX                CHAR(2),
   REQSTATUS            CHAR(1),
   STABX                CHAR(3),
   SRNO                 CHAR(2),
   SRSTATUS             CHAR(1),
   OPTLINE              CHAR(1),
   LASERA               CHAR(1),
   LASERB               CHAR(1),
   DAROUT               VARCHAR(255),
   constraint P_KEY_22 primary key (INT_SEQ_NO)
)
;

insert into JOB_QUEUE_OUT (INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, RTABX, REQSTATUS, STABX, SRNO, SRSTATUS, OPTLINE, LASERA, LASERB, DAROUT)
select INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, RTABX, REQSTATUS, STABX, SRNO, SRSTATUS, OPTLINE, LASERA, LASERB, DAROUT
from tmp_JOB_QUEUE_OUT
;

drop table tmp_JOB_QUEUE_OUT
;

--==============================================================
-- Index: JOB_Q_OUT_IDX
--==============================================================
create index JOB_Q_OUT_IDX on JOB_QUEUE_OUT (
   JOBQ_SEQ_NO          ASC,
   USER_SEQ_NO          ASC,
   RTABX                ASC,
   STABX                ASC,
   OPTLINE              ASC
)
;

--==============================================================
-- Table: JOB_QUEUE_REQ
--==============================================================
create table JOB_QUEUE_REQ
(
   JOBQ_SEQ_NO          NUMERIC(9)             not null,
   RTABX                CHAR(3)                not null,
   RNO                  CHAR(3),
   RNAME                VARCHAR(9),
   PSNAME               VARCHAR(15),
   CATEGORY             VARCHAR(15),
   SUMMARY_GRP          VARCHAR(15),
   TRANSCRIPT           CHAR(1),
   TOTAL_HOUR           CHAR(1),
   TOTAL_GPA            CHAR(1),
   HIDEFROMCHART        CHAR(1),
   SATISFIED            CHAR(1),
   SUMMARY              CHAR(1),
   SORTFLG              CHAR(1),
   ORREQ                CHAR(1),
   OPTREQ               CHAR(1),
   REQSRQ               INTEGER,
   GOTSRQ               INTEGER,
   NEEDSRQ              INTEGER,
   REQCT                INTEGER,
   GOTCT                INTEGER,
   IPCT                 INTEGER,
   WHATIFCT             INTEGER,
   NEEDCT               INTEGER,
   MAXHRS               NUMERIC(10,5),
   REQHRS               NUMERIC(10,5),
   EST_REQHRS           NUMERIC(10,5),
   GOTHRS               NUMERIC(10,5),
   IPHRS                NUMERIC(10,5),
   WHATIFHRS            NUMERIC(10,5),
   NEEDHRS              NUMERIC(10,5),
   GOTGPAHRS            NUMERIC(10,5),
   GOTGPAPTS            NUMERIC(10,5),
   REQGPA               NUMERIC(10,5),
   GOTGPA               NUMERIC(10,5),
   NEEDGPA              NUMERIC(10,5),
   constraint P_KEY_1 primary key (JOBQ_SEQ_NO, RTABX)
)
;

--==============================================================
-- Index: JOBQ_REQ_IDX
--==============================================================
create index JOBQ_REQ_IDX on JOB_QUEUE_REQ (
   JOBQ_SEQ_NO          ASC,
   RTABX                ASC,
   RNAME                ASC,
   CATEGORY             ASC,
   SUMMARY_GRP          ASC,
   TRANSCRIPT           ASC,
   TOTAL_HOUR           ASC,
   HIDEFROMCHART        ASC,
   SUMMARY              ASC
)
;

--==============================================================
-- Table: JOB_QUEUE_RUN
--==============================================================
create table JOB_QUEUE_RUN
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                default ' ',
   INSTID               CHAR(8)                default ' ',
   INSTCD               CHAR(3)                default ' ',
   JOBID                CHAR(16)               default ' ',
   USERID               CHAR(30)               default ' ',
   SOPRID               CHAR(8)                default ' ',
   STUNO                CHAR(13)               default ' ',
   DPROG                CHAR(15)               default ' ',
   DPMASK               CHAR(15)               default ' ',
   CATLYT               CHAR(6)                default ' ',
   BINSTID              CHAR(8),
   BINSTCD              CHAR(3),
   RUNDATE              CHAR(10),
   JOBQ_SYSOUT_USED     CHAR(1),
   RUNTIME              CHAR(8),
   NCOL                 CHAR(1),
   COMPLETE             CHAR(1),
   IP                   CHAR(1),
   constraint P_KEY_23 primary key (INT_SEQ_NO)
)
;

insert into JOB_QUEUE_RUN (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, SOPRID, STUNO, DPROG, DPMASK, CATLYT, BINSTID, BINSTCD, RUNDATE, JOBQ_SYSOUT_USED, RUNTIME, NCOL, COMPLETE, IP)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, SOPRID, STUNO, DPROG, DPMASK, CATLYT, BINSTID, BINSTCD, RUNDATE, JOBQ_SYSOUT_USED, RUNTIME, NCOL, COMPLETE, IP
from tmp_JOB_QUEUE_RUN
;

drop table tmp_JOB_QUEUE_RUN
;

--==============================================================
-- Index: JOBQ_RUN_IDX
--==============================================================
create index JOBQ_RUN_IDX on JOB_QUEUE_RUN (
   STUNO                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   SOPRID               ASC,
   DPROG                ASC,
   DPMASK               ASC,
   CATLYT               ASC,
   USERID               ASC
)
;

--==============================================================
-- Table: JOB_QUEUE_SUBREQ
--==============================================================
create table JOB_QUEUE_SUBREQ
(
   JOBQ_SEQ_NO          NUMERIC(9)             not null,
   RTABX                CHAR(3)                not null,
   STABX                CHAR(3)                not null,
   SNO                  CHAR(3),
   SATISFIED            CHAR(1),
   SORTFLG              CHAR(1),
   ORSUB                CHAR(1),
   OPTSUB               CHAR(1),
   REQCT                INTEGER,
   GOTCT                INTEGER,
   NEEDCT               INTEGER,
   IPCT                 INTEGER,
   WHATIFCT             INTEGER,
   MAXHRS               NUMERIC(10,5),
   REQHRS               NUMERIC(10,5),
   EST_REQHRSFLG        CHAR(1),
   EST_REQHRS           NUMERIC(10,5),
   GOTHRS               NUMERIC(10,5),
   IPHRS                NUMERIC(10,5),
   WHATIFHRS            NUMERIC(10,5),
   NEEDHRS              NUMERIC(10,5),
   REQGPA               NUMERIC(10,5),
   GOTGPA               NUMERIC(10,5),
   NEEDGPA              NUMERIC(10,5),
   GOTGPAHRS            NUMERIC(10,5),
   GOTGPAPTS            NUMERIC(10,5)          default 0,
   constraint P_KEY_1 primary key (JOBQ_SEQ_NO, RTABX, STABX)
)
;

--==============================================================
-- Table: JOB_QUEUE_SYSIN
--==============================================================
create table JOB_QUEUE_SYSIN
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                default ' ',
   INSTID               CHAR(8)                default ' ',
   INSTCD               CHAR(3)                default ' ',
   JOBID                CHAR(16),
   USERID               CHAR(30),
   USER_SEQ_NO          INTEGER                default 0,
   SYSIN                CHAR(80),
   constraint P_KEY_46 primary key (INT_SEQ_NO)
)
;

insert into JOB_QUEUE_SYSIN (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, SYSIN)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, SYSIN
from tmp_JOB_QUEUE_SYSIN
;

drop table tmp_JOB_QUEUE_SYSIN
;

--==============================================================
-- Table: MASTREF
--==============================================================
create table MASTREF
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   SOURCE_ID            CHAR(8)                not null default ' ',
   SOURCE_CD            CHAR(3)                not null default ' ',
   MRFYT                CHAR(6)                not null default '0000',
   LYT                  CHAR(6)                default '9999',
   INAME                VARCHAR(60),
   ITYPE                CHAR(2),
   STATUS               CHAR(1),
   CRSCASE              CHAR(1),
   GRDCASE              CHAR(1),
   SOURCEIDQ            CHAR(2),
   BACC                 CHAR(1),
   ACTC                 CHAR(1),
   AGCLC                CHAR(2),
   HONORS               CHAR(1),
   REPEATF              CHAR(1),
   CSCALE               CHAR(1),
   CASSIGN              CHAR(1),
   CEXCESS              CHAR(1),
   CFINAL               CHAR(1),
   DCOURSE              CHAR(15),
   DPFLG                CHAR(1),
   GRULE                CHAR(1),
   GPARULE              CHAR(1),
   DGRADE               CHAR(4),
   D0GRADE              CHAR(4),
   CRSMASK              CHAR(15),
   REFUCOND1            CHAR(3),
   REFUCOND2            CHAR(3),
   REFUCOND3            CHAR(3),
   GRDREQ               CHAR(1),
   GPASCALE             CHAR(1),
   UNITSCALE            NUMERIC(6,4)           default 0,
   DINSTID              CHAR(8),
   DINSTCD              CHAR(3),
   DEPTBGN              NUMERIC(2)             default 0,
   DEPTEND              NUMERIC(2)             default 0,
   CRSBGN               NUMERIC(2)             default 0,
   CRSEND               NUMERIC(2)             default 0,
   RPTINSTID            CHAR(8),
   TAINSTID             CHAR(8),
   TAINSTCD             CHAR(3),
   REFONLY              CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_15 primary key (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT)
)
;

insert into MASTREF (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, LYT, INAME, ITYPE, STATUS, CRSCASE, GRDCASE, SOURCEIDQ, BACC, ACTC, AGCLC, HONORS, REPEATF, CSCALE, CASSIGN, CEXCESS, CFINAL, DCOURSE, DPFLG, GRULE, GPARULE, DGRADE, D0GRADE, CRSMASK, REFUCOND1, REFUCOND2, REFUCOND3, GRDREQ, GPASCALE, UNITSCALE, DINSTID, DINSTCD, DEPTBGN, DEPTEND, CRSBGN, CRSEND, RPTINSTID, TAINSTID, TAINSTCD, REFONLY, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, LYT, INAME, ITYPE, STATUS, CRSCASE, GRDCASE, SOURCEIDQ, BACC, ACTC, AGCLC, HONORS, REPEATF, CSCALE, CASSIGN, CEXCESS, CFINAL, DCOURSE, DPFLG, GRULE, GPARULE, DGRADE, D0GRADE, CRSMASK, REFUCOND1, REFUCOND2, REFUCOND3, GRDREQ, GPASCALE, UNITSCALE, DINSTID, DINSTCD, DEPTBGN, DEPTEND, CRSBGN, CRSEND, RPTINSTID, TAINSTID, TAINSTCD, REFONLY, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_MASTREF
;

drop table tmp_MASTREF
;

--==============================================================
-- Index: MASTREF_IDX
--==============================================================
create unique index MASTREF_IDX on MASTREF (
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   MRFYT                ASC,
   LYT                  ASC
)
;

--==============================================================
-- Table: MASTREF_ADDRESS
--==============================================================
create table MASTREF_ADDRESS
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   SOURCE_ID            CHAR(8)                not null default ' ',
   SOURCE_CD            CHAR(3)                not null default ' ',
   MRFYT                CHAR(6)                not null default '0000',
   USER_SEQ_NO          INTEGER                default 0,
   ADDRESS1             VARCHAR(35),
   ADDRESS2             VARCHAR(35),
   CITY                 VARCHAR(30),
   STATE                VARCHAR(2),
   ZIP                  VARCHAR(10),
   COUNTRY              VARCHAR(3),
   LOCATIONQ            VARCHAR(2),
   LOCATIONID           VARCHAR(25),
   CONTACTCD            VARCHAR(2),
   CONTACTNAME          VARCHAR(35),
   COMMNOQ              VARCHAR(2),
   FAX                  VARCHAR(25),
   PHONE                VARCHAR(25),
   E_MAIL               VARCHAR(80),
   FROM_DATE            CHAR(8),
   TO_DATE              CHAR(8),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_33 primary key (INT_SEQ_NO)
)
;

insert into MASTREF_ADDRESS (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, CONTACTCD, CONTACTNAME, COMMNOQ, FAX, PHONE, E_MAIL, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, CONTACTCD, CONTACTNAME, COMMNOQ, FAX, PHONE, E_MAIL, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_MASTREF_ADDRESS
;

drop table tmp_MASTREF_ADDRESS
;

--==============================================================
-- Index: MASTREF_ADDR_IDX
--==============================================================
create index MASTREF_ADDR_IDX on MASTREF_ADDRESS (
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   MRFYT                ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: MASTREF_SEG
--==============================================================
create table MASTREF_SEG
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   SOURCE_ID            CHAR(8)                not null default ' ',
   SOURCE_CD            CHAR(3)                not null default ' ',
   MRFYT                CHAR(6)                not null default '0000',
   USER_SEQ_NO          INTEGER                default 0,
   LTYPE                CHAR(1),
   I2UFLG               CHAR(1),
   GRADE                CHAR(4),
   AC                   CHAR(1),
   RC                   CHAR(1),
   U2IFLG               CHAR(1),
   UGRADE               CHAR(4),
   ACU                  CHAR(3),
   RCU                  CHAR(3),
   GPAPT                NUMERIC(4,3)           default 0,
   GPACAL               CHAR(1),
   ADDCR                CHAR(1),
   ADDCT                CHAR(1),
   COND1                CHAR(1),
   COND2                CHAR(1),
   UCOND1               CHAR(3),
   UCOND2               CHAR(3),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_32 primary key (INT_SEQ_NO)
)
;

insert into MASTREF_SEG (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, LTYPE, I2UFLG, GRADE, AC, RC, U2IFLG, UGRADE, ACU, RCU, GPAPT, GPACAL, ADDCR, ADDCT, COND1, COND2, UCOND1, UCOND2, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, LTYPE, I2UFLG, GRADE, AC, RC, U2IFLG, UGRADE, ACU, RCU, GPAPT, GPACAL, ADDCR, ADDCT, COND1, COND2, UCOND1, UCOND2, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_MASTREF_SEG
;

drop table tmp_MASTREF_SEG
;

--==============================================================
-- Index: MASTER_IDX
--==============================================================
create index MASTER_IDX on MASTREF_SEG (
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   MRFYT                ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: REPEAT
--==============================================================
create table REPEAT
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                default ' ',
   INSTID               CHAR(8)                default ' ',
   INSTCD               CHAR(3)                default ' ',
   USER_SEQ_NO          INTEGER                default 0,
   COURSE               CHAR(15),
   CTITLE               VARCHAR(29),
   HMAX                 NUMERIC(4,1)           default 0,
   CHFLAG               CHAR(1),
   AC                   CHAR(1),
   RC                   CHAR(1),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_5 primary key (INT_SEQ_NO)
)
;

insert into REPEAT (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, COURSE, CTITLE, HMAX, CHFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, COURSE, CTITLE, HMAX, CHFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_REPEAT
;

drop table tmp_REPEAT
;

--==============================================================
-- Index: REPEAT_IDX
--==============================================================
create index REPEAT_IDX on REPEAT (
   INSTID               ASC,
   INSTCD               ASC,
   INSTIDQ              ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: REQ_MAIN
--==============================================================
create table REQ_MAIN
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null default '0000',
   LYT                  CHAR(6)                default '9999',
   REQSRQ               NUMERIC(2)             default 0,
   REQHRS               NUMERIC(4,1)           default 0,
   REQGPA               NUMERIC(4,3)           default 0,
   AC1                  CHAR(1),
   AC2                  CHAR(1),
   RC1                  CHAR(1),
   RC2                  CHAR(1),
   ASSIGNC              CHAR(1),
   REUSE                CHAR(1),
   NOLIST               CHAR(1),
   PSNAME               CHAR(15),
   REFCYCLE             CHAR(1),
   RQTYPE               CHAR(1),
   REQSRQF              CHAR(1),
   REQHRSF              CHAR(1),
   REQGPAF              CHAR(1),
   USECT                NUMERIC(2)             default 0,
   IPLIST               CHAR(1),
   NOCOMPL              CHAR(1),
   REQCT                NUMERIC(2)             default 0,
   REQCTF               CHAR(1),
   MAXHRS               NUMERIC(4,1)           default 999.9,
   RCONDA               CHAR(1),
   RCONDR               CHAR(1),
   VARR                 CHAR(1),
   LOKOVR1              CHAR(1),
   LNOOVR1              CHAR(1),
   LOKOVR2              CHAR(1),
   LNOOVR2              CHAR(1),
   RACTL                CHAR(1),
   ASSIGNC2             CHAR(1),
   REFDIR               CHAR(1),
   REFFLD               CHAR(1),
   REFSUB               CHAR(1),
   REFVAL               CHAR(1),
   RTITLE1              VARCHAR(58),
   RTITLE2              VARCHAR(58),
   RUNSTATUS            CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   ESTREQHRS            NUMERIC(4,1),
   constraint P_KEY_8 primary key (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
)
;

insert into REQ_MAIN (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, LYT, REQSRQ, REQHRS, REQGPA, AC1, AC2, RC1, RC2, ASSIGNC, REUSE, NOLIST, PSNAME, REFCYCLE, RQTYPE, REQSRQF, REQHRSF, REQGPAF, USECT, IPLIST, NOCOMPL, REQCT, REQCTF, MAXHRS, RCONDA, RCONDR, VARR, LOKOVR1, LNOOVR1, LOKOVR2, LNOOVR2, RACTL, ASSIGNC2, REFDIR, REFFLD, REFSUB, REFVAL, RTITLE1, RTITLE2, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, LYT, REQSRQ, REQHRS, REQGPA, AC1, AC2, RC1, RC2, ASSIGNC, REUSE, NOLIST, PSNAME, REFCYCLE, RQTYPE, REQSRQF, REQHRSF, REQGPAF, USECT, IPLIST, NOCOMPL, REQCT, REQCTF, MAXHRS, RCONDA, RCONDR, VARR, LOKOVR1, LNOOVR1, LOKOVR2, LNOOVR2, RACTL, ASSIGNC2, REFDIR, REFFLD, REFSUB, REFVAL, RTITLE1, RTITLE2, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_REQ_MAIN
;

drop table tmp_REQ_MAIN
;

--==============================================================
-- Index: REQ_MAIN_IDX
--==============================================================
create unique index REQ_MAIN_IDX on REQ_MAIN (
   RNAME                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   RQFYT                ASC,
   LYT                  ASC
)
;

--==============================================================
-- Table: REQ_TEXT
--==============================================================
create table REQ_TEXT
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null default '0000',
   USER_SEQ_NO          INTEGER                default 0,
   RTEXT_TYPE           CHAR(1),
   TEXT                 VARCHAR(65),
   LOKOVR1              CHAR(1),
   LNOOVR1              CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_10 primary key (INT_SEQ_NO)
)
;

insert into REQ_TEXT (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, RTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, RTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_REQ_TEXT
;

drop table tmp_REQ_TEXT
;

--==============================================================
-- Index: REQ_TEXT_IDX
--==============================================================
create index REQ_TEXT_IDX on REQ_TEXT (
   RNAME                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   RQFYT                ASC,
   RTEXT_TYPE           ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: REQ_XY
--==============================================================
create table REQ_XY
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null default '0000',
   USER_SEQ_NO          INTEGER                default 0,
   XY_TYPE              CHAR(1),
   MAXGRPC              NUMERIC(2)             default 99,
   MAXHRC               NUMERIC(4,1)           default 999.9,
   SKIPDUP              CHAR(1),
   CTCOND               CHAR(1),
   ASSIGNM              CHAR(1),
   MAXCTC               NUMERIC(2)             default 99,
   MAXSRC               NUMERIC(2)             default 99,
   CTPSNAME             CHAR(15),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_9 primary key (INT_SEQ_NO)
)
;

insert into REQ_XY (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, XY_TYPE, MAXGRPC, MAXHRC, SKIPDUP, CTCOND, ASSIGNM, MAXCTC, MAXSRC, CTPSNAME, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, XY_TYPE, MAXGRPC, MAXHRC, SKIPDUP, CTCOND, ASSIGNM, MAXCTC, MAXSRC, CTPSNAME, LAST_MOD_USER, LAST_MOD_DATE
from tmp_REQ_XY
;

drop table tmp_REQ_XY
;

--==============================================================
-- Index: REQ_XY_IDX
--==============================================================
create index REQ_XY_IDX on REQ_XY (
   RNAME                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   RQFYT                ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: SECURE_MASTER
--==============================================================
create table SECURE_MASTER
(
   USERID               CHAR(30)               not null,
   REFUSERID            CHAR(30),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_40 primary key (USERID)
)
;

insert into SECURE_MASTER (USERID, REFUSERID, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select USERID, REFUSERID, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_SECURE_MASTER
;

drop table tmp_SECURE_MASTER
;

--==============================================================
-- Table: STRING
--==============================================================
create table STRING
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                default ' ',
   INSTID               CHAR(8)                default ' ',
   INSTCD               CHAR(3)                default ' ',
   USER_SEQ_NO          INTEGER                default 0,
   STYPE                CHAR(1),
   STYPEQ               CHAR(1),
   COND                 CHAR(1),
   LIMCT                NUMERIC(2)             default 0,
   LIMHRS               NUMERIC(4,2)           default 0,
   CTLCD                CHAR(2),
   AC                   CHAR(1),
   RC                   CHAR(1),
   AEFLG                CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_6 primary key (INT_SEQ_NO)
)
;

insert into STRING (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, STYPE, STYPEQ, COND, LIMCT, LIMHRS, CTLCD, AC, RC, AEFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, STYPE, STYPEQ, COND, LIMCT, LIMHRS, CTLCD, AC, RC, AEFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STRING
;

drop table tmp_STRING
;

--==============================================================
-- Index: STRING_IDX
--==============================================================
create index STRING_IDX on STRING (
   INSTID               ASC,
   INSTCD               ASC,
   INSTIDQ              ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: STRING_CRSE
--==============================================================
create table STRING_CRSE
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   STR_INT_SEQ_NO       NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   COURSE               CHAR(15),
   CTITLE               VARCHAR(29),
   AC                   CHAR(1),
   RC                   CHAR(1),
   AEFLG                CHAR(1),
   PFLG                 CHAR(1),
   EFFDTE               CHAR(12),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_7 primary key (INT_SEQ_NO)
)
;

insert into STRING_CRSE (INT_SEQ_NO, STR_INT_SEQ_NO, USER_SEQ_NO, COURSE, CTITLE, AC, RC, AEFLG, PFLG, EFFDTE, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STR_INT_SEQ_NO, USER_SEQ_NO, COURSE, CTITLE, AC, RC, AEFLG, PFLG, EFFDTE, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STRING_CRSE
;

drop table tmp_STRING_CRSE
;

--==============================================================
-- Index: STRING_CRSE_IDX
--==============================================================
create index STRING_CRSE_IDX on STRING_CRSE (
   STR_INT_SEQ_NO       ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: STU_ACADREC
--==============================================================
create table STU_ACADREC
(
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   SOURCE_ID            CHAR(8)                not null default ' ',
   SOURCE_CD            CHAR(3)                not null default ' ',
   CDPMASK              CHAR(15)               not null default ' ',
   CRS_YT               CHAR(6)                not null default '0000',
   CRS_NUM              CHAR(15)               not null,
   CRS_SEQ              CHAR(3)                not null default '001',
   SECTION              CHAR(3),
   PFLG                 CHAR(1),
   RCREDIT              NUMERIC(7,5)           default 0,
   GRADE                CHAR(4),
   CTITLE               VARCHAR(29),
   RTEXT                CHAR(2),
   CONDC                CHAR(12),
   CLINE                CHAR(27),
   XCOURSE              CHAR(15),
   ECREDIT              NUMERIC(7,5)           default 0,
   GPAHRS               NUMERIC(7,5)           default 0,
   GPAPTS               NUMERIC(9,5)           default 0,
   LINKNO               CHAR(2),
   XPFLG                CHAR(1),
   RTITLE               CHAR(29),
   EVALFLG              CHAR(1)                not null default ' ',
   BACC                 CHAR(1),
   ACTC                 CHAR(1),
   AGCLC                CHAR(2),
   HONORS               CHAR(1),
   REPEATF              CHAR(1),
   IFLG1                CHAR(3),
   IFLG2                CHAR(3),
   IFLG3                CHAR(3),
   IFLG4                CHAR(3),
   IFLG5                CHAR(3),
   ACOURSE1             CHAR(15),
   APFLG1               CHAR(1),
   ACOURSE2             CHAR(15),
   APFLG2               CHAR(1),
   ACOURSE3             CHAR(15),
   APFLG3               CHAR(1),
   GRADEQ               CHAR(3),
   RGRADE               CHAR(4),
   CERTIFY              CHAR(1)                not null default ' ',
   SUBJ_AREA            CHAR(17),
   GRADELEV             CHAR(2),
   DRPDATE              CHAR(6),
   OVACADSRC            CHAR(2),
   SECURITY_FLAG        CHAR(1),
   DATA_SOURCE          CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_21 primary key (STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ)
)
;

insert into STU_ACADREC (STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ, SECTION, PFLG, RCREDIT, GRADE, CTITLE, RTEXT, CONDC, CLINE, XCOURSE, ECREDIT, GPAHRS, GPAPTS, LINKNO, XPFLG, RTITLE, EVALFLG, BACC, ACTC, AGCLC, HONORS, REPEATF, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, GRADEQ, RGRADE, CERTIFY, SUBJ_AREA, GRADELEV, DRPDATE, OVACADSRC, SECURITY_FLAG, DATA_SOURCE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ, SECTION, PFLG, RCREDIT, GRADE, CTITLE, RTEXT, CONDC, CLINE, XCOURSE, ECREDIT, GPAHRS, GPAPTS, LINKNO, XPFLG, RTITLE, EVALFLG, BACC, ACTC, AGCLC, HONORS, REPEATF, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, GRADEQ, RGRADE, CERTIFY, SUBJ_AREA, GRADELEV, DRPDATE, OVACADSRC, SECURITY_FLAG, DATA_SOURCE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_ACADREC
;

drop table tmp_STU_ACADREC
;

--==============================================================
-- Index: STU_ACAD_IDX
--==============================================================
create unique index STU_ACAD_IDX on STU_ACADREC (
   STU_MAST_NO          ASC,
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   CDPMASK              ASC,
   CRS_YT               ASC,
   CRS_NUM              ASC,
   CRS_SEQ              ASC,
   EVALFLG              ASC,
   CERTIFY              ASC
)
;

--==============================================================
-- Table: STU_ADDRESS
--==============================================================
create table STU_ADDRESS
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   SOURCE_ID            CHAR(8)                not null default ' ',
   ADDRESS_TYPE         VARCHAR(2),
   ADDRNAME             VARCHAR(35),
   NAMETYPECD           VARCHAR(2),
   ADDRESS1             VARCHAR(35),
   ADDRESS2             VARCHAR(35),
   CITY                 VARCHAR(30),
   STATE                VARCHAR(2),
   ZIP                  VARCHAR(10),
   COUNTRY              VARCHAR(3),
   LOCATIONQ            VARCHAR(2),
   LOCATIONID           VARCHAR(25),
   ENTITYIDCD           VARCHAR(2),
   REFNOQ               VARCHAR(2),
   REFNO                VARCHAR(30),
   INDRELCD             VARCHAR(2),
   FROM_DATE            CHAR(8),
   TO_DATE              CHAR(8),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_28 primary key (INT_SEQ_NO)
)
;

insert into STU_ADDRESS (INT_SEQ_NO, STU_MAST_NO, SOURCE_ID, ADDRESS_TYPE, ADDRNAME, NAMETYPECD, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, ENTITYIDCD, REFNOQ, REFNO, INDRELCD, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_MAST_NO, SOURCE_ID, ADDRESS_TYPE, ADDRNAME, NAMETYPECD, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, ENTITYIDCD, REFNOQ, REFNO, INDRELCD, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_ADDRESS
;

drop table tmp_STU_ADDRESS
;

--==============================================================
-- Table: STU_DEMO
--==============================================================
create table STU_DEMO
(
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   SOURCE_ID            CHAR(8)                not null default ' ',
   STUNAME              VARCHAR(35),
   STUIDQ               CHAR(2),
   STUIDDESC            VARCHAR(80),
   DOB                  CHAR(6),
   BIRTHCOUNTRY         CHAR(3),
   BIRTHSTATE           CHAR(2),
   BIRTHCOUNTY          CHAR(5),
   BIRTHCITY            VARCHAR(30),
   CITIZENSTATUS        CHAR(2),
   CITIZENCOUNTRY       CHAR(3),
   NATIVELANG           CHAR(3),
   ENGLPROF             CHAR(3),
   MARITAL              CHAR(1),
   GENDER               CHAR(1),
   RACE                 CHAR(1),
   HSGRADTYPE           CHAR(3),
   HSGRADDATE           CHAR(8),
   HS                   VARCHAR(30),
   TCTLAST              CHAR(6),
   NODFLT               CHAR(1),
   BDVERIF              CHAR(2),
   SPOKENINHOME         CHAR(3),
   CORRESLANG           CHAR(3),
   SUBNATQ              CHAR(2),
   SUBNATIONAL          VARCHAR(20),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_18 primary key (STU_MAST_NO, SOURCE_ID)
)
;

insert into STU_DEMO (STU_MAST_NO, SOURCE_ID, STUNAME, STUIDQ, STUIDDESC, DOB, BIRTHCOUNTRY, BIRTHSTATE, BIRTHCOUNTY, BIRTHCITY, CITIZENSTATUS, CITIZENCOUNTRY, NATIVELANG, ENGLPROF, MARITAL, GENDER, RACE, HSGRADTYPE, HSGRADDATE, HS, TCTLAST, NODFLT, BDVERIF, SPOKENINHOME, CORRESLANG, SUBNATQ, SUBNATIONAL, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, SOURCE_ID, STUNAME, STUIDQ, STUIDDESC, DOB, BIRTHCOUNTRY, BIRTHSTATE, BIRTHCOUNTY, BIRTHCITY, CITIZENSTATUS, CITIZENCOUNTRY, NATIVELANG, ENGLPROF, MARITAL, GENDER, RACE, HSGRADTYPE, HSGRADDATE, HS, TCTLAST, NODFLT, BDVERIF, SPOKENINHOME, CORRESLANG, SUBNATQ, SUBNATIONAL, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_DEMO
;

drop table tmp_STU_DEMO
;

--==============================================================
-- Table: STU_DPROG
--==============================================================
create table STU_DPROG
(
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   INSTCD               CHAR(3)                not null default ' ',
   DPROG                CHAR(15)               not null,
   DRCATLYT             CHAR(6),
   DPMASK               CHAR(15),
   ACATLYT1             CHAR(6),
   ACATLYT2             CHAR(6),
   ACATLYT3             CHAR(6),
   ACATLYT4             CHAR(6),
   ACATLYT5             CHAR(6),
   ACATLYT6             CHAR(6),
   ACATLYT7             CHAR(6),
   ACATLYT8             CHAR(6),
   ACATLYT9             CHAR(6),
   WHATIF               CHAR(1),
   DEGREECD             CHAR(3),
   ENTRYYR              CHAR(4),
   EXITYR               CHAR(4),
   TRMODMET             CHAR(1),
   DEGREESTATUS         CHAR(1),
   HONORSLEVEL          CHAR(3),
   MEMO                 VARCHAR(255),
   DEGREE_DATE          CHAR(10),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_19 primary key (STU_MAST_NO, INSTCD, DPROG)
)
;

insert into STU_DPROG (STU_MAST_NO, INSTCD, DPROG, DRCATLYT, DPMASK, ACATLYT1, ACATLYT2, ACATLYT3, ACATLYT4, ACATLYT5, ACATLYT6, ACATLYT7, ACATLYT8, ACATLYT9, WHATIF, DEGREECD, ENTRYYR, EXITYR, TRMODMET, DEGREESTATUS, HONORSLEVEL, MEMO, DEGREE_DATE, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, INSTCD, DPROG, DRCATLYT, DPMASK, ACATLYT1, ACATLYT2, ACATLYT3, ACATLYT4, ACATLYT5, ACATLYT6, ACATLYT7, ACATLYT8, ACATLYT9, WHATIF, DEGREECD, ENTRYYR, EXITYR, TRMODMET, DEGREESTATUS, HONORSLEVEL, MEMO, DEGREE_DATE, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_DPROG
;

drop table tmp_STU_DPROG
;

--==============================================================
-- Table: STU_EGRP_COURSES
--==============================================================
create table STU_EGRP_COURSES
(
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   EVALGRP              CHAR(3)                not null default ' ',
   SOURCE_ID            CHAR(8)                not null default ' ',
   SOURCE_CD            CHAR(3)                not null default ' ',
   CDPMASK              CHAR(15)               not null default ' ',
   CRS_YT               CHAR(6)                not null default '0000',
   CRS_NUM              CHAR(15)               not null,
   CRS_SEQ              CHAR(3)                not null default '001',
   constraint P_KEY_39 primary key (STU_MAST_NO, EVALGRP, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ)
)
;

insert into STU_EGRP_COURSES (STU_MAST_NO, EVALGRP, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ)
select STU_MAST_NO, EVALGRP, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ
from tmp_STU_EGRP_COURSES
;

drop table tmp_STU_EGRP_COURSES
;

--==============================================================
-- Index: STU_EGRP_CRS_IDX2
--==============================================================
create index STU_EGRP_CRS_IDX2 on STU_EGRP_COURSES (
   STU_MAST_NO          ASC,
   EVALGRP              ASC
)
;

--==============================================================
-- Index: STU_EGRP_CRS_IDX3
--==============================================================
create index STU_EGRP_CRS_IDX3 on STU_EGRP_COURSES (
   CDPMASK              ASC,
   CRS_NUM              ASC,
   CRS_SEQ              ASC,
   CRS_YT               ASC,
   SOURCE_CD            ASC,
   SOURCE_ID            ASC,
   STU_MAST_NO          ASC
)
;

--==============================================================
-- Table: STU_EVALGRP
--==============================================================
create table STU_EVALGRP
(
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   EVALGRP              CHAR(3)                not null default ' ',
   INSTCD               CHAR(3)                default ' ',
   DPMASK               CHAR(15)               default ' ',
   SOURCE_ID            CHAR(8)                default ' ',
   SOURCE_CD            CHAR(3)                default ' ',
   EVALLOCK             CHAR(1)                default ' ',
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   CERTIFY              CHAR(1)                default ' ',
   constraint P_KEY_29 primary key (STU_MAST_NO, EVALGRP)
)
;

insert into STU_EVALGRP (STU_MAST_NO, EVALGRP, INSTCD, DPMASK, SOURCE_ID, SOURCE_CD, EVALLOCK, MEMO, LAST_MOD_USER,  LAST_MOD_DATE,CERTIFY)
select STU_MAST_NO, EVALGRP, INSTCD, DPMASK, SOURCE_ID, SOURCE_CD, EVALLOCK, MEMO, LAST_MOD_USER,  LAST_MOD_DATE, CERTIFY
from tmp_STU_EVALGRP
;

drop table tmp_STU_EVALGRP
;

--==============================================================
-- Index: STU_EVALGRP_IDX
--==============================================================
create unique index STU_EVALGRP_IDX on STU_EVALGRP (
   STU_MAST_NO          ASC,
   EVALGRP              ASC,
   INSTCD               ASC,
   DPMASK               ASC,
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   EVALLOCK             ASC
)
;

--==============================================================
-- Table: STU_EXCEPTIONS
--==============================================================
create table STU_EXCEPTIONS
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   STU_MAST_NO          NUMERIC(9)             default 0,
   INSTCD               CHAR(3)                not null default ' ',
   DPMASK               CHAR(15)               not null default ' ',
   DPROG                CHAR(15)               not null default ' ',
   USER_SEQ_NO          INTEGER                default 0,
   CTLCD                CHAR(2),
   ACTION               CHAR(1),
   RUFLG                CHAR(1),
   YEARTM               CHAR(6),
   AC1                  CHAR(1),
   AC2                  CHAR(1),
   RC1                  CHAR(1),
   RC2                  CHAR(1),
   COURSE               CHAR(15),
   RCOURSE              CHAR(15),
   CLINE                CHAR(27),
   REQHRS               NUMERIC(5,2),
   MAXHRS               NUMERIC(5,2),
   REQSRQ               NUMERIC(3),
   MAXCT                NUMERIC(3),
   VAL                  NUMERIC(3),
   MATCHCTL             CHAR(1),
   EFFDTE               CHAR(12),
   REQGPA               NUMERIC(5,3),
   ASSIGNC              CHAR(1),
   MAXHRSCK             CHAR(1),
   PSNAME               CHAR(15),
   RNAME                CHAR(9),
   MEMO                 VARCHAR(255),
   AUTH_ID              VARCHAR(30),
   AUTH_DATE            CHAR(12),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_30 primary key (INT_SEQ_NO)
)
;

insert into STU_EXCEPTIONS (INT_SEQ_NO, STU_MAST_NO, INSTCD, DPMASK, DPROG, USER_SEQ_NO, CTLCD, ACTION, RUFLG, YEARTM, AC1, AC2, RC1, RC2, COURSE, RCOURSE, CLINE, REQHRS, MAXHRS, REQSRQ, MAXCT, VAL, MATCHCTL, EFFDTE, REQGPA, ASSIGNC, MAXHRSCK, PSNAME, RNAME, MEMO, AUTH_ID, AUTH_DATE, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_MAST_NO, INSTCD, DPMASK, DPROG, USER_SEQ_NO, CTLCD, ACTION, RUFLG, YEARTM, AC1, AC2, RC1, RC2, COURSE, RCOURSE, CLINE, REQHRS, MAXHRS, REQSRQ, MAXCT, VAL, MATCHCTL, EFFDTE, REQGPA, ASSIGNC, MAXHRSCK, PSNAME, RNAME, MEMO, AUTH_ID, AUTH_DATE, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_EXCEPTIONS
;

drop table tmp_STU_EXCEPTIONS
;

--==============================================================
-- Index: STU_EXCEPTIONS_IDX
--==============================================================
create index STU_EXCEPTIONS_IDX on STU_EXCEPTIONS (
   STU_MAST_NO          ASC,
   INSTCD               ASC,
   DPROG                ASC,
   DPMASK               ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: STU_EXC_COURSES
--==============================================================
create table STU_EXC_COURSES
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   STU_INT_SEQ_NO       NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   COURSE               CHAR(15),
   RCOURSE              CHAR(15),
   MATCHCTL             CHAR(1),
   EFFDTE               CHAR(12),
   AC                   CHAR(1),
   RC                   CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_31 primary key (INT_SEQ_NO)
)
;

insert into STU_EXC_COURSES (INT_SEQ_NO, STU_INT_SEQ_NO, USER_SEQ_NO, COURSE, RCOURSE, MATCHCTL, EFFDTE, AC, RC, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_INT_SEQ_NO, USER_SEQ_NO, COURSE, RCOURSE, MATCHCTL, EFFDTE, AC, RC, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_EXC_COURSES
;

drop table tmp_STU_EXC_COURSES
;

--==============================================================
-- Index: STU_EXC_CRS_IDX
--==============================================================
create index STU_EXC_CRS_IDX on STU_EXC_COURSES (
   STU_INT_SEQ_NO       ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: STU_MARKER_REQ
--==============================================================
create table STU_MARKER_REQ
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   INSTCD               CHAR(3)                not null default ' ',
   DPROG                CHAR(15)               not null,
   USER_SEQ_NO          INTEGER                default 0,
   MARKER               CHAR(9),
   DRVAL                CHAR(15),
   DRTYPE               CHAR(1),
   DRINSTCD             CHAR(3),
   DRCATLYT             CHAR(6),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_20 primary key (INT_SEQ_NO)
)
;

insert into STU_MARKER_REQ (INT_SEQ_NO, STU_MAST_NO, INSTCD, DPROG, USER_SEQ_NO, MARKER, DRVAL, DRTYPE, DRINSTCD, DRCATLYT, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_MAST_NO, INSTCD, DPROG, USER_SEQ_NO, MARKER, DRVAL, DRTYPE, DRINSTCD, DRCATLYT, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_MARKER_REQ
;

drop table tmp_STU_MARKER_REQ
;

--==============================================================
-- Index: STU_MARKER_REQ_IDX
--==============================================================
create index STU_MARKER_REQ_IDX on STU_MARKER_REQ (
   STU_MAST_NO          ASC,
   INSTCD               ASC,
   DPROG                ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: STU_MASTER
--==============================================================
create table STU_MASTER
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                default ' ',
   STUNO                CHAR(13),
   TCTLAST              CHAR(6),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   NODFLT               CHAR(1),
   PIN                  VARCHAR(20),
   ENCRYPTED_PIN        VARCHAR(80),
   constraint P_KEY_35 primary key (INT_SEQ_NO)
)
;

insert into STU_MASTER (INT_SEQ_NO, INSTIDQ, INSTID, STUNO, TCTLAST, MEMO, LAST_MOD_USER,  LAST_MOD_DATE, NODFLT, PIN)
select INT_SEQ_NO, INSTIDQ, INSTID, STUNO, TCTLAST, MEMO, LAST_MOD_USER, LAST_MOD_DATE, NODFLT, PIN
from tmp_STU_MASTER
;

drop table tmp_STU_MASTER
;

--==============================================================
-- Index: STU_INFO_IDX
--==============================================================
create unique index STU_INFO_IDX on STU_MASTER (
   STUNO                ASC,
   INSTIDQ              ASC,
   INSTID               ASC
)
;

--==============================================================
-- Table: STU_TRANS_DEGREE
--==============================================================
create table STU_TRANS_DEGREE
(
   STU_MAST_NO          NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                not null default 0,
   SEGTITLE             CHAR(5),
   ACADFOSCODE          CHAR(1),
   SEGLITERAL           VARCHAR(75),
   FIELDOFSTUDY         VARCHAR(20),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_34 primary key (STU_MAST_NO, USER_SEQ_NO)
)
;

insert into STU_TRANS_DEGREE (STU_MAST_NO, USER_SEQ_NO, SEGTITLE, ACADFOSCODE, SEGLITERAL, FIELDOFSTUDY, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, USER_SEQ_NO, SEGTITLE, ACADFOSCODE, SEGLITERAL, FIELDOFSTUDY, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_STU_TRANS_DEGREE
;

drop table tmp_STU_TRANS_DEGREE
;

--==============================================================
-- Table: SUB_REQ
--==============================================================
create table SUB_REQ
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null default '0000',
   USER_SEQ_NO          INTEGER                default 0,
   SREQNO               INTEGER                default 0,
   REQCT                NUMERIC(2)             default 0,
   REQCTF               CHAR(1),
   REQHRS               NUMERIC(4,1)           default 0,
   REQHRSF              CHAR(1),
   REQGPA               NUMERIC(4,3)           default 0,
   REQGPAF              CHAR(1),
   MAXHRS               NUMERIC(4,1)           default 999.9,
   MAXHRSCK             CHAR(1),
   ALLRES               CHAR(1),
   AC1                  CHAR(1),
   AC2                  CHAR(1),
   AC3                  CHAR(1),
   AC4                  CHAR(1),
   AC5                  CHAR(1),
   ACOR                 CHAR(1),
   RC1                  CHAR(1),
   RC2                  CHAR(1),
   RC3                  CHAR(1),
   RC4                  CHAR(1),
   RC5                  CHAR(1),
   RCAND                CHAR(1),
   ACTL                 CHAR(1),
   ASSIGNC              CHAR(1),
   ASSIGNC2             CHAR(1),
   ASSIGNM              CHAR(1),
   SREUSE               CHAR(1),
   SKIPBCT              NUMERIC(1),
   NOLIST               CHAR(1),
   NOSEQNO              CHAR(1),
   REQFLG               CHAR(1),
   IPLIST               CHAR(1),
   IGNORECL             CHAR(1),
   GPAWEIGHT            CHAR(1),
   SEQCHK               CHAR(1),
   MAXCT                NUMERIC(2)             default 99,
   CTCOND0              CHAR(1),
   CTCOND1              CHAR(1),
   CTCOND2              CHAR(1),
   CTCOND3              CHAR(1),
   CTCOND4              CHAR(1),
   CTCOND5              CHAR(1),
   CTCOND6              CHAR(1),
   CTCOND7              CHAR(1),
   CTCOND8              CHAR(1),
   CTCOND9              CHAR(1),
   CTCOND10             CHAR(1),
   CTCOND11             CHAR(1),
   CTCOND12             CHAR(1),
   CTCOND13             CHAR(1),
   CTCOND14             CHAR(1),
   CONDA                CHAR(1),
   CONDR                CHAR(1),
   LISTSR               CHAR(1),
   NEGREQ               CHAR(1),
   PNTDESCR             CHAR(1),
   GPA                  CHAR(1),
   AONLY                CHAR(1),
   CALPHA               CHAR(1),
   GRP                  CHAR(1),
   GRPMIN               NUMERIC(2)             default 0,
   GRPMAX               NUMERIC(2)             default 99,
   VARC                 CHAR(1),
   HCMIN                NUMERIC(2)             default 0,
   HCMAX                NUMERIC(2)             default 99,
   XREFSR               CHAR(1),
   REFGNO               NUMERIC(2)             default 0,
   EORDER               CHAR(1),
   ETOPDOWN             CHAR(1),
   ESTOP                CHAR(1),
   ELIMIT               CHAR(1),
   REFDIR               CHAR(1),
   REFFLD               CHAR(1),
   REFSUB               CHAR(1),
   REFVAL               CHAR(1),
   REFCYCLE             CHAR(1),
   SELRA                CHAR(1),
   SORTFLG              CHAR(1),
   SREQOR               CHAR(1),
   ACTLX                CHAR(1),
   ASSIGNCX             CHAR(1),
   REVARTL              CHAR(1),
   MATCHONE             CHAR(1),
   LTOPDOWN             CHAR(1),
   SELIP                CHAR(1),
   RUNSTATUS            CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   ESTHRS               NUMERIC(4,1),
   ESTHRSFLG            CHAR(1),
   constraint P_KEY_11 primary key (INT_SEQ_NO)
)
;

insert into SUB_REQ (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, SREQNO, REQCT, REQCTF, REQHRS, REQHRSF, REQGPA, REQGPAF, MAXHRS, MAXHRSCK, ALLRES, AC1, AC2, AC3, AC4, AC5, ACOR, RC1, RC2, RC3, RC4, RC5, RCAND, ACTL, ASSIGNC, ASSIGNC2, ASSIGNM, SREUSE, SKIPBCT, NOLIST, NOSEQNO, REQFLG, IPLIST, IGNORECL, GPAWEIGHT, SEQCHK, MAXCT, CTCOND0, CTCOND1, CTCOND2, CTCOND3, CTCOND4, CTCOND5, CTCOND6, CTCOND7, CTCOND8, CTCOND9, CTCOND10, CTCOND11, CTCOND12, CTCOND13, CTCOND14, CONDA, CONDR, LISTSR, NEGREQ, PNTDESCR, GPA, AONLY, CALPHA, GRP, GRPMIN, GRPMAX, VARC, HCMIN, HCMAX, XREFSR, REFGNO, EORDER, ETOPDOWN, ESTOP, ELIMIT, REFDIR, REFFLD, REFSUB, REFVAL, REFCYCLE, SELRA, SORTFLG, SREQOR, ACTLX, ASSIGNCX, REVARTL, MATCHONE, LTOPDOWN, SELIP, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, SREQNO, REQCT, REQCTF, REQHRS, REQHRSF, REQGPA, REQGPAF, MAXHRS, MAXHRSCK, ALLRES, AC1, AC2, AC3, AC4, AC5, ACOR, RC1, RC2, RC3, RC4, RC5, RCAND, ACTL, ASSIGNC, ASSIGNC2, ASSIGNM, SREUSE, SKIPBCT, NOLIST, NOSEQNO, REQFLG, IPLIST, IGNORECL, GPAWEIGHT, SEQCHK, MAXCT, CTCOND0, CTCOND1, CTCOND2, CTCOND3, CTCOND4, CTCOND5, CTCOND6, CTCOND7, CTCOND8, CTCOND9, CTCOND10, CTCOND11, CTCOND12, CTCOND13, CTCOND14, CONDA, CONDR, LISTSR, NEGREQ, PNTDESCR, GPA, AONLY, CALPHA, GRP, GRPMIN, GRPMAX, VARC, HCMIN, HCMAX, XREFSR, REFGNO, EORDER, ETOPDOWN, ESTOP, ELIMIT, REFDIR, REFFLD, REFSUB, REFVAL, REFCYCLE, SELRA, SORTFLG, SREQOR, ACTLX, ASSIGNCX, REVARTL, MATCHONE, LTOPDOWN, SELIP, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_SUB_REQ
;

drop table tmp_SUB_REQ
;

--==============================================================
-- Index: SUB_REQ_IDX
--==============================================================
create index SUB_REQ_IDX on SUB_REQ (
   RNAME                ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   RQFYT                ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: SUB_REQ_AR
--==============================================================
create table SUB_REQ_AR
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   SUB_INT_SEQ_NO       NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   AR_TYPE              CHAR(1)                not null,
   COURSE               CHAR(15),
   MATCHCTL             CHAR(1),
   CTITLE               VARCHAR(29),
   TFLG                 CHAR(1),
   CREDITLIM            CHAR(1),
   CRSFLAG              CHAR(3),
   AC                   CHAR(1),
   RC                   CHAR(1),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_13 primary key (INT_SEQ_NO)
)
;

insert into SUB_REQ_AR (INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, AR_TYPE, COURSE, MATCHCTL, CTITLE, TFLG, CREDITLIM, CRSFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, AR_TYPE, COURSE, MATCHCTL, CTITLE, TFLG, CREDITLIM, CRSFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_SUB_REQ_AR
;

drop table tmp_SUB_REQ_AR
;

--==============================================================
-- Index: SUB_REQ_AR_IDX
--==============================================================
create index SUB_REQ_AR_IDX on SUB_REQ_AR (
   SUB_INT_SEQ_NO       ASC,
   AR_TYPE              DESC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: SUB_REQ_TEXT
--==============================================================
create table SUB_REQ_TEXT
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   SUB_INT_SEQ_NO       NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   SRTEXT_TYPE          CHAR(1),
   TEXT                 VARCHAR(55),
   LOKOVR1              CHAR(1),
   LNOOVR1              CHAR(1),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_12 primary key (INT_SEQ_NO)
)
;

insert into SUB_REQ_TEXT (INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, SRTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, SRTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, LAST_MOD_USER, LAST_MOD_DATE
from tmp_SUB_REQ_TEXT
;

drop table tmp_SUB_REQ_TEXT
;

--==============================================================
-- Index: SUB_REQ_TEXT_IDX
--==============================================================
create index SUB_REQ_TEXT_IDX on SUB_REQ_TEXT (
   SUB_INT_SEQ_NO       ASC,
   SRTEXT_TYPE          ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: TCA_MASTER
--==============================================================
create table TCA_MASTER
(
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   SOURCE_ID            CHAR(8)                not null default ' ',
   SOURCE_CD            CHAR(3)                not null default ' ',
   DPMASK               CHAR(15)               not null default ' ',
   FYT                  CHAR(6)                not null default '0000',
   LYT                  CHAR(6)                default '9999',
   INAME                VARCHAR(60),
   UNIV_DPMASK          CHAR(1),
   DINSTID              CHAR(8),
   DINSTCD              CHAR(3),
   TASTATUS             CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_DATE        TIMESTAMP,
   LAST_MOD_USER        VARCHAR(30),
   constraint P_KEY_24 primary key (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT)
)
;

insert into TCA_MASTER (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, LYT, INAME, UNIV_DPMASK, DINSTID, DINSTCD, TASTATUS, MEMO, LAST_MOD_DATE, LAST_MOD_USER)
select INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, LYT, INAME, UNIV_DPMASK, DINSTID, DINSTCD, TASTATUS, MEMO, LAST_MOD_DATE, LAST_MOD_USER 
from  tmp_TCA_MASTER
;

drop table tmp_TCA_MASTER
;

--==============================================================
-- Index: TCA_MASTER_IDX
--==============================================================
create unique index TCA_MASTER_IDX on TCA_MASTER (
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   DPMASK               ASC,
   FYT                  ASC,
   LYT                  ASC,
   TASTATUS             ASC
)
;

--==============================================================
-- Table: TCA_RULE
--==============================================================
create table TCA_RULE
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   INSTIDQ              CHAR(2)                not null default ' ',
   INSTID               CHAR(8)                not null default ' ',
   INSTCD               CHAR(3)                not null default ' ',
   SOURCE_ID            CHAR(8)                not null default ' ',
   SOURCE_CD            CHAR(3)                not null default ' ',
   DPMASK               CHAR(15)               not null default ' ',
   FYT                  CHAR(6)                not null default '0000',
   TSEG                 CHAR(7)                not null default ' ',
   USER_SEQ_NO          INTEGER                default 0,
   COND                 CHAR(1),
   LIMCT                NUMERIC(2)             default 0,
   LIMHRS               NUMERIC(4,2)           default 0,
   CTLCD                CHAR(2),
   AC                   CHAR(1),
   RC                   CHAR(1),
   TASTATUS             CHAR(1),
   PRIVATE_NOTE         VARCHAR(255),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_25 primary key (INT_SEQ_NO)
)
;

insert into TCA_RULE (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, TSEG, USER_SEQ_NO, COND, LIMCT, LIMHRS, CTLCD, AC, RC, TASTATUS, PRIVATE_NOTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, TSEG, USER_SEQ_NO, COND, LIMCT, LIMHRS, CTLCD, AC, RC, TASTATUS, PRIVATE_NOTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from tmp_TCA_RULE
;

drop table tmp_TCA_RULE
;

--==============================================================
-- Index: TCA_RULE_IDX
--==============================================================
create index TCA_RULE_IDX on TCA_RULE (
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   DPMASK               ASC,
   FYT                  ASC,
   TSEG                 ASC,
   USER_SEQ_NO          ASC,
   TASTATUS             ASC
)
;

--==============================================================
-- Table: TCA_SOURCE
--==============================================================
create table TCA_SOURCE
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   TCA_RULE_SEQ_NO      NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   COURSE               CHAR(15),
   PFLG                 CHAR(1),
   CTITLE               VARCHAR(29),
   TFLG                 CHAR(1),
   LIMHRS               NUMERIC(4,2)           default 0,
   CTLCD                CHAR(2),
   AC                   CHAR(1),
   RC                   CHAR(1),
   COND                 CHAR(1),
   EFFDTE               CHAR(12),
   LOWEFFDTE            CHAR(6),
   HIEFFDTE             CHAR(6),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_26 primary key (INT_SEQ_NO)
)
;

insert into TCA_SOURCE (INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, CTLCD, AC, RC, COND, EFFDTE, LOWEFFDTE, HIEFFDTE, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, CTLCD, AC, RC, COND, EFFDTE, LOWEFFDTE, HIEFFDTE, LAST_MOD_USER, LAST_MOD_DATE
from tmp_TCA_SOURCE
;

drop table tmp_TCA_SOURCE
;

--==============================================================
-- Index: TCA_SOURCE_IDX
--==============================================================
create index TCA_SOURCE_IDX on TCA_SOURCE (
   TCA_RULE_SEQ_NO      ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: TCA_TARGET
--==============================================================
create table TCA_TARGET
(
   INT_SEQ_NO           NUMERIC(9)             not null generated by default as identity,
   TCA_RULE_SEQ_NO      NUMERIC(9)             not null default 0,
   USER_SEQ_NO          INTEGER                default 0,
   COURSE               CHAR(15),
   PFLG                 CHAR(1),
   CTITLE               VARCHAR(29),
   TFLG                 CHAR(1),
   LIMHRS               NUMERIC(4,2)           default 0,
   FORCEHRS             CHAR(1),
   COND                 CHAR(1),
   IFLG1                CHAR(3),
   IFLG2                CHAR(3),
   IFLG3                CHAR(3),
   IFLG4                CHAR(3),
   IFLG5                CHAR(3),
   ACOURSE1             CHAR(15),
   APFLG1               CHAR(1),
   ACOURSE2             CHAR(15),
   APFLG2               CHAR(1),
   ACOURSE3             CHAR(15),
   APFLG3               CHAR(1),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   TASTATUS             CHAR(1),
   constraint P_KEY_27 primary key (INT_SEQ_NO)
)
;

insert into TCA_TARGET (INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, FORCEHRS, COND, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, LAST_MOD_USER, LAST_MOD_DATE,TASTATUS)
select INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, FORCEHRS, COND, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, LAST_MOD_USER, LAST_MOD_DATE, TASTATUS
from tmp_TCA_TARGET
;

drop table tmp_TCA_TARGET
;

--==============================================================
-- Index: TCA_TARGET_IDX
--==============================================================
create index TCA_TARGET_IDX on TCA_TARGET (
   TCA_RULE_SEQ_NO      ASC,
   USER_SEQ_NO          ASC
)
;

--==============================================================
-- Table: WHATIF_COURSES
--==============================================================
create table WHATIF_COURSES
(
   STU_MAST_NO          NUMERIC(9)             not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   CDPMASK              CHAR(15)               not null,
   CRS_YT               CHAR(6)                not null,
   CRS_NUM              CHAR(15)               not null,
   CRS_SEQ              CHAR(3)                not null,
   RCREDIT              NUMERIC(7,5),
   GRADE                CHAR(4),
   CTITLE               VARCHAR(29),
   RTEXT                CHAR(2),
   CART                 CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   constraint P_KEY_1 primary key (STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ)
)
;

--==============================================================
-- Index: WHATIF_CART_IDX
--==============================================================
create unique index WHATIF_CART_IDX on WHATIF_COURSES (
   STU_MAST_NO          ASC,
   SOURCE_ID            ASC,
   SOURCE_CD            ASC,
   CDPMASK              ASC,
   CRS_YT               ASC,
   CRS_NUM              ASC,
   CRS_SEQ              ASC,
   CART                 ASC
)
;

--==============================================================
-- Index: WHATIF_CART2_IDX
--==============================================================
create index WHATIF_CART2_IDX on WHATIF_COURSES (
   STU_MAST_NO          ASC,
   CART                 ASC
)
;

--==============================================================
-- View: VW_ADV_CTLCD
--==============================================================

create view VW_ADV_CTLCD as
select adv_id, ctlcd from adv_ctlcd
;

--==============================================================
-- View: VW_ADV_DPROGS
--==============================================================

create view VW_ADV_DPROGS as
select adv_id, dprog from adv_dprogs
;

--==============================================================
-- View: VW_ADV_FUNCTIONS
--==============================================================

create view VW_ADV_FUNCTIONS as
select adv_id, adv_function, authority, instidq, instid, instcd
from adv_functions
;

--==============================================================
-- View: VW_ADV_INST
--==============================================================

create view VW_ADV_INST as
select
   adv_id,
   instidq,
   instid,
   instcd
from
   adv_inst
;

--==============================================================
-- View: VW_ADV_MASTER
--==============================================================

create view VW_ADV_MASTER as
select adv_id, pin, encrypted_pin, name, dept, ref_adv_id from adv_master
;

--==============================================================
-- View: VW_ADV_REQ
--==============================================================

create view VW_ADV_REQ as
select adv_id, rname from adv_req
;

--==============================================================
-- View: VW_STU_DEMO
--==============================================================

create view VW_STU_DEMO as
select stu_mast_no, source_id, stuname, stuidq, stuiddesc, dob, birthcountry, birthstate, birthcounty, birthcity, citizenstatus, citizencountry, nativelang, englprof, marital, gender, race, hsgradtype, hsgraddate, hs, tctlast, nodflt, bdverif, spokeninhome, correslang, subnatq, subnational, memo, last_mod_user, last_mod_date
from stu_demo
;

--==============================================================
-- View: VW_STU_MASTER
--==============================================================

create view VW_STU_MASTER as
select int_seq_no, instidq, instid, stuno, memo, last_mod_user, last_mod_date, tctlast, pin, nodflt, encrypted_pin from STU_MASTER
;

alter table ADV_CTLCD
   add constraint F_REFERENCE_38 foreign key (ADV_ID)
      references ADV_MASTER (ADV_ID)
      on delete restrict on update restrict
;

alter table ADV_DPROGS
   add constraint F_REFERENCE_37 foreign key (ADV_ID)
      references ADV_MASTER (ADV_ID)
      on delete restrict on update restrict
;

alter table ADV_FUNCTIONS
   add constraint F_REFERENCE_35 foreign key (ADV_ID)
      references ADV_MASTER (ADV_ID)
      on delete restrict on update restrict
;

alter table ADV_INST
   add constraint F_REFERENCE_36 foreign key (ADV_ID)
      references ADV_MASTER (ADV_ID)
      on delete restrict on update restrict
;

alter table ADV_REQ
   add constraint F_REFERENCE_39 foreign key (ADV_ID)
      references ADV_MASTER (ADV_ID)
      on delete restrict on update restrict
;

alter table JOB_QUEUE_ACCEPT
   add constraint F_REFERENCE_43 foreign key (JOBQ_SEQ_NO, RTABX, STABX)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
      on delete restrict on update restrict
;

alter table JOB_QUEUE_COURSE
   add constraint FK_JOBQ_CRS_REF_JO foreign key (JOBQ_SEQ_NO, RTABX, STABX)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
      on delete restrict on update restrict
;

alter table JOB_QUEUE_OUT
   add constraint FK_JOBQ_OUT_REF_JO foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table JOB_QUEUE_REQ
   add constraint FK_JOBQ_REQ_REF_JO foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table JOB_QUEUE_SUBREQ
   add constraint FK_JOBQ_SUBREQ_REF foreign key (JOBQ_SEQ_NO, RTABX)
      references JOB_QUEUE_REQ (JOBQ_SEQ_NO, RTABX)
      on delete restrict on update restrict
;

alter table ANALYSIS_REQ
   add constraint FK_ANAL_2_REQ foreign key (JOBQ_SEQ_NO)
      references ANALYSIS (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table ANALYSIS_COURSES
   add constraint FK_ANAL_REQ_2_CRS foreign key (JOBQ_SEQ_NO)
      references ANALYSIS_REQ (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table DPROG_REQ
   add constraint F_RELATION_183 foreign key (INSTIDQ, INSTID, INSTCD, DPROG, DPFYT)
      references DPROG (INSTIDQ, INSTID, INSTCD, DPROG, DPFYT)
      on delete restrict on update restrict
;

alter table JOB_QUEUE_DETAIL
   add constraint F_RELATION_4493 foreign key (INSTIDQ, INSTID, INSTCD, JOBID, USERID)
      references JOB_QUEUE_LIST (INSTIDQ, INSTID, INSTCD, JOBID, USERID)
      on delete restrict on update restrict
;

alter table JOB_QUEUE_SYSIN
   add constraint F_REF_56906 foreign key (INSTIDQ, INSTID, INSTCD, JOBID, USERID)
      references JOB_QUEUE_LIST (INSTIDQ, INSTID, INSTCD, JOBID, USERID)
      on delete restrict on update restrict
;

alter table MASTREF_ADDRESS
   add constraint F_REF_16608 foreign key (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT)
      references MASTREF (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT)
      on delete restrict on update restrict
;

alter table MASTREF_SEG
   add constraint F_REF_15108 foreign key (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT)
      references MASTREF (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT)
      on delete restrict on update restrict
;

alter table REQ_TEXT
   add constraint F_RELATION_2589 foreign key (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      references REQ_MAIN (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      on delete restrict on update restrict
;

alter table REQ_XY
   add constraint F_RELATION_2607 foreign key (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      references REQ_MAIN (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      on delete restrict on update restrict
;

alter table SUB_REQ
   add constraint F_RELATION_2577 foreign key (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      references REQ_MAIN (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      on delete restrict on update restrict
;

alter table SECURE_IMPORT
   add constraint FK_SIMP_2_SMAST foreign key (USERID)
      references SECURE_MASTER (USERID)
      on delete restrict on update restrict
;

alter table SECURE_INST
   add constraint FK_SINST_2_SMAST foreign key (USERID)
      references SECURE_MASTER (USERID)
      on delete restrict on update restrict
;

alter table STRING_CRSE
   add constraint F_RELATION_1118 foreign key (STR_INT_SEQ_NO)
      references STRING (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table STU_ACADREC
   add constraint F_REF_23073 foreign key (STU_MAST_NO)
      references STU_MASTER (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table STU_EGRP_COURSES
   add constraint F_REF_46007 foreign key (STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ)
      references STU_ACADREC (STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ)
      on delete restrict on update restrict
;

alter table STU_ADDRESS
   add constraint F_REF_12130 foreign key (STU_MAST_NO, SOURCE_ID)
      references STU_DEMO (STU_MAST_NO, SOURCE_ID)
      on delete restrict on update restrict
;

alter table STU_DEMO
   add constraint F_REF_23034 foreign key (STU_MAST_NO)
      references STU_MASTER (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table STU_DPROG
   add constraint F_REF_23053 foreign key (STU_MAST_NO)
      references STU_MASTER (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table STU_MARKER_REQ
   add constraint F_RELATION_3307 foreign key (STU_MAST_NO, INSTCD, DPROG)
      references STU_DPROG (STU_MAST_NO, INSTCD, DPROG)
      on delete restrict on update restrict
;

alter table STU_EGRP_COURSES
   add constraint FK_EGRP_2_EGRP_CRS foreign key (STU_MAST_NO, EVALGRP)
      references STU_EVALGRP (STU_MAST_NO, EVALGRP)
      on delete restrict on update restrict
;

alter table STU_EVALGRP
   add constraint FK_STU_EVAL_2_MAST foreign key (STU_MAST_NO)
      references STU_MASTER (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table STU_EXC_COURSES
   add constraint F_REF_14062 foreign key (STU_INT_SEQ_NO)
      references STU_EXCEPTIONS (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table STU_EXCEPTIONS
   add constraint F_REF_23068 foreign key (STU_MAST_NO)
      references STU_MASTER (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table STU_TRANS_DEGREE
   add constraint F_REF_23058 foreign key (STU_MAST_NO)
      references STU_MASTER (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table SUB_REQ_AR
   add constraint SREQ_TO_SREQ_AR foreign key (SUB_INT_SEQ_NO)
      references SUB_REQ (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table SUB_REQ_TEXT
   add constraint SREQ_TO_SREQ_TEXT foreign key (SUB_INT_SEQ_NO)
      references SUB_REQ (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table TCA_RULE
   add constraint F_REF_10199 foreign key (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT)
      references TCA_MASTER (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT)
      on delete restrict on update restrict
;

alter table TCA_SOURCE
   add constraint F_REF_11057 foreign key (TCA_RULE_SEQ_NO)
      references TCA_RULE (INT_SEQ_NO)
      on delete restrict on update restrict
;

alter table TCA_TARGET
   add constraint F_REF_11060 foreign key (TCA_RULE_SEQ_NO)
      references TCA_RULE (INT_SEQ_NO)
      on delete restrict on update restrict
;


create trigger TI_CRS_CONVERT no cascade before INSERT on CRS_CONVERT
REFERENCING NEW AS n    FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_DPROG_REQ no cascade before INSERT on DPROG_REQ
REFERENCING NEW AS n	 FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_GMASTER no cascade before INSERT on GMASTER
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL  
set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_MASTREF_ADDRESS no cascade before INSERT on MASTREF_ADDRESS
REFERENCING NEW AS n	FOR EACH 
ROW MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_MASTREF_SEG no cascade before INSERT on MASTREF_SEG
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_REPEAT no cascade before INSERT on REPEAT
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL  set 
n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_REQ_TEXT no cascade before INSERT on REQ_TEXT
REFERENCING NEW AS n	 FOR EACH ROW MODE DB2SQL  
set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_REQ_XY no cascade before INSERT on REQ_XY
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL  set 
n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STRING no cascade before INSERT on STRING
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL	set 
n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STRING_CRSE no cascade before INSERT on STRING_CRSE
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_ADDRESS no cascade before INSERT on STU_ADDRESS
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_EXCEPTIONS no cascade before INSERT on STU_EXCEPTIONS
REFERENCING NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_EXC_COURSES no cascade before INSERT on STU_EXC_COURSES
REFERENCING NEW AS n    FOR EACH 
ROW MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_MARKER_REQ no cascade before INSERT on STU_MARKER_REQ
REFERENCING NEW AS n	FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_INFO no cascade before INSERT on STU_MASTER
REFERENCING NEW AS n    FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_TRANS_DEG no cascade before INSERT on STU_TRANS_DEGREE
REFERENCING NEW AS n	 FOR EACH 
ROW MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_SUB_REQ no cascade before INSERT on SUB_REQ
REFERENCING NEW AS n	  FOR EACH ROW MODE DB2SQL  
set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_SUB_REQ_AR no cascade before INSERT on SUB_REQ_AR
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_SUB_REQ_TEXT no cascade before INSERT on SUB_REQ_TEXT
REFERENCING NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_TCA_RULE no cascade before INSERT on TCA_RULE
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL  
set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_TCA_SOURCE no cascade before INSERT on TCA_SOURCE
REFERENCING NEW AS n    FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_TCA_TARGET no cascade before INSERT on TCA_TARGET
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_COM no cascade before INSERT on COM
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL  set 
n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_COM no cascade before UPDATE on COM
REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW MODE 
DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_COND_CONDES no cascade before INSERT on COND_CODES
REFERENCING NEW AS n	 FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_CRSE_BANK no cascade before INSERT on COURSE_BANK
REFERENCING NEW AS n	 FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_CRS_CONVERT no cascade before UPDATE on CRS_CONVERT
REFERENCING OLD AS OLD NEW AS n    FOR 
EACH ROW MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_DPROG no cascade before INSERT on DPROG
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL  set 
n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_DPROG no cascade before UPDATE on DPROG
REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW MODE 
DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_DPROG_REQ no cascade before UPDATE on DPROG_REQ
REFERENCING OLD AS OLD NEW AS n    FOR EACH 
ROW MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_GMASTER no cascade before UPDATE on GMASTER
REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_JOB_QUEUE_LIST no cascade before INSERT on JOB_QUEUE_LIST
REFERENCING NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_MASTREF no cascade before INSERT on MASTREF
REFERENCING NEW AS n    FOR EACH ROW MODE DB2SQL  set 
n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_MASTREF no cascade before UPDATE on MASTREF
REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_MASTREF_ADDRESS no cascade before UPDATE on MASTREF_ADDRESS
REFERENCING OLD AS OLD NEW AS n    
FOR EACH ROW MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_MASTREF_SEG no cascade before UPDATE on MASTREF_SEG
REFERENCING OLD AS OLD NEW AS n    FOR 
EACH ROW MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_REPEAT no cascade before UPDATE on REPEAT
REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_REQ_MAIN no cascade before INSERT on REQ_MAIN
REFERENCING NEW AS n	  FOR EACH ROW MODE DB2SQL  
set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_REQ_MAIN no cascade before UPDATE on REQ_MAIN
REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TU_REQ_TEXT no cascade before UPDATE on REQ_TEXT
REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_SECURE_MAS no cascade before INSERT on SECURE_MASTER
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_ACADREC no cascade before INSERT on STU_ACADREC
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_DEMO no cascade before INSERT on STU_DEMO
REFERENCING NEW AS n	 FOR EACH ROW MODE DB2SQL  
set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_DPROG no cascade before INSERT on STU_DPROG
REFERENCING NEW AS n    FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_STU_EVALGRP no cascade before INSERT on STU_EVALGRP
REFERENCING NEW AS n    FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;


create trigger TI_TCA_MASTER no cascade before INSERT on TCA_MASTER
REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
;

