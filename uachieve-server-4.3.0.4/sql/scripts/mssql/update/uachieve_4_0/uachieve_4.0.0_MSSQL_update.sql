/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2000                    */
/* Created on:     6/27/2008 2:30:15 PM                         */
/* Database Modification Script to                               */
/*Update Darwin 3.5.7 to u.achieve4.0                           */
/*==============================================================*/

truncate table job_queue_accept
go
truncate table job_queue_course
go
update job_queue_run set rundate = ''
go
alter table job_queue_run alter column rundate datetime
go
alter table job_queue_run drop column runtime
go
alter table job_queue_run add  altstuno    char(13)   null
go
alter table job_queue_run add  firstname    varchar(30)      null
go
alter table job_queue_run add  middlename varchar(15)           null
go
alter table job_queue_run add  lastname  varchar(30)  null
go     
alter table job_queue_run add  prefixname  varchar(4)   null
go
alter table job_queue_run add  suffixname varchar(6) null
go
alter table job_queue_run add   stuname  varchar(60)  null
go
alter table job_queue_run add  listall char(1)  null
go
alter table job_queue_run add  teststatus  char(1) null
go
alter table job_queue_run add  report_type  char(3) null
go
alter table job_queue_list add  comkey varchar(10)
go
alter table job_queue_list add  log_level char(1)
go
alter table job_queue_list add  ignore_cache char(1)
go
alter table job_queue_list add  report_type char(3)
go
alter table job_queue_detail add  status char(1)
go

alter table job_queue_subreq
    drop constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ
go

alter table job_queue_accept
   drop constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU
go
alter table job_queue_course
   drop constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ
go
drop table job_queue_course
go
drop table job_queue_accept
go
/*==============================================================*/
/* Table: job_queue_accept                                      */
/*==============================================================*/
create table job_queue_accept (
   int_seq_no           numeric(9)           identity(1, 1),
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

/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
create table job_queue_course (
   int_seq_no           numeric(9)           identity(1, 1),
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
   ctitle               varchar(29)           null,
   rtitle               varchar(29)           null,
   stitle               varchar(29)           null,
   cvttitle             varchar(29)           null,
   alttitle             varchar(29)           null,
   user_seq_no          numeric(9)           null,
   constraint PK_JOB_QUEUE_COURSE primary key (int_seq_no)
)
go
create table job_queue_req_text (
   jobq_seq_no          numeric(9)            not null,
   text_type             char(1)               not null default 'T',
   rtabx                char(3)            not null,
   text                 ntext           	  null,
   constraint PK_J_Q_REQ_TEXT primary key (jobq_seq_no, rtabx, text_type)
)
go

create table job_queue_subreq_text (
   jobq_seq_no          numeric(9)           not null,
   text_type             char(1)              not null default 'T',
   rtabx                char(3)           not null,
   stabx                char(3)           not null,
   text                 ntext          		 null,
   constraint PK_J_Q_SUBREQ_TEXT primary key (jobq_seq_no, text_type, rtabx, stabx)
)
go
create table job_queue_report (
   int_seq_no           numeric(9)           identity(1, 1),
   jobq_seq_no          numeric(9)            null,
   report_type          char(3)               null,
   report               image                null,
   constraint PK_J_Q_REPORT primary key (int_seq_no)
)
go

create table job_queue_markers (
   int_seq_no           numeric(9)           identity(1, 1),
   jobq_seq_no			numeric(9)			  null,
   user_seq_no          int                   null,
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
create table job_queue_incl_text (
   int_seq_no           numeric(9)           identity(1, 1),
   jobq_seq_no          numeric(9)            null,
   TEXT_TYPE            char(1)               null,
   TEXT                 ntext                 null,
   constraint PK_JOB_QUEUE_INCL_TEXT primary key (int_seq_no)
)
go
/*==============================================================*/
/* Table: job_queue_exceptions                                  */
/*==============================================================*/
create table job_queue_exceptions (
   int_seq_no           numeric(9)           identity(1, 1),
   jobq_seq_no			numeric(9)			  null,
   user_seq_no          int                   null,
   ctlcd                char(2)               null,
   action               char(1)               null,
   ruflg                char(1)               null,
   memo                 varchar(255)          null,
   last_mod_user        varchar(30)           null,
   last_mod_date        timestamp            null,
   constraint PK_J_Q_EXCEPTION primary key (int_seq_no)
)
go

if not (exists(select * from information_schema.tables
                where table_name = 'job_queue_destination'))
    begin

        CREATE TABLE JOB_QUEUE_DESTINATION(
            JOBID 				char(16)  			NOT NULL,
            USERID 				char(30) 				NOT NULL,
            DESTINATION_URL 	varchar(255)  		NOT NULL,
            OUTPUT_FORMAT 		char(1) 				NULL,
            SEND_ERROR_COUNT 	int 					NOT NULL DEFAULT (0),
            SEND_ERROR_MESSAGE 	varchar(255) 			NULL,
            STATUS 				char(1) 				NOT NULL,
            SEND_DATE 			datetime 				NULL,
            NEXT_SEND_DATE 		datetime 				NULL,
            CONSTRAINT PK_JOB_QUEUE_DESTINATION PRIMARY KEY (JOBID,USERID) 
        )
    end
go

create index jobq_report_idx on JOB_QUEUE_REPORT (
JOBQ_SEQ_NO ASC
)
go
create unique index jobq_subreq_idx on JOB_QUEUE_SUBREQ (
JOBQ_SEQ_NO ASC,
RTABX ASC,
STABX ASC
)
go

create index jobq_accept_idx on job_queue_accept (
jobq_seq_no ASC,
rtabx ASC,
stabx ASC
)
go

create index jobq_course_idx on job_queue_course (
jobq_seq_no ASC,
rtabx ASC,
stabx ASC
)
go
/*==============================================================*/
/* Index: jobq_markers_idx                                       */
/*==============================================================*/
create index jobq_markers_idx on job_queue_markers (
jobq_seq_no ASC
)
go
/*==============================================================*/
/* Index: jobq_exceptions_idx                                       */
/*==============================================================*/
create index jobq_exceptions_idx on job_queue_exceptions (
jobq_seq_no ASC
)
go
/*==============================================================*/
/* Index: jobq_incl_text_idx                                       */
/*==============================================================*/
create index jobq_incl_text_idx on job_queue_incl_text (
jobq_seq_no ASC
)
go

alter table job_queue_exceptions
   add constraint FK_JQEXC_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_incl_text
   add constraint FK_JQINCL_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_markers
   add constraint FK_JQMRK_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_report
   add constraint FK_JQREP_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_req_text
   add constraint FK_JQRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
go

alter table job_queue_subreq
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
go
alter table job_queue_req
   add constraint FK_job_queue_req_job_queue_run foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_subreq_text
   add constraint FK_JQSRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go
alter table job_queue_course
   add constraint FK_job_queue_course_job_queue_subreq foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go
alter table job_queue_accept
   add constraint FK_job_queue_accept_job_queue_subreq foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go

create table include_text (
   INSTIDQ              char(2)               not null,
   INSTID               char(8)               not null,
   INSTCD               char(3)               not null,
   TEXT_KEY             varchar(20)           not null,
   TEXT_TYPE            char(1)               not null,
   TEXT                 ntext                 null,
   LAST_MOD_USER        varchar(30)           null,
   LAST_MOD_DATE        datetime              null,
   constraint PK_INCLUDE_TEXT primary key (INSTIDQ, INSTID, INSTCD, TEXT_KEY, TEXT_TYPE)
)
go
CREATE TABLE current_jobs(
	instcd 			varchar(3)  		NOT NULL,
	instid 			varchar(8)  		NOT NULL,
	instidq 		varchar(2)  		NOT NULL,
	stuno 			varchar(15)  		NOT NULL,
	starttime 		datetime 			NULL,
 CONSTRAINT PK_CURRENT_JOBS PRIMARY KEY (instcd, instid , instidq, stuno)
)
go


drop index job_queue_list.job_q_list_idx
go
create index job_q_list_idx on JOB_QUEUE_LIST (
	SERVERNAME ASC,
	STATUS ASC,
	STARTDATE ASC,
	STARTTIME ASC,
	PRIORITY ASC,
	JOBID ASC
)
go
alter table analysis_courses alter column credit numeric(10,5) null
go

alter table analysis_req alter column reqhrs numeric(10,5) null
go
alter table analysis_req alter column gothrs numeric(10,5) null
go
alter table analysis_req alter column reqgpa numeric(10,5) null
go
alter table analysis_req alter column gotgpa numeric(10,5) null
go
alter table analysis_req alter column gotgpahrs numeric(10,5) null
go
alter table analysis_req alter column gotgpapts numeric(10,5) null
go

alter table gmaster alter column gpapt numeric(10,5) null
go
alter table gmaster alter column lcredit numeric(10,5) null
go
alter table gmaster alter column hcredit numeric(10,5) null
go

alter table job_queue_course alter column rcredit numeric(10,5) null
go
alter table job_queue_course alter column credit numeric(10,5) null
go
alter table job_queue_course alter column gpahrs numeric(10,5) null
go
alter table job_queue_course alter column gpapts numeric(10,5) null
go
alter table job_queue_course alter column gpa numeric(10,5) null
go

alter table job_queue_req alter column maxhrs numeric(10,5) null
go
alter table job_queue_req alter column reqhrs numeric(10,5) null
go
alter table job_queue_req alter column est_reqhrs numeric(10,5) null
go
alter table job_queue_req alter column gothrs numeric(10,5) null
go
alter table job_queue_req alter column iphrs numeric(10,5) null
go
alter table job_queue_req alter column whatifhrs numeric(10,5) null
go
alter table job_queue_req alter column needhrs numeric(10,5) null
go
alter table job_queue_req alter column gotgpahrs numeric(10,5) null
go
alter table job_queue_req alter column gotgpapts numeric(10,5) null
go
alter table job_queue_req alter column reqgpa numeric(10,5) null
go
alter table job_queue_req alter column gotgpa numeric(10,5) null
go
alter table job_queue_req alter column needgpa numeric(10,5) null
go

alter table job_queue_subreq alter column maxhrs numeric(10,5) null
go
alter table job_queue_subreq alter column reqhrs numeric(10,5) null
go
alter table job_queue_subreq alter column est_reqhrs numeric(10,5) null
go
alter table job_queue_subreq alter column gothrs numeric(10,5) null
go
alter table job_queue_subreq alter column iphrs numeric(10,5) null
go
alter table job_queue_subreq alter column whatifhrs numeric(10,5) null
go
alter table job_queue_subreq alter column needhrs numeric(10,5) null
go
alter table job_queue_subreq alter column reqgpa numeric(10,5) null
go
alter table job_queue_subreq alter column gotgpa numeric(10,5) null
go
alter table job_queue_subreq alter column needgpa numeric(10,5) null
go
alter table job_queue_subreq alter column gotgpahrs numeric(10,5) null
go
alter table job_queue_subreq alter column gotgpapts numeric(10,5) null
go

alter table mastref_seg alter column gpapt numeric(10,5) null
go

alter table req_main alter column reqhrs numeric(10,5) null
go
alter table req_main alter column reqgpa numeric(10,5) null
go
alter table req_main alter column maxhrs numeric(10,5) null
go
alter table req_main alter column estreqhrs numeric(10,5) null
go

alter table string alter column limhrs numeric(10,5) null
go

alter table stu_acadrec alter column rcredit numeric(10,5) null
go
alter table stu_acadrec alter column ecredit numeric(10,5) null
go
alter table stu_acadrec alter column gpahrs numeric(10,5) null
go
alter table stu_acadrec alter column gpapts numeric(10,5) null
go

alter table stu_exceptions alter column reqhrs numeric(10,5) null
go
alter table stu_exceptions alter column maxhrs numeric(10,5) null
go
alter table stu_exceptions alter column reqgpa numeric(10,5) null
go

alter table sub_req alter column reqhrs numeric(10,5) null
go
alter table sub_req alter column reqgpa numeric(10,5) null
go
alter table sub_req alter column maxhrs numeric(10,5) null
go
alter table sub_req alter column esthrs numeric(10,5) null
go

alter table tca_rule alter column limhrs numeric(10,5) null
go

alter table tca_source alter column limhrs numeric(10,5) null
go

alter table tca_target alter column limhrs numeric(10,5) null
go

alter table whatif_courses alter column rcredit numeric(10,5) null
go


