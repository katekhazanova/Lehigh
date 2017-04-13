/*==============================================================*/
/* Database name:  DARwin 3.5                                   */
/* DBMS name:      Oracle                                       */
/* Created on:     1/28/2004 12:09:31 PM                        */
/*                                                              */
/* Script name:    dw35oramod.sql                               */
/* Purpose:        Updates existing DARwin 3.0 database objects */
/*                 to their DARwin 3.5 format.                  */
/* Updates:                                                     */
/*      05/12/04   removed stu_egrp_crs_idx                     */
/*      07/02/04   update values in esthrs and esthrsflg        */
/*                 Added comments for output                    */
/*                                                              */
/* Copyright(c) 1995-2004 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

select 'Drop unnecessary job_queue tables' as "Task" from dual;

drop index job_q_out_idx;

drop table job_queue_sysout cascade constraints;

drop table job_queue_course cascade constraints;

drop table tmp_job_queue_run cascade constraints;

/*==============================================================*/
/* Table: tmp_job_queue_run                                     */
/*==============================================================*/
create table tmp_job_queue_run  (
   int_seq_no           NUMBER(9)                       not null,
   instidq              CHAR(2)                        default ' ',
   instid               CHAR(8)                        default ' ',
   instcd               CHAR(3)                        default ' ',
   jobid                CHAR(16)                       default ' ',
   userid               CHAR(30)                       default ' ',
   soprid               CHAR(8)                        default ' ',
   stuno                CHAR(13)                       default ' ',
   dprog                CHAR(15)                       default ' ',
   dpmask               CHAR(15)                       default ' ',
   catlyt               CHAR(6)                        default ' ',
   binstid              CHAR(8),
   binstcd              CHAR(3),
   rundate              CHAR(10),
   jobq_sysout_used     CHAR(1),
   runtime              CHAR(8),
   ncol                 CHAR(1),
   complete             VARCHAR2(1),
   ip                   VARCHAR2(1)
);

insert into tmp_job_queue_run (int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip)
select int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip
from job_queue_run;

drop table job_queue_run cascade constraints;

select 'Create advisor tables...' as "Task" from dual;
/*==============================================================*/
/* Table: adv_ctlcd                                             */
/*==============================================================*/
create table adv_ctlcd  (
   adv_id               CHAR(20)                        not null,
   ctlcd                CHAR(2)                         not null,
   constraint PK_ADV_CTLCD primary key (adv_id, ctlcd)
);

/*==============================================================*/
/* Table: adv_dprogs                                            */
/*==============================================================*/
create table adv_dprogs  (
   adv_id               CHAR(20)                        not null,
   dprog                CHAR(15)                        not null,
   constraint PK_ADV_DPROGS primary key (adv_id, dprog)
);

/*==============================================================*/
/* Table: adv_functions                                         */
/*==============================================================*/
create table adv_functions  (
   adv_function         CHAR(40)                        not null,
   adv_id               CHAR(20)                        not null,
   instidq              CHAR(2)                         not null,
   instid               CHAR(8)                         not null,
   instcd               CHAR(3)                         not null,
   authority            CHAR(1)                         not null,
   constraint PK_ADV_FUNCTIONS primary key (adv_id, adv_function, instidq, instid, instcd)
);

/*==============================================================*/
/* Table: adv_inst                                              */
/*==============================================================*/
create table adv_inst  (
   adv_id               CHAR(20)                        not null,
   instidq              CHAR(2)                         not null,
   instid               CHAR(8)                         not null,
   instcd               CHAR(3)                         not null,
   constraint PK_ADV_INST primary key (adv_id, instidq, instid, instcd)
);

/*==============================================================*/
/* Table: adv_master                                            */
/*==============================================================*/
select 'If adv_master table exists, add column' as " " from dual;
alter table adv_master add encrypted_pin  varchar2(80);

select '   otherwise create adv_master table' as " " from dual;
create table adv_master  (
   adv_id               CHAR(20)                        not null,
   pin                  CHAR(20),
   encrypted_pin        VARCHAR2(80),
   name                 VARCHAR2(40),
   dept                 VARCHAR2(40),
   ref_adv_id           VARCHAR2(20),
   constraint PK_ADV_MASTER primary key (adv_id)
);

/*==============================================================*/
/* Table: adv_req                                               */
/*==============================================================*/
create table adv_req  (
   adv_id               CHAR(20)                        not null,
   rname                CHAR(9)                         not null,
   constraint PK_ADV_REQ primary key (adv_id, rname)
);

/*==============================================================*/
/* Index: analysis_idx                                          */
/*==============================================================*/
create index analysis_idx on analysis (
   stuno ASC,
   dprog ASC,
   dpmask ASC,
   catlyt ASC,
   jobid ASC
);

/*==============================================================*/
/* Index: analysis_req_idx2                                     */
/*==============================================================*/
create index analysis_req_idx2 on analysis_req (
   jobq_seq_no ASC,
   rno ASC,
   sno ASC
);

/*==============================================================*/
/* Table: chart_categories                                      */
/*==============================================================*/
select 'Create chart_categories table...' as "Task " from dual;

create table chart_categories  (
   instidq              CHAR(2)                        default ' ' not null,
   instid               CHAR(8)                        default ' ' not null,
   instcd               CHAR(3)                        default ' ' not null,
   category_code        CHAR(1)                         not null,
   category_name        CHAR(15),
   category_desc        VARCHAR2(255),
   transcript           CHAR(1),
   total_hour           CHAR(1),
   hidefromchart        CHAR(1),
   last_mod_user        VARCHAR2(30),
   last_mod_date        DATE,
   constraint PK_CHART_CATEGORIES primary key (instidq, instid, instcd, category_code)
);

/*==============================================================*/
/* Index: chart_cat_idx                                         */
/*==============================================================*/
create index chart_cat_idx on chart_categories (
   instidq ASC,
   instid ASC,
   instcd ASC,
   category_code ASC,
   transcript ASC,
   hidefromchart ASC,
   total_hour ASC
);

alter table dprog_req add category CHAR(1);

select 'Create new job_queue tables...' as "Task " from dual;
/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
create table job_queue_course  (
   jobq_seq_no          NUMBER(9)                       not null,
   rtabx                CHAR(3)                         not null,
   stabx                CHAR(3)                         not null,
   etabx                CHAR(3)                         not null,
   yt                   CHAR(6),
   course               VARCHAR2(15),
   xcourse              VARCHAR2(15),
   rcredit              NUMBER(10,5),
   credit               NUMBER(10,5),
   gpahrs               NUMBER(10,5),
   gpapts               NUMBER(10,5),
   gpa                  NUMBER(10,5),
   grade                CHAR(4),
   rgrade               CHAR(4),
   ip                   CHAR(1),
   whatif               CHAR(1),
   ctitle               VARCHAR2(29),
   rtitle               VARCHAR2(29),
   stitle               VARCHAR2(29),
   cvttitle             VARCHAR2(29),
   alttitle             VARCHAR2(29),
   constraint PK_JOB_QUEUE_COURSE primary key (jobq_seq_no, rtabx, stabx, etabx)
);

/*==============================================================*/
/* Index: job_q_out_idx                                         */
/*==============================================================*/
create index job_q_out_idx on job_queue_out (
   jobq_seq_no ASC,
   user_seq_no ASC,
   rtabx ASC,
   stabx ASC,
   optline ASC
);

/*==============================================================*/
/* Table: job_queue_req                                         */
/*==============================================================*/
create table job_queue_req  (
   jobq_seq_no          NUMBER(9)                       not null,
   rtabx                CHAR(3)                         not null,
   rno                  CHAR(3),
   rname                VARCHAR2(9),
   psname               VARCHAR2(15),
   category             VARCHAR2(15),
   summary_grp          VARCHAR2(15),
   transcript           CHAR(1),
   total_hour           CHAR(1),
   hidefromchart        CHAR(1),
   satisfied            CHAR(1),
   summary              CHAR(1),
   sortflg              CHAR(1),
   orreq                CHAR(1),
   optreq               CHAR(1),
   reqsrq               INTEGER,
   gotsrq               INTEGER,
   needsrq              INTEGER,
   reqct                INTEGER,
   gotct                INTEGER,
   ipct                 INTEGER,
   whatifct             INTEGER,
   needct               INTEGER,
   maxhrs               NUMBER(10,5),
   reqhrs               NUMBER(10,5),
   est_reqhrs           NUMBER(10,5),
   gothrs               NUMBER(10,5),
   iphrs                NUMBER(10,5),
   whatifhrs            NUMBER(10,5),
   needhrs              NUMBER(10,5),
   gotgpahrs            NUMBER(10,5),
   gotgpapts            NUMBER(10,5),
   reqgpa               NUMBER(10,5),
   gotgpa               NUMBER(10,5),
   needgpa              NUMBER(10,5),
   constraint PK_JOB_QUEUE_REQ primary key (jobq_seq_no, rtabx)
);

/*==============================================================*/
/* Index: jobq_req_idx                                          */
/*==============================================================*/
create index jobq_req_idx on job_queue_req (
   jobq_seq_no ASC,
   rtabx ASC,
   rname ASC,
   category ASC,
   summary_grp ASC,
   transcript ASC,
   total_hour ASC,
   hidefromchart ASC,
   summary ASC
);

/*==============================================================*/
/* Table: job_queue_run                                         */
/*==============================================================*/
create table job_queue_run  (
   int_seq_no           NUMBER(9)                       not null,
   instidq              CHAR(2)                        default ' ',
   instid               CHAR(8)                        default ' ',
   instcd               CHAR(3)                        default ' ',
   jobid                CHAR(16)                       default ' ',
   userid               CHAR(30)                       default ' ',
   soprid               CHAR(8)                        default ' ',
   stuno                CHAR(13)                       default ' ',
   dprog                CHAR(15)                       default ' ',
   dpmask               CHAR(15)                       default ' ',
   catlyt               CHAR(6)                        default ' ',
   binstid              CHAR(8),
   binstcd              CHAR(3),
   rundate              CHAR(10),
   jobq_sysout_used     CHAR(1),
   runtime              CHAR(8),
   ncol                 CHAR(1),
   complete             CHAR(1),
   ip                   CHAR(1),
   constraint PK_JOB_QUEUE_RUN primary key (int_seq_no)
);

insert into job_queue_run (int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip)
select int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip
from tmp_job_queue_run;

drop table tmp_job_queue_run cascade constraints;

/*==============================================================*/
/* Index: jobq_run_idx                                          */
/*==============================================================*/
create index jobq_run_idx on job_queue_run (
   stuno ASC,
   instidq ASC,
   instid ASC,
   instcd ASC,
   soprid ASC,
   dprog ASC,
   dpmask ASC,
   catlyt ASC,
   userid ASC
);

/*==============================================================*/
/* Table: job_queue_subreq                                      */
/*==============================================================*/
create table job_queue_subreq  (
   jobq_seq_no          NUMBER(9)                       not null,
   rtabx                CHAR(3)                         not null,
   stabx                CHAR(3)                         not null,
   sno                  CHAR(3),
   satisfied            CHAR(1),
   sortflg              CHAR(1),
   orsub                CHAR(1),
   optsub               CHAR(1),
   reqct                INTEGER,
   gotct                INTEGER,
   needct               INTEGER,
   ipct                 INTEGER,
   whatifct             INTEGER,
   maxhrs               NUMBER(10,5),
   reqhrs               NUMBER(10,5),
   est_reqhrsflg        CHAR(1),
   est_reqhrs           NUMBER(10,5),
   gothrs               NUMBER(10,5),
   iphrs                NUMBER(10,5),
   whatifhrs            NUMBER(10,5),
   needhrs              NUMBER(10,5),
   reqgpa               NUMBER(10,5),
   gotgpa               NUMBER(10,5),
   needgpa              NUMBER(10,5),
   gotgpahrs            NUMBER(10,5),
   gotgpapts            NUMBER(10,5)                   default 0,
   constraint PK_JOB_QUEUE_SUBREQ primary key (jobq_seq_no, rtabx, stabx)
);

select 'Add column estreqhrs to req_main...' as "Task " from dual;
alter table req_main add estreqhrs NUMBER(4,1);

select 'Add column update_pin to secure_inst (may already exist)...' as "Task " from dual;
alter table secure_inst add update_pin CHAR(1);

select 'Add indexes to stu_egrp_courses...' as "Task " from dual;
/*==============================================================*/
/* Index: stu_egrp_crs_idx2                                     */
/*==============================================================*/
create index stu_egrp_crs_idx2 on stu_egrp_courses (
   stu_mast_no ASC,
   evalgrp ASC
);

/*==============================================================*/
/* Index: stu_egrp_crs_idx3                                     */
/*==============================================================*/
create index stu_egrp_crs_idx3 on stu_egrp_courses (
   cdpmask ASC,
   crs_num ASC,
   crs_seq ASC,
   crs_yt ASC,
   source_cd ASC,
   source_id ASC,
   stu_mast_no ASC
);

select 'Add column to stu_master...' as "Task " from dual;
alter table stu_master add encrypted_pin VARCHAR2(80);

select 'Add esthrs and esthrsflg to sub_req...' as "Task " from dual;
alter table sub_req add esthrs NUMBER(4,1);

alter table sub_req add esthrsflg CHAR(1);

update sub_req
	set esthrs = 0,
	    esthrsflg = ' ';

select 'Update whatif_courses table...' as "Task " from dual;
/*==============================================================*/
/* Table: whatif_courses                                        */
/*==============================================================*/
select '  Add column, if whatif_courses table already exists...' as " " from dual;
alter table whatif_courses add cart CHAR(1);

select '  otherwise create whatif_courses table...' as " " from dual;
create table whatif_courses  (
   stu_mast_no          NUMBER(9)                       not null,
   source_id            CHAR(8)                         not null,
   source_cd            CHAR(3)                         not null,
   cdpmask              CHAR(15)                        not null,
   crs_yt               CHAR(6)                         not null,
   crs_num              CHAR(15)                        not null,
   crs_seq              CHAR(3)                         not null,
   rcredit              NUMBER(7,5),
   grade                CHAR(4),
   ctitle               VARCHAR2(29),
   rtext                CHAR(2),
   cart                 CHAR(1),
   memo                 VARCHAR2(255),
   last_mod_user        VARCHAR2(30),
   last_mod_date        DATE,
   constraint PK_WHATIF_COURSES primary key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
);

/*==============================================================*/
/* Index: whatif_cart_idx                                       */
/*==============================================================*/
create unique index whatif_cart_idx on whatif_courses (
   stu_mast_no ASC,
   source_id ASC,
   source_cd ASC,
   cdpmask ASC,
   crs_yt ASC,
   crs_num ASC,
   crs_seq ASC,
   cart ASC
);

/*==============================================================*/
/* Index: whatif_cart2_idx                                      */
/*==============================================================*/
create index whatif_cart2_idx on whatif_courses (
   stu_mast_no ASC,
   cart ASC
);

select 'Create views...' as "Task " from dual;
/*==============================================================*/
/* View: vw_adv_ctlcd                                           */
/*==============================================================*/
create or replace view vw_adv_ctlcd as
select adv_id, ctlcd from adv_ctlcd;

/*==============================================================*/
/* View: vw_adv_dprogs                                          */
/*==============================================================*/
create or replace view vw_adv_dprogs as
select adv_id, dprog from adv_dprogs;

/*==============================================================*/
/* View: vw_adv_functions                                       */
/*==============================================================*/
create or replace view vw_adv_functions as
select adv_id, adv_function, authority, instidq, instid, instcd
from adv_functions;

/*==============================================================*/
/* View: vw_adv_inst                                            */
/*==============================================================*/
create or replace view vw_adv_inst as
select adv_id, instidq, instid, instcd
from adv_inst;

/*==============================================================*/
/* View: vw_adv_master                                          */
/*==============================================================*/
create or replace view vw_adv_master as
select adv_id, pin, encrypted_pin, name, dept, ref_adv_id from adv_master;

/*==============================================================*/
/* View: vw_adv_req                                             */
/*==============================================================*/
create or replace view vw_adv_req as
select adv_id, rname from adv_req;

/*==============================================================*/
/* View: vw_stu_demo                                            */
/*==============================================================*/
create or replace view vw_stu_demo as
select stu_mast_no, source_id, stuname, stuidq, stuiddesc, dob, birthcountry, birthstate, birthcounty, birthcity, citizenstatus, citizencountry, nativelang, englprof, marital, gender, race, hsgradtype, hsgraddate, hs, tctlast, nodflt, bdverif, spokeninhome, correslang, subnatq, subnational, memo, last_mod_user, last_mod_date
from stu_demo;

/*==============================================================*/
/* View: vw_stu_master                                          */
/*==============================================================*/
create or replace view vw_stu_master as
select int_seq_no, instidq, instid, stuno, memo, last_mod_user, last_mod_date, tctlast, pin, nodflt, encrypted_pin from stu_master;

select 'Add foreign key references...' as "Task " from dual;
alter table adv_ctlcd
   add constraint FK_ADV_CTLC_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id);

alter table adv_dprogs
   add constraint FK_ADV_DPRO_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id);

alter table adv_functions
   add constraint FK_ADV_FUNC_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id);

alter table adv_inst
   add constraint FK_ADV_INST_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id);

alter table adv_req
   add constraint FK_ADV_REQ_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id);

alter table job_queue_course
   add constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx);

alter table job_queue_req
   add constraint FK_JOBQ_REQ_REF_JOBQ_RUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no);

alter table job_queue_subreq
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx);

alter table job_queue_out
   add constraint FK_JOBQ_OUT_REF_JOBQ_RUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no);


select 'Update triggers...' as "Task " from dual;
-- ****************************
-- Triggers
-- ****************************

--  INSERT WITH int_seq_no, WITHOUT last_mod_user, date
--  Before insert trigger "tib_job_queue_run" for table "job_queue_run"
create or replace trigger tib_job_queue_run before insert
on job_queue_run for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no

    select jobqr_seq_no.nextval
    into next_seq_no
    from dual;

    :new.int_seq_no := next_seq_no;

end;
/
-- ****************************
-- New triggers with DARwin 3.5
-- ****************************

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_chart_categories" for table "chart_categories"
create or replace trigger tib_chart_categories before insert
on chart_categories for each row

begin

--  update "Last Saved" information

IF  :new.last_mod_user IS NULL  or :new.last_mod_date IS NULL  THEN
    :new.last_mod_user := user;
  :new.last_mod_date := sysdate;
END IF;
    
end;
/


--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_chart_categories" for table "chart_categories"
create or replace trigger tub_chart_categories before update
on chart_categories for each row

begin
--  update "Last Saved" information

    :new.last_mod_user := user;
    :new.last_mod_date := sysdate;

end;
/


--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_whatif_courses" for table "whatif_courses"
create or replace trigger tib_whatif_courses before insert
on whatif_courses for each row

begin

--  update "Last Saved" information

IF  :new.last_mod_user IS NULL  or :new.last_mod_date IS NULL  THEN
    :new.last_mod_user := user;
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

    :new.last_mod_user := user;
    :new.last_mod_date := sysdate;

end;
/

