/*================================================================*/
/* DBMS name:      DB2                                            */
/* Created on:     8/13/2008 2:30:15 PM                           */
/* Last Updated:   5/08/2014                                      */
/* Script name:    uachieve_4.2_DB2_create_tab.sql                */
/* Purpose:        Creates the u.achieve server tables            */
/*                                                                */
/* Beginning with 4.2, we have moved all the security tables      */
/* and any other tables specific to u.achieve self-service to     */
/* the Dashboard installation scripts.                            */
/*                                                                */
/* This script now contains only those tables specific to the     */
/* u.achieve server.                                              */
/*                                                                */
/* Copyright(c) 1998-2014 CollegeSource, Inc. All Rights Reserved */
/*                                                                */
/*================================================================*/

--============================================================
--                 Create Tables and Indexes
--============================================================

/*==============================================================*/
/* Table: chart_categories                                      */
/*==============================================================*/
create table chart_categories (
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   category_code        char(1)               not null,
   category_name        char(15)              null,
   category_desc        varchar(255)          null,
   transcript           char(1)               null,
   total_hour           char(1)               null,
   total_gpa            char(1)               null,
   hidefromchart        char(1)               null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   hide_gpa             char(1)               null,
   force_schema_include	char(1)				  null,
   constraint PK_CHART_CATEGORIES primary key (instidq, instid, instcd, category_code)
)
go

/* ==== Index:  chart_cat_idx                                         */
create index chart_cat_idx on chart_categories (
	instidq ASC,
	instid ASC,
	instcd ASC,
	category_code ASC,
	transcript ASC,
	hidefromchart ASC,
	total_hour ASC
)
go

/*==============================================================*/
/* Table: com                                                   */
/*==============================================================*/
create table com (
   instidq              char(2)               not null  default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   comkey               char(5)               not null default ' ',
   comfield             char(10)              not null,
   comvalue             varchar(255)          null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_COM primary key (instidq, instid, instcd, comkey, comfield)
)
go

/* ==== Index:  com_idx                                               */
create unique index com_idx on com (
	comkey ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	comfield ASC
)
go

/*==============================================================*/
/* Table: cond_codes                                            */
/*==============================================================*/
create table cond_codes (
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   comkey               char(5)               not null default ' ',
   seq_no               integer               not null default 0,
   cond_code            char(1)               null,
   course_cc_desc       char(80)              null,
   system_cc_desc       char(80)              null,
   last_mod_date        timestamp            null,
   last_mod_user        varchar(30)           null,
   constraint PK_COND_CODES primary key (instidq, instid, instcd, comkey, seq_no)
)
go

/*==============================================================*/
/* Table: course_bank                                           */
/*==============================================================*/
create table course_bank (
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   course               char(15)              not null,
   pflg                 char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_COURSE_BANK primary key (instidq, instid, instcd, course)
)
go

/*==============================================================*/
/* Table: crs_convert                                           */
/*==============================================================*/
create table crs_convert (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               null default ' ',
   instid               char(8)               null default ' ',
   instcd               char(3)               null default ' ',
   user_seq_no          integer               null default 0,
   oldcrse              char(15)              null,
   newcrse              char(15)              null,
   effdte               char(12)              null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   constraint PK_CRS_CONVERT primary key (int_seq_no)
)
go

/* ==== Index:  convert_idx                                           */
create index convert_idx on crs_convert (
	instid ASC,
	instcd ASC,
	instidq ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: current_jobs                                          */
/*==============================================================*/
create table current_jobs(
	instcd 			varchar(3)  		NOT NULL,
	instid 			varchar(8)  		NOT NULL,
	instidq 		varchar(2)  		NOT NULL,
	stuno 			varchar(15)  		NOT NULL,
	starttime 		timestamp			NULL,
 	constraint PK_CURRENT_JOBS PRIMARY KEY (instcd, instid , instidq, stuno)
)
go

/*==============================================================*/
/* Table: dprog                                                 */
/*==============================================================*/
create table dprog (
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   dprog                char(15)              not null,
   dpfyt                char(6)               not null default '0000',
   lyt                  char(6)               null default '9999',
   dptitle1             varchar(65)           null,
   dptitle2             varchar(65)           null,
   webtitle             varchar(50)           null,
   college              varchar(10)           null,
   major                varchar(10)           null,
   degree               varchar(10)           null,
   location             varchar(10)           null,
   dpcips               char(6)               null,
   dpmask               char(15)              null,
   dpstatus             char(1)               null,
   efilter              char(15)              null,
   instpad              varchar(44)           null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   dptype               char(1)               null,
   type_code				char(3)					null,
   constraint PK_DPROG primary key (instidq, instid, instcd, dprog, dpfyt)
)
go

/* ==== Index:  dprog_idx                                             */
create unique index dprog_idx on dprog (
	dprog ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	dpfyt ASC,
	lyt ASC
)
go

/* ==== Index:  webtitle_idx                                          */
create index webtitle_idx on dprog (
	webtitle ASC,
	dprog ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	dpfyt ASC,
	lyt ASC
)
go

/*==============================================================*/
/* Table: dprog_req                                             */
/*==============================================================*/
create table dprog_req (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   dprog                char(15)              not null,
   dpfyt                char(6)               not null default '0000',
   user_seq_no          integer               null default 0,
   dprname              char(9)               not null,
   grp1                 char(1)               null,
   grp2                 char(1)               null,
   orflg                char(1)               null,
   optflg               char(1)               null,
   sumgrp               char(1)               null,
   crlink               char(1)               null,
   altcflg              char(1)               null,
   sortflg              char(1)               null,
   extend               char(1)               null,
   calcgrp              char(1)               null,
   calcflg              char(1)               null,
   runstatus            char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   category             char(1)               null,
   constraint PK_DPROG_REQ primary key (int_seq_no)
)
go

/* ==== Index:  dprog_req_idx                                         */
create index dprog_req_idx on dprog_req (
	dprog ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	dpfyt ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: gmaster                                               */
/*==============================================================*/
create table gmaster (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               null default ' ',
   instid               char(8)               null default ' ',
   instcd               char(3)               null default ' ',
   line_type            char(1)               null default ' ',
   user_seq_no          integer               null  default 0,
   grade                char(4)               null,
   rgrade               char(4)               null,
   gpapt                numeric(10,5)         null default 0,
   gpacal               char(1)               null,
   addcr                char(1)               null,
   addct                char(1)               null,
   pseudo               char(1)               null,
   force                char(1)               null,
   ip                   char(1)               null,
   ctlcd                char(2)               null,
   action               char(1)               null,
   ruflg                char(1)               null,
   condg                char(6)               null,
   delig                char(1)               null,
   replac               char(1)               null,
   creditck             char(1)               null,
   lcredit              numeric(10,5)          null default 0,
   hcredit              numeric(10,5)          null default 0,
   ac                   char(1)               null,
   rc                   char(1)               null,
   effdte               char(12)              null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_GMASTER primary key (int_seq_no)
)
go

/* ==== Index:  gmaster_idx                                           */
create index gmaster_idx on gmaster (
    instid ASC,
    instcd ASC,
    instidq ASC,
    user_seq_no ASC
)
go

/*==============================================================*/
/* Table: include_text                                          */
/*==============================================================*/
create table include_text (
   INSTIDQ              char(2)               not null,
   INSTID               char(8)               not null,
   INSTCD               char(3)               not null,
   TEXT_KEY             varchar(20)           not null,
   TEXT_TYPE            char(1)               not null,
   TEXT                 clob                  null,
   LAST_MOD_USER        varchar(30)           null,
   LAST_MOD_DATE        timestamp             null,
   constraint PK_INCLUDE_TEXT primary key (INSTIDQ, INSTID, INSTCD, TEXT_KEY, TEXT_TYPE)
)
go

/*==============================================================*/
/* Table: job_queue_accept                                      */
/*==============================================================*/
create table job_queue_accept (
   int_seq_no           numeric(9)           not null generated by default as identity,
   jobq_seq_no          numeric(9)           not null default 0,
   rtabx                char(3)              not null,
   stabx                char(3)              not null,
   course               varchar(15)           null,
   title                varchar(29)           null,
   reject               char(1)               null,
   used                 char(1)               null,
   logic                char(1)               null,
   required             char(1)               null,
   cmprtitle            char(1)               null,
   rangecourse          char(15)              null,
   lowyt                char(6)               null,
   highyt               char(6)               null,
   hidden               char(1)               null,
   inner_mem            char(1)               null,
   inner_bgn            char(1)               null,
   inner_end            char(1)               null,
   outer_mem            char(1)               null,
   outer_bgn            char(1)               null,
   outer_end            char(1)               null,
   symbol_before        char(5)               null,
   user_seq_no          numeric(9)            null,
   dept                 char(15)              null,
   crsno                char(15)              null,
   pseudo_flag          char(1)               null,
   constraint PK_JOB_QUEUE_ACCEPT primary key (int_seq_no)
)
go

/* ==== Index:  jobq_accept_idx                                       */
create index jobq_accept_idx on job_queue_accept (
	jobq_seq_no ASC,
	rtabx ASC,
    stabx ASC
)
go

/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
create table job_queue_course (
   int_seq_no           numeric(9)           not null generated by default as identity,
   jobq_seq_no          numeric(9)           not null,
   rtabx                char(3)           not null,
   stabx                char(3)           not null,
   yt                   char(6)               null,
   edit_yt              char(4)               null,
   course               varchar(15)           null,
   xcourse              varchar(15)           null,
   rcredit              numeric(10,5)         null,
   credit               numeric(10,5)         null,
   gpahrs               numeric(10,5)         null,
   gpapts               numeric(10,5)         null,
   gpa                  numeric(10,5)         null,
   grade                char(4)               null,
   rgrade               char(4)               null,
   ip                   char(1)               null,
   whatif               char(1)               null,
   pseudo               char(1)               null,
   ctitle               varchar(29)           null,
   rtitle               varchar(29)           null,
   stitle               varchar(29)           null,
   cvttitle             varchar(29)           null,
   alttitle             varchar(29)           null,
   user_seq_no          numeric(9)           null,
   passfail             char(1)              null,
   addct                integer               null,
   constraint PK_JOB_QUEUE_COURSE primary key (int_seq_no)
)
go

/* ==== Index: jobq_course_idx                                    */
create index jobq_course_idx on job_queue_course (
	jobq_seq_no, 
	rtabx, 
	stabx
)
go

/*==============================================================*/
/* Table: job_queue_destination                                 */
/*==============================================================*/
create table JOB_QUEUE_DESTINATION(
	JOBID 				char(16)  			NOT NULL,
	USERID 				char(30) 			NOT NULL,
	DESTINATION_URL 	varchar(255)  		NOT NULL,
	OUTPUT_FORMAT 		char(1) 			NULL,
	SEND_ERROR_COUNT 	integer 			NOT NULL DEFAULT 0,
	SEND_ERROR_MESSAGE 	varchar(255) 		NULL,
	STATUS 				char(1) 			NOT NULL,
	SEND_DATE 			timestamp			NULL,
	NEXT_SEND_DATE 		timestamp			NULL,
 constraint PK_JOB_QUEUE_DESTINATION PRIMARY KEY (JOBID,USERID) 
)
go

/*==============================================================*/
/* Table: job_queue_detail                                      */
/*==============================================================*/
create table job_queue_detail (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   jobid                char(16)              not null,
   userid               char(30)              not null,
   user_seq_no          integer               not null default 0,
   stuno                char(13)              null,
   comkey               char(5)               null,
   evalsw               char(1)               null,
   f1or2                char(1)               null,
   report               char(1)               null,
   pntreq               char(1)               null,
   listall              char(1)               null,
   test                 char(1)               null,
   fdprog               char(15)              null,
   fcatlyt              char(6)               null,
   sinstid              char(8)               null,
   sinstcd              char(3)               null,
   fdpmask              char(15)              null,
   time_token           char(6)               null,
   lasertext            char(1)               null,
   format               char(1)               null,
   parseflg             char(8)               null,
   revart               char(1)               null,
   binstid              char(8)               null,
   binstcd              char(3)               null,
   bytaken              char(6)               null,
   soprid               char(8)               null,
   status               char(1)               null,
   d_whatif             char(1)               null default ' ',
   constraint PK_JOB_QUEUE_DETAIL primary key (int_seq_no)
)
go

/* ====  Index: job_q_detail_idx  ==== */
create index job_q_detail_idx on JOB_QUEUE_DETAIL (
	JOBID ASC,
	INSTIDQ ASC,
	INSTID ASC,
	INSTCD ASC,
	USERID ASC,
	USER_SEQ_NO ASC
)
go

/*==============================================================*/
/* Table: job_queue_exceptions                                  */
/*==============================================================*/
create table job_queue_exceptions (
   int_seq_no           numeric(9)           not null generated by default as identity,
   jobq_seq_no			numeric(9)			  null,
   user_seq_no          integer               null,
   ctlcd                char(2)               null,
   action               char(1)               null,
   ruflg                char(1)               null,
   course				varchar(15)			  null,
   rcourse				varchar(15)			  null,
   cline				varchar(27)           null,
   psname               varchar(15)           null,
   rname                varchar(9)            null,
   memo                 varchar(255)          null,
   auth_id              varchar(30)           null,
   auth_date            varchar(12)           null,
   auth_code            varchar(10)           null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   constraint PK_J_Q_EXCEPTION primary key (int_seq_no)
)
go

/* ==== Index:  jobq_exceptions_idx                                       */
create index jobq_exceptions_idx on job_queue_exceptions (
	jobq_seq_no ASC
)
go

/*==============================================================*/
/* Table: job_queue_incl_text                                   */
/*==============================================================*/
create table job_queue_incl_text (
   int_seq_no           numeric(9)           not null generated by default as identity,
   jobq_seq_no          numeric(9)            null,
   TEXT_TYPE            char(1)               null,
   TEXT                 clob                  null,
   constraint PK_JOB_QUEUE_INCL_TEXT primary key (int_seq_no)
)
go

/* ==== Index:  jobq_incl_text_idx                                       */
create index jobq_incl_text_idx on job_queue_incl_text (
	jobq_seq_no ASC
)
go

/*==============================================================*/
/* Table: job_queue_list                                        */
/*==============================================================*/
create table job_queue_list (
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   jobid                char(16)              not null,
   userid               char(30)              not null,
   status               char(1)               null default 'N',
   priority             integer               null default 100,
   startdate            char(10)              null,
   starttime            char(5)               null,
   external_eval        char(1)               null,
   read_sysin           char(1)               null,
   servername           char(10)              not null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   comkey               varchar(10)           null,
   log_level            char(1)               null,
   report_type          varchar(10)           null,
   ignore_cache			char(1)				  null,
   constraint PK_JOB_QUEUE_LIST primary key (instidq, instid, instcd, jobid, userid)
)
go

/* ==== Index: job_q_list_idx                                        */
create index job_q_list_idx on JOB_QUEUE_LIST (
	SERVERNAME ASC,
	STATUS ASC,
	STARTDATE ASC,
	STARTTIME ASC,
	PRIORITY ASC,
	JOBID ASC
)
go

/* ==== Index: job_q_list_jobidx                                     */
create index job_q_list_jobidx on JOB_QUEUE_LIST (
	JOBID ASC
)
go

/*==============================================================*/
/* Table: job_queue_markers                                     */
/*==============================================================*/
create table job_queue_markers (
   int_seq_no           numeric(9)           not null generated by default as identity,
   jobq_seq_no			numeric(9)			  null,
   user_seq_no          integer               null,
   rname                char(9)               null,
   drval                char(15)              null,
   drtype               char(1)               null,
   catlyt               char(6)               null,
   title1               varchar(80)           null,
   title2               varchar(80)           null,
   webtitle             varchar(80)           null,
   constraint PK_J_Q_MARKER primary key (int_seq_no)
)
go

/* ==== Index:  jobq_markers_idx                                       */
create index jobq_markers_idx on job_queue_markers (
	jobq_seq_no ASC
)
go

/*==============================================================*/
/* Table: job_queue_report                                      */
/*==============================================================*/
create table job_queue_report (
   int_seq_no           numeric(9)			not null generated by default as identity,
   jobq_seq_no          numeric(9)			null,
   report_type          varchar(10)			null,
   report               blob 				null,
   constraint PK_J_Q_REPORT primary key (int_seq_no)
)
go

/* ==== Index:  jobq_report                                          */
create index jobq_report_idx on JOB_QUEUE_REPORT (
	JOBQ_SEQ_NO ASC
)
go

/*==============================================================*/
/* Table: job_queue_req                                         */
/*==============================================================*/
create table job_queue_req (
   jobq_seq_no          numeric(9)            not null,
   rtabx                char(3)            	  not null,
   rno                  char(3)            	  null,
   rname                varchar(9)            null,
   psname               varchar(15)           null,
   category             varchar(15)           null,
   summary_grp          varchar(15)           null,
   transcript           char(1)               null,
   total_hour           char(1)               null,
   total_gpa            char(1)               null,
   hidefromchart        char(1)               null,
   satisfied            char(1)               null,
   summary              char(1)               null,
   sortflg              char(1)               null,
   orreq                char(1)               null,
   optreq               char(1)               null,
   reqsrq               integer               null,
   gotsrq               integer               null,
   needsrq              integer               null,
   reqct                integer               null,
   gotct                integer               null,
   ipct                 integer               null,
   whatifct             integer               null,
   needct               integer               null,
   maxhrs               numeric(10,5)         null,
   reqhrs               numeric(10,5)         null,
   est_reqhrs           numeric(10,5)         null,
   gothrs               numeric(10,5)         null,
   iphrs                numeric(10,5)         null,
   whatifhrs            numeric(10,5)         null,
   needhrs              numeric(10,5)         null,
   gotgpahrs            numeric(10,5)         null,
   gotgpapts            numeric(10,5)         null,
   reqgpa               numeric(10,5)         null,
   gotgpa               numeric(10,5)         null,
   needgpa              numeric(10,5)         null,
   reqgpaf              char(1)               null,
   gpaname              char(15)              null,
   gpalowyt             char(6)               null,
   gpahighyt            char(6)               null,
   hidden               char(1)               null,
   hidecategorygpa      char(1)               null,
   group1               char(1)               null,
   group2               char(1)               null,
   reuse                char(1)               null,
   label                varchar(25)           null,
   hideheadtitle        char(1)               null,
   hideneedssummary     char(1)               null,
   hideselfrmcrs        char(1)               null,
   hidemtchdcrs         char(1)               null,
   force_schema_include	char(1)				  null,
   constraint PK_JOB_QUEUE_REQ primary key (jobq_seq_no, rtabx)
)
go

/* ==== Index:  jobq_req_idx                                          */
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
go

/*==============================================================*/
/* Table: job_queue_req_text                                    */
/*==============================================================*/
create table job_queue_req_text (
   jobq_seq_no          numeric(9)			not null,
   text_type             char(1)			not null default 'T',
   rtabx                char(3)				not null,
   text                 clob            	null,
   constraint PK_J_Q_REQ_TEXT primary key (jobq_seq_no, rtabx, text_type)
)
go

/* ==== Index: jq_req_text_idx                                        */
create index jq_req_text_idx on job_queue_req_text (
    jobq_seq_no ASC,
    rtabx ASC
)
go

/*==============================================================*/
/* Table: job_queue_run                                         */
/*==============================================================*/
create table job_queue_run (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               null default ' ',
   instid               char(8)               null default ' ',
   instcd               char(3)               null default ' ',
   jobid                char(16)              null default ' ',
   userid               char(30)              null default ' ',
   soprid               char(8)               null default ' ',
   stuno                char(13)              null default ' ',
   dprog                char(15)              null default ' ',
   dpmask               char(15)              null default ' ',
   catlyt               char(6)               null default ' ',
   binstid              char(8)               null,
   binstcd              char(3)               null,
   ncol					char(1)				  null,
   rundate              timestamp             null,
   complete             char(1)               null,
   ip                   char(1)               null,
   dptitle1             varchar(65)           null,
   dptitle2             varchar(65)           null,
   webtitle             varchar(50)           null,
   detail_seq_no        numeric(9)            null,
   altstuno             char(13)              null,
   firstname            varchar(30)           null,
   middlename           varchar(15)           null,
   lastname             varchar(30)           null,
   prefixname           varchar(4)            null,
   suffixname           varchar(6)            null,
   stuname              varchar(60)           null,
   listall              char(1)               null,
   teststatus           char(1)               null,
   report_type			varchar(10)			  null,
   graddate				varchar(80)			  null,
   constraint PK_JOB_QUEUE_RUN primary key (int_seq_no)
)
go

/* ==== Index:  jobq_run_idx                                          */
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
go

/*==============================================================*/
/* Table: job_queue_subreq                                      */
/*==============================================================*/
create table job_queue_subreq (
   jobq_seq_no          numeric(9)           not null,
   rtabx                char(3)              not null,
   stabx                char(3)              not null,
   sno                  char(3)				 null,
   satisfied            char(1)              null,
   sortflg              char(1)              null,
   orsub                char(1)              null,
   optsub               char(1)              null,
   reqct                integer              null,
   gotct                integer              null,
   needct               integer              null,
   ipct                 integer              null,
   whatifct             integer              null,
   maxhrs               numeric(10,5)        null,
   reqhrs               numeric(10,5)        null,
   est_reqhrsflg        char(1)              null,
   est_reqhrs           numeric(10,5)        null,
   gothrs               numeric(10,5)        null,
   iphrs                numeric(10,5)        null,
   whatifhrs            numeric(10,5)        null,
   needhrs              numeric(10,5)        null,
   reqgpa               numeric(10,5)        null,
   gotgpa               numeric(10,5)        null,
   needgpa              numeric(10,5)        null,
   gotgpahrs            numeric(10,5)        null,
   gotgpapts            numeric(10,5)        null default 0,
   reqgpaf              char(1)              null,
   gpaname              char(15)             null,
   gpalowyt             char(6)              null,
   gpahighyt            char(6)              null,
   hidden               char(1)              null,
   subreq_id            numeric(9)           null,
   reuse                char(1)              null,
   label                varchar(25)          null,
   stitle               varchar(55)          null,
   hidetitle 			char(1)              null,
   hidesummary 			char(1)              null,
   hideselfrmcrs 		char(1)              null,
   hidestucrs 			char(1)              null,
   constraint PK_JOB_QUEUE_SUBREQ primary key (jobq_seq_no, rtabx, stabx)
)
go

/*==============================================================*/
/* Table: job_queue_subreq_text                                 */
/*==============================================================*/
create table job_queue_subreq_text (
   jobq_seq_no          numeric(9)          not null,
   text_type            char(1)             not null default 'T',
   rtabx                char(3)           	not null,
   stabx                char(3)           	not null,
   text                 clob           		null,
   constraint PK_J_Q_SUBREQ_TEXT primary key (jobq_seq_no, text_type, rtabx, stabx)
)
go

/*==============================================================*/
/* Index: jq_subreq_text_idx                                    */
/*==============================================================*/
create index jq_subreq_text_idx on job_queue_subreq_text (
    jobq_seq_no ASC,
    rtabx ASC,
    stabx ASC
)
go

/*==============================================================*/
/* Table: job_queue_sysin                                       */
/*==============================================================*/
create table job_queue_sysin (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               null default ' ',
   instid               char(8)               null default ' ',
   instcd               char(3)               null default ' ',
   jobid                char(16)              null,
   userid               char(30)              null,
   user_seq_no          integer               null default 0,
   sysin                char(80)              null,
   constraint PK_JOB_QUEUE_SYSIN primary key (int_seq_no)
)
go

/* ==== Index: jobq_sys_idx                                          */
create index jobq_sys_idx on JOB_QUEUE_SYSIN (
	instidq asc, 
	instid asc, 
	instcd asc, 
	jobid asc, 
	userid asc
)
go

/*==============================================================*/
/* Table: job_queue_out                                         */
/*==============================================================*/
create table job_queue_out  ( 
    int_seq_no 	numeric(9,0) not null generated by default as identity,
    jobq_seq_no	numeric(9,0) NOT NULL,
    user_seq_no	integer null,
    rtabx      	char(3) NULL,
    reqstatus  	char(1) NULL,
    stabx      	char(3) NULL,
    srno       	char(2) NULL,
    srstatus   	char(1) NULL,
    optline    	char(1) NULL,
    lasera     	char(1) NULL,
    laserb     	char(1) NULL,
    darout     	varchar(255) NULL,
    constraint PK_JOB_QUEUE_OUT PRIMARY KEY(int_seq_no)

)
go

/* ==== Index:  jobq_out_idx                                       */
create index jobq_out_idx on JOB_QUEUE_OUT (
	JOBQ_SEQ_NO ASC
)
go

/*==============================================================*/
/* Table: mastref                                               */
/*==============================================================*/
create table mastref (
   instidq              char(2)               not null  default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   source_id            char(8)               not null  default ' ',
   source_cd            char(3)               not null  default ' ',
   mrfyt                char(6)               not null default '0000',
   lyt                  char(6)               null default '9999',
   iname                varchar(60)           null,
   itype                char(2)               null,
   status               char(1)               null,
   crscase              char(1)               null,
   grdcase              char(1)               null,
   sourceidq            char(2)               null,
   bacc                 char(1)               null,
   actc                 char(1)               null,
   agclc                char(2)               null,
   honors               char(1)               null,
   repeatf              char(1)               null,
   cscale               char(1)               null,
   cassign              char(1)               null,
   cexcess              char(1)               null,
   cfinal               char(1)               null,
   dcourse              char(15)              null,
   dpflg                char(1)               null,
   grule                char(1)               null,
   gparule              char(1)               null,
   dgrade               char(4)               null,
   d0grade              char(4)               null,
   crsmask              char(15)              null,
   refucond1            char(3)               null,
   refucond2            char(3)               null,
   refucond3            char(3)               null,
   grdreq               char(1)               null,
   gpascale             char(1)               null,
   unitscale            numeric(6,4)         null default 0,
   dinstid              char(8)               null,
   dinstcd              char(3)               null,
   deptbgn              numeric(2)           null  default 0,
   deptend              numeric(2)           null  default 0,
   crsbgn               numeric(2)           null  default 0,
   crsend               numeric(2)           null  default 0,
   rptinstid            char(8)               null,
   tainstid             char(8)               null,
   tainstcd             char(3)               null,
   refonly              char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_MASTREF primary key (instidq, instid, instcd, source_id, source_cd, mrfyt)
)
go

/* ==== Index:  mastref_idx                                           */
create unique index mastref_idx on mastref (
	source_id ASC,
	source_cd ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	mrfyt ASC,
	lyt ASC
)
go

/*==============================================================*/
/* Table: mastref_address                                       */
/*==============================================================*/
create table mastref_address (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null  default ' ',
   instid               char(8)               not null  default ' ',
   instcd               char(3)               not null  default ' ',
   source_id            char(8)               not null  default ' ',
   source_cd            char(3)               not null  default ' ',
   mrfyt                char(6)               not null  default '0000',
   user_seq_no          integer              null default 0,
   address1             varchar(35)           null,
   address2             varchar(35)           null,
   city                 varchar(30)           null,
   state                varchar(2)            null,
   zip                  varchar(10)           null,
   country              varchar(3)            null,
   locationq            varchar(2)            null,
   locationid           varchar(25)           null,
   contactcd            varchar(2)            null,
   contactname          varchar(35)           null,
   commnoq              varchar(2)            null,
   fax                  varchar(25)           null,
   phone                varchar(25)           null,
   e_mail               varchar(80)           null,
   from_date            char(8)               null,
   to_date              char(8)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_MASTREF_ADDRESS primary key (int_seq_no)
)
go

/* ==== Index:  mastref_addr_idx                                      */
create index mastref_addr_idx on mastref_address (
	source_id ASC,
	source_cd ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	mrfyt ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: mastref_seg                                           */
/*==============================================================*/
create table mastref_seg (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null  default ' ',
   instid               char(8)               not null  default ' ',
   instcd               char(3)               not null  default ' ',
   source_id            char(8)               not null  default ' ',
   source_cd            char(3)               not null  default ' ',
   mrfyt                char(6)               not null  default '0000',
   user_seq_no          integer               null default 0,
   ltype                char(1)               null,
   i2uflg               char(1)               null,
   grade                char(4)               null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   u2iflg               char(1)               null,
   ugrade               char(4)               null,
   acu                  char(3)               null,
   rcu                  char(3)               null,
   gpapt                numeric(10,5)         null default 0,
   gpacal               char(1)               null,
   addcr                char(1)               null,
   addct                char(1)               null,
   cond1                char(1)               null,
   cond2                char(1)               null,
   ucond1               char(3)               null,
   ucond2               char(3)               null,
   effdte               char(12)              null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_MASTREF_SEG primary key (int_seq_no)
)
go

/* ==== Index:  master_idx                                            */
create index master_idx on mastref_seg (
	source_id ASC,
	source_cd ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	mrfyt ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: repeat                                                */
/*==============================================================*/
create table repeat (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               null  default ' ',
   instid               char(8)               null default ' ',
   instcd               char(3)               null default ' ',
   user_seq_no          integer               null default 0,
   course               char(15)              null,
   ctitle               varchar(29)           null,
   hmax                 numeric(4,1)          null default 0,
   chflag               char(1)               null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   effdte               char(12)              null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_REPEAT primary key (int_seq_no)
)
go

/* ==== Index:  repeat_idx                                            */
create index repeat_idx on repeat (
	instid ASC,
	instcd ASC,
	instidq ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: req_main                                              */
/*==============================================================*/
create table req_main (
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   rname                char(9)               not null,
   rqfyt                char(6)               not null default '0000',
   lyt                  char(6)               null default '9999',
   reqsrq               numeric(2)            null default 0,
   reqhrs               numeric(10,5)          null default 0,
   reqgpa               numeric(10,5)          null default 0,
   ac1                  char(1)               null,
   ac2                  char(1)               null,
   rc1                  char(1)               null,
   rc2                  char(1)               null,
   assignc              char(1)               null,
   reuse                char(1)               null,
   nolist               char(1)               null,
   psname               char(15)              null,
   refcycle             char(1)               null,
   rqtype               char(1)               null,
   reqsrqf              char(1)               null,
   reqhrsf              char(1)               null,
   reqgpaf              char(1)               null,
   usect                numeric(2)            null default 0,
   iplist               char(1)               null,
   nocompl              char(1)               null,
   reqct                numeric(2)            null default 0,
   reqctf               char(1)               null,
   maxhrs               numeric(10,5)          null default 999.9,
   rconda               char(1)               null,
   rcondr               char(1)               null,
   varr                 char(1)               null,
   lokovr1              char(1)               null,
   lnoovr1              char(1)               null,
   lokovr2              char(1)               null,
   lnoovr2              char(1)               null,
   ractl                char(1)               null,
   assignc2             char(1)               null,
   refdir               char(1)               null,
   reffld               char(1)               null,
   refsub               char(1)               null,
   refval               char(1)               null,
   rtitle1              varchar(58)           null,
   rtitle2              varchar(58)           null,
   runstatus            char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   estreqhrs            numeric(10,5)          null,
   gpaname              char(15)              null,
   label                varchar(25)           null,
   auth_code1           varchar(10)           null,
   auth_code2           varchar(10)           null,
   constraint PK_REQ_MAIN primary key (instidq, instid, instcd, rname, rqfyt)
)
go

/* ==== Index:  req_main_idx                                          */
create unique index req_main_idx on req_main (
	rname ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	rqfyt ASC,
	lyt ASC
)
go

/*==============================================================*/
/* Table: req_text                                              */
/*==============================================================*/
create table req_text (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   rname                char(9)               not null,
   rqfyt                char(6)               not null default '0000',
   user_seq_no          integer               null default 0,
   rtext_type           char(1)               null,
   text                 varchar(65)           null,
   lokovr1              char(1)               null,
   lnoovr1              char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_REQ_TEXT primary key (int_seq_no)
)
go

/* ==== Index:  req_text_idx                                          */
create index req_text_idx on req_text (
	rname ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	rqfyt ASC,
	rtext_type ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: req_xy                                                */
/*==============================================================*/
create table req_xy (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null  default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   rname                char(9)               not null,
   rqfyt                char(6)               not null default '0000',
   user_seq_no          integer               null default 0,
   xy_type              char(1)               null,
   series				char(1)               null,
   maxgrpc              numeric(2)            null  default 99,
   maxhrc               numeric(4,1)          null default 999.9,
   skipdup              char(1)               null,
   ctcond               char(1)               null,
   assignm              char(1)               null,
   maxctc               numeric(2)            null default 99,
   maxsrc               numeric(2)            null default 99,
   ctpsname             char(15)              null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   constraint PK_REQ_XY primary key (int_seq_no)
)
go

/* ==== Index:  req_xy_idx                                            */
create index req_xy_idx on req_xy (
	rname ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	rqfyt ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: string                                                */
/*==============================================================*/
create table string (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               null default ' ',
   instid               char(8)               null default ' ',
   instcd               char(3)               null default ' ',
   user_seq_no          integer               null  default 0,
   stype                char(1)               null,
   stypeq               char(1)               null,
   cond                 char(1)               null,
   limct                numeric(2)            null default 0,
   limhrs               numeric(10,5)          null  default 0,
   ctlcd                char(2)               null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   aeflg                char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   constraint PK_STRING primary key (int_seq_no)
)
go

/* ==== Index:  string_idx                                            */
create index string_idx on string (
	instid ASC,	
	instcd ASC,
	instidq ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: string_crse                                           */
/*==============================================================*/
create table string_crse (
   int_seq_no           numeric(9)           not null generated by default as identity,
   str_int_seq_no       numeric(9)            not null  default 0,
   user_seq_no          integer               null default 0,
   course               char(15)              null,
   ctitle               varchar(29)           null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   aeflg                char(1)               null,
   pflg                 char(1)               null,
   effdte               char(12)              null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   constraint PK_STRING_CRSE primary key (int_seq_no)
)
go

/* ==== Index:  string_crse_idx                                       */
create index string_crse_idx on string_crse (
   str_int_seq_no ASC,
   user_seq_no ASC
)
go

/*==============================================================*/
/* Table: stu_acadrec                                           */
/*==============================================================*/
create table stu_acadrec (
   stu_mast_no          numeric(9)           not null default 0,
   source_id            varchar(20)           not null default ' ',
   source_cd            varchar(10)           not null default ' ',
   cdpmask              varchar(15)           not null default ' ',
   crs_yt               varchar(6)            not null default '0000',
   crs_num              varchar(15)           not null,
   crs_seq              varchar(3)            not null default '001',
   section              varchar(3)            null,
   pflg                 char(1)               null,
   rcredit              numeric(10,5)          null default 0,
   grade                varchar(4)            null,
   ctitle               varchar(30)           null,
   rtext                varchar(2)            null,
   condc                varchar(12)           null,
   cline                varchar(30)           null,
   xcourse              varchar(15)           null,
   ecredit              numeric(10,5)          null default 0,
   gpahrs               numeric(10,5)          null default 0,
   gpapts               numeric(10,5)          null default 0,
   linkno               varchar(2)            null,
   xpflg                char(1)               null,
   rtitle               varchar(30)           null,
   evalflg              char(1)               not null default ' ',
   bacc                 char(1)               null,
   actc                 char(1)               null,
   agclc                varchar(2)            null,
   honors               char(1)               null,
   repeatf              char(1)               null,
   iflg1                varchar(3)            null,
   iflg2                varchar(3)            null,
   iflg3                varchar(3)            null,
   iflg4                varchar(3)            null,
   iflg5                varchar(3)            null,
   acourse1             varchar(15)           null,
   apflg1               char(1)               null,
   acourse2             varchar(15)           null,
   apflg2               char(1)               null,
   acourse3             varchar(15)           null,
   apflg3               char(1)               null,
   gradeq               varchar(3)            null,
   rgrade               varchar(4)            null,
   certify              varchar(1)            not null default ' ',
   subj_area            varchar(17)           null,
   gradelev             varchar(2)            null,
   drpdate              varchar(6)            null,
   ovacadsrc            varchar(2)            null,
   security_flag        char(1)               null,
   data_source          char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_STU_ACADREC primary key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
)
go

/* ==== Index:  stu_acad_idx                                          */
create unique index stu_acad_idx on stu_acadrec (
	stu_mast_no ASC,
	source_id ASC,
	source_cd ASC,
	cdpmask ASC,
	crs_yt ASC,
	crs_num ASC,
	crs_seq ASC,
	evalflg ASC,
	certify ASC
)
go

/*==============================================================*/
/* Table: stu_address                                           */
/*==============================================================*/
create table stu_address (
   int_seq_no           numeric(9)           not null generated by default as identity,
   stu_mast_no          numeric(9)           not null default 0,
   source_id            varchar(20)           not null default ' ',
   address_type         varchar(2)            null,
   addrname             varchar(35)           null,
   nametypecd           varchar(2)            null,
   address1             varchar(35)           null,
   address2             varchar(35)           null,
   city                 varchar(30)           null,
   state                varchar(2)            null,
   zip                  varchar(10)           null,
   country              varchar(3)            null,
   locationq            varchar(2)            null,
   locationid           varchar(25)           null,
   entityidcd           varchar(2)            null,
   refnoq               varchar(2)            null,
   refno                varchar(30)           null,
   indrelcd             varchar(2)            null,
   from_date            char(8)               null,
   to_date              char(8)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_STU_ADDRESS primary key (int_seq_no)
)
go

/* ==== Index:  idx_stu_address_fk                  */
create index idx_stu_address_fk on stu_address (
	stu_mast_no ASC,
	source_id ASC
)
go

/*==============================================================*/
/* Table: stu_demo                                              */
/*==============================================================*/
create table stu_demo (
   stu_mast_no          numeric(9)           not null default 0,
   source_id            varchar(20)           not null default ' ',
   stuname              varchar(35)           null,
   stuidq               varchar(2)            null,
   stuiddesc            varchar(80)           null,
   dob                  varchar(6)            null,
   birthcountry         char(3)               null,
   birthstate           char(2)               null,
   birthcounty          char(5)               null,
   birthcity            varchar(30)           null,
   citizenstatus        char(2)               null,
   citizencountry       char(3)               null,
   nativelang           char(3)               null,
   englprof             char(3)               null,
   marital              char(1)               null,
   gender               char(1)               null,
   race                 char(1)               null,
   hsgradtype           char(3)               null,
   hsgraddate           char(8)               null,
   hs                   varchar(30)           null,
   tctlast              varchar(6)            null,
   nodflt               char(1)               null,
   bdverif              char(2)               null,
   spokeninhome         char(3)               null,
   correslang           char(3)               null,
   subnatq              char(2)               null,
   subnational          varchar(20)           null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_STU_DEMO primary key (stu_mast_no, source_id)
)
go

/* ==== View: vw_stu_demo                                            */
create or replace view vw_stu_demo as
	select stu_mast_no, source_id, stuname, stuidq, stuiddesc, dob, birthcountry, birthstate, birthcounty, birthcity, citizenstatus, citizencountry, nativelang, englprof, marital, gender, race, hsgradtype, hsgraddate, hs, tctlast, nodflt, bdverif, spokeninhome, correslang, subnatq, subnational, memo, last_mod_user, last_mod_date
	from stu_demo
go

/*==============================================================*/
/* Table: stu_dprog                                             */
/*==============================================================*/
create table stu_dprog (
   stu_mast_no          numeric(9)           not null default 0,
   instcd               varchar(10)           not null default ' ',
   dprog                varchar(15)           not null,
   drcatlyt             varchar(6)            null,
   dpmask               varchar(15)           null,
   acatlyt1             varchar(6)            null,
   acatlyt2             varchar(6)            null,
   acatlyt3             varchar(6)            null,
   acatlyt4             varchar(6)            null,
   acatlyt5             varchar(6)            null,
   acatlyt6             varchar(6)            null,
   acatlyt7             varchar(6)            null,
   acatlyt8             varchar(6)            null,
   acatlyt9             varchar(6)            null,
   whatif               varchar(1)            null,
   degreecd             varchar(3)            null,
   entryyr              varchar(4)            null,
   exityr               varchar(4)            null,
   trmodmet             char(1)               null,
   degreestatus         char(1)               null,
   honorslevel          varchar(3)            null,
   memo                 varchar(255)          null,
   degree_date          char(10)              null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_STU_DPROG primary key (stu_mast_no, instcd, dprog)
)
go

/*==============================================================*/
/* Table: stu_egrp_courses                                      */
/*==============================================================*/
create table stu_egrp_courses (
   stu_mast_no          numeric(9)           not null default 0,
   evalgrp              varchar(3)            not null default ' ',
   source_id            varchar(20)           not null default ' ',
   source_cd            varchar(10)           not null default ' ',
   cdpmask              varchar(15)           not null default ' ',
   crs_yt               varchar(6)            not null default '0000',
   crs_num              varchar(15)           not null,
   crs_seq              varchar(3)            not null  default '001',
   constraint PK_STU_EGRP_COURSES primary key (stu_mast_no, evalgrp, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
)
go

/* ==== Index:  stu_egrp_crs_idx2                                     */
create index stu_egrp_crs_idx2 on stu_egrp_courses (
	stu_mast_no ASC,
	evalgrp ASC
)
go

/* ==== Index:  stu_egrp_crs_idx3                                     */
create index stu_egrp_crs_idx3 on stu_egrp_courses (
	cdpmask ASC,
	crs_num ASC,
	crs_seq ASC,
	crs_yt ASC,
	source_cd ASC,
	source_id ASC,
	stu_mast_no ASC
)
go

/*==============================================================*/
/* Table: stu_evalgrp                                           */
/*==============================================================*/
create table stu_evalgrp (
   stu_mast_no          numeric(9)           not null default 0,
   evalgrp              varchar(3)            not null default ' ',
   instcd               varchar(10)           null default ' ',
   dpmask               varchar(15)           null default ' ',
   source_id            varchar(20)           null default ' ',
   source_cd            varchar(10)           null default ' ',
   evallock             char(1)               null default ' ',
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   certify              char(1)               null default ' ',
   constraint PK_STU_EVALGRP primary key (stu_mast_no, evalgrp)
)
go

/* ==== Index:  stu_evalgrp_idx                                       */
create unique index stu_evalgrp_idx on stu_evalgrp (
	stu_mast_no ASC,
	evalgrp ASC,
	instcd ASC,
	dpmask ASC,
	source_id ASC,
	source_cd ASC,
	evallock ASC
)
go

/*==============================================================*/
/* Table: stu_exc_courses                                       */
/*==============================================================*/
create table stu_exc_courses (
   int_seq_no           numeric(9)           not null generated by default as identity,
   stu_int_seq_no       numeric(9)            not null default 0,
   user_seq_no          integer               null  default 0,
   course               varchar(15)           null,
   rcourse              varchar(15)           null,
   matchctl             char(1)               null,
   effdte               varchar(12)           null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_STU_EXC_COURSES primary key (int_seq_no)
)
go

/* ==== Index:  stu_exc_crs_idx                                       */
create index stu_exc_crs_idx on stu_exc_courses (
	stu_int_seq_no ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: stu_exceptions                                        */
/*==============================================================*/
create table stu_exceptions (
   int_seq_no           numeric(9)           not null generated by default as identity,
   stu_mast_no          numeric(9)            null  default 0,
   instcd               varchar(20)           not null default ' ',
   dpmask               varchar(15)           not null default ' ',
   dprog                varchar(15)           not null default ' ',
   user_seq_no          integer               null default 0,
   ctlcd                varchar(2)            null,
   action               char(1)               null,
   ruflg                char(1)               null,
   yeartm               varchar(6)            null,
   ac1                  char(1)               null,
   ac2                  char(1)               null,
   rc1                  char(1)               null,
   rc2                  char(1)               null,
   course               varchar(15)           null,
   rcourse              varchar(15)           null,
   cline                varchar(27)           null,
   reqhrs               numeric(10,5)          null,
   maxhrs               numeric(10,5)          null,
   reqsrq               numeric(3)            null,
   maxct                numeric(3)            null,
   val                  numeric(3)            null,
   matchctl             char(1)               null,
   effdte               varchar(12)           null,
   reqgpa               numeric(10,5)          null,
   assignc              char(1)               null,
   maxhrsck             char(1)               null,
   psname               varchar(15)           null,
   rname                char(9)               null,
   memo                 varchar(255)          null,
   auth_id              varchar(30)           null,
   auth_date            varchar(12)           null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   auth_code            varchar(10)           null,
   constraint PK_STU_EXCEPTIONS primary key (int_seq_no)
)
go

/* ==== Index:  stu_exceptions_idx                                    */
create index stu_exceptions_idx on stu_exceptions (
	stu_mast_no ASC,
	instcd ASC,
	dprog ASC,
	dpmask ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: stu_marker_req                                        */
/*==============================================================*/
create table stu_marker_req (
   int_seq_no           numeric(9)           not null generated by default as identity,
   stu_mast_no          numeric(9)            not null default 0,
   instcd               varchar(10)           not null default ' ',
   dprog                varchar(15)           not null,
   user_seq_no          integer               null default 0,
   marker               varchar(9)            null,
   drval                varchar(15)           null,
   drtype               char(1)               null,
   drinstcd             varchar(3)            null,
   drcatlyt             varchar(6)            null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_STU_MARKER_REQ primary key (int_seq_no)
)
go

/* ==== Index:  stu_marker_req_idx                                    */
create index stu_marker_req_idx on stu_marker_req (
	stu_mast_no ASC,
	instcd ASC,
	dprog ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: stu_master                                            */
/*==============================================================*/
create table stu_master (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              varchar(2)            not null default ' ',
   instid               varchar(8)            null default ' ',
   stuno                varchar(30)           null,
   tctlast              varchar(6)            null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   nodflt               char(1)               null,
   pin                  varchar(20)           null,
   encrypted_pin        varchar(80)           null,
   constraint PK_STU_MASTER primary key (int_seq_no)
)
go

/* ==== Index:  stu_info_idx                                          */
create unique index stu_info_idx on stu_master (
	stuno ASC,
	instidq ASC,
	instid ASC
)
go

/* ==== View: vw_stu_master                                          */
create or replace view vw_stu_master  as
	select int_seq_no, instidq, instid, stuno, memo, last_mod_user, last_mod_date, tctlast, pin, nodflt, encrypted_pin 
	from stu_master
go

/*==============================================================*/
/* Table: stu_trans_degree                                      */
/*==============================================================*/
create table stu_trans_degree (
   stu_mast_no          numeric(9)           not null default 0,
   user_seq_no          integer              not null default 0,
   segtitle             char(5)               null,
   acadfoscode          char(1)               null,
   segliteral           varchar(75)           null,
   fieldofstudy         varchar(20)           null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_STU_TRANS_DEGREE primary key (stu_mast_no, user_seq_no)
)
go

/*==============================================================*/
/* Table: sub_req                                               */
/*==============================================================*/
create table sub_req (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null  default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   rname                char(9)               not null,
   rqfyt                char(6)               not null default '0000',
   user_seq_no          integer               null  default 0,
   sreqno               integer               null default 0,
   reqct                numeric(2)            null default 0,
   reqctf               char(1)               null,
   reqhrs               numeric(10,5)          null default 0,
   reqhrsf              char(1)               null,
   reqgpa               numeric(10,5)          null  default 0,
   reqgpaf              char(1)               null,
   maxhrs               numeric(10,5)          null default 999.9,
   maxhrsck             char(1)               null,
   allres               char(1)               null,
   ac1                  char(1)               null,
   ac2                  char(1)               null,
   ac3                  char(1)               null,
   ac4                  char(1)               null,
   ac5                  char(1)               null,
   acor                 char(1)               null,
   rc1                  char(1)               null,
   rc2                  char(1)               null,
   rc3                  char(1)               null,
   rc4                  char(1)               null,
   rc5                  char(1)               null,
   rcand                char(1)               null,
   actl                 char(1)               null,
   assignc              char(1)               null,
   assignc2             char(1)               null,
   assignm              char(1)               null,
   sreuse               char(1)               null,
   skipbct              numeric(1)            null,
   nolist               char(1)               null,
   noseqno              char(1)               null,
   reqflg               char(1)               null,
   iplist               char(1)               null,
   ignorecl             char(1)               null,
   gpaweight            char(1)               null,
   seqchk               char(1)               null,
   maxct                numeric(2)            null default 99,
   ctcond0              char(1)               null,
   ctcond1              char(1)               null,
   ctcond2              char(1)               null,
   ctcond3              char(1)               null,
   ctcond4              char(1)               null,
   ctcond5              char(1)               null,
   ctcond6              char(1)               null,
   ctcond7              char(1)               null,
   ctcond8              char(1)               null,
   ctcond9              char(1)               null,
   ctcond10             char(1)               null,
   ctcond11             char(1)               null,
   ctcond12             char(1)               null,
   ctcond13             char(1)               null,
   ctcond14             char(1)               null,
   conda                char(1)               null,
   condr                char(1)               null,
   listsr               char(1)               null,
   negreq               char(1)               null,
   pntdescr             char(1)               null,
   gpa                  char(1)               null,
   aonly                char(1)               null,
   calpha               char(1)               null,
   grp                  char(1)               null,
   grpmin               numeric(2)            null default 0,
   grpmax               numeric(2)            null default 99,
   varc                 char(1)               null,
   hcmin                numeric(2)            null default 0,
   hcmax                numeric(2)            null default 99,
   xrefsr               char(1)               null,
   refgno               numeric(2)            null default 0,
   eorder               char(1)               null,
   etopdown             char(1)               null,
   estop                char(1)               null,
   elimit               char(1)               null,
   refdir               char(1)               null,
   reffld               char(1)               null,
   refsub               char(1)               null,
   refval               char(1)               null,
   refcycle             char(1)               null,
   selra                char(1)               null,
   sortflg              char(1)               null,
   sreqor               char(1)               null,
   actlx                char(1)               null,
   assigncx             char(1)               null,
   revartl              char(1)               null,
   matchone             char(1)               null,
   ltopdown             char(1)               null,
   selip                char(1)               null,
   runstatus            char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   esthrs               numeric(10,5)          null,
   esthrsflg            char(1)               null,
   gpaname              char(15)              null,
   label                varchar(25)           null,
   constraint PK_SUB_REQ primary key (int_seq_no)
)
go

/* ==== Index:  sub_req_idx                                           */
create index sub_req_idx on sub_req (
	rname ASC,
	instidq ASC,	
	instid ASC,
	instcd ASC,
	rqfyt ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: sub_req_ar                                            */
/*==============================================================*/
create table sub_req_ar (
   int_seq_no           numeric(9)           not null generated by default as identity,
   sub_int_seq_no       numeric(9)           not null  default 0,
   user_seq_no          integer              null default 0,
   ar_type              char(1)               not null,
   course               char(15)              null,
   matchctl             char(1)               null,
   ctitle               varchar(29)           null,
   tflg                 char(1)               null,
   creditlim            char(1)               null,
   crsflag              char(3)               null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   effdte               char(12)              null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_SUB_REQ_AR primary key (int_seq_no)
)
go

/* ==== Index:  sub_req_ar_idx                                        */
create index sub_req_ar_idx on sub_req_ar (
	sub_int_seq_no ASC,
	ar_type DESC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: sub_req_text                                          */
/*==============================================================*/
create table sub_req_text (
   int_seq_no           numeric(9)           not null generated by default as identity,
   sub_int_seq_no       numeric(9)           not null default 0,
   user_seq_no          integer              null default 0,
   srtext_type          char(1)               null,
   text                 varchar(55)           null,
   lokovr1              char(1)               null,
   lnoovr1              char(1)               null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_SUB_REQ_TEXT primary key (int_seq_no)
)
go

/* ==== Index:  sub_req_text_idx                                      */
create index sub_req_text_idx on sub_req_text (
	sub_int_seq_no ASC,
	srtext_type ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: tca_master                                            */
/*==============================================================*/
create table tca_master (
   instidq              char(2)               not null  default ' ',
   instid               char(8)               not null  default ' ',
   instcd               char(3)               not null  default ' ',
   source_id            char(8)               not null  default ' ',
   source_cd            char(3)               not null  default ' ',
   dpmask               char(15)              not null  default ' ',
   fyt                  char(6)               not null default '0000',
   lyt                  char(6)               null default '9999',
   iname                varchar(60)           null,
   univ_dpmask          char(1)               null,
   dinstid              char(8)               null,
   dinstcd              char(3)               null,
   tastatus             char(1)               null,
   memo                 varchar(255)          null,
   last_mod_date        timestamp            null,
   last_mod_user        varchar(30)           null,
   constraint PK_TCA_MASTER primary key (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
)
go

/* ==== Index:  tca_master_idx                                        */
create unique index tca_master_idx on tca_master (
	source_id ASC,
	source_cd ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	dpmask ASC,
	fyt ASC,
	lyt ASC,
	tastatus ASC
)
go

/*==============================================================*/
/* Table: tca_rule                                              */
/*==============================================================*/
create table tca_rule (
   int_seq_no           numeric(9)           not null generated by default as identity,
   instidq              char(2)               not null default ' ',
   instid               char(8)               not null default ' ',
   instcd               char(3)               not null default ' ',
   source_id            char(8)               not null default ' ',
   source_cd            char(3)               not null default ' ',
   dpmask               char(15)              not null default ' ',
   fyt                  char(6)               not null default '0000',
   tseg                 char(7)               not null  default ' ',
   user_seq_no          integer               null default 0,
   cond                 char(1)               null,
   limct                numeric(2)            null default 0,
   limhrs               numeric(10,5)          null  default 0,
   ctlcd                char(2)               null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   tastatus             char(1)               null,
   private_note         varchar(255)          null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   constraint PK_TCA_RULE primary key (int_seq_no)
)
go

/* ==== Index:  tca_rule_idx                                          */
create index tca_rule_idx on tca_rule (
	source_id ASC,
	source_cd ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	dpmask ASC,
	fyt ASC,
	tseg ASC,
	user_seq_no ASC,
	tastatus ASC
)
go

/*==============================================================*/
/* Table: tca_source                                            */
/*==============================================================*/
create table tca_source (
   int_seq_no           numeric(9)           not null generated by default as identity,
   tca_rule_seq_no      numeric(9)            not null  default 0,
   user_seq_no          integer               null default 0,
   course               char(15)              null,
   pflg                 char(1)               null,
   ctitle               varchar(29)           null,
   tflg                 char(1)               null,
   limhrs               numeric(10,5)          null default 0,
   ctlcd                char(2)               null,
   ac                   char(1)               null,
   rc                   char(1)               null,
   cond                 char(1)               null,
   effdte               char(12)              null,
   loweffdte            char(6)               null,
   hieffdte             char(6)               null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_TCA_SOURCE primary key (int_seq_no)
)
go

/* ==== Index:  tca_source_idx                                        */
create index tca_source_idx on tca_source (
	tca_rule_seq_no ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: tca_target                                            */
/*==============================================================*/
create table tca_target (
   int_seq_no           numeric(9)           not null generated by default as identity,
   tca_rule_seq_no      numeric(9)            not null default 0,
   user_seq_no          integer               null default 0,
   course               char(15)              null,
   pflg                 char(1)               null,
   ctitle               varchar(29)           null,
   tflg                 char(1)               null,
   limhrs               numeric(10,5)          null default 0,
   forcehrs             char(1)               null,
   cond                 char(1)               null,
   iflg1                char(3)               null,
   iflg2                char(3)               null,
   iflg3                char(3)               null,
   iflg4                char(3)               null,
   iflg5                char(3)               null,
   acourse1             char(15)              null,
   apflg1               char(1)               null,
   acourse2             char(15)              null,
   apflg2               char(1)               null,
   acourse3             char(15)              null,
   apflg3               char(1)               null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp             null,
   tastatus             char(1)               null,
   hide_acourse1        char(1)               null,
   hide_acourse2        char(1)               null,
   hide_acourse3        char(1)               null,
   hide_iflgs           char(1)               null,
   constraint PK_TCA_TARGET primary key (int_seq_no)
)
go

/* ==== Index:  tca_target_idx                                        */
create index tca_target_idx on tca_target (
	tca_rule_seq_no ASC,
	user_seq_no ASC
)
go

/*==============================================================*/
/* Table: DPROG_TYPE                                            */
/*==============================================================*/
create table dprog_type (
   instidq              char(2)               not null,
   instid               char(8)               not null,
   instcd               char(3)               not null,
   type_code            char(3)               not null,
   label	            varchar(30)           null,
   type_order           integer               not null,
   constraint PK_dprog_type primary key (instidq, instid, instcd, type_code)
)
go

alter table dprog_type
	add constraint uc_dprog_type
	UNIQUE (instidq, instid, instcd, type_order)
go

/*==============================================================*/
/* Table: WHATIF_ELEMENT_TYPE_ASSOC                             */
/*==============================================================*/
create table whatif_element_type_assoc ( 
	int_seq_no    		numeric(18,0) 			not null generated by default as identity,
	instidq		       	char(2) 				NOT NULL,
	instid		       	char(8) 				NOT NULL,
	instcd	        	char(3) 				NOT NULL,
	element		       	char(15)				NOT NULL,
	dprog_type		   	char(3) 				NOT NULL,
	label	         	varchar(30) 			NULL,
	forced_mapping		char(1) 				NOT NULL  DEFAULT 'N',
	reqd_values		   	integer 				NOT NULL  DEFAULT 0,
	max_values	    	integer 				NOT NULL  DEFAULT 0,
	parent_element		char(15) 				NOT NULL,
	fyt		           	char(6) 				NOT NULL,
	lyt		           	char(6) 				NOT NULL,
	group_order		   	integer 				NOT NULL,
	forced_catalog_year	char(1)					NOT NULL  DEFAULT 'N',
	constraint pk_weta PRIMARY KEY (int_seq_no)
)
go

alter table whatif_element_type_assoc
	add constraint uc_wi_element_type_assoc
	UNIQUE (instidq, instid, instcd, element, dprog_type, fyt, parent_element)	
go

create index idx_whatif_eta_fk on whatif_element_type_assoc (
	instidq, instid, instcd, dprog_type
)
go

/*==============================================================*/
/* Table: WHATIF_FORCED_MARKER	                                */
/*==============================================================*/
create table whatif_forced_marker  ( 
	int_seq_no	     	numeric(18,0) 		not null generated by default as identity,
	weta_int_seq_no		numeric(18,0) 		NOT NULL,
	element_value	  	char(15) 			NOT NULL,
	forced_marker	  	char(9) 			NOT NULL,
	forced_val	     	char(15)			NOT NULL,
	forced_type	    	char(1) 			NOT NULL,
	fyt	            	char(6) 			NOT NULL,
	lyt	            	char(6) 			NOT NULL,
	exclude 	       	char(1) 			NOT NULL,
	ref_instidq	    	varchar(2) 			NOT NULL,
	ref_instid 	    	varchar(8) 			NOT NULL,
	ref_instcd	     	varchar(3) 			NOT NULL,
	constraint pk_wi_forced_marker PRIMARY KEY(int_seq_no)
	)
go

create index idx_whatif_fm_fk on whatif_forced_marker (
	weta_int_seq_no
)
go

/*==============================================================*/
/* Table: WHATIF_ELEMENT_FILTER	                                */
/*==============================================================*/
create table whatif_element_filter  ( 
	int_seq_no    	numeric(18,0) 		not null generated by default as identity,
	instidq       	char(2) 			NOT NULL,
	instid        	char(8) 			NOT NULL,
	instcd        	char(3) 			NOT NULL,
	dprog         	char(15) 			NOT NULL,
	element       	char(15) 			NOT NULL,
	filter_pattern	char(25) 			NOT NULL,
	fyt           	char(6) 			NOT NULL,
	lyt           	char(6) 			NOT NULL,
	exclude       	char(1) 			NOT NULL,
	ref_instidq   	varchar(2) 			NOT NULL,
	ref_instid    	varchar(8) 			NOT NULL,
	ref_instcd    	varchar(3) 			NOT NULL,
	constraint pk_wi_element_filter PRIMARY KEY (int_seq_no)
	)
go

--============================================================
--                Create Foreign Key Constraints
--============================================================

alter table job_queue_accept
   add constraint FK_job_queue_accept_job_queue_subreq foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
	 	 	on delete restrict on update restrict 
go

alter table job_queue_course
   add constraint FK_job_queue_course_job_queue_subreq foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
		on delete restrict on update restrict 
go

alter table dprog_req
   add constraint FK_DPROG_RE_RELATION__DPROG foreign key (instidq, instid, instcd, dprog, dpfyt)
      references dprog (instidq, instid, instcd, dprog, dpfyt)
		on delete restrict on update restrict 
go

alter table job_queue_detail
   add constraint FK_JOB_QUEU_RELATION__JOB_QUEU foreign key (instidq, instid, instcd, jobid, userid)
      references job_queue_list (instidq, instid, instcd, jobid, userid)
		on delete restrict on update restrict 
go

alter table job_queue_exceptions
   add constraint FK_JQEXC_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
		on delete restrict on update restrict 
go

alter table job_queue_incl_text
   add constraint FK_JQINCL_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
		on delete restrict on update restrict 
go

alter table job_queue_markers
   add constraint FK_JQMRK_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
		on delete restrict on update restrict 
go

alter table job_queue_out
    add constraint FK_JOBQ_OUT_REF_JOBQ_RUN foreign key (jobq_seq_no)
		references job_queue_run(int_seq_no)
		on delete restrict on update restrict 
go

alter table job_queue_report
   add constraint FK_JQREP_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
		on delete restrict on update restrict 
go

alter table job_queue_req
    add constraint FK_job_queue_req_job_queue_run foreign key (jobq_seq_no) 
    	references job_queue_run (int_seq_no)
		on delete restrict on update restrict 
go

alter table job_queue_req_text
   add constraint FK_JQRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
		on delete restrict on update restrict 
go

alter table job_queue_subreq
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
		on delete restrict on update restrict 
go

alter table job_queue_subreq_text
   add constraint FK_JQSRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
		on delete restrict on update restrict 
go

alter table job_queue_sysin
   add constraint FK_JOB_QUEU_REF_56906_JOB_QUEU foreign key (instidq, instid, instcd, jobid, userid)
      references job_queue_list (instidq, instid, instcd, jobid, userid)
		on delete restrict on update restrict 
go

alter table mastref_address
   add constraint FK_MASTREF__REF_16608_MASTREF foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
		on delete restrict on update restrict 
go

alter table mastref_seg
   add constraint FK_MASTREF__REF_15108_MASTREF foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
		on delete restrict on update restrict 
go

alter table req_text
   add constraint FK_REQ_TEXT_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
		on delete restrict on update restrict 
go

alter table req_xy
   add constraint FK_REQ_XY_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
		on delete restrict on update restrict 
go

alter table string_crse
   add constraint FK_STRING_C_RELATION__STRING foreign key (str_int_seq_no)
      references string (int_seq_no)
		on delete restrict on update restrict 
go

alter table stu_acadrec
   add constraint FK_STU_ACAD_REF_23073_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
		on delete restrict on update restrict 
go

alter table stu_address
   add constraint FK_STU_ADDR_REF_12130_STU_DEMO foreign key (stu_mast_no, source_id)
      references stu_demo (stu_mast_no, source_id)
		on delete restrict on update restrict 
go

alter table stu_demo
   add constraint FK_STU_DEMO_REF_23034_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
		on delete restrict on update restrict 
go

alter table stu_dprog
   add constraint FK_STU_DPRO_REF_23053_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
		on delete restrict on update restrict 
go

alter table stu_egrp_courses
   add constraint FK_STU_EGRP_REF_46007_STU_ACAD foreign key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
      references stu_acadrec (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
		on delete restrict on update restrict 
go

alter table stu_egrp_courses
   add constraint fk_egrp_2_egrp_crs foreign key (stu_mast_no, evalgrp)
      references stu_evalgrp (stu_mast_no, evalgrp)
		on delete restrict on update restrict 
go

alter table stu_evalgrp
   add constraint fk_stu_eval_2_mast foreign key (stu_mast_no)
      references stu_master (int_seq_no)
		on delete restrict on update restrict 
go

alter table stu_exc_courses
   add constraint FK_STU_EXC__REF_14062_STU_EXCE foreign key (stu_int_seq_no)
      references stu_exceptions (int_seq_no)
		on delete restrict on update restrict 
go

alter table stu_exceptions
   add constraint FK_STU_EXCE_REF_23068_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
		on delete restrict on update restrict 
go

alter table stu_marker_req
   add constraint FK_STU_MARK_RELATION__STU_DPRO foreign key (stu_mast_no, instcd, dprog)
      references stu_dprog (stu_mast_no, instcd, dprog)
		on delete restrict on update restrict 
go

alter table stu_trans_degree
	add constraint FK_STU_TRAN_REF_23058_STU_MAST foreign key (stu_mast_no)
		references stu_master (int_seq_no)
		on delete restrict on update restrict 
go

alter table sub_req
	add constraint FK_SUB_REQ_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
    	references req_main (instidq, instid, instcd, rname, rqfyt)
		on delete restrict on update restrict 
go

alter table sub_req_ar
	add constraint sreq_to_sreq_ar foreign key (sub_int_seq_no)
		references sub_req (int_seq_no)
		on delete restrict on update restrict 
go

alter table sub_req_text
   add constraint sreq_to_sreq_text foreign key (sub_int_seq_no)
    	references sub_req (int_seq_no)
		on delete restrict on update restrict 
go

alter table tca_rule
   add constraint FK_TCA_RULE_REF_10199_TCA_MAST foreign key (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
    	references tca_master (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
		on delete restrict on update restrict 
go

alter table tca_source
   add constraint FK_TCA_SOUR_REF_11057_TCA_RULE foreign key (tca_rule_seq_no)
		references tca_rule (int_seq_no)
		on delete restrict on update restrict 
go

alter table tca_target
	add constraint FK_TCA_TARG_REF_11060_TCA_RULE foreign key (tca_rule_seq_no)
    	references tca_rule (int_seq_no)
		on delete restrict on update restrict 
go

alter table whatif_forced_marker
	add constraint fk_wi_ele_type_assoc foreign key(weta_int_seq_no)
		references whatif_element_type_assoc(int_seq_no)
		on delete restrict on update restrict 
go

alter table whatif_element_type_assoc
	add constraint fk_weta_relation_dprog_type foreign key(instidq, instid, instcd, dprog_type)
		references dprog_type(instidq, instid, instcd, type_code)
		on delete restrict on update restrict 
go
