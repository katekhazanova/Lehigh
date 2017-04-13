/*==============================================================*/
/* DARwin Release: DARwin 3.5.1                                 */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     6/30/2004 2:23:34 PM                         */
/*                                                              */
/* Script name:    dw351mssmod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.1 format.                         */
/*                                                              */
/* Copyright(c) 1995-2004 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/* Table: chart_categories                                      */
/*==============================================================*/
alter table chart_categories
	add total_gpa char(1) null
go
   
/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
alter table job_queue_course	 
	add edit_yt char(4) null
go

/*==============================================================*/
/* Table: job_queue_req                                         */
/*==============================================================*/
alter table job_queue_req
	add total_gpa char(1) null
go

/*==============================================================*/
/* Table: job_queue_accept                                      */
/*==============================================================*/
create table job_queue_accept (
   jobq_seq_no          numeric(9)           default 0 not null,
   rtabx                char(3)              not null,
   stabx                char(3)              not null,
   ctabx                char(4)              not null,
   course               varchar(15)          null,
   title                varchar(29)          null,
   reject               char(1)              null,
   used                 char(1)              null,
   logic                char(1)              null,
   required             char(1)              null,
   cmprtitle            char(1)              null,
   rangecourse          char(15)             null,
   lowyt                char(6)              null,
   highyt               char(6)              null,
   constraint PK_JOB_QUEUE_ACCEPT primary key  (jobq_seq_no, rtabx, stabx, ctabx)
)
go

/*==============================================================*/
/* Index: jobq_accept_idx                                       */
/*==============================================================*/
create   index jobq_accept_idx on job_queue_accept (
jobq_seq_no,
rtabx,
stabx,
ctabx,
reject
)
go

alter table job_queue_accept
   add constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go


/*==============================================================*/
/* Index: webtitle_idx                                          */
/*==============================================================*/
if exists (select name from sysindexes
         where name = 'webtitle_idx')
   drop index dprog.webtitle_idx
go

create   index webtitle_idx on dprog (
webtitle,
dprog,
instidq,
instid,
instcd,
dpfyt,
lyt
)
go

/*==============================================================*/
/* Index: job_q_detail_idx                                      */
/*==============================================================*/

if exists (select name from sysindexes
         where name = 'job_q_detail_idx')
   drop index job_queue_detail.job_q_detail_idx
go

create   index job_q_detail_idx on job_queue_detail (
jobid,
instidq,
instid,
instcd,
userid,
user_seq_no
)
go

/*==============================================================*/
/* Index: analysis_req_idx2                                     */
/*==============================================================*/
if exists (select name from sysindexes
         where name = 'analysis_req_idx2')
   drop index analysis_req.analysis_req_idx2
go



create   index analysis_req_idx2 on analysis_req (
jobq_seq_no,
rno,
sno,
rname,
psname
)
go

/*==============================================================*/
/* Update: adv_functions                                        */
/*==============================================================*/
update adv_functions 
set adv_function = 'planned' 
where adv_function = 'whatif'
go
