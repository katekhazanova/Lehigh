/*==============================================================*/
/* Database name:  Database                                     */
/* DARwin Release: DARwin 3.0b3                                 */
/* DBMS name:      Microsoft SQL Server 7.x/2000                */
/* Created on:     9/14/2001 4:55:34 PM                         */
/*                                                              */
/* Modifications:	1/29/02	Added ip, complete to job_queue_run  */
/*                         Modified stu_exceptions.auth_date    */
/*                            from char(10) to char(12)         */
/*                         Added update_pin to secure_inst      */
/*==============================================================*/

if exists (select 1
            from  sysobjects 
            where  id = object_id('analysis_courses')
            and    type = 'U')
   drop table analysis_courses
go

if exists (select 1
            from  sysobjects 
            where  id = object_id('analysis_req')
            and    type = 'U')
   drop table analysis_req
go

if exists (select 1
            from  sysobjects 
            where  id = object_id('analysis')
            and    type = 'U')
   drop table analysis
go

/*==============================================================*/
/* Table : analysis                                             */
/*==============================================================*/
create table analysis (
int_seq_no           numeric(9)           identity,
complete             varchar(1)           null,
ip                   varchar(1)           null,
seqout               varchar(1)           null,
reqct                int                  null,
sreqct               numeric              null,
userid               char(30)             null,
soprid               char(8)              null,
stuno                varchar(13)          null,
stuname              varchar(35)          null,
dprog                varchar(15)          null,
instcd               varchar(3)           null default ' ',
dpmask               char(15)             null,
degree_date          varchar(10)          null,
catlyt               varchar(6)           null,
runtime              char(9)              null,
rundate              char(10)             null,
instid               char(8)              null default ' ',
jobid                char(16)             null,
instidq              char(2)              null default ' ',
constraint PK_ANALYSIS primary key  (int_seq_no)
)
go


/*==============================================================*/
/* Table : analysis_courses                                     */
/*==============================================================*/
create table analysis_courses (
int_seq_no           numeric(9)           identity,
jobq_seq_no          numeric(9)           not null default 0,
user_seq_no          int                  null default 0,
course               varchar(15)          null,
passfail             varchar(1)           null,
yeartm               char(6)              null default '0000',
credit               numeric(7,5)         null default 0,
constraint PK_ANALYSIS_COURSES primary key  (int_seq_no)
)
go


/*==============================================================*/
/* Index: analysis_crs_idx                                      */
/*==============================================================*/
create   index analysis_crs_idx on analysis_courses (
jobq_seq_no,
user_seq_no
)
go


/*==============================================================*/
/* Table : analysis_req                                         */
/*==============================================================*/
create table analysis_req (
int_seq_no           numeric(9)           identity,
jobq_seq_no          numeric(9)           not null default 0,
rct                  numeric(2)           null,
srct                 numeric(3)           null,
rname                varchar(9)           null,
psname               varchar(15)          null,
rno                  numeric(2)           null,
sno                  numeric(3)           null,
met                  varchar(1)           null,
fmet                 varchar(1)           null,
seqout               varchar(1)           null,
reqct                numeric(2)           null,
gotct                numeric(3)           null,
reqhrs               numeric(5,2)         null,
gothrs               numeric(5,2)         null,
reqgpa               numeric(4,3)         null,
gotgpa               numeric(4,3)         null,
gotgpahrs            numeric(5,2)         null,
gotgpapts            numeric(9,5)         null default 0,
constraint PK_ANALYSIS_REQ primary key  (int_seq_no)
)
go


/*==============================================================*/
/* Index: analysis_req_idx                                      */
/*==============================================================*/
create   index analysis_req_idx on analysis_req (
jobq_seq_no,
rct,
srct
)
go

alter table analysis_courses
   add constraint fk_anal_req_2_crs foreign key (jobq_seq_no)
      references analysis_req (int_seq_no)
go


alter table analysis_req
   add constraint fk_anal_2_req foreign key (jobq_seq_no)
      references analysis (int_seq_no)
go


alter table dprog 
   add dptype char(1) null
go

alter table dprog 
   add webtitle varchar(50) null
go


alter table stu_evalgrp 
   add certify char(1) not null default ' '
go


alter table stu_exceptions
   alter column reqhrs numeric(5,2)
go


alter table stu_exceptions
   alter column maxhrs numeric(5,2)
go


alter table stu_exceptions
   alter column reqsrq numeric(3)
go


alter table stu_exceptions
   alter column maxct numeric(3)
go


alter table stu_exceptions
   alter column val numeric(3)
go


alter table stu_exceptions
   alter column reqgpa numeric(5,3)
go

alter table stu_exceptions
   alter column auth_date char(12)
go

alter table stu_master 
   add nodflt char(1) null
go


alter table stu_master 
   add pin varchar(20) null
go


alter table tca_rule
   add private_note varchar(255) null
go

alter table tca_target 
   add tastatus char(1) null
go

alter table job_queue_run
  add complete char(1) null
go

alter table job_queue_run
  add ip char(1) null
go

alter table secure_inst
  add update_pin char(1) null
go

update sub_req_ar
	set tflg = 'C', matchctl = ' '
	where matchctl = 'C'
go


/*  insert trigger "ti_com" for table "com"  */
alter trigger ti_com on com for insert as
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
    update com
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from com t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.comkey = i.comkey and
          t.comfield = i.comfield and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_com" for table "com"  */
alter trigger tu_com on com for update as
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
    update com
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from com t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.comkey = i.comkey and
          t.comfield = i.comfield and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_crs_convert" for table "crs_convert"  */
alter trigger ti_crs_convert on crs_convert for insert as
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
    update crs_convert
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from crs_convert t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_crs_convert" for table "crs_convert"  */
alter trigger tu_crs_convert on crs_convert for update as
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
    update crs_convert
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from crs_convert t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_dprog" for table "dprog"  */
alter trigger ti_dprog on dprog for insert as
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
    update dprog
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.dprog = i.dprog and
          t.dpfyt = i.dpfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_dprog" for table "dprog"  */
alter trigger tu_dprog on dprog for update as
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
    update dprog
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.dprog = i.dprog and
          t.dpfyt = i.dpfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_dprog_req" for table "dprog_req"  */
alter trigger ti_dprog_req on dprog_req for insert as
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
    update dprog_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_dprog_req" for table "dprog_req"  */
alter trigger tu_dprog_req on dprog_req for update as
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
    update dprog_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from dprog_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_gmaster" for table "gmaster"  */
alter trigger ti_gmaster on gmaster for insert as
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
    update gmaster
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from gmaster t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_gmaster" for table "gmaster"  */
alter trigger tu_gmaster on gmaster for update as
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
    update gmaster
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from gmaster t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_job_queue_list" for table "job_queue_list"  */
alter trigger ti_job_queue_list on job_queue_list for insert as
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
    update job_queue_list
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from job_queue_list t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.jobid = i.jobid and
          t.userid = i.userid and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_job_queue_list" for table "job_queue_list"  */
alter trigger tu_job_queue_list on job_queue_list for update as
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
    update job_queue_list
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from job_queue_list t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.jobid = i.jobid and
          t.userid = i.userid and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_mastref" for table "mastref"  */
alter trigger ti_mastref on mastref for insert as
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
    update mastref
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.mrfyt = i.mrfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_mastref" for table "mastref"  */
alter trigger tu_mastref on mastref for update as
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
    update mastref
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.mrfyt = i.mrfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_mastref_address" for table "mastref_address"  */
alter trigger ti_mastref_address on mastref_address for insert as
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
    update mastref_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_address t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_mastref_address" for table "mastref_address"  */
alter trigger tu_mastref_address on mastref_address for update as
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
    update mastref_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_address t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_mastref_seg" for table "mastref_seg"  */
alter trigger ti_mastref_seg on mastref_seg for insert as
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
    update mastref_seg
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_seg t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_mastref_seg" for table "mastref_seg"  */
alter trigger tu_mastref_seg on mastref_seg for update as
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
    update mastref_seg
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from mastref_seg t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_repeat" for table "repeat"  */
alter trigger ti_repeat on repeat for insert as
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
    update repeat
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from repeat t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_repeat" for table "repeat"  */
alter trigger tu_repeat on repeat for update as
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
    update repeat
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from repeat t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_req_main" for table "req_main"  */
alter trigger ti_req_main on req_main for insert as
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
    update req_main
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_main t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.rname = i.rname and
          t.rqfyt = i.rqfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_req_main" for table "req_main"  */
alter trigger tu_req_main on req_main for update as
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
    update req_main
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_main t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.rname = i.rname and
          t.rqfyt = i.rqfyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_req_text" for table "req_text"  */
alter trigger ti_req_text on req_text for insert as
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
    update req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_req_text" for table "req_text"  */
alter trigger tu_req_text on req_text for update as
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
    update req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_req_xy" for table "req_xy"  */
alter trigger ti_req_xy on req_xy for insert as
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
    update req_xy
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_xy t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_req_xy" for table "req_xy"  */
alter trigger tu_req_xy on req_xy for update as
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
    update req_xy
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from req_xy t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_string" for table "string"  */
alter trigger ti_string on string for insert as
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
    update string
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_string" for table "string"  */
alter trigger tu_string on string for update as
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
    update string
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_string_crse" for table "string_crse"  */
alter trigger ti_string_crse on string_crse for insert as
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
    update string_crse
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string_crse t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_string_crse" for table "string_crse"  */
alter trigger tu_string_crse on string_crse for update as
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
    update string_crse
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from string_crse t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_acadrec" for table "stu_acadrec"  */
alter trigger ti_stu_acadrec on stu_acadrec for insert as
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
    update stu_acadrec
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_acadrec t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.cdpmask = i.cdpmask and
          t.crs_yt = i.crs_yt and
          t.crs_num = i.crs_num and
          t.crs_seq = i.crs_seq and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_acadrec" for table "stu_acadrec"  */
alter trigger tu_stu_acadrec on stu_acadrec for update as
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
    update stu_acadrec
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_acadrec t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.cdpmask = i.cdpmask and
          t.crs_yt = i.crs_yt and
          t.crs_num = i.crs_num and
          t.crs_seq = i.crs_seq and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_address" for table "stu_address"  */
alter trigger ti_stu_address on stu_address for insert as
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
    update stu_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_address t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_address" for table "stu_address"  */
alter trigger tu_stu_address on stu_address for update as
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
    update stu_address
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_address t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_demo" for table "stu_demo"  */
alter trigger ti_stu_demo on stu_demo for insert as
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
    update stu_demo
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_demo t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.source_id = i.source_id and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_studemo" for table "stu_demo"  */
alter trigger tu_studemo on stu_demo for update as
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
    update stu_demo
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_demo t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.source_id = i.source_id and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_dprog" for table "stu_dprog"  */
alter trigger ti_stu_dprog on stu_dprog for insert as
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
    update stu_dprog
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_dprog t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.instcd = i.instcd and
          t.dprog = i.dprog and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_dprog" for table "stu_dprog"  */
alter trigger tu_stu_dprog on stu_dprog for update as
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
    update stu_dprog
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_dprog t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.instcd = i.instcd and
          t.dprog = i.dprog and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_evalgrp" for table "stu_evalgrp"  */
alter trigger ti_stu_evalgrp on stu_evalgrp for insert as
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
    update stu_evalgrp
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_evalgrp t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.evalgrp = i.evalgrp and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_eval_seg" for table "stu_evalgrp"  */
alter trigger tu_stu_eval_seg on stu_evalgrp for update as
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
    update stu_evalgrp
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_evalgrp t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.evalgrp = i.evalgrp and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_exc_courses" for table "stu_exc_courses"  */
alter trigger ti_stu_exc_courses on stu_exc_courses for insert as
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
    update stu_exc_courses
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_exc_courses t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_exc_courses" for table "stu_exc_courses"  */
alter trigger tu_stu_exc_courses on stu_exc_courses for update as
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
    update stu_exc_courses
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_exc_courses t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_exceptions" for table "stu_exceptions"  */
alter trigger ti_stu_exceptions on stu_exceptions for insert as
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
    update stu_exceptions
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_exceptions t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_exceptions" for table "stu_exceptions"  */
alter trigger tu_stu_exceptions on stu_exceptions for update as
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
    update stu_exceptions
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_exceptions t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_marker_req" for table "stu_marker_req"  */
alter trigger ti_stu_marker_req on stu_marker_req for insert as
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
    update stu_marker_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_marker_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_marker_req" for table "stu_marker_req"  */
alter trigger tu_stu_marker_req on stu_marker_req for update as
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
    update stu_marker_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_marker_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_student_information" for table "stu_master"  */
alter trigger ti_student_information on stu_master for insert as
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
    update stu_master
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_master t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_student_information" for table "stu_master"  */
alter trigger tu_student_information on stu_master for update as
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
    update stu_master
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_master t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_stu_trans_degree" for table "stu_trans_degree"  */
alter trigger ti_stu_trans_degree on stu_trans_degree for insert as
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
    update stu_trans_degree
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_trans_degree t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.user_seq_no = i.user_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_stu_transfer_degree" for table "stu_trans_degree"  */
alter trigger tu_stu_transfer_degree on stu_trans_degree for update as
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
    update stu_trans_degree
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from stu_trans_degree t, inserted i
    where t.stu_mast_no = i.stu_mast_no and
          t.user_seq_no = i.user_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_sub_req" for table "sub_req"  */
alter trigger ti_sub_req on sub_req for insert as
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
    update sub_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_sub_req" for table "sub_req"  */
alter trigger tu_sub_req on sub_req for update as
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
    update sub_req
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_sub_req_ar" for table "sub_req_ar"  */
alter trigger ti_sub_req_ar on sub_req_ar for insert as
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
    update sub_req_ar
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_ar t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_sub_req_ar" for table "sub_req_ar"  */
alter trigger tu_sub_req_ar on sub_req_ar for update as
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
    update sub_req_ar
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_ar t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_sub_req_text" for table "sub_req_text"  */
alter trigger ti_sub_req_text on sub_req_text for insert as
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
    update sub_req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_sub_req_text" for table "sub_req_text"  */
alter trigger tu_sub_req_text on sub_req_text for update as
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
    update sub_req_text
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from sub_req_text t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_tca_master" for table "tca_master"  */
alter trigger ti_tca_master on tca_master for insert as
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
    update tca_master
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_master t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.dpmask = i.dpmask and
          t.fyt = i.fyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_tca_master" for table "tca_master"  */
alter trigger tu_tca_master on tca_master for update as
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
    update tca_master
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_master t, inserted i
    where t.instidq = i.instidq and
          t.instid = i.instid and
          t.instcd = i.instcd and
          t.source_id = i.source_id and
          t.source_cd = i.source_cd and
          t.dpmask = i.dpmask and
          t.fyt = i.fyt and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_tca_rule" for table "tca_rule"  */
alter trigger ti_tca_rule on tca_rule for insert as
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
    update tca_rule
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_rule t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_tca_rule" for table "tca_rule"  */
alter trigger tu_tca_rule on tca_rule for update as
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
    update tca_rule
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_rule t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_tca_source" for table "tca_source"  */
alter trigger ti_tca_source on tca_source for insert as
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
    update tca_source
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_source t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_tca_source" for table "tca_source"  */
alter trigger tu_tca_source on tca_source for update as
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
    update tca_source
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_source t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  insert trigger "ti_tca_target" for table "tca_target"  */
alter trigger ti_tca_target on tca_target for insert as
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
    update tca_target
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_target t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

/*  update trigger "tu_tca_target" for table "tca_target"  */
alter trigger tu_tca_target on tca_target for update as
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
    update tca_target
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_target t, inserted i
    where t.int_seq_no = i.int_seq_no and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)


      return

/*  errors handling  */
error:
    raiserror @errno @errmsg
    rollback  transaction
end
go

