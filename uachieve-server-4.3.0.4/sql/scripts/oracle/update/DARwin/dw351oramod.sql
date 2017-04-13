/*==============================================================*/
/* DARwin Release: DARwin 3.5.1                                 */
/* DBMS name:      Oracle                                       */
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
select 'Add total_gpa to chart_categories...' as "Task" from dual;

alter table chart_categories
	add total_gpa CHAR(1);
   
   
/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
select 'Add edit_yt to job_queue_course...' as "Task" from dual;

alter table job_queue_course	 
	add edit_yt CHAR(4);


/*==============================================================*/
/* Table: job_queue_req                                         */
/*==============================================================*/
select 'Add total_gpa to job_queue_req...' as "Task" from dual;

alter table job_queue_req
	add total_gpa CHAR(1);


/*==============================================================*/
/* Index: sub_req_ar_idx                                        */
/*==============================================================*/
select 'Redefine index sub_req_ar_idx...' as "Task" from dual;

drop index sub_req_ar_idx;

create index sub_req_ar_idx on sub_req_ar (
   sub_int_seq_no ASC,
   ar_type DESC,
   user_seq_no ASC
);


/*==============================================================*/
/* Table: job_queue_accept                                      */
/*==============================================================*/
select 'Add table job_queue_accept...' as "Task" from dual;

create table job_queue_accept  (
   jobq_seq_no          NUMBER(9)                      default 0 not null,
   rtabx                CHAR(3)                         not null,
   stabx                CHAR(3)                         not null,
   ctabx                CHAR(4)                         not null,
   course               VARCHAR2(15),
   title                VARCHAR2(29),
   reject               CHAR(1),
   used                 CHAR(1),
   logic                CHAR(1),
   required             CHAR(1),
   cmprtitle            CHAR(1),
   rangecourse          CHAR(15),
   lowyt                CHAR(6),
   highyt               CHAR(6),
   constraint PK_JOB_QUEUE_ACCEPT primary key (jobq_seq_no, rtabx, stabx, ctabx)
);

/*==============================================================*/
/* Index: jobq_accept_idx                                       */
/*==============================================================*/

create index jobq_accept_idx on job_queue_accept (
   jobq_seq_no ASC,
   rtabx ASC,
   stabx ASC,
   ctabx ASC,
   reject ASC
);


alter table job_queue_accept
   add constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx);
      

/*==============================================================*/
/* Index: job_q_list_jobidx                                     */
/*==============================================================*/
select 'Redefine index job_q_list_jobidx...' as "Task" from dual;
select 'Drop index job_q_list_jobidx, if it exists' as " " from dual;
drop index job_q_list_jobidx;

select 'Create index job_q_list_jobidx' as " " from dual;
create   index job_q_list_jobidx on job_queue_list (
jobid ASC
);

/*==============================================================*/
/* Index: webtitle_idx                                          */
/*==============================================================*/
select 'Redefine index webtitle_idx...' as "Task" from dual;
select 'Drop index webtitle_idx, if it exists' as " " from dual;
drop index webtitle_idx;

select 'Create index webtitle_idx' as " " from dual;
create   index webtitle_idx on dprog (
webtitle ASC,
dprog ASC,
instidq ASC,
instid ASC,
instcd ASC,
dpfyt ASC,
lyt ASC
);

/*==============================================================*/
/* Index: job_q_detail_idx                                      */
/*==============================================================*/
select 'Redefine index job_q_detail_idx...' as "Task" from dual;
select 'Drop index job_q_detail_idx, if it exists' as " " from dual;
drop index job_q_detail_idx;

select 'Create index job_q_detail_idx' as " " from dual;
create   index job_q_detail_idx on job_queue_detail (
jobid ASC,
instidq ASC,
instid ASC,
instcd ASC,
userid ASC,
user_seq_no ASC
);


/*==============================================================*/
/* Index: ANALYSIS_REQ_IDX2                                     */
/*==============================================================*/
select 'Redefine index analysis_req_idx2...' as "Task" from dual;
select 'Drop index analysis_req_idx2, if it exists' as " " from dual;
drop index analysis_req_idx2;

select 'Create index analysis_req_idx2' as " " from dual;

create index ANALYSIS_REQ_IDX2 on ANALYSIS_REQ (
   JOBQ_SEQ_NO ASC,
   RNO ASC,
   SNO ASC,
   RNAME ASC,
   PSNAME ASC
);

/*==============================================================*/
/* Update: adv_functions                                        */
/*==============================================================*/
update ADV_FUNCTIONS 
set ADV_FUNCTION = 'planned' 
where ADV_FUNCTION = 'whatif'
;

      