/*==============================================================*/
/* Release:        u.achieve 4.3                                */
/* DBMS name:      Microsoft SQL Server 2005/2008/2012          */
/* Created on:     05/08/2015                                   */
/*                                                              */
/*                 Database Modification Script to update       */
/*                 u.achieve 4.2.x to u.achieve 4.3.0           */
/*                                                              */
/* Highlights:     4.3.0.3                                      */
/*                 * moved delete of invalid job_queue_out data */
/*                   so that it occurs before job_queue_out     */
/*                   indexes are dropped and rebuilt            */
/*                                                              */
/*                 4.3.0                                        */   
/*                 * new tables to aid in transfer rule editing */
/*                   transfer_inst, tca_segment                 */
/*                 * increase string table limct to 3 digits    */
/*                 * update job_queue tables to identify        */
/*                   u.achieve server host                      */
/*                 * increase int_seq_no from 9 digits to 18 in */
/*                   job_queue tables                           */
/*                 * redefined primary key in some job_queue    */
/*                   tables                                     */
/*                                                              */
/*  Copyright(c) 2015 CollegeSource, Inc. All Rights Reserved.  */
/*==============================================================*/

/*==============================================================*/
/* Create new transfer institution table (transfer_inst)        */
/*==============================================================*/

-- drop the transfer_inst table if it exists already.
-- we'll recreate it and populate it from tca_rule below

if exists (select 1 from sys.tables where name = 'transfer_inst')
	begin
		drop table transfer_inst
	end
go


-- the 'if not exists' test is overkill, since we just deleted the table above,
-- but i'm leaving it here anyway because it works, and the original script
-- didn't delete the table first if it already existed.

if not exists (select 1 from sys.tables where name = 'transfer_inst')
    begin

        create table transfer_inst (
            instidq            char(2)                        default ' ' not null,
            instid             char(8)                        default ' ' not null,
            instcd             char(3)                        default ' ' not null,
            source_id          char(8)                        default ' ' not null,
            inst_name          varchar(60),
            ipeds              varchar(20),
            opeid              varchar(20),
            fice               varchar(20),
            atp                varchar(20),
            act                varchar(20),
            last_mod_user      varchar(30),
            last_mod_date      datetime,
            constraint PK_TRANSFER_INST primary key (instidq, instid, instcd, source_id)
        )

    end
go

if exists (select 1 from sys.triggers where name = 'ti_transfer_inst')
    begin
        drop trigger ti_transfer_inst
    end
go

/*  insert trigger "ti_transfer_inst" for table "transfer_inst"  */
create trigger ti_transfer_inst on transfer_inst for insert as
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
    update transfer_inst
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from transfer_inst t, inserted i
    where   t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

if exists (select 1 from sys.triggers where name = 'tu_transfer_inst')
    begin
        drop trigger tu_transfer_inst
    end
go

/*  update trigger "tu_transfer_inst" for table "transfer_inst"  */
create trigger tu_transfer_inst on transfer_inst for update as
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
    update transfer_inst
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from transfer_inst t, inserted i
    where t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id

      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go


-- populate transfer_inst from master reference table data (as long as no rows exist in transfer_inst)

if (select count(*) from transfer_inst) = 0
    begin
        insert into TRANSFER_INST (INSTIDQ, INSTID, INSTCD, SOURCE_ID, INST_NAME)
            select instidq, instid, instcd, source_id, min(iname)
            from MASTREF
            group by instidq, instid, instcd, SOURCE_ID
    end
go

select 'Rows contained in transfer_inst:', count(*) from transfer_inst
go

/*==============================================================*/
/* Create new transfer rule segment table (tca_segment)         */
/*==============================================================*/

-- drop the tca_segment table if it exists already.
-- we'll recreate it and populate it from tca_rule below

if exists (select 1 from sys.tables where name = 'tca_segment')
	begin
		drop table tca_segment
	end
go

-- the 'if not exists' test is overkill, since we just deleted the table above,
-- but i'm leaving it here anyway because it works, and the original script
-- didn't delete the table first if it already existed.

if not exists (select 1 from sys.tables where name = 'tca_segment')
    begin

        create table tca_segment (
            int_seq_no         numeric(9)           identity(1, 1),
            instidq            char(2)                        default ' ' not null,
            instid             char(8)                        default ' ' not null,
            instcd             char(3)                        default ' ' not null,
            source_id          char(8)                        default ' ' not null,
            source_cd          char(3)                        default ' ' not null,
            dpmask             char(15)                       default ' ' not null,
            fyt                char(6)                        default '0000' not null,
            tseg               char(7)                        default ' ' not null,
            hint               varchar(25),
            description        varchar(255),
            last_mod_user      varchar(30),
            last_mod_date      datetime,
            constraint PK_TCA_SEGMENT primary key (int_seq_no)
        )
    end
go

/* ==== Index:  tca_segment_idx                                       */
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
go

/*  insert trigger "ti_tca_segment" for table "tca_segment"  */
if exists (select 1 from sys.triggers where name = 'ti_tca_segment')
    begin
        drop trigger ti_tca_segment
    end
go

create trigger ti_tca_segment on tca_segment for insert as
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
    update tca_segment
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_segment t, inserted i
    where t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id and
            t.source_cd = i.source_cd and
            t.dpmask = i.dpmask and
            t.fyt = i.fyt and
            t.tseg = i.tseg and
          (i.last_mod_user IS NULL OR
          i.last_mod_date IS NULL)

    return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

if exists (select 1 from sys.triggers where name = 'tu_tca_segment')
    begin
        drop trigger tu_tca_segment
    end
go

/*  update trigger "tu_tca_segment" for table "tca_segment"  */
create trigger tu_tca_segment on tca_segment for update as
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
    update tca_segment
    set last_mod_user = user_name(),
        last_mod_date = getdate()
    from tca_segment t, inserted i
    where t.instidq = i.instidq and
            t.instid = i.instid and
            t.instcd = i.instcd and
            t.source_id = i.source_id and
            t.source_cd = i.source_cd and
            t.dpmask = i.dpmask and
            t.fyt = i.fyt and
            t.tseg = i.tseg

      return

/*  errors handling  */
error:
    raiserror(@errmsg, 1, 1)
    rollback  transaction
end
go

-- populate tca_segment from tca_rule data (as long as no rows exist in tca_segment)

if (select count(*) from tca_segment) = 0
    begin
        insert into tca_segment (INSTIDQ, INSTID, INSTCD, SOURCE_ID, source_cd, dpmask, fyt, tseg)
            select distinct instidq, instid, instcd, source_id, source_cd, dpmask, fyt, tseg
            from tca_rule
    end
go

select 'Rows contained in tca_segment:', count(*) from tca_segment
go

/*===============================================================*/
/* Modify String Table to handle Limit Count (limct) values > 99 */
/*===============================================================*/

-- string table
alter table string alter column 
	limct	numeric(3)
go

select count(*) as "Expected LimCt updates" from string where limct = 99
go

update string
set limct = 999 
where limct = 99
go

select count(*) as "Expected LimHrs updates" from string where limhrs = 99.9
go

update string
set limhrs = 999.9
where limhrs = 99.9
go

/*=================================================================*/
/* Updating job_queue tables to:                                   */
/*    * Handle identity values > 9 digits.                         */
/*    * redefine primary key when columns other than int_seq_no    */
/*      can be used.                                               */
/*    * Identifying host server processing each audit request.     */
/*=================================================================*/

--  *************************************
--  *************************************
--    Modify Job_Queue REQUEST Tables
--  *************************************
--  *************************************

--  No foreign key changes required for request tables

--  ****************************************************************************
--  ALTER JOB_QUEUE_LIST
--  ****************************************************************************

--  add new columns to job_queue_list
if not exists (select 1 from sys.columns where name = 'host_name' and object_id = (object_id('job_queue_list')))
begin
alter table job_queue_list add 
	host_name 		varchar(255) null, 
	host_ip			varchar(255) null,
	uach_dir		varchar(255) null 
end
go

--  ****************************************************************************
--	ALTER JOB_QUEUE_DETAIL
--  ****************************************************************************

--  redefining primary key column, so drop the current
if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_DETAIL' and type = 'PK')
begin
    alter table job_queue_detail
    drop constraint PK_JOB_QUEUE_DETAIL
end
go

alter table job_queue_detail alter column 
	int_seq_no	numeric(18) 	not null
go

alter table job_queue_detail
    add constraint PK_JOB_QUEUE_DETAIL primary key (int_seq_no)
go

--  ****************************************************************************
--	ALTER JOB_QUEUE_SYSIN
--  ****************************************************************************
if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_SYSIN' and type = 'PK')
begin
    alter table job_queue_sysin
    drop constraint PK_JOB_QUEUE_SYSIN
end
go

alter table job_queue_sysin alter column 
	int_seq_no	numeric(18) 	not null
go

alter table job_queue_sysin
    add constraint PK_JOB_QUEUE_SYSIN primary key (int_seq_no)
go

-- *************************************
-- *************************************
--    Modify Job_Queue OUTPUT Tables
-- *************************************
-- *************************************


--  Drop Affected Foreign Keys
if exists (select 1 from sys.foreign_keys where name = 'FK_job_queue_accept_job_queue_subreq' and type = 'F')
begin
    alter table job_queue_accept
    drop constraint FK_job_queue_accept_job_queue_subreq
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_job_queue_course_job_queue_subreq' and type = 'F')
begin
    alter table job_queue_course
    drop constraint FK_job_queue_course_job_queue_subreq
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JQEXC_REF_JQRUN' and type = 'F')
begin
    alter table job_queue_exceptions
    drop constraint FK_JQEXC_REF_JQRUN
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JQINCL_REF_JQRUN' and type = 'F')
begin
    alter table job_queue_incl_text
    drop constraint FK_JQINCL_REF_JQRUN
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JQMRK_REF_JQRUN' and type = 'F')
begin
    alter table job_queue_markers
    drop constraint FK_JQMRK_REF_JQRUN
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JOBQ_OUT_REF_JOBQ_RUN' and type = 'F')
begin
    alter table job_queue_out
    drop constraint FK_JOBQ_OUT_REF_JOBQ_RUN
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JQREP_REF_JQRUN' and type = 'F')
begin
    alter table job_queue_report
    drop constraint FK_JQREP_REF_JQRUN
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_job_queue_req_job_queue_run' and type = 'F')
begin
    alter table job_queue_req
    drop constraint FK_job_queue_req_job_queue_run
end
go

--	UACH-4471	04/21/16	Added the following FK to drop (alternate name used in early versions)
if exists (select 1 from sys.foreign_keys where name = 'FK_jobq_req_ref_jobq_run' and type = 'F')
begin
    alter table job_queue_req
    drop constraint FK_job_queue_req_job_queue_run
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JQRTXT_REF_JQREQ' and type = 'F')
begin
    alter table job_queue_req_text
    drop constraint FK_JQRTXT_REF_JQREQ
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JOBQ_SUBREQ_REF_JOBQ_REQ' and type = 'F')
begin
    alter table job_queue_subreq
    drop constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ
end
go

if exists (select 1 from sys.foreign_keys where name = 'FK_JQSRTXT_REF_JQREQ' and type = 'F')
begin
    alter table job_queue_subreq_text
    drop constraint FK_JQSRTXT_REF_JQREQ
end
go

--  ****************************************************************************
--	ALTER JOB_QUEUE_RUN
--  ****************************************************************************
if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_RUN' and type = 'PK')
begin
    alter table job_queue_run
    drop constraint PK_JOB_QUEUE_RUN
end
go

if not exists (select 1 from sys.columns where name = 'host_name' and object_id = (object_id('job_queue_run')))
begin
alter table job_queue_run add 
	dprog_type		char(1)	null,
	wifip_message	varchar(255) null,
	incltop_text	varchar(4000) null,  
	host_name 		varchar(255) null, 
	host_ip			varchar(255) null,
	uach_dir		varchar(255) null,
	comkey			char(5) null,
	evalsw			char(1) null,
	elapsed_ms	    numeric(18) null
end
go

alter table job_queue_run alter column int_seq_no		numeric(18) 	not null 
go
alter table job_queue_run alter column detail_seq_no	numeric(18)     null
go

alter table job_queue_run
    add constraint PK_JOB_QUEUE_RUN primary key (int_seq_no)
go

--  ****************************************************************************
--	ALTER JOB_QUEUE_REQ
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_REQ' and type = 'PK')
begin
    alter table job_queue_req
    drop constraint PK_JOB_QUEUE_REQ
end
go

if exists (select 1 from sys.indexes where name = 'JOBQ_REQ_IDX')
begin
    drop index JOBQ_REQ_IDX on job_queue_req
end
go

-- add fyt, catlyt
if not exists (select 1 from sys.columns where name = 'fyt' and object_id = (object_id('job_queue_req')))
begin
alter table job_queue_req add 
	fyt 		char(6) null, 
	catlyt	 	char(6) null 
end
go

alter table job_queue_req alter column 
	jobq_seq_no	numeric(18) 	not null
go

-- no change to primary key and index, but had to rebuild b/c of change to jobq_seq_no
alter table job_queue_req
    add constraint PK_JOB_QUEUE_REQ primary key (jobq_seq_no, rtabx)
go

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

--  ****************************************************************************
--	ALTER JOB_QUEUE_REQ_TEXT
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_J_Q_REQ_TEXT' and type = 'PK')
begin
    alter table job_queue_req_text
    drop constraint PK_J_Q_REQ_TEXT
end
go

if exists (select 1 from sys.indexes where name = 'JQ_REQ_TEXT_IDX')
begin
    drop index JQ_REQ_TEXT_IDX on job_queue_req_text
end
go

alter table job_queue_req_text alter column 
	jobq_seq_no	numeric(18) 	not null
go

-- no change to primary key and index, but had to rebuild b/c of change to jobq_seq_no
alter table job_queue_req_text
    add constraint PK_J_Q_REQ_TEXT primary key (jobq_seq_no, text_type, rtabx)
go

create index jq_req_text_idx on job_queue_req_text (
    jobq_seq_no ASC,
    rtabx ASC
)
go

--  ****************************************************************************
--	ALTER JOB_QUEUE_SUBREQ
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_SUBREQ' and type = 'PK')
begin
    alter table job_queue_subreq
    drop constraint PK_JOB_QUEUE_SUBREQ
end
go

-- this index was created in the 4.0 update scripts.
-- won't need to recreate this index - it's the same as the primary key
if exists (select 1 from sys.indexes where name = 'JOBQ_SUBREQ_IDX')
begin
    drop index JOBQ_SUBREQ_IDX on job_queue_subreq
end
go

alter table job_queue_subreq alter column 
	jobq_seq_no	numeric(18) 	not null
go

-- no change to primary key, but had to rebuild b/c of change to jobq_seq_no
alter table job_queue_subreq
    add constraint PK_JOB_QUEUE_SUBREQ primary key (jobq_seq_no, rtabx, stabx)
go

--  ****************************************************************************
--	ALTER JOB_QUEUE_SUBREQ_TEXT
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_J_Q_SUBREQ_TEXT' and type = 'PK')
begin
    alter table job_queue_subreq_text
    drop constraint PK_J_Q_SUBREQ_TEXT
end
go

if exists (select 1 from sys.indexes where name = 'JQ_SUBREQ_TEXT_IDX')
begin
    drop index JQ_SUBREQ_TEXT_IDX on job_queue_subreq_text
end
go

alter table job_queue_subreq_text alter column 
	jobq_seq_no	numeric(18) 	not null
go

-- no change to primary key, but had to rebuild b/c of change to jobq_seq_no
alter table job_queue_subreq_text
    add constraint PK_J_Q_SUBREQ_TEXT primary key (jobq_seq_no, text_type, rtabx, stabx)
go

create index jq_subreq_text_idx on job_queue_subreq_text (
    jobq_seq_no ASC,
    rtabx ASC,
    stabx ASC
)
go

--  ****************************************************************************
--  ALTER JOB_QUEUE_COURSE 
--  ****************************************************************************

-- drop primary key so we can update data type of primary key columns
if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_COURSE' and type = 'PK')
begin
    alter table job_queue_course
    drop constraint PK_JOB_QUEUE_COURSE
end
go

-- drop index  so we can update data type of columns
if exists (select 1 from sys.indexes where name = 'JOBQ_COURSE_IDX' and object_id = OBJECT_ID('JOB_QUEUE_COURSE'))
begin
    drop index JOBQ_COURSE_IDX on JOB_QUEUE_COURSE
end
go

-- Job_queue_course

if not exists (select 1 from sys.columns where name = 'evalflg' and object_id = (object_id('job_queue_course')))
begin
alter table job_queue_course add 
	evalflg 		char(1) null, 
	source_id		varchar(20) null,
	source_cd		varchar(10) null
end	
go


-- increase precision of int_seq_no and jobq_seq_no
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQCOURSE_INT_SEQ_NO')
begin
    alter table job_queue_course drop DFLT_JQCOURSE_INT_SEQ_NO
end
go
alter table job_queue_course alter column int_seq_no	numeric(18)		not null
go

alter table job_queue_course alter column jobq_seq_no	numeric(18) 	not null
go

-- change user_seq_no from accepting null values to not null, and set default value
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQCOURSE_USER_SEQ_NO')
begin
    alter table job_queue_course drop DFLT_JQCOURSE_USER_SEQ_NO
end
go

alter table job_queue_course alter column user_seq_no	numeric(18)		not null
go

alter table job_queue_course add constraint DFLT_JQCOURSE_USER_SEQ_NO default 0 for user_seq_no
go

-- recreate primary key
alter table job_queue_course 
    add constraint PK_JOB_QUEUE_COURSE primary key(jobq_seq_no, rtabx, stabx, user_seq_no)
go

--  ****************************************************************************
--  ALTER JOB_QUEUE_ACCEPT
--  ****************************************************************************

-- drop primary key so we can update data type of primary key columns
if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_ACCEPT' and type = 'PK')
begin
    alter table job_queue_accept
    drop constraint PK_JOB_QUEUE_ACCEPT
end
go

-- won't need to recreate this index - it's the same as the new primary key
if exists (select 1 from sys.indexes where name = 'JOBQ_ACCEPT_IDX')
begin
    drop index JOBQ_ACCEPT_IDX on job_queue_accept
end
go

-- increase precision of int_seq_no and jobq_seq_no
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQACCEPT_INT_SEQ_NO')
begin
    alter table job_queue_accept drop DFLT_JQACCEPT_INT_SEQ_NO
end
go
alter table job_queue_accept alter column int_seq_no	numeric(18)     not null
go

alter table job_queue_accept alter column jobq_seq_no	numeric(18) 	not null
go

-- change user_seq_no from accepting null values to not null, and set default value
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQACCEPT_USER_SEQ_NO')
begin
    alter table job_queue_accept drop DFLT_JQACCEPT_USER_SEQ_NO
end
go
alter table job_queue_accept alter column user_seq_no	numeric(18) 	not null
go
alter table job_queue_accept add constraint DFLT_JQACCEPT_USER_SEQ_NO default 0 for user_seq_no
go

--  recreate primary key
alter table job_queue_accept 
    add constraint PK_JOB_QUEUE_ACCEPT primary key(jobq_seq_no, rtabx, stabx, user_seq_no)
go

--  ****************************************************************************
--  ALTER JOB_QUEUE_OUT
--  ****************************************************************************

--  remove invalid data from job_queue_out

--  DARwin would save audits with a fatal COBOL error using the same value of '0'
-- in user_seq_no for all rows of the audit.  These must be removed so the 
-- new primary key can be created correctly.  (u.achieve audits do not have this problem)

delete from job_queue_out
where user_seq_no = 0 and lasera > '1'

-- drop primary key so we can update data type of primary key columns
if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_OUT' and type = 'PK')
begin
    alter table job_queue_out
    drop constraint PK_JOB_QUEUE_OUT
end
go

-- won't need to recreate this index - it's the same as the new primary key
if exists (select 1 from sys.indexes where name = 'JOBQ_OUT_IDX')
begin
    drop index JOBQ_OUT_IDX on job_queue_out
end
go

-- increase precision of int_seq_no and jobq_seq_no
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQOUT_INT_SEQ_NO')
begin
    alter table job_queue_out drop DFLT_JQOUT_INT_SEQ_NO
end
go
alter table job_queue_out alter column int_seq_no	numeric(18)		not null
go

alter table job_queue_out alter column jobq_seq_no	numeric(18) 	not null
go

-- change user_seq_no from accepting null values to not null, and set default value
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQOUT_USER_SEQ_NO')
begin
    alter table job_queue_out drop DFLT_JQOUT_USER_SEQ_NO
end
go
alter table job_queue_out alter column user_seq_no	numeric(18) 	not null
go
alter table job_queue_out add constraint DFLT_JQOUT_USER_SEQ_NO default 0 for user_seq_no
go

-- recreate primary key with the new definition
alter table job_queue_out 
    add constraint PK_JOB_QUEUE_OUT primary key(jobq_seq_no, user_seq_no)
go

--  ****************************************************************************
--  ALTER JOB_QUEUE_REPORT
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_J_Q_REPORT' and type = 'PK')
begin
    alter table job_queue_report
    drop constraint PK_J_Q_REPORT
end
go

-- won't need to recreate this index - it's the same as the new primary key
if exists (select 1 from sys.indexes where name = 'JOBQ_REPORT_IDX')
begin
    drop index JOBQ_REPORT_IDX on job_queue_report
end
go

if exists (select 1 from sys.default_constraints where name = 'DFLT_JQREPORT_INT_SEQ_NO')
begin
    alter table job_queue_report drop DFLT_JQREPORT_INT_SEQ_NO
end
go
alter table job_queue_report alter column int_seq_no	numeric(18)		not null
go

alter table job_queue_report alter column jobq_seq_no	numeric(18) 	not null
go

if exists (select 1 from sys.default_constraints where name = 'DFLT_JQREPORT_REPORT_TYPE')
begin
    alter table job_queue_report drop DFLT_JQREPORT_REPORT_TYPE
end
go
alter table job_queue_report alter column report_type	varchar(10) 	not null
go
alter table job_queue_report add constraint DFLT_JQREPORT_REPORT_TYPE default ' ' for report_type
go


alter table job_queue_report 
    add constraint PK_J_Q_REPORT primary key(jobq_seq_no, report_type)
go	

--  ****************************************************************************
--  ALTER JOB_QUEUE_MARKERS
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_J_Q_MARKER' and type = 'PK')
begin
    alter table job_queue_markers
    drop constraint PK_J_Q_MARKER
end
go

-- won't need to recreate this index - it's the same as the new primary key
if exists (select 1 from sys.indexes where name = 'JOBQ_MARKERS_IDX')
begin
    drop index JOBQ_MARKERS_IDX on job_queue_markers
end
go

if exists (select 1 from sys.default_constraints where name = 'DFLT_JQMARKERS_INT_SEQ_NO')
begin
    alter table job_queue_markers drop DFLT_JQMARKERS_INT_SEQ_NO
end
go
alter table job_queue_markers alter column int_seq_no	numeric(18)		not null
go

alter table job_queue_markers alter column jobq_seq_no	numeric(18) 	not null
go
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQMARKERS_JOBQ_SEQ_NO')
begin
    alter table job_queue_markers drop DFLT_JQMARKERS_JOBQ_SEQ_NO
end
go
alter table job_queue_markers add constraint DFLT_JQMARKERS_JOBQ_SEQ_NO default 0 for jobq_seq_no
go

if exists (select 1 from sys.default_constraints where name = 'DFLT_JQMARKERS_USER_SEQ_NO')
begin
    alter table job_queue_markers drop DFLT_JQMARKERS_USER_SEQ_NO
end
go
alter table job_queue_markers alter column user_seq_no	numeric(18) 	not null
go
alter table job_queue_markers add constraint DFLT_JQMARKERS_USER_SEQ_NO default 0 for user_seq_no
go


alter table job_queue_markers add constraint PK_J_Q_MARKER primary key(jobq_seq_no, user_seq_no)
go

--  ****************************************************************************
--  ALTER JOB_QUEUE_EXCEPTIONS
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_J_Q_EXCEPTION' and type = 'PK')
begin
    alter table job_queue_exceptions
    drop constraint PK_J_Q_EXCEPTION
end
go

-- won't need to recreate this index - it's the same as the new primary key
if exists (select 1 from sys.indexes where name = 'JOBQ_EXCEPTIONS_IDX')
begin
    drop index JOBQ_EXCEPTIONS_IDX on job_queue_exceptions
end
go

-- remove abandoned exception output data
-- THIS DELETE DOES NOT AFFECT STUDENT RECORDS IN ANY WAY,
-- NOR DOES THE DELETE AFFECT SAVED AUDITS.
-- The delete only removes exceptions that are in the job_queue_exception
-- table that are orphaned and no longer associated with an audit report.

delete from job_queue_exceptions
    where   jobq_seq_no is null
    or      user_seq_no is null
go    

-- update int_seq_no
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQEXCEPTIONS_INT_SEQ_NO')
begin
    alter table job_queue_exceptions drop DFLT_JQEXCEPTIONS_INT_SEQ_NO
end
go
alter table job_queue_exceptions alter column int_seq_no	numeric(18)		not null
go

-- update jobq_seq_no
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQEXCEPTIONS_JOBQ_SEQ_NO')
begin
    alter table job_queue_EXCEPTIONS drop DFLT_JQEXCEPTIONS_JOBQ_SEQ_NO
end
go
alter table job_queue_exceptions alter column jobq_seq_no	numeric(18) 	not null
go
alter table job_queue_EXCEPTIONS add constraint DFLT_JQEXCEPTIONS_JOBQ_SEQ_NO default 0 for jobq_seq_no
go

-- update user_seq_no
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQEXCEPTIONS_USER_SEQ_NO')
begin
    alter table job_queue_exceptions drop DFLT_JQEXCEPTIONS_USER_SEQ_NO
end
go
alter table job_queue_exceptions alter column user_seq_no	numeric(18) 	not null
go
alter table job_queue_EXCEPTIONS add constraint DFLT_JQEXCEPTIONS_USER_SEQ_NO default 0 for user_seq_no
go

alter table job_queue_exceptions add constraint PK_J_Q_EXCEPTION primary key(jobq_seq_no, user_seq_no)
go

--  ****************************************************************************
--  ALTER JOB_QUEUE_INCL_TEXT
--  ****************************************************************************

if exists (select 1 from sys.key_constraints where name = 'PK_JOB_QUEUE_INCL_TEXT' and type = 'PK')
begin
    alter table job_queue_incl_text
    drop constraint PK_JOB_QUEUE_INCL_TEXT
end
go

-- won't need to recreate this index - it's the same as the new primary key
if exists (select 1 from sys.indexes where name = 'JOBQ_INCL_TEXT_IDX')
begin
    drop index JOBQ_INCL_TEXT_IDX on job_queue_incl_text
end
go

-- remove abandoned incl_text output data
-- THIS DELETE DOES NOT AFFECT STUDENT RECORDS IN ANY WAY,
-- NOR DOES THE DELETE AFFECT SAVED AUDITS.
-- The delete only removes text that is in the job_queue_incl_text
-- table that is orphaned and no longer associated with an audit report.

delete from job_queue_incl_text
    where   jobq_seq_no is null
go


if exists (select 1 from sys.default_constraints where name = 'DFLT_JQINCLTEXT_INT_SEQ_NO')
begin
    alter table job_queue_incl_text drop DFLT_JQINCLTEXT_INT_SEQ_NO
end
go
alter table job_queue_incl_text alter column int_seq_no	numeric(18)		not null
go

alter table job_queue_incl_text alter column jobq_seq_no	numeric(18) 	not null
go
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQINCLTEXT_JOBQ_SEQ_NO')
begin
    alter table job_queue_incl_text drop DFLT_JQINCLTEXT_JOBQ_SEQ_NO
end
go
alter table job_queue_incl_text add constraint DFLT_JQINCLTEXT_JOBQ_SEQ_NO default 0 for jobq_seq_no
go

alter table job_queue_incl_text alter column text_type	char(1) 	not null
go
if exists (select 1 from sys.default_constraints where name = 'DFLT_JQINCLTEXT_TEXT_TYPE')
begin
    alter table job_queue_incl_text drop DFLT_JQINCLTEXT_TEXT_TYPE
end
go
alter table job_queue_incl_text add constraint DFLT_JQINCLTEXT_TEXT_TYPE default ' ' for text_type
go


alter table job_queue_incl_text 
    add constraint PK_JOB_QUEUE_INCL_TEXT primary key(jobq_seq_no, text_type)
go

--  ****************************************************************************
--  Re-Create Foreign Keys on Audit Result Tables
--  ****************************************************************************

alter table job_queue_accept
   add constraint FK_job_queue_accept_job_queue_subreq foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go

alter table job_queue_course
   add constraint FK_job_queue_course_job_queue_subreq foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
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

alter table job_queue_out
    add constraint FK_JOBQ_OUT_REF_JOBQ_RUN foreign key (jobq_seq_no)
		references job_queue_run(int_seq_no)
go

alter table job_queue_report
   add constraint FK_JQREP_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_req
    add constraint FK_job_queue_req_job_queue_run foreign key (jobq_seq_no) 
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

alter table job_queue_subreq_text
   add constraint FK_JQSRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go

