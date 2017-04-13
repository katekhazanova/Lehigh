/*==============================================================*/
/* Database name:  DARwin 3.5                                   */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     1/28/2004 12:09:31 PM                        */
/*                                                              */
/* Script name:    dw35mssmod.sql                               */
/* Purpose:        Updates existing DARwin 3.0 database objects */
/*                 to their DARwin 3.5 format.                  */
/* Updates:                                                     */
/*      05/12/04   removed stu_egrp_crs_idx                     */
/*      06/30/04   check for existance of whatif_courses table  */
/*                 and update_pin column in secure_master       */
/*      07/02/04   update values in esthrs and esthrsflg        */
/*                                                              */
/* Copyright(c) 1995-2004 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/


/*==============================================================*/
/*  Drop all foreign key constraints                            */
/*==============================================================*/

declare @fk_name char(30)
declare @fk_table char(30)

select @fk_name = '1'
while @fk_name > ' ' begin
   select @fk_name = ' '
   select @fk_name = cast(f.name  as varchar(30)), @fk_table = cast(c.name as  varchar(30))
      from sysobjects f
      inner join sysobjects c on  f.parent_obj = c.id
      where f.name = (select min(name) from sysobjects where type = 'F')
   if @fk_name > ' '  begin 
      exec ('alter table ' + @fk_table + ' drop constraint ' + @fk_name)
   end 

end

go

/*==============================================================*/
/*  Modify tables and views                                    */
/*==============================================================*/


if exists (select 1
            from  sysindexes
           where  id    = object_id('job_queue_out')
            and   name  = 'job_q_out_idx'
            and   indid > 0
            and   indid < 255)
   drop index job_queue_out.job_q_out_idx
go


if exists (select 1
            from  sysobjects
            where  id = object_id('job_queue_course')
            and    type = 'U')
   drop table job_queue_course
go


if exists (select 1
            from  sysobjects
            where  id = object_id('tmp_job_queue_run')
            and    type = 'U')
   drop table tmp_job_queue_run
go


/*==============================================================*/
/* Table: tmp_job_queue_run                                     */
/*==============================================================*/
create table tmp_job_queue_run (
     int_seq_no           numeric(9)                     not null,
     instidq              char(2)                        default ' ' null,
     instid               char(8)                        default ' ' null,
     instcd               char(3)                        default ' ' null,
     jobid                char(16)                       default ' ' null,
     userid               char(30)                       default ' ' null,
     soprid               char(8)                        default ' ' null,
     stuno                char(13)                       default ' ' null,
     dprog                char(15)                       default ' ' null,
     dpmask               char(15)                       default ' ' null,
     catlyt               char(6)                        default ' ' null,
     binstid              char(8)                        null,
     binstcd              char(3)                        null,
     rundate              char(10)                       null,
     jobq_sysout_used     char(1)                        null,
     runtime              char(8)                        null,
     ncol                 char(1)                        null,
     complete             varchar(1)                     null,
     ip                   varchar(1)                     null
)
go


insert into tmp_job_queue_run (int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip)
select int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip
from job_queue_run
go


if exists (select 1
            from  sysobjects
            where  id = object_id('job_queue_run')
            and    type = 'U')
   drop table job_queue_run
go




if exists (select 1
            from  sysobjects
            where  id = object_id('tmp_whatif_courses')
            and    type = 'U')
   drop table tmp_whatif_courses
go


/*==============================================================*/
/* Table: tmp_whatif_courses                                    */
/*==============================================================*/
create table tmp_whatif_courses (
     stu_mast_no          numeric(9)                     not null,
     source_id            char(8)                        not null,
     source_cd            char(3)                        not null,
     cdpmask              char(15)                       not null,
     crs_yt               char(6)                        not null,
     crs_num              char(15)                       not null,
     crs_seq              char(3)                        not null,
     rcredit              numeric(7,5)                   null,
     grade                char(4)                        null,
     ctitle               varchar(29)                    null,
     rtext                char(2)                        null,
     cart                 char(1)                        null,
     memo                 varchar(255)                   null,
     last_mod_user        varchar(30)                    null,
     last_mod_date        datetime                       null,
     constraint PK_TMP_WHATIF_COURSES primary key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
)
go



if exists (select 1
            from  sysobjects
            where  id = object_id('whatif_courses')
            and    type = 'U')
	insert into tmp_whatif_courses (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq, rcredit, grade, ctitle, rtext, memo)
	select stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq, rcredit, grade, ctitle, rtext, memo
	from whatif_courses
go


if exists (select 1
            from  sysobjects
            where  id = object_id('whatif_courses')
            and    type = 'U')
   drop table whatif_courses
go



/*==============================================================*/
/* Table: adv_ctlcd                                             */
/*==============================================================*/
if not exists (select 1
            from  sysobjects
            where  id = object_id('adv_ctlcd')
            and    type = 'U')

   create table adv_ctlcd (
     adv_id               char(20)                       not null,
     ctlcd                char(2)                        not null,
     constraint PK_ADV_CTLCD primary key (adv_id, ctlcd)
   )
go


/*==============================================================*/
/* Table: adv_dprogs                                            */
/*==============================================================*/
create table adv_dprogs (
     adv_id               char(20)                       not null,
     dprog                char(15)                       not null,
     constraint PK_ADV_DPROGS primary key (adv_id, dprog)
)
go


/*==============================================================*/
/* Table: adv_functions                                         */
/*==============================================================*/
create table adv_functions (
     adv_function         char(40)                       not null,
     adv_id               char(20)                       not null,
     instidq              char(2)                        not null,
     instid               char(8)                        not null,
     instcd               char(3)                        not null,
     authority            char(1)                        not null,
     constraint PK_ADV_FUNCTIONS primary key (adv_id, adv_function, instidq, instid, instcd)
)
go


/*==============================================================*/
/* Table: adv_inst                                              */
/*==============================================================*/
create table adv_inst (
     adv_id               char(20)                       not null,
     instidq              char(2)                        not null,
     instid               char(8)                        not null,
     instcd               char(3)                        not null,
     constraint PK_ADV_INST primary key (adv_id, instidq, instid, instcd)
)
go


/*==============================================================*/
/* Table: adv_master                                            */
/*==============================================================*/
if exists (select 1
            from  sysobjects
            where  id = object_id('adv_master')
            and    type = 'U')
   begin
      alter table adv_master
         add encrypted_pin        varchar(80)                    null
   end
else
   begin 
      create table adv_master (
         adv_id               char(20)                       not null,
         pin                  char(20)                       null,
         encrypted_pin        varchar(80)                    null,
         name                 varchar(40)                    null,
         dept                 varchar(40)                    null,
         ref_adv_id           varchar(20)                    null,
         constraint PK_ADV_MASTER primary key (adv_id)
      )
   end
go

/*==============================================================*/
/* Table: adv_req                                               */
/*==============================================================*/
create table adv_req (
     adv_id               char(20)                       not null,
     rname                char(9)                        not null,
     constraint PK_ADV_REQ primary key (adv_id, rname)
)
go


/*==============================================================*/
/* Index: analysis_idx                                          */
/*==============================================================*/
create index analysis_idx on analysis (
stuno ,
dprog ,
dpmask ,
catlyt ,
jobid 
)
go


/*==============================================================*/
/* Index: analysis_req_idx2                                     */
/*==============================================================*/
create index analysis_req_idx2 on analysis_req (
jobq_seq_no ,
rno ,
sno 
)
go


/*==============================================================*/
/* Table: chart_categories                                      */
/*==============================================================*/
create table chart_categories (
     instidq              char(2)                        default ' ' not null,
     instid               char(8)                        default ' ' not null,
     instcd               char(3)                        default ' ' not null,
     category_code        char(1)                        not null,
     category_name        char(15)                       null,
     category_desc        varchar(255)                   null,
     transcript           char(1)                        null,
     total_hour           char(1)                        null,
     hidefromchart        char(1)                        null,
     last_mod_user        varchar(30)                    null,
     last_mod_date        datetime                       null,
     constraint PK_CHART_CATEGORIES primary key (instidq, instid, instcd, category_code)
)
go


/*==============================================================*/
/* Index: chart_cat_idx                                         */
/*==============================================================*/
create index chart_cat_idx on chart_categories (
instidq ,
instid ,
instcd ,
category_code ,
transcript ,
hidefromchart ,
total_hour 
)
go


alter table dprog_req
  add category             char(1)                        null
go


/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
create table job_queue_course (
     jobq_seq_no          numeric(9)                     not null,
     rtabx                char(3)                        not null,
     stabx                char(3)                        not null,
     etabx                char(3)                        not null,
     yt                   char(6)                        null,
     course               varchar(15)                    null,
     xcourse              varchar(15)                    null,
     rcredit              numeric(10,5)                  null,
     credit               numeric(10,5)                  null,
     gpahrs               numeric(10,5)                  null,
     gpapts               numeric(10,5)                  null,
     gpa                  numeric(10,5)                  null,
     grade                char(4)                        null,
     rgrade               char(4)                        null,
     ip                   char(1)                        null,
     whatif               char(1)                        null,
     ctitle               varchar(29)                    null,
     rtitle               varchar(29)                    null,
     stitle               varchar(29)                    null,
     cvttitle             varchar(29)                    null,
     alttitle             varchar(29)                    null,
     constraint PK_JOB_QUEUE_COURSE primary key (jobq_seq_no, rtabx, stabx, etabx)
)
go

/*==============================================================*/
/* Index: job_q_out_idx                                         */
/*==============================================================*/
create index job_q_out_idx on job_queue_out (
jobq_seq_no ,
user_seq_no ,
rtabx ,
stabx ,
optline 
)
go


/*==============================================================*/
/* Table: job_queue_req                                         */
/*==============================================================*/
create table job_queue_req (
     jobq_seq_no          numeric(9)                     not null,
     rtabx                char(3)                        not null,
     rno                  char(3)                        null,
     rname                varchar(9)                     null,
     psname               varchar(15)                    null,
     category             varchar(15)                    null,
     summary_grp          varchar(15)                    null,
     transcript           char(1)                        null,
     total_hour           char(1)                        null,
     hidefromchart        char(1)                        null,
     satisfied            char(1)                        null,
     summary              char(1)                        null,
     sortflg              char(1)                        null,
     orreq                char(1)                        null,
     optreq               char(1)                        null,
     reqsrq               integer                        null,
     gotsrq               integer                        null,
     needsrq              integer                        null,
     reqct                integer                        null,
     gotct                integer                        null,
     ipct                 integer                        null,
     whatifct             integer                        null,
     needct               integer                        null,
     maxhrs               numeric(10,5)                  null,
     reqhrs               numeric(10,5)                  null,
     est_reqhrs           numeric(10,5)                  null,
     gothrs               numeric(10,5)                  null,
     iphrs                numeric(10,5)                  null,
     whatifhrs            numeric(10,5)                  null,
     needhrs              numeric(10,5)                  null,
     gotgpahrs            numeric(10,5)                  null,
     gotgpapts            numeric(10,5)                  null,
     reqgpa               numeric(10,5)                  null,
     gotgpa               numeric(10,5)                  null,
     needgpa              numeric(10,5)                  null,
     constraint PK_JOB_QUEUE_REQ primary key (jobq_seq_no, rtabx)
)
go


/*==============================================================*/
/* Index: jobq_req_idx                                          */
/*==============================================================*/
create index jobq_req_idx on job_queue_req (
jobq_seq_no ,
rtabx ,
rname ,
category ,
summary_grp ,
transcript ,
total_hour ,
hidefromchart ,
summary 
)
go


/*==============================================================*/
/* Table: job_queue_run                                         */
/*==============================================================*/
create table job_queue_run (
     int_seq_no           numeric(9)                     identity,
     instidq              char(2)                        default ' ' null,
     instid               char(8)                        default ' ' null,
     instcd               char(3)                        default ' ' null,
     jobid                char(16)                       default ' ' null,
     userid               char(30)                       default ' ' null,
     soprid               char(8)                        default ' ' null,
     stuno                char(13)                       default ' ' null,
     dprog                char(15)                       default ' ' null,
     dpmask               char(15)                       default ' ' null,
     catlyt               char(6)                        default ' ' null,
     binstid              char(8)                        null,
     binstcd              char(3)                        null,
     rundate              char(10)                       null,
     jobq_sysout_used     char(1)                        null,
     runtime              char(8)                        null,
     ncol                 char(1)                        null,
     complete             char(1)                        null,
     ip                   char(1)                        null,
     constraint PK_JOB_QUEUE_RUN primary key (int_seq_no)
)
go


set identity_insert job_queue_run on
go


insert into job_queue_run (int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip)
select int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip
from tmp_job_queue_run
go


set identity_insert job_queue_run off
go


if exists (select 1
            from  sysobjects
            where  id = object_id('tmp_job_queue_run')
            and    type = 'U')
   drop table tmp_job_queue_run
go


/*==============================================================*/
/* Index: jobq_run_idx                                          */
/*==============================================================*/
create index jobq_run_idx on job_queue_run (
stuno ,
instidq ,
instid ,
instcd ,
soprid ,
dprog ,
dpmask ,
catlyt ,
userid 
)
go


/*==============================================================*/
/* Table: job_queue_subreq                                      */
/*==============================================================*/
create table job_queue_subreq (
     jobq_seq_no          numeric(9)                     not null,
     rtabx                char(3)                        not null,
     stabx                char(3)                        not null,
     sno                  char(3)                        null,
     satisfied            char(1)                        null,
     sortflg              char(1)                        null,
     orsub                char(1)                        null,
     optsub               char(1)                        null,
     reqct                integer                        null,
     gotct                integer                        null,
     needct               integer                        null,
     ipct                 integer                        null,
     whatifct             integer                        null,
     maxhrs               numeric(10,5)                  null,
     reqhrs               numeric(10,5)                  null,
     est_reqhrsflg        char(1)                        null,
     est_reqhrs           numeric(10,5)                  null,
     gothrs               numeric(10,5)                  null,
     iphrs                numeric(10,5)                  null,
     whatifhrs            numeric(10,5)                  null,
     needhrs              numeric(10,5)                  null,
     reqgpa               numeric(10,5)                  null,
     gotgpa               numeric(10,5)                  null,
     needgpa              numeric(10,5)                  null,
     gotgpahrs            numeric(10,5)                  null,
     gotgpapts            numeric(10,5)                  default 0 null,
     constraint PK_JOB_QUEUE_SUBREQ primary key (jobq_seq_no, rtabx, stabx)
)
go


alter table req_main
  add estreqhrs            numeric(4,1)                   null
go

if not exists (select 1
            from  syscolumns
            where  id = object_id('secure_inst')
            and    name = 'update_pin')

	alter table secure_inst
	  add update_pin           char(1)                        null
go


/*==============================================================*/
/* Index: stu_egrp_crs_idx2                                     */
/*==============================================================*/
create index stu_egrp_crs_idx2 on stu_egrp_courses (
stu_mast_no ,
evalgrp 
)
go


/*==============================================================*/
/* Index: stu_egrp_crs_idx3                                     */
/*==============================================================*/
create index stu_egrp_crs_idx3 on stu_egrp_courses (
cdpmask ,
crs_num ,
crs_seq ,
crs_yt ,
source_cd ,
source_id ,
stu_mast_no 
)
go


alter table stu_master
  add encrypted_pin        varchar(80)                    null
go


alter table sub_req
  add esthrs               numeric(4,1)                   null
go


alter table sub_req
  add esthrsflg            char(1)                        null
go

update sub_req
   set esthrs = 0, esthrsflg = ' '
go

/*==============================================================*/
/* Table: whatif_courses                                        */
/*==============================================================*/
create table whatif_courses (
     stu_mast_no          numeric(9)                     not null,
     source_id            char(8)                        not null,
     source_cd            char(3)                        not null,
     cdpmask              char(15)                       not null,
     crs_yt               char(6)                        not null,
     crs_num              char(15)                       not null,
     crs_seq              char(3)                        not null,
     rcredit              numeric(7,5)                   null,
     grade                char(4)                        null,
     ctitle               varchar(29)                    null,
     rtext                char(2)                        null,
     cart                 char(1)                        null,
     memo                 varchar(255)                   null,
     last_mod_user        varchar(30)                    null,
     last_mod_date        datetime                       null,
     constraint PK_WHATIF_COURSES primary key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
)
go


/*==============================================================*/
/* Index: whatif_cart_idx                                       */
/*==============================================================*/
create unique index whatif_cart_idx on whatif_courses (
stu_mast_no ,
source_id ,
source_cd ,
cdpmask ,
crs_yt ,
crs_num ,
crs_seq ,
cart 
)
go


/*==============================================================*/
/* Index: whatif_cart2_idx                                      */
/*==============================================================*/
create index whatif_cart2_idx on whatif_courses (
stu_mast_no ,
cart 
)
go


insert into whatif_courses (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq, rcredit, grade, ctitle, rtext, memo)
select stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq, rcredit, grade, ctitle, rtext, memo
from tmp_whatif_courses
go

drop table tmp_whatif_courses
go


/*==============================================================*/
/* View: vw_adv_ctlcd                                           */
/*==============================================================*/
create view vw_adv_ctlcd as
select adv_id, ctlcd from adv_ctlcd
go


/*==============================================================*/
/* View: vw_adv_dprogs                                          */
/*==============================================================*/
create view vw_adv_dprogs as
select adv_id, dprog from adv_dprogs
go


/*==============================================================*/
/* View: vw_adv_functions                                       */
/*==============================================================*/
create view vw_adv_functions as
select adv_id, adv_function, authority, instidq, instid, instcd
from adv_functions
go


/*==============================================================*/
/* View: vw_adv_inst                                            */
/*==============================================================*/
create view vw_adv_inst as
Select adv_id, instidq, instid, instcd from adv_inst
go


/*==============================================================*/
/* View: vw_adv_master                                          */
/*==============================================================*/
create view vw_adv_master as
select adv_id, pin, encrypted_pin, name, dept, ref_adv_id from adv_master
go


/*==============================================================*/
/* View: vw_adv_req                                             */
/*==============================================================*/
create view vw_adv_req as
select adv_id, rname from adv_req
go


/*==============================================================*/
/* View: vw_stu_demo                                            */
/*==============================================================*/
create view vw_stu_demo as
select stu_mast_no, source_id, stuname, stuidq, stuiddesc, dob, birthcountry, birthstate, birthcounty, birthcity, citizenstatus, citizencountry, nativelang, englprof, marital, gender, race, hsgradtype, hsgraddate, hs, tctlast, nodflt, bdverif, spokeninhome, correslang, subnatq, subnational, memo, last_mod_user, last_mod_date
from stu_demo
go


/*==============================================================*/
/* View: vw_stu_master                                          */
/*==============================================================*/
create view vw_stu_master as
select int_seq_no, instidq, instid, stuno, memo, last_mod_user, last_mod_date, tctlast, pin, nodflt, encrypted_pin from stu_master
go


/*==============================================================*/
/*  Add triggers to new tables                                  */
/*==============================================================*/

/*  insert trigger "ti_chart_cat" for table "chart_categories"  */
create trigger ti_chart_cat on chart_categories for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update chart_categories
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from chart_categories c, inserted i
    where c.instidq = i.instidq and
          c.instid = i.instid and
          c.instcd = i.instcd and
          c.category_code = i.category_code and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_chart_cat" for table "chart_categories"  */
create trigger tu_chart_cat on chart_categories for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update chart_categories
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from chart_categories c, inserted i
    where c.instidq = i.instidq and
          c.instid = i.instid and
          c.instcd = i.instcd and
          c.category_code = i.category_code and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_whatif_course" for table "whatif_courses"  */
create trigger ti_whatif_course on whatif_courses for insert as
begin
    declare
       @numrows  int,
       @numnull  int,
       @errno    int,
       @errmsg   varchar(255)

    select  @numrows = @@rowcount
    if @numrows = 0
       return


    
    /*  update "last saved" information */
    update whatif_courses
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from whatif_courses w, inserted i
    where w.stu_mast_no = i.stu_mast_no and
          w.source_id = i.source_id and
          w.source_cd = i.source_cd and
          w.cdpmask = i.cdpmask and
          w.crs_yt = i.crs_yt and
          w.crs_num = i.crs_num and
          w.crs_seq = i.crs_seq and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_whatif_course" for table "whatif_courses"  */
create trigger tu_whatif_course on whatif_courses for update as
begin
   declare
      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255)

      select  @numrows = @@rowcount
      if @numrows = 0
         return

    /*  update "last saved" information */
    update whatif_courses
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from whatif_courses w, inserted i
    where w.stu_mast_no = i.stu_mast_no and
          w.source_id = i.source_id and
          w.source_cd = i.source_cd and
          w.cdpmask = i.cdpmask and
          w.crs_yt = i.crs_yt and
          w.crs_num = i.crs_num and
          w.crs_seq = i.crs_seq and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go


/*==============================================================*/
/*  Add foreign keys                                            */
/*==============================================================*/

alter table adv_ctlcd
   add constraint FK_ADV_CTLC_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id)
go


alter table adv_dprogs
   add constraint FK_ADV_DPRO_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id)
go


alter table adv_functions
   add constraint FK_ADV_FUNC_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id)
go


alter table adv_inst
   add constraint FK_ADV_INST_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id)
go


alter table adv_req
   add constraint FK_ADV_REQ_REFERENCE_ADV_MAST foreign key (adv_id)
      references adv_master (adv_id)
go


alter table analysis_courses
   add constraint fk_anal_req_2_crs foreign key (jobq_seq_no)
      references analysis_req (int_seq_no)
go


alter table analysis_req
   add constraint fk_anal_2_req foreign key (jobq_seq_no)
      references analysis (int_seq_no)
go


alter table dprog_req
   add constraint FK_DPROG_RE_RELATION__DPROG foreign key (instidq, instid, instcd, dprog, dpfyt)
      references dprog (instidq, instid, instcd, dprog, dpfyt)
go


alter table job_queue_course
   add constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go


alter table job_queue_detail
   add constraint FK_JOB_QUEU_RELATION__JOB_QUEU foreign key (instidq, instid, instcd, jobid, userid)
      references job_queue_list (instidq, instid, instcd, jobid, userid)
go


alter table job_queue_out
   add constraint FK_JOBQ_OUT_REF_JOBQ_RUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go


alter table job_queue_req
   add constraint FK_JOBQ_REQ_REF_JOBQ_RUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go


alter table job_queue_subreq
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
go


alter table job_queue_sysin
   add constraint FK_JOB_QUEU_REF_56906_JOB_QUEU foreign key (instidq, instid, instcd, jobid, userid)
      references job_queue_list (instidq, instid, instcd, jobid, userid)
go


alter table mastref_address
   add constraint FK_MASTREF__REF_16608_MASTREF foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
go


alter table mastref_seg
   add constraint FK_MASTREF__REF_15108_MASTREF foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
go


alter table req_text
   add constraint FK_REQ_TEXT_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
go


alter table req_xy
   add constraint FK_REQ_XY_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
go


alter table secure_import
   add constraint fk_simp_2_smast foreign key (userid)
      references secure_master (userid)
go


alter table secure_inst
   add constraint fk_sinst_2_smast foreign key (userid)
      references secure_master (userid)
go


alter table string_crse
   add constraint FK_STRING_C_RELATION__STRING foreign key (str_int_seq_no)
      references string (int_seq_no)
go


alter table stu_acadrec
   add constraint FK_STU_ACAD_REF_23073_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_address
   add constraint FK_STU_ADDR_REF_12130_STU_DEMO foreign key (stu_mast_no, source_id)
      references stu_demo (stu_mast_no, source_id)
go


alter table stu_demo
   add constraint FK_STU_DEMO_REF_23034_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_dprog
   add constraint FK_STU_DPRO_REF_23053_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_egrp_courses
   add constraint fk_egrp_2_egrp_crs foreign key (stu_mast_no, evalgrp)
      references stu_evalgrp (stu_mast_no, evalgrp)
go


alter table stu_egrp_courses
   add constraint FK_STU_EGRP_REF_46007_STU_ACAD foreign key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
      references stu_acadrec (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
go


alter table stu_evalgrp
   add constraint fk_stu_eval_2_mast foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_exc_courses
   add constraint FK_STU_EXC__REF_14062_STU_EXCE foreign key (stu_int_seq_no)
      references stu_exceptions (int_seq_no)
go


alter table stu_exceptions
   add constraint FK_STU_EXCE_REF_23068_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table stu_marker_req
   add constraint FK_STU_MARK_RELATION__STU_DPRO foreign key (stu_mast_no, instcd, dprog)
      references stu_dprog (stu_mast_no, instcd, dprog)
go


alter table stu_trans_degree
   add constraint FK_STU_TRAN_REF_23058_STU_MAST foreign key (stu_mast_no)
      references stu_master (int_seq_no)
go


alter table sub_req
   add constraint FK_SUB_REQ_RELATION__REQ_MAIN foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
go


alter table sub_req_ar
   add constraint sreq_to_sreq_ar foreign key (sub_int_seq_no)
      references sub_req (int_seq_no)
go


alter table sub_req_text
   add constraint sreq_to_sreq_text foreign key (sub_int_seq_no)
      references sub_req (int_seq_no)
go


alter table tca_rule
   add constraint FK_TCA_RULE_REF_10199_TCA_MAST foreign key (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
      references tca_master (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
go


alter table tca_source
   add constraint FK_TCA_SOUR_REF_11057_TCA_RULE foreign key (tca_rule_seq_no)
      references tca_rule (int_seq_no)
go


alter table tca_target
   add constraint FK_TCA_TARG_REF_11060_TCA_RULE foreign key (tca_rule_seq_no)
      references tca_rule (int_seq_no)
go
