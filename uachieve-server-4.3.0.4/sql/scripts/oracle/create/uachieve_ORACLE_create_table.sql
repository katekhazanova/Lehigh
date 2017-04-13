/*================================================================*/
/* Release:			u.achieve 4.3                                 */
/* DBMS name:      	ORACLE Version 10g/11i/12c                    */
/* Created on: 		8/13/2008 4:51:53 PM                          */
/* Last Updated:   	6/07/2015                                     */
/* Script name: 	uachieve_oracle_create_table.sql              */
/* Purpose:        	Creates the u.achieve Server database tables  */
/*                                                                */
/* Beginning with 4.2, we have moved all the security tables      */
/* and any other tables specific to u.achieve self-service to     */
/* the Dashboard installation scripts.                            */
/*                                                                */
/* This script now contains only those tables specific to the     */
/* u.achieve server.                                              */
/*                                                                */
/* Highlights: 	u.achieve Server 4.3	June 15, 2015         	  */
/*                * Removed version from create script names.     */
/*                * Removed int_seq_no from most job_queue PKs.   */
/*                * Added columns to job_queue tables to identify */
/*                  server host.                                  */
/*                * Added tca_segment and transfer_inst tables.   */
/*                * Change int_seq_no data type from numeric(9)   */
/*                  to numeric(18) on job_queue tables.           */
/*                                                                */
/*				u.achieve Server 4.3.0.0.1	July 31, 2015         */
/*                * indexes on some job_queue tables incorrectly  */
/*                  defined.                                      */
/*                * sequence objects with nomaxvalue also require */
/*                  nocycle.                                      */
/*                                                                */
/* Copyright(c) 1998-2015 CollegeSource, Inc. All Rights Reserved */
/*                                                                */
/*================================================================*/

--============================================================
--                 Create Tables and Indexes
--============================================================

/*==============================================================*/
/* Table: chart_categories                                      */
/*==============================================================*/
create table chart_categories (
   instidq            char(2)			default ' ' not null,
   instid             char(8)           default ' ' not null,
   instcd             char(3)           default ' ' not null,
   category_code      char(1)           not null,
   category_name      char(15),
   category_desc      varchar2(255),
   transcript         char(1),
   total_hour         char(1),
   total_gpa          char(1),
   hidefromchart      char(1),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   hide_gpa           char(1),
   force_schema_include	char(1),
   constraint PK_CHART_CATEGORIES primary key (instidq, instid, instcd, category_code)
)
/


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
/

/*==============================================================*/
/* Table: com                                                   */
/*==============================================================*/
create table com (
   instidq            char(2)			default ' ' not null,
   instid             char(8)           default ' ' not null,
   instcd             char(3)           default ' ' not null,
   comkey             char(5)           default ' ' not null,
   comfield           char(10)          not null,
   comvalue           varchar2(255),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_COM primary key (instidq, instid, instcd, comkey, comfield)
)
/

/* ==== Index:  com_idx                                               */
create unique index com_idx on com (
	comkey ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	comfield ASC
)
/

/*==============================================================*/
/* Table: cond_codes                                            */
/*==============================================================*/
create table cond_codes (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   comkey             char(5)                        default ' ' not null,
   seq_no             integer                        default 0 not null,
   cond_code          char(1),
   course_cc_desc     char(80),
   system_cc_desc     char(80),
   last_mod_date      date,
   last_mod_user      varchar2(30),
   constraint PK_COND_CODES primary key (instidq, instid, instcd, comkey, seq_no)
)
/

/*==============================================================*/
/* Table: course_bank                                           */
/*==============================================================*/
create table course_bank (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   course             char(15)                       not null,
   pflg               char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_COURSE_BANK primary key (instidq, instid, instcd, course)
)
/

/*==============================================================*/
/* Table: crs_convert                                           */
/*==============================================================*/
create table crs_convert (
   int_seq_no         number(9)                      not null,
   instidq            char(2)                        default ' ',
   instid             char(8)                        default ' ',
   instcd             char(3)                        default ' ',
   user_seq_no        integer                        default 0,
   oldcrse            char(15),
   newcrse            char(15),
   effdte             char(12),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_CRS_CONVERT primary key (int_seq_no)
)
/

/* ==== Index:  convert_idx                                           */
create index convert_idx on crs_convert (
	instid ASC,
	instcd ASC,
	instidq ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: current_jobs                                          */
/*==============================================================*/
create table current_jobs(
	instcd 			varchar2(3)  		NOT NULL,
	instid 			varchar2(8)  		NOT NULL,
	instidq 		varchar2(2)  		NOT NULL,
	stuno 			varchar2(15),
	starttime 		TIMESTAMP,
 	constraint PK_CURRENT_JOBS PRIMARY KEY (instcd, instid , instidq, stuno)
)
/

/*==============================================================*/
/* Table: dprog                                                 */
/*==============================================================*/
create table dprog (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   dprog              char(15)                       not null,
   dpfyt              char(6)                        default '0000' not null,
   lyt                char(6)                        default '9999',
   dptitle1           varchar2(65),
   dptitle2           varchar2(65),
   webtitle           varchar2(50),
   college            varchar2(10),
   major              varchar2(10),
   degree             varchar2(10),
   location           varchar2(10),
   dpcips             char(6),
   dpmask             char(15),
   dpstatus           char(1),
   efilter            char(15),
   instpad            varchar2(44),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   dptype             char(1),
   type_code          char(3),
   constraint PK_DPROG primary key (instidq, instid, instcd, dprog, dpfyt)
)
/


/* ==== Index:  dprog_idx                                             */
create unique index dprog_idx on dprog (
	dprog ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	dpfyt ASC,
	lyt ASC
)
/

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
/

/*==============================================================*/
/* Table: dprog_req                                             */
/*==============================================================*/
create table dprog_req (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   dprog              char(15)                        not null,
   dpfyt              char(6)                        default '0000' not null,
   user_seq_no        integer                        default 0,
   dprname            char(9)                         not null,
   grp1               char(1),
   grp2               char(1),
   orflg              char(1),
   optflg             char(1),
   sumgrp             char(1),
   crlink             char(1),
   altcflg            char(1),
   sortflg            char(1),
   extend             char(1),
   calcgrp            char(1),
   calcflg            char(1),
   runstatus          char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   category           char(1),
   constraint PK_DPROG_REQ primary key (int_seq_no)
)
/

/* ==== Index:  dprog_req_idx                                         */
create index dprog_req_idx on dprog_req (
	dprog ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	dpfyt ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: gmaster                                               */
/*==============================================================*/
create table gmaster (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ',
   instid             char(8)                        default ' ',
   instcd             char(3)                        default ' ',
   line_type          char(1)                        default ' ',
   user_seq_no        integer                        default 0,
   grade              char(4),
   rgrade             char(4),
   gpapt              number(10,5)                    default 0,
   gpacal             char(1),
   addcr              char(1),
   addct              char(1),
   pseudo             char(1),
   force              char(1),
   ip                 char(1),
   ctlcd              char(2),
   action             char(1),
   ruflg              char(1),
   condg              char(6),
   delig              char(1),
   replac             char(1),
   creditck           char(1),
   lcredit            number(10,5)                    default 0,
   hcredit            number(10,5)                    default 0,
   ac                 char(1),
   rc                 char(1),
   effdte             char(12),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_GMASTER primary key (int_seq_no)
)
/


/* ==== Index:  gmaster_idx                                           */
create index gmaster_idx on gmaster (
    instid ASC,
    instcd ASC,
    instidq ASC,
    user_seq_no ASC
)
/

/*==============================================================*/
/* Table: include_text                                          */
/*==============================================================*/
create table include_text (
   INSTIDQ              char(2)                        default ' ' not null,
   INSTID               char(8)                        default ' ' not null,
   INSTCD               char(3)                        default ' ' not null,
   TEXT_KEY             varchar2(20)                   default ' ' not null,
   TEXT_TYPE            char                            not null,
   TEXT                 nclob,
   LAST_MOD_USER        varchar2(30),
   LAST_MOD_DATE        date,
   constraint PK_INCL_TEXT primary key (INSTIDQ, INSTID, INSTCD, TEXT_KEY, TEXT_TYPE)
)
/

/*==============================================================*/
/* Table: job_queue_accept                                      */
/*==============================================================*/
create table JOB_QUEUE_ACCEPT (
   INT_SEQ_NO           number					default 0 not null,
   JOBQ_SEQ_NO          number                  default 0 not null,
   RTABX                char(3)                 not null,
   STABX                char(3)                 not null,  
   COURSE               varchar2(15),
   TITLE                varchar2(29),
   REJECT               char(1),
   USED                 char(1),
   LOGIC                char(1),
   REQUIRED             char(1),
   CMPRTITLE            char(1),
   RANGECOURSE          char(15),
   LOWYT                char(6),
   HIGHYT               char(6),
   HIDDEN               char(1),
   INNER_MEM 			char(1),
   INNER_BGN 			char(1),
   INNER_END 			char(1),
   OUTER_MEM 			char(1),
   OUTER_BGN 			char(1),
   OUTER_END 			char(1),
   SYMBOL_BEFORE 		char(5),
   USER_SEQ_NO          number					default 0 not null,
   DEPT                 char(15),
   CRSNO                char(15),
   PSEUDO_FLAG          char(1),
   constraint PK_JOB_QUEUE_ACCEPT primary key (jobq_seq_no, rtabx, stabx, user_seq_no)
)
/

/* ==== Index:  jobq_accept_idx                                       */
create index jobq_accept_idx on job_queue_accept (
	jobq_seq_no ASC,
	rtabx ASC,
    stabx ASC,
    reject ASC,
    user_seq_no ASC
)
/

/* ==== Index:  jobq_accept_idx2                                         */
create index jobq_accept_idx2 on job_queue_accept (int_seq_no)
/

/* ==== Index:  jobq_accept_idx3                                         */
create index jobq_accept_idx3 on job_queue_accept (jobq_seq_no)
/

/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
create table JOB_QUEUE_COURSE (
   INT_SEQ_NO           number							default 0 not null,
   JOBQ_SEQ_NO          number                          default 0 not null,
   RTABX                char(3)                         not null,
   STABX                char(3)                         not null,   
   YT                   char(6),
   EDIT_YT              char(4),
   COURSE               varchar2(15),
   XCOURSE              varchar2(15),
   RCREDIT              number(10,5),
   CREDIT               number(10,5),
   GPAHRS               number(10,5),
   GPAPTS               number(10,5),
   GPA                  number(10,5),
   GRADE                char(4),
   RGRADE               char(4),
   IP                   char(1),
   WHATIF               char(1),
   PSEUDO               char(1),
   CTITLE               varchar2(29),
   RTITLE               varchar2(29),
   STITLE               varchar2(29),
   CVTTITLE             varchar2(29),
   ALTTITLE             varchar2(29),
   USER_SEQ_NO          number				default 0 not null,
   PASSFAIL             char(1),
   ADDCT                integer,
   EVALFLG 				char(1) 			null, 
   SOURCE_ID			varchar2(20) 		null,
   SOURCE_CD			varchar2(10) 		null,
   constraint PK_JOB_QUEUE_COURSE primary key (jobq_seq_no, rtabx, stabx, user_seq_no)
)
/

/* ==== Index:  jobq_course_idx                                         */
create index jobq_course_idx on job_queue_course (int_seq_no)
/
/* ==== Index:  jobq_course_idx2                                        */
create index jobq_course_idx2 on job_queue_course (jobq_seq_no)
/

/*==============================================================*/
/* Table: job_queue_destination                                 */
/*==============================================================*/
create table JOB_QUEUE_DESTINATION(
	JOBID 					char(16)  				NOT NULL,
	USERID 					char(30) 				NOT NULL,
	DESTINATION_URL 		varchar2(255)  			NOT NULL,
	OUTPUT_FORMAT 			char(1),
	SEND_ERROR_COUNT 		integer 				DEFAULT 0 NOT NULL ,
	SEND_ERROR_MESSAGE 		varchar2(255),
	STATUS 					char(1) 				NOT NULL,
	SEND_DATE 				TIMESTAMP,
	NEXT_SEND_DATE 			TIMESTAMP,
 	constraint PK_JOB_QUEUE_DESTINATION PRIMARY KEY (JOBID,USERID) 
)
/

/*==============================================================*/
/* Table: job_queue_detail                                      */
/*==============================================================*/
create table JOB_QUEUE_DETAIL (
   INT_SEQ_NO           number					not null,
   INSTIDQ              char(2)					default ' ' not null,
   INSTID               char(8) 				default ' ' not null,
   INSTCD               char(3) 				default ' ' not null,
   JOBID                char(16)				not null,
   USERID               char(30) 				not null,
   USER_SEQ_NO          integer 				default 0 not null,
   STUNO                char(13),
   COMKEY               char(5),
   EVALSW               char,
   F1OR2                char,
   REPORT               char,
   PNTREQ               char,
   LISTALL              char,
   TEST                 char,
   FDPROG               char(15),
   FCATLYT              char(6),
   SINSTID              char(8),
   SINSTCD              char(3),
   FDPMASK              char(15),
   TIME_TOKEN           char(6),
   LASERTEXT            char,
   FORMAT               char,
   PARSEFLG             char(8),
   REVART               char,
   BINSTID              char(8),
   BINSTCD              char(3),
   BYTAKEN              char(6),
   SOPRID               char(8),
   D_WHATIF             char					default ' ',
   STATUS               char,
   constraint PK_JOB_QUEUE_DETAIL primary key (INT_SEQ_NO)
)
/

/* ====  Index: job_q_detail_idx  ==== */
create index job_q_detail_idx on JOB_QUEUE_DETAIL (
	JOBID ASC,
	INSTIDQ ASC,
	INSTID ASC,
	INSTCD ASC,
	USERID ASC,
	USER_SEQ_NO ASC
)
/

/*==============================================================*/
/* Table: job_queue_exceptions                                  */
/*==============================================================*/
create table JOB_QUEUE_EXCEPTIONS (
   INT_SEQ_NO           number                  default 0	not null,
   JOBQ_SEQ_NO          number					default 0	not null,
   USER_SEQ_NO          number					default 0	not null,
   CTLCD                char(2),
   ACTION               char,
   RUFLG                char,
   COURSE				varchar2(15),
   RCOURSE				varchar2(15),
   CLINE				varchar2(27),
   PSNAME               varchar2(15),
   RNAME                varchar2(9),
   MEMO                 varchar2(255),
   AUTH_ID              varchar2(30),
   AUTH_DATE            varchar2(12),
   AUTH_CODE            varchar2(10),
   LAST_MOD_USER        varchar2(30),
   LAST_MOD_DATE        date,
   constraint PK_JOB_QUEUE_EXCEPTIONS primary key (jobq_seq_no, user_seq_no)
)
/

/* ==== Index:  jobq_exceptions_idx                                         */
create index jobq_exceptions_idx on job_queue_exceptions (int_seq_no)
/

/*==============================================================*/
/* Table: job_queue_incl_text                                   */
/*==============================================================*/
create table JOB_QUEUE_INCL_TEXT (
   INT_SEQ_NO           number					default 0	not null,
   JOBQ_SEQ_NO          number					default 0	not null,
   TEXT_TYPE            char					default ' '	not null,
   TEXT                 NCLOB,
   constraint PK_JOB_QUEUE_INCL_TEXT primary key (jobq_seq_no, text_type)
)
/


/*==============================================================*/
/* Table: job_queue_list										*/
/*==============================================================*/
create table job_queue_list (
	instidq				char(2)					default ' ' not null,
	instid				char(8)					default ' ' not null,
	instcd				char(3)					default ' ' not null,
	jobid				char(16)				not null,
	userid				char(30)				not null,
	status				char					default 'N',
	priority			integer					default 100,
	startdate			char(10),
	starttime			char(5),
	external_eval		char,
	read_sysin			char,
	servername			char(10),
	last_mod_user		varchar2(30),
	last_mod_date		date,
	comkey				char(5),
	log_level			char,
	report_type			varchar2(10),
	ignore_cache		char(1),
	host_name			varchar(255)			null, 
	host_ip				varchar(255)			null,
	uach_dir			varchar(255)			null,
   constraint PK_JOB_QUEUE_LIST primary key (instidq, instid, instcd, jobid, userid)
)
/

/* ==== index: job_q_list_idx                                        */
create index job_q_list_idx on job_queue_list (
	servername asc,
	status asc,
	startdate asc,
	starttime asc,
	priority asc,
	jobid asc
)
/

/* ==== Index: job_q_list_jobidx                                     */
create index job_q_list_jobidx on JOB_QUEUE_LIST (
	JOBID ASC
)
/

/*==============================================================*/
/* Table: job_queue_markers                                     */
/*==============================================================*/
create table JOB_QUEUE_MARKERS (
   INT_SEQ_NO           number                  default 0	not null,
   JOBQ_SEQ_NO          number					default 0	not null,
   USER_SEQ_NO          number					default 0	not null,
   RNAME                char(9),
   DRVAL                char(15),
   DRTYPE               char,
   CATLYT               char(6),
   TITLE1               varchar2(80),
   TITLE2               varchar2(80),
   WEBTITLE             varchar2(80),
   constraint PK_JOB_QUEUE_MARKERS primary key (jobq_seq_no, user_seq_no)
)
/

/* ==== Index:  jobq_markers_idx                                         */
create index jobq_markers_idx on job_queue_markers (int_seq_no)
/

/*==============================================================*/
/* Table: job_queue_report                                      */
/*==============================================================*/
create table JOB_QUEUE_REPORT (
   INT_SEQ_NO           number                          default 0	not null,
   JOBQ_SEQ_NO          number							default 0	not null,
   REPORT_TYPE          varchar2(10)					default ' ',
   REPORT               BLOB,
   constraint PK_JOB_QUEUE_REPORT primary key (jobq_seq_no, report_type)
)
/
create index jobq_report_idx on job_queue_report (jobq_seq_no)
/

/*==============================================================*/
/* Table: job_queue_req                                         */
/*==============================================================*/
create table JOB_QUEUE_REQ (
   JOBQ_SEQ_NO          number                          default 0	not null,
   RTABX                char(3)                         not null,
   RNO                  char(3),
   RNAME                varchar2(9),
   FYT 					char(6), 
   CATLYT	 			char(6), 
   PSNAME               varchar2(15),
   CATEGORY             varchar2(15),
   SUMMARY_GRP          varchar2(15),
   TRANSCRIPT           char,
   TOTAL_HOUR           char,
   TOTAL_GPA            char,
   HIDEFROMCHART        char,
   SATISFIED            char,
   SUMMARY              char,
   SORTFLG              char,
   ORREQ                char,
   OPTREQ               char,
   REQSRQ               integer,
   GOTSRQ               integer,
   NEEDSRQ              integer,
   REQCT                integer,
   GOTCT                integer,
   IPCT                 integer,
   WHATIFCT             integer,
   NEEDCT               integer,
   MAXHRS               number(10,5),
   REQHRS               number(10,5),
   EST_REQHRS           number(10,5),
   GOTHRS               number(10,5),
   IPHRS                number(10,5),
   WHATIFHRS            number(10,5),
   NEEDHRS              number(10,5),
   GOTGPAHRS            number(10,5),
   GOTGPAPTS            number(10,5),
   REQGPA               number(10,5),
   GOTGPA               number(10,5),
   NEEDGPA              number(10,5),
   REQGPAF              char,
   GPANAME              char(15),
   GPALOWYT             char(6),
   GPAHIGHYT            char(6),
   HIDDEN               char,
   HIDECATEGORYGPA      char,
   GROUP1               char,
   GROUP2               char,
   REUSE                char,
   LABEL                VARCHAR(25),
   HIDEHEADTITLE 		char(1),
   HIDENEEDSSUMMARY 	char(1),
   HIDESELFRMCRS 		char(1),
   HIDEMTCHDCRS         char(1),
   FORCE_SCHEMA_INCLUDE	char(1),
   constraint PK_JOB_QUEUE_REQ primary key (JOBQ_SEQ_NO, RTABX)
)
/


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
/

/*==============================================================*/
/* Table: job_queue_req_text                                    */
/*==============================================================*/
create table JOB_QUEUE_REQ_TEXT (
   JOBQ_SEQ_NO          number							default 0	not null,
   TEXT_TYPE             char(1)                        default 'T'	not null,
   RTABX                char(3)							not null,
   TEXT                 NCLOB,
   constraint PK_J_Q_REQ_TEXT primary key (JOBQ_SEQ_NO, TEXT_TYPE, RTABX)
)
/

/* ==== Index: jq_req_text_idx                                        */
create index jq_req_text_idx on job_queue_req_text (
    jobq_seq_no ASC,
    rtabx ASC
)
/

/*==============================================================*/
/* Table: job_queue_run                                         */
/*==============================================================*/
create table JOB_QUEUE_RUN (
   	INT_SEQ_NO           number                          not null,
   	INSTIDQ              char(2)                        default ' ',
   	INSTID               char(8)                        default ' ',
   	INSTCD               char(3)                        default ' ',
   	JOBID                char(16)                       default ' ',
   	USERID               char(30)                       default ' ',
   	SOPRID               char(8)                        default ' ',
   	STUNO                char(13)                       default ' ',
   	DPROG                char(15)                       default ' ',
   	DPMASK               char(15)                       default ' ',
   	CATLYT               char(6)                        default ' ',
   	BINSTID              char(8),
   	BINSTCD              char(3),
   	JOBQ_SYSOUT_USED     char,
   	NCOL                 char,
   	COMPLETE             char,
   	IP                   char,
   	DPTITLE1             VARCHAR(65),
   	DPTITLE2             VARCHAR(65),
   	WEBTITLE             VARCHAR(50),
   	DETAIL_SEQ_NO        number,
   	RUNDATE              date,
   	ALTSTUNO             char(13),
   	FIRSTNAME            varchar2(30),
   	MIDDLENAME           varchar2(15),
   	LASTNAME             varchar2(30),
   	PREFIXNAME           varchar2(4),
   	SUFFIXNAME           varchar2(6),
   	STUNAME              varchar2(60),
   	LISTALL              char(1),
   	TESTSTATUS           char(1),
   	REPORT_TYPE			varchar2(10),
   	GRADDATE			varchar2(80),
   	DPROG_TYPE			char(1)				null,
	WIFIP_MESSAGE		varchar2(255) 		null,
	INCLTOP_TEXT		varchar2(4000) 		null,  
	HOST_NAME 			varchar2(255) 		null, 
	HOST_IP				varchar2(255) 		null,
	UACH_DIR			varchar2(255) 		null,
	COMKEY				char(5) 			null,
	EVALSW				char(1) 			null,
	ELAPSED_MS	    	number				null,   
	constraint PK_JOB_QUEUE_RUN primary key (INT_SEQ_NO)
)
/

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
/

/*==============================================================*/
/* Table: job_queue_subreq                                      */
/*==============================================================*/
create table JOB_QUEUE_SUBREQ (
   JOBQ_SEQ_NO          number                          default 0	not null,
   RTABX                char(3)                         not null,
   STABX                char(3)                         not null,
   SNO                  char(3),
   SATISFIED            char,
   SORTFLG              char,
   ORSUB                char,
   OPTSUB               char,
   REQCT                integer,
   GOTCT                integer,
   NEEDCT               integer,
   IPCT                 integer,
   WHATIFCT             integer,
   MAXHRS               number(10,5),
   REQHRS               number(10,5),
   EST_REQHRSFLG        char,
   EST_REQHRS           number(10,5),
   GOTHRS               number(10,5),
   IPHRS                number(10,5),
   WHATIFHRS            number(10,5),
   NEEDHRS              number(10,5),
   REQGPA               number(10,5),
   GOTGPA               number(10,5),
   NEEDGPA              number(10,5),
   GOTGPAHRS            number(10,5),
   GOTGPAPTS            number(10,5)                   default 0,
   REQGPAF              char,
   GPANAME              char(15),
   GPALOWYT             char(6),
   GPAHIGHYT            char(6),
   HIDDEN               char,
   SUBREQ_ID            number(9),
   REUSE                char,
   LABEL                VARCHAR(25), 
   STITLE               VARCHAR(55),
   HIDETITLE 			char(1),
   HIDESUMMARY 			char(1),
   HIDESELFRMCRS 		char(1),
   HIDESTUCRS 			char(1),
   constraint PK_JOB_QUEUE_SUBREQ primary key (JOBQ_SEQ_NO, RTABX, STABX)
)
/

/*==============================================================*/
/* Table: JOB_QUEUE_SUBREQ_TEXT                                 */
/*==============================================================*/
create table JOB_QUEUE_SUBREQ_TEXT (
   JOBQ_SEQ_NO          number					default 0	not null,
   TEXT_TYPE            char					default 'T'	not null,
   RTABX                char(3)					not null,
   STABX                char(3)					not null,
   TEXT                 NCLOB,
   constraint PK_J_Q_SUBREQ_TEXT primary key (JOBQ_SEQ_NO, TEXT_TYPE, RTABX, STABX)
)
/

/*==============================================================*/
/* Index: jq_subreq_text_idx                                    */
/*==============================================================*/
create index jq_subreq_text_idx on job_queue_subreq_text (
    jobq_seq_no ASC,
    rtabx ASC,
    stabx ASC
)
/

/*==============================================================*/
/* Table: job_queue_sysin                                       */
/*==============================================================*/
create table job_queue_sysin (
   int_seq_no         number					not null,
   instidq            char(2)					default ' ',
   instid             char(8)					default ' ',
   instcd             char(3)					default ' ',
   jobid              char(16),
   userid             char(30),
   user_seq_no        integer 					default 0,
   sysin              char(80),
   constraint PK_JOB_QUEUE_SYSIN primary key (int_seq_no)
)
/

/* ==== Index: jobq_sys_idx                                          */
create index jobq_sys_idx on JOB_QUEUE_SYSIN (
	instidq asc, 
	instid asc, 
	instcd asc, 
	jobid asc, 
	userid asc
)
/

/*==============================================================*/
/* Table: job_queue_out                                         */
/*==============================================================*/
create table JOB_QUEUE_OUT ( 
    INT_SEQ_NO 	number 					DEFAULT 0	NOT NULL,
    JOBQ_SEQ_NO	number 					DEFAULT 0	NOT NULL,
    USER_SEQ_NO	number 					DEFAULT 0	NULL,
    RTABX      	char(3) NULL,
    STABX      	char(3) NULL,
    REQSTATUS  	char(1) NULL,
    SRNO       	char(2) NULL,
    SRSTATUS   	char(1) NULL,
    OPTLINE    	char(1) NULL,
    LASERA     	char(1) NULL,
    LASERB     	char(1) NULL,
    DAROUT     	varchar2(255) NULL,
    constraint PK_JOB_QUEUE_OUT PRIMARY KEY(jobq_seq_no, user_seq_no)
)
/


/*==============================================================*/
/* Table: mastref                                               */
/*==============================================================*/
create table mastref (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   mrfyt              char(6)                        default '0000' not null,
   lyt                char(6)                        default '9999',
   iname              varchar2(60),
   itype              char(2),
   status             char(1),
   crscase            char(1),
   grdcase            char(1),
   sourceidq          char(2),
   bacc               char(1),
   actc               char(1),
   agclc              char(2),
   honors             char(1),
   repeatf            char(1),
   cscale             char(1),
   cassign            char(1),
   cexcess            char(1),
   cfinal             char(1),
   dcourse            char(15),
   dpflg              char(1),
   grule              char(1),
   gparule            char(1),
   dgrade             char(4),
   d0grade            char(4),
   crsmask            char(15),
   refucond1          char(3),
   refucond2          char(3),
   refucond3          char(3),
   grdreq             char(1),
   gpascale           char(1),
   unitscale          number(6,4)                    default 0,
   dinstid            char(8),
   dinstcd            char(3),
   deptbgn            number(2)                      default 0,
   deptend            number(2)                      default 0,
   crsbgn             number(2)                      default 0,
   crsend             number(2)                      default 0,
   rptinstid          char(8),
   tainstid           char(8),
   tainstcd           char(3),
   refonly            char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_MASTREF primary key (instidq, instid, instcd, source_id, source_cd, mrfyt)
)
/


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
/

/*==============================================================*/
/* Table: mastref_address                                       */
/*==============================================================*/
create table mastref_address (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   mrfyt              char(6)                        default '0000' not null,
   user_seq_no        integer                        default 0,
   address1           varchar2(35),
   address2           varchar2(35),
   city               varchar2(30),
   state              varchar2(2),
   zip                varchar2(10),
   country            varchar2(3),
   locationq          varchar2(2),
   locationid         varchar2(25),
   contactcd          varchar2(2),
   contactname        varchar2(35),
   commnoq            varchar2(2),
   fax                varchar2(25),
   phone              varchar2(25),
   e_mail             varchar2(80),
   from_date          char(8),
   to_date            char(8),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_MASTREF_ADDRESS primary key (int_seq_no)
)
/


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
/

/*==============================================================*/
/* Table: mastref_seg                                           */
/*==============================================================*/
create table mastref_seg (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   mrfyt              char(6)                        default '0000' not null,
   user_seq_no        integer                        default 0,
   ltype              char(1),
   i2uflg             char(1),
   grade              char(4),
   ac                 char(1),
   rc                 char(1),
   u2iflg             char(1),
   ugrade             char(4),
   acu                char(3),
   rcu                char(3),
   gpapt              number(10,5)                    default 0,
   gpacal             char(1),
   addcr              char(1),
   addct              char(1),
   cond1              char(1),
   cond2              char(1),
   ucond1             char(3),
   ucond2             char(3),
   effdte             char(12),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_MASTREF_SEG primary key (int_seq_no)
)
/


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
/

/*==============================================================*/
/* Table: repeat                                                */
/*==============================================================*/
create table repeat (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ',
   instid             char(8)                        default ' ',
   instcd             char(3)                        default ' ',
   user_seq_no        integer                        default 0,
   course             char(15),
   ctitle             varchar2(29),
   hmax               number(4,1)                    default 0,
   chflag             char(1),
   ac                 char(1),
   rc                 char(1),
   effdte             char(12),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_REPEAT primary key (int_seq_no)
)
/


/* ==== Index:  repeat_idx                                            */
create index repeat_idx on repeat (
	instid ASC,
	instcd ASC,
	instidq ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: req_main                                              */
/*==============================================================*/
create table req_main (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   rname              char(9)                         not null,
   rqfyt              char(6)                        default '0000' not null,
   lyt                char(6)                        default '9999',
   reqsrq             number(2)                      default 0,
   reqhrs             number(10,5)                    default 0,
   reqgpa             number(10,5)                    default 0,
   ac1                char(1),
   ac2                char(1),
   rc1                char(1),
   rc2                char(1),
   assignc            char(1),
   reuse              char(1),
   nolist             char(1),
   psname             char(15),
   refcycle           char(1),
   rqtype             char(1),
   reqsrqf            char(1),
   reqhrsf            char(1),
   reqgpaf            char(1),
   usect              number(2)                      default 0,
   iplist             char(1),
   nocompl            char(1),
   reqct              number(2)                      default 0,
   reqctf             char(1),
   maxhrs             number(10,5)                    default 999.9,
   rconda             char(1),
   rcondr             char(1),
   varr               char(1),
   lokovr1            char(1),
   lnoovr1            char(1),
   lokovr2            char(1),
   lnoovr2            char(1),
   ractl              char(1),
   assignc2           char(1),
   refdir             char(1),
   reffld             char(1),
   refsub             char(1),
   refval             char(1),
   rtitle1            varchar2(58),
   rtitle2            varchar2(58),
   runstatus          char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   estreqhrs          number(10,5),
   label              VARCHAR(25),   
   gpaname            char(15),
   auth_code1		  varchar2(10),
   auth_code2		  varchar2(10),
   constraint PK_REQ_MAIN primary key (instidq, instid, instcd, rname, rqfyt)
)
/

/* ==== Index:  req_main_idx                                          */
create unique index req_main_idx on req_main (
	rname ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	rqfyt ASC,
	lyt ASC
)
/

/*==============================================================*/
/* Table: req_text                                              */
/*==============================================================*/
create table req_text (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   rname              char(9)                         not null,
   rqfyt              char(6)                        default '0000' not null,
   user_seq_no        integer                        default 0,
   rtext_type         char(1),
   text               varchar2(65),
   lokovr1            char(1),
   lnoovr1            char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_REQ_TEXT primary key (int_seq_no)
)
/

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
/

/*==============================================================*/
/* Table: req_xy                                                */
/*==============================================================*/
create table req_xy (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   rname              char(9)                         not null,
   rqfyt              char(6)                        default '0000' not null,
   user_seq_no        integer                        default 0,
   xy_type            char(1),
   series             char(1),
   maxgrpc            number(2)                      default 99,
   maxhrc             number(4,1)                    default 999.9,
   skipdup            char(1),
   ctcond             char(1),
   assignm            char(1),
   maxctc             number(2)                      default 99,
   maxsrc             number(2)                      default 99,
   ctpsname           char(15),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_REQ_XY primary key (int_seq_no)
)
/

/* ==== Index:  req_xy_idx                                            */
create index req_xy_idx on req_xy (
	rname ASC,
	instidq ASC,
	instid ASC,
	instcd ASC,
	rqfyt ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: string                                                */
/*==============================================================*/
create table string (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ',
   instid             char(8)                        default ' ',
   instcd             char(3)                        default ' ',
   user_seq_no        integer                        default 0,
   stype              char(1),
   stypeq             char(1),
   cond               char(1),
   limct              number(3)						 default 0,
   limhrs             number(10,5)                   default 0,
   ctlcd              char(2),
   ac                 char(1),
   rc                 char(1),
   aeflg              char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STRING primary key (int_seq_no)
)
/


/* ==== Index:  string_idx                                            */
create index string_idx on string (
	instid ASC,	
	instcd ASC,
	instidq ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: string_crse                                           */
/*==============================================================*/
create table string_crse (
   int_seq_no         number(9)                       not null,
   str_int_seq_no     number(9)                      default 0 not null,
   user_seq_no        integer                        default 0,
   course             char(15),
   ctitle             varchar2(29),
   ac                 char(1),
   rc                 char(1),
   aeflg              char(1),
   pflg               char(1),
   effdte             char(12),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STRING_CRSE primary key (int_seq_no)
)
/


/* ==== Index:  string_crse_idx                                       */
create index string_crse_idx on string_crse (
   str_int_seq_no ASC,
   user_seq_no ASC
)
/

/*==============================================================*/
/* Table: stu_acadrec                                           */
/*==============================================================*/
create table stu_acadrec (
   stu_mast_no        number(9)                      default 0 not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   cdpmask            char(15)                       default ' ' not null,
   crs_yt             char(6)                        default '0000' not null,
   crs_num            char(15)                       not null,
   crs_seq            char(3)                        default '001' not null,
   section            char(3),
   pflg               char(1),
   rcredit            number(10,5)                    default 0,
   grade              char(4),
   ctitle             varchar2(29),
   rtext              char(2),
   condc              char(12),
   cline              char(27),
   xcourse            char(15),
   ecredit            number(10,5)                    default 0,
   gpahrs             number(10,5)                    default 0,
   gpapts             number(10,5)                    default 0,
   linkno             char(2),
   xpflg              char(1),
   rtitle             char(29),
   evalflg            char(1)                        default ' ' not null,
   bacc               char(1),
   actc               char(1),
   agclc              char(2),
   honors             char(1),
   repeatf            char(1),
   iflg1              char(3),
   iflg2              char(3),
   iflg3              char(3),
   iflg4              char(3),
   iflg5              char(3),
   acourse1           char(15),
   apflg1             char(1),
   acourse2           char(15),
   apflg2             char(1),
   acourse3           char(15),
   apflg3             char(1),
   gradeq             char(3),
   rgrade             char(4),
   certify            char(1)                        default ' ' not null,
   subj_area          char(17),
   gradelev           char(2),
   drpdate            char(6),
   ovacadsrc          char(2),
   security_flag      char(1),
   data_source        char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_ACADREC primary key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
)
/

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
/

/*==============================================================*/
/* Table: stu_address                                           */
/*==============================================================*/
create table stu_address (
   int_seq_no         number(9)                       not null,
   stu_mast_no        number(9)                      default 0 not null,
   source_id          char(8)                        default ' ' not null,
   address_type       varchar2(2),
   addrname           varchar2(35),
   nametypecd         varchar2(2),
   address1           varchar2(35),
   address2           varchar2(35),
   city               varchar2(30),
   state              varchar2(2),
   zip                varchar2(10),
   country            varchar2(3),
   locationq          varchar2(2),
   locationid         varchar2(25),
   entityidcd         varchar2(2),
   refnoq             varchar2(2),
   refno              varchar2(30),
   indrelcd           varchar2(2),
   from_date          char(8),
   to_date            char(8),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_ADDRESS primary key (int_seq_no)
)
/

CREATE INDEX idx_stu_address_fk ON stu_address (
    stu_mast_no, source_id
)
/

/*==============================================================*/
/* Table: stu_demo                                              */
/*==============================================================*/
create table stu_demo (
   stu_mast_no        number(9)                      default 0 not null,
   source_id          char(8)                        default ' ' not null,
   stuname            varchar2(35),
   stuidq             char(2),
   stuiddesc          varchar2(80),
   dob                char(6),
   birthcountry       char(3),
   birthstate         char(2),
   birthcounty        char(5),
   birthcity          varchar2(30),
   citizenstatus      char(2),
   citizencountry     char(3),
   nativelang         char(3),
   englprof           char(3),
   marital            char(1),
   gender             char(1),
   race               char(1),
   hsgradtype         char(3),
   hsgraddate         char(8),
   hs                 varchar2(30),
   tctlast            char(6),
   nodflt             char(1),
   bdverif            char(2),
   spokeninhome       char(3),
   correslang         char(3),
   subnatq            char(2),
   subnational        varchar2(20),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_DEMO primary key (stu_mast_no, source_id)
)
/

/* ==== View: vw_stu_demo                                          */
create or replace view vw_stu_demo as
	select stu_mast_no, source_id, stuname, stuidq, stuiddesc, dob, birthcountry, birthstate, birthcounty, birthcity, citizenstatus, citizencountry, nativelang, englprof, marital, gender, race, hsgradtype, hsgraddate, hs, tctlast, nodflt, bdverif, spokeninhome, correslang, subnatq, subnational, memo, last_mod_user, last_mod_date
	from stu_demo
/

/*==============================================================*/
/* Table: stu_dprog                                             */
/*==============================================================*/
create table stu_dprog (
   stu_mast_no        number(9)                      default 0 not null,
   instcd             char(3)                        default ' ' not null,
   dprog              char(15)                        not null,
   drcatlyt           char(6),
   dpmask             char(15),
   acatlyt1           char(6),
   acatlyt2           char(6),
   acatlyt3           char(6),
   acatlyt4           char(6),
   acatlyt5           char(6),
   acatlyt6           char(6),
   acatlyt7           char(6),
   acatlyt8           char(6),
   acatlyt9           char(6),
   whatif             char(1),
   degreecd           char(3),
   entryyr            char(4),
   exityr             char(4),
   trmodmet           char(1),
   degreestatus       char(1),
   honorslevel        char(3),
   memo               varchar2(255),
   degree_date        char(10),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_DPROG primary key (stu_mast_no, instcd, dprog)
)
/

/*==============================================================*/
/* Table: stu_egrp_courses                                      */
/*==============================================================*/
create table stu_egrp_courses (
   stu_mast_no        number(9)                      default 0 not null,
   evalgrp            char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   cdpmask            char(15)                       default ' ' not null,
   crs_yt             char(6)                        default '0000' not null,
   crs_num            char(15)                        not null,
   crs_seq            char(3)                        default '001' not null,
   constraint PK_STU_EGRP_COURSES primary key (stu_mast_no, evalgrp, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
)
/


/* ==== Index:  stu_egrp_crs_idx2                                     */
create index stu_egrp_crs_idx2 on stu_egrp_courses (
	stu_mast_no ASC,
	evalgrp ASC
)
/

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
/

/*==============================================================*/
/* Table: stu_evalgrp                                           */
/*==============================================================*/
create table stu_evalgrp (
   stu_mast_no        number(9)                      default 0 not null,
   evalgrp            char(3)                        default ' ' not null,
   instcd             char(3)                        default ' ',
   dpmask             char(15)                       default ' ',
   source_id          char(8)                        default ' ',
   source_cd          char(3)                        default ' ',
   evallock           char(1)                        default ' ',
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   certify            char(1)                        default ' ',
   constraint PK_STU_EVALGRP primary key (stu_mast_no, evalgrp)
)
/

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
/

/*==============================================================*/
/* Table: stu_exc_courses                                       */
/*==============================================================*/
create table stu_exc_courses (
   int_seq_no         number(9)                       not null,
   stu_int_seq_no     number(9)                      default 0 not null,
   user_seq_no        integer                        default 0,
   course             char(15),
   rcourse            char(15),
   matchctl           char(1),
   effdte             char(12),
   ac                 char(1),
   rc                 char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_EXC_COURSES primary key (int_seq_no)
)
/


/* ==== Index:  stu_exc_crs_idx                                       */
create index stu_exc_crs_idx on stu_exc_courses (
	stu_int_seq_no ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: stu_exceptions                                        */
/*==============================================================*/
create table stu_exceptions (
   int_seq_no         number(9)                       not null,
   stu_mast_no        number(9)                      default 0,
   instcd             char(3)                        default ' ' not null,
   dpmask             char(15)                       default ' ' not null,
   dprog              char(15)                       default ' ' not null,
   user_seq_no        integer                        default 0,
   ctlcd              char(2),
   action             char(1),
   ruflg              char(1),
   yeartm             char(6),
   ac1                char(1),
   ac2                char(1),
   rc1                char(1),
   rc2                char(1),
   course             char(15),
   rcourse            char(15),
   cline              char(27),
   reqhrs             number(10,5),
   maxhrs             number(10,5),
   reqsrq             number(3),
   maxct              number(3),
   val                number(3),
   matchctl           char(1),
   effdte             char(12),
   reqgpa             number(10,5),
   assignc            char(1),
   maxhrsck           char(1),
   psname             char(15),
   rname              char(9),
   memo               varchar2(255),  
   auth_id            varchar2(30),
   auth_date          char(12),
   auth_code		  varchar2(10),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_EXCEPTIONS primary key (int_seq_no)
)
/

/* ==== Index:  stu_exceptions_idx                                    */
create index stu_exceptions_idx on stu_exceptions (
	stu_mast_no ASC,
	instcd ASC,
	dprog ASC,
	dpmask ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: stu_marker_req                                        */
/*==============================================================*/
create table stu_marker_req (
   int_seq_no         number(9)                       not null,
   stu_mast_no        number(9)                      default 0 not null,
   instcd             char(3)                        default ' ' not null,
   dprog              char(15)                        not null,
   user_seq_no        integer                        default 0,
   marker             char(9),
   drval              char(15),
   drtype             char(1),
   drinstcd           char(3),
   drcatlyt           char(6),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_MARKER_REQ primary key (int_seq_no)
)
/

/* ==== Index:  stu_marker_req_idx                                    */
create index stu_marker_req_idx on stu_marker_req (
	stu_mast_no ASC,
	instcd ASC,
	dprog ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: stu_master                                            */
/*==============================================================*/
create table stu_master (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ',
   stuno              char(13),
   tctlast            char(6),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   nodflt             char(1),
   pin                varchar2(20),
   encrypted_pin      varchar2(80),
   constraint PK_STU_MASTER primary key (int_seq_no)
)
/

/* ==== Index:  stu_info_idx                                          */
create unique index stu_info_idx on stu_master (
	stuno ASC,
	instidq ASC,
	instid ASC
)
/

/* ==== View: vw_stu_master                                        */
create or replace view vw_stu_master as
	select int_seq_no, instidq, instid, stuno, memo, last_mod_user, last_mod_date, tctlast, pin, nodflt, encrypted_pin 
	from stu_master
/

/*==============================================================*/
/* Table: stu_trans_degree                                      */
/*==============================================================*/
create table stu_trans_degree (
   stu_mast_no        number(9)                      default 0 not null,
   user_seq_no        integer                        default 0 not null,
   segtitle           char(5),
   acadfoscode        char(1),
   segliteral         varchar2(75),
   fieldofstudy       varchar2(20),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_STU_TRANS_DEGREE primary key (stu_mast_no, user_seq_no)
)
/

/*==============================================================*/
/* Table: sub_req                                               */
/*==============================================================*/
create table sub_req (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   rname              char(9)                         not null,
   rqfyt              char(6)                        default '0000' not null,
   user_seq_no        integer                        default 0,
   sreqno             integer                        default 0,
   reqct              number(2)                      default 0,
   reqctf             char(1),
   reqhrs             number(10,5)                    default 0,
   reqhrsf            char(1),
   reqgpa             number(10,5)                    default 0,
   reqgpaf            char(1),
   maxhrs             number(10,5)                    default 999.9,
   maxhrsck           char(1),
   allres             char(1),
   ac1                char(1),
   ac2                char(1),
   ac3                char(1),
   ac4                char(1),
   ac5                char(1),
   acor               char(1),
   rc1                char(1),
   rc2                char(1),
   rc3                char(1),
   rc4                char(1),
   rc5                char(1),
   rcand              char(1),
   actl               char(1),
   assignc            char(1),
   assignc2           char(1),
   assignm            char(1),
   sreuse             char(1),
   skipbct            number(1),
   nolist             char(1),
   noseqno            char(1),
   reqflg             char(1),
   iplist             char(1),
   ignorecl           char(1),
   gpaweight          char(1),
   seqchk             char(1),
   maxct              number(2)                      default 99,
   ctcond0            char(1),
   ctcond1            char(1),
   ctcond2            char(1),
   ctcond3            char(1),
   ctcond4            char(1),
   ctcond5            char(1),
   ctcond6            char(1),
   ctcond7            char(1),
   ctcond8            char(1),
   ctcond9            char(1),
   ctcond10           char(1),
   ctcond11           char(1),
   ctcond12           char(1),
   ctcond13           char(1),
   ctcond14           char(1),
   conda              char(1),
   condr              char(1),
   listsr             char(1),
   negreq             char(1),
   pntdescr           char(1),
   gpa                char(1),
   aonly              char(1),
   calpha             char(1),
   grp                char(1),
   grpmin             number(2)                      default 0,
   grpmax             number(2)                      default 99,
   varc               char(1),
   hcmin              number(2)                      default 0,
   hcmax              number(2)                      default 99,
   xrefsr             char(1),
   refgno             number(2)                      default 0,
   eorder             char(1),
   etopdown           char(1),
   estop              char(1),
   elimit             char(1),
   refdir             char(1),
   reffld             char(1),
   refsub             char(1),
   refval             char(1),
   refcycle           char(1),
   selra              char(1),
   sortflg            char(1),
   sreqor             char(1),
   actlx              char(1),
   assigncx           char(1),
   revartl            char(1),
   matchone           char(1),
   ltopdown           char(1),
   selip              char(1),
   runstatus          char(1),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   esthrs             number(10,5),
   esthrsflg          char(1),
   label              VARCHAR(25),
   gpaname            char(15),
   constraint PK_SUB_REQ primary key (int_seq_no)
)
/

/* ==== Index:  sub_req_idx                                           */
create index sub_req_idx on sub_req (
	rname ASC,
	instidq ASC,	
	instid ASC,
	instcd ASC,
	rqfyt ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: sub_req_ar                                            */
/*==============================================================*/
create table sub_req_ar (
   int_seq_no         number(9)                       not null,
   sub_int_seq_no     number(9)                      default 0 not null,
   user_seq_no        integer                        default 0,
   ar_type            char(1)                         not null,
   course             char(15),
   matchctl           char(1),
   ctitle             varchar2(29),
   tflg               char(1),
   creditlim          char(1),
   crsflag            char(3),
   ac                 char(1),
   rc                 char(1),
   effdte             char(12),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_SUB_REQ_AR primary key (int_seq_no)
)
/

/* ==== Index:  sub_req_ar_idx                                        */
create index sub_req_ar_idx on sub_req_ar (
	sub_int_seq_no ASC,
	ar_type DESC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: sub_req_text                                          */
/*==============================================================*/
create table sub_req_text (
   int_seq_no         number(9)                       not null,
   sub_int_seq_no     number(9)                      default 0 not null,
   user_seq_no        integer                        default 0,
   srtext_type        char(1),
   text               varchar2(55),
   lokovr1            char(1),
   lnoovr1            char(1),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_SUB_REQ_TEXT primary key (int_seq_no)
)
/


/* ==== Index:  sub_req_text_idx                                      */
create index sub_req_text_idx on sub_req_text (
	sub_int_seq_no ASC,
	srtext_type ASC,
	user_seq_no ASC
)
/


/*==============================================================*/
/* Table: tca_master                                            */
/*==============================================================*/
create table tca_master (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   dpmask             char(15)                       default ' ' not null,
   fyt                char(6)                        default '0000' not null,
   lyt                char(6)                        default '9999',
   iname              varchar2(60),
   univ_dpmask        char(1),
   dinstid            char(8),
   dinstcd            char(3),
   tastatus           char(1),
   memo               varchar2(255),
   last_mod_date      date,
   last_mod_user      varchar2(30),
   constraint PK_TCA_MASTER primary key (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
)
/

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
/

/*==============================================================*/
/* Table: tca_rule                                              */
/*==============================================================*/
create table tca_rule (
   int_seq_no         number(9)                       not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   dpmask             char(15)                       default ' ' not null,
   fyt                char(6)                        default '0000' not null,
   tseg               char(7)                        default ' ' not null,
   user_seq_no        integer                        default 0,
   cond               char(1),
   limct              number(2)                      default 0,
   limhrs             number(10,5)                    default 0,
   ctlcd              char(2),
   ac                 char(1),
   rc                 char(1),
   tastatus           char(1),
   private_note       varchar2(255),
   memo               varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_TCA_RULE primary key (int_seq_no)
)
/

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
/

/*==============================================================*/
/* Table: tca_source                                            */
/*==============================================================*/
create table tca_source (
   int_seq_no         number(9)                       not null,
   tca_rule_seq_no    number(9)                      default 0 not null,
   user_seq_no        integer                        default 0,
   course             char(15),
   pflg               char(1),
   ctitle             varchar2(29),
   tflg               char(1),
   limhrs             number(10,5)                    default 0,
   ctlcd              char(2),
   ac                 char(1),
   rc                 char(1),
   cond               char(1),
   effdte             char(12),
   loweffdte          char(6),
   hieffdte           char(6),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_TCA_SOURCE primary key (int_seq_no)
)
/

/* ==== Index:  tca_source_idx                                        */
create index tca_source_idx on tca_source (
	tca_rule_seq_no ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: tca_target                                            */
/*==============================================================*/
create table tca_target (
   int_seq_no         number(9)                       not null,
   tca_rule_seq_no    number(9)                      default 0 not null,
   user_seq_no        integer                        default 0,
   course             char(15),
   pflg               char(1),
   ctitle             varchar2(29),
   tflg               char(1),
   limhrs             number(10,5)                    default 0,
   forcehrs           char(1),
   cond               char(1),
   iflg1              char(3),
   iflg2              char(3),
   iflg3              char(3),
   iflg4              char(3),
   iflg5              char(3),
   acourse1           char(15),
   apflg1             char(1),
   acourse2           char(15),
   apflg2             char(1),
   acourse3           char(15),
   apflg3             char(1),
   tastatus           char(1),
   hide_acourse1      char(1),
   hide_acourse2      char(1),
   hide_acourse3      char(1),
   hide_iflgs         char(1),
   last_mod_user      varchar2(30),
   last_mod_date      date,

   constraint PK_TCA_TARGET primary key (int_seq_no)
)
/

/* ==== Index:  tca_target_idx                                        */
create index tca_target_idx on tca_target (
	tca_rule_seq_no ASC,
	user_seq_no ASC
)
/

/*==============================================================*/
/* Table: tca_segment 		(since 4.3)                         */
/*==============================================================*/
create table tca_segment (
   int_seq_no         number(9)                      not null,
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   source_cd          char(3)                        default ' ' not null,
   dpmask             char(15)                       default ' ' not null,
   fyt                char(6)                        default '0000' not null,
   tseg               char(7)                        default ' ' not null,
   hint               varchar2(25),
   description        varchar2(255),
   last_mod_user      varchar2(30),
   last_mod_date      date,
   constraint PK_TCA_SEGMENT primary key (int_seq_no)
)
/

/* ==== Index:  tca_segment_idx                                          */
create index tca_segment_idx on tca_segment (
	INSTIDQ ASC,
	INSTID ASC,
	INSTCD ASC,
	SOURCE_ID ASC,
	SOURCE_CD ASC,
	DPMASK ASC,
	FYT ASC,
	TSEG ASC
)
/

/*==============================================================*/
/* Table: transfer_inst		(since 4.3)                         */
/*==============================================================*/
create table transfer_inst (
	instidq            char(2)			default ' ' not null,
    instid             char(8)          default ' ' not null,
    instcd             char(3)          default ' ' not null,
    source_id          char(8)          default ' ' not null,
    inst_name          varchar2(60),
    ipeds              varchar2(20),
    opeid              varchar2(20),
    fice               varchar2(20),
    atp                varchar2(20),
    act                varchar2(20),
    last_mod_user      varchar2(30),
    last_mod_date      date,
    constraint PK_TRANSFER_INST primary key (instidq, instid, instcd, source_id)
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
   label	            varchar2(30)           null,
   type_order           integer               not null,
   constraint PK_dprog_type primary key (instidq, instid, instcd, type_code)
)
/

alter table dprog_type
	add constraint uc_dprog_type
	UNIQUE (instidq, instid, instcd, type_order)
/

/*==============================================================*/
/* Table: WHATIF_ELEMENT_TYPE_ASSOC                             */
/*==============================================================*/
create table whatif_element_type_assoc ( 
	int_seq_no    		number(9) 				NOT NULL,
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
	constraint pk_weta PRIMARY KEY (int_seq_no)
)
/

alter table whatif_element_type_assoc
	add constraint uc_wi_element_type_assoc
	UNIQUE (instidq, instid, instcd, element, dprog_type, fyt, parent_element)	
/

create index idx_whatif_eta_fk on whatif_element_type_assoc (
	instidq, instid, instcd, dprog_type
)
/

/*==============================================================*/
/* Table: WHATIF_FORCED_MARKER	                                */
/*==============================================================*/
create table whatif_forced_marker ( 
	int_seq_no	     	number(9)	 		NOT NULL,
	weta_int_seq_no		number(9)	 		NOT NULL,
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
	constraint pk_wi_forced_marker PRIMARY KEY(int_seq_no)
	)
/

create index idx_whatif_fm_fk on whatif_forced_marker (
	weta_int_seq_no
)
/

/*==============================================================*/
/* Table: WHATIF_ELEMENT_FILTER	                                */
/*==============================================================*/
create table whatif_element_filter ( 
	int_seq_no    	number(9) 			NOT NULL,
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
	constraint pk_wi_element_filter PRIMARY KEY (int_seq_no)
	)
/


--============================================================
--                Create Foreign Key Constraints
--============================================================

alter table job_queue_accept
   add constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
/

alter table job_queue_course
   add constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
/

alter table JOB_QUEUE_DETAIL
   add constraint FK_JOB_QUEU_RELATION__JOB_QUEU foreign key (INSTIDQ, INSTID, INSTCD, JOBID, USERID)
      references JOB_QUEUE_LIST (INSTIDQ, INSTID, INSTCD, JOBID, USERID)
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

alter table JOB_QUEUE_OUT
    add ( constraint FK_JOBQ_OUT_REF_JOBQ_RUN
	foreign key(JOBQ_SEQ_NO)
	references JOB_QUEUE_RUN(INT_SEQ_NO)
	)
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


alter table dprog_req
   add constraint FK_DPROG_RE_RELATION__DPROG foreign key (instidq, instid, instcd, dprog, dpfyt)
      references dprog (instidq, instid, instcd, dprog, dpfyt)
/

alter table job_queue_sysin
   add constraint FK_JOB_QUEU_REF_56906_JOB_QUEU foreign key (instidq, instid, instcd, jobid, userid)
      references job_queue_list (instidq, instid, instcd, jobid, userid)
go

alter table mastref_address
   add constraint FK_MASTREF__REF_16608_MASTREF foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
/

alter table mastref_seg
   add constraint FK_MASTREF__REF_15108_MASTREF foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
/

alter table req_text
   add constraint FK_REQ_TEXT_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
/

alter table req_xy
   add constraint FK_REQ_XY_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
/

alter table string_crse
   add constraint FK_STRING_C_RELATION__STRING foreign key (str_int_seq_no)
      references string (int_seq_no)
/

alter table stu_acadrec
   add constraint FK_STU_ACAD_REF_23073_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
/

alter table stu_address
   add constraint FK_STU_ADDR_REF_12130_STU_DEMO foreign key (stu_mast_no, source_id)
      references stu_demo (stu_mast_no, source_id)
/

alter table stu_demo
   add constraint FK_STU_DEMO_REF_23034_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
/

alter table stu_dprog
   add constraint FK_STU_DPRO_REF_23053_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
/

alter table stu_egrp_courses
   add constraint FK_STU_EGRP_REF_46007_STU_ACAD foreign key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
      references stu_acadrec (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
/

alter table stu_egrp_courses
   add constraint fk_egrp_2_egrp_crs foreign key (stu_mast_no, evalgrp)
      references stu_evalgrp (stu_mast_no, evalgrp)
/

alter table stu_evalgrp
   add constraint fk_stu_eval_2_mast foreign key (stu_mast_no)
      references stu_master (int_seq_no)
/

alter table stu_exc_courses
   add constraint FK_STU_EXC__REF_14062_STU_EXCE foreign key (stu_int_seq_no)
      references stu_exceptions (int_seq_no)
/

alter table stu_exceptions
   add constraint FK_STU_EXCE_REF_23068_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
/

alter table stu_marker_req
   add constraint FK_STU_MARK_RELATION__STU_DPRO foreign key (stu_mast_no, instcd, dprog)
      references stu_dprog (stu_mast_no, instcd, dprog)
/

alter table stu_trans_degree
   add constraint FK_STU_TRAN_REF_23058_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
/

alter table sub_req
   add constraint FK_SUB_REQ_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
/

alter table sub_req_ar
   add constraint sreq_to_sreq_ar foreign key (sub_int_seq_no)
      references sub_req (int_seq_no)
/

alter table sub_req_text
   add constraint sreq_to_sreq_text foreign key (sub_int_seq_no)
      references sub_req (int_seq_no)
/

alter table tca_rule
   add constraint FK_TCA_RULE_REF_10199_TCA_MAST foreign key (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
      references tca_master (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
/

alter table tca_source
   add constraint FK_TCA_SOUR_REF_11057_TCA_RULE foreign key (tca_rule_seq_no)
      references tca_rule (int_seq_no)
/

alter table tca_target
   add constraint FK_TCA_TARG_REF_11060_TCA_RULE foreign key (tca_rule_seq_no)
      references tca_rule (int_seq_no)
/

alter table whatif_forced_marker
	add constraint fk_wi_ele_type_assoc foreign key(weta_int_seq_no)
	references whatif_element_type_assoc(int_seq_no)
/

alter table whatif_element_type_assoc
	add constraint fk_weta_relation_dprog_type
	foreign key(instidq, instid, instcd, dprog_type)
	references dprog_type(instidq, instid, instcd, type_code)
/

--============================================================
--                    Create Sequence Objects
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


create sequence seq_int_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/


create sequence jobqd_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/


create sequence jobqsi_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/


create sequence jobqr_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/
    
create sequence jobqso_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

/* UACH-4130	DAP		7/19/15
 * 
 * The next 5 sequence objects can be deleted when the hibernate mappings are fixed for 
 * job_queue_out, accept, _course, _markers, and _exceptions
 */
create sequence jobqo_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/

create sequence jobqcrs_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/

create sequence jobqacpt_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/

create sequence jobqmrk_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/

create sequence jobqexc_seq_no
    start with 1
    increment by 1
    nocycle
    nomaxvalue
/

/*
 * End of 'soon to be deleted' sequence objects
 */

create sequence dprog_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/


create sequence req_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/


create sequence mref_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/


create sequence tca_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/


create sequence stuexc_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/


create sequence stumast_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

