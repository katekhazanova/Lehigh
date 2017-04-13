/*=================================================================*/
/* Release:        u.achieve 4.3                                   */
/* DBMS name:      DB2 LUW                                         */
/* Created on:     09/03/2015                                      */
/*                                                                 */
/* Purpose:        Database Modification Script to update          */
/*                 u.achieve 4.2.0 to u.achieve 4.3.0              */
/*                                                                 */
/* Highlights:     4.3.0.3                                         */
/*                 * moved delete of invalid job_queue_out data    */
/*                   so that it occurs before job_queue_out        */
/*                   indexes are dropped and rebuilt               */
/*                                                                 */
/* Highlights:     4.3.0                                           */
/*                 * new tables to aid in transfer rule editing    */
/*                   transfer_inst, tca_segment                    */
/*                 * increase string table limct to 3 digits       */
/*                 * update job_queue tables to identify           */
/*                   u.achieve server host                         */
/*                 * change data type of int_seq_no and            */
/*                   jobq_seq_no in job_queue_tables to            */
/*                   numeric(18)                                   */
/*                 * redefined primary key in some job_queue       */
/*                   tables                                        */
/*                                                                 */
/*=================================================================*/
/* Notes	9/4/15                                                 */
/*                                                                 */
/* !!! Important !!!                                               */
/* An update to job_queue_run requires that the u.achieve 4.3      */
/* tablespace page size = 8K or higher.                            */
/*                                                                 */
/* DB2 prohibits DDL within an atomic SQL block, making the        */
/* execution and trapping of errors difficult without installing   */
/* a stored procedure provided by IBM.  Since we can't assume the  */
/* stored procidure is installed and don't want to require it,     */
/* you may see some common errors where we attempt to drop a table */
/* before creating it.   We note these with "values" messages.     */
/*                                                                 */
/*  Copyright(c) 2015 CollegeSource, Inc. All Rights Reserved.     */
/*=================================================================*/


SET SCHEMA UA43_UPDATE
;

/*==============================================================*/
/* (Re)Create new transfer institution table (transfer_inst)    */
/*==============================================================*/

-- Uncomment the "drop table" command if you're running this update script more than once.
-- we'll recreate it and populate it from tca_rule below

--values 'Attempt to drop table transfer_inst.  An error typically indicates the table does not exist in the current schema and can be ignored'
--;
--drop table transfer_inst
--;

create table transfer_inst (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
   inst_name          varchar(60)                   null,
   ipeds              varchar(20)                   null,
   opeid              varchar(20)                   null,
   fice               varchar(20)                   null,
   atp                varchar(20)                   null,
   act                varchar(20)                   null,
   last_mod_user      varchar(30)                   null,
   last_mod_date      timestamp,
   constraint PK_TRANSFER_INST primary key (instidq, instid, instcd, source_id)
)
;

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "ti_transfer_inst" for table "transfer_inst"
create or replace trigger ti_transfer_inst
	NO CASCADE BEFORE INSERT ON TRANSFER_INST
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
	set n.last_mod_date = current timestamp, n.last_mod_user = user
;

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tu_transfer_inst" for table "transfer_inst"
create or replace trigger tu_transfer_inst
	NO CASCADE BEFORE UPDATE ON TRANSFER_INST
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
	set n.last_mod_date = current timestamp, n.last_mod_user = user
;

-- populate transfer_inst from master reference table data

insert into TRANSFER_INST (INSTIDQ, INSTID, INSTCD, SOURCE_ID, INST_NAME)
    select instidq, instid, instcd, source_id, min(iname)
    from MASTREF
    group by instidq, instid, instcd, SOURCE_ID
;

select 'Rows contained in transfer_inst:', count(*) from transfer_inst
;

commit
;
/*==============================================================*/
/* Create new transfer rule segment table (tca_segment)         */
/*==============================================================*/

-- Uncomment the "drop table" command if you're running this script more than once.
-- we'll recreate it and populate it from tca_rule below

--values 'Attempt to drop table tca_segment.  An error typically indicates the table does not exist in the current schema and can be ignored'
--;
--drop table tca_segment
--;

create table tca_segment (
   int_seq_no         numeric(9)                     not null generated by default as identity,
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
   last_mod_date      timestamp,
   constraint PK_TCA_SEGMENT primary key (int_seq_no)
)
;

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
;


--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "ti_tca_segment" for table "tca_segment"
create or replace trigger ti_tca_segment
	NO CASCADE BEFORE INSERT ON TCA_SEGMENT
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
	set n.last_mod_date = current timestamp, n.last_mod_user = user
;

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tu_tca_segment" for table "tca_segment"
create or replace trigger tu_tca_segment
	NO CASCADE BEFORE UPDATE ON TCA_SEGMENT
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
	set n.last_mod_date = current timestamp, n.last_mod_user = user
;

-- populate tca_segment from tca_rule data

insert into tca_segment (INSTIDQ, INSTID, INSTCD, SOURCE_ID, source_cd, dpmask, fyt, tseg)
    select distinct instidq, instid, instcd, source_id, source_cd, dpmask, fyt, tseg
    from tca_rule
;

select 'Rows contained in tca_segment:', count(*) from tca_segment
;

commit;
/*===============================================================*/
/* Modify String Table to handle Limit Count (limct) values > 99 */
/*===============================================================*/

-- string table
alter table string alter column	limct	set data type numeric(3)
;
alter table string alter column limct   set default 0
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE STRING' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE STRING' );

select count(*) as "Expected LimCt updates" from string where limct = 99
;

update string
set limct = 999 
where limct = 99
;

select count(*) as "Expected LimHrs updates" from string where limhrs = 99.9
;
update string
set limhrs = 999.9
where limhrs = 99.9
;

commit;
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

--	ADD COLUMNS
alter table job_queue_list add column   host_name   varchar(255)  null
;
alter table job_queue_list add column   host_ip  	varchar(255)  null
;
alter table job_queue_list add column   uach_dir  	varchar(255)  null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_LIST' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_LIST' );
--  ****************************************************************************
--	ALTER JOB_QUEUE_DETAIL
--  ****************************************************************************

--  DROP IDENTITY
alter table job_queue_detail alter column int_seq_no drop identity
;

--	MODIFY PRIMARY KEY COLUMN
alter table job_queue_detail alter column int_seq_no  set data type numeric(18)
;

--  ADD IDENTITY
alter table job_queue_detail alter column int_seq_no set generated by default as identity 
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_DETAIL' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_DETAIL' );

--  ****************************************************************************
--	ALTER JOB_QUEUE_SYSIN
--  ****************************************************************************

--  DROP IDENTITY
alter table job_queue_sysin alter column int_seq_no drop identity
;

--	MODIFY COLUMN
alter table job_queue_sysin alter column int_seq_no     set data type numeric(18) 
;

--  ADD IDENTITY
alter table job_queue_sysin alter column int_seq_no set generated by default as identity
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_SYSIN' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_SYSIN' );
-- *************************************
-- *************************************
--    Modify Job_Queue OUTPUT Tables
-- *************************************
-- *************************************

--	***********************************************
--	Drop Foreign keys on job_queue output tables
--	(Will recreate them at the end of script.)
--	***********************************************

ALTER TABLE JOB_QUEUE_COURSE DROP CONSTRAINT FK_JOB_QUEUE_COURSE_JOB_QUEUE_SUBREQ
;

ALTER TABLE JOB_QUEUE_ACCEPT DROP CONSTRAINT FK_JOB_QUEUE_ACCEPT_JOB_QUEUE_SUBREQ
;

ALTER TABLE JOB_QUEUE_EXCEPTIONS DROP CONSTRAINT FK_JQEXC_REF_JQRUN
;

ALTER TABLE JOB_QUEUE_MARKERS DROP CONSTRAINT FK_JQMRK_REF_JQRUN
;

ALTER TABLE JOB_QUEUE_OUT DROP CONSTRAINT FK_JOBQ_OUT_REF_JOBQ_RUN
;

ALTER TABLE JOB_QUEUE_REPORT DROP CONSTRAINT FK_JQREP_REF_JQRUN
;

ALTER TABLE JOB_QUEUE_INCL_TEXT DROP CONSTRAINT FK_JQINCL_REF_JQRUN
;

ALTER TABLE JOB_QUEUE_REQ DROP CONSTRAINT FK_JOB_QUEUE_REQ_JOB_QUEUE_RUN
;

ALTER TABLE JOB_QUEUE_REQ_TEXT DROP CONSTRAINT FK_JQRTXT_REF_JQREQ
;

ALTER TABLE JOB_QUEUE_SUBREQ DROP CONSTRAINT FK_JOBQ_SUBREQ_REF_JOBQ_REQ
;

ALTER TABLE JOB_QUEUE_SUBREQ_TEXT DROP CONSTRAINT FK_JQSRTXT_REF_JQREQ
;


--  ****************************************************************************
--	ALTER JOB_QUEUE_RUN
--  ****************************************************************************

-- 	ADD COLUMNS

alter table job_queue_run	add column   dprog_type  	char(1)  null
;
alter table job_queue_run	add column   wifip_message	varchar(255)  null
;
alter table job_queue_run	add column   incltop_text	varchar(2000)  null
;
alter table job_queue_run	add column   host_name		varchar(255)  null
;
alter table job_queue_run	add column   host_ip		varchar(255)  null
;
alter table job_queue_run	add column   uach_dir  	varchar(255)  null
;
alter table job_queue_run	add column   comkey	  	char(5)  null
;
alter table job_queue_run	add column   evalsw  		char(1)  null
;
alter table job_queue_run	add column   elapsed_ms   numeric(18)  null
;
                               

--  DROP IDENTITY
alter table job_queue_run alter column int_seq_no drop identity
;
--	MODIFY IDENTITY
alter table job_queue_run alter column int_seq_no set data type numeric(18)
;
--  ADD IDENTITY
alter table job_queue_run alter column int_seq_no set generated by default as identity
;

alter table job_queue_run alter column detail_seq_no    set data type numeric(18)
;
alter table job_queue_run alter column detail_seq_no    set default 0
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_RUN' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_RUN' );

commit;
--  ****************************************************************************
--	ALTER JOB_QUEUE_REQ
--  ****************************************************************************

--	ADD COLUMNS

alter table job_queue_req	add column   fyt  		char(6)  default null
;
alter table job_queue_req	add column   catlyt  	char(6)  default null
;

--	MODIFY COLUMN
alter table job_queue_req alter column jobq_seq_no	set data type numeric(18)
;
alter table job_queue_req alter column jobq_seq_no	set default 0
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_REQ' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_REQ' );

--  ****************************************************************************
--	ALTER JOB_QUEUE_REQ_TEXT
--  ****************************************************************************

--	MODIFY COLUMN
alter table job_queue_req_text alter column	jobq_seq_no	set data type numeric(18)
;
alter table job_queue_req_text alter column	jobq_seq_no	set default 0
;


CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_REQ_TEXT' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_REQ_TEXT' );
--  ****************************************************************************
--	ALTER JOB_QUEUE_SUBREQ
--  ****************************************************************************

--	MODIFY COLUMN
alter table job_queue_subreq alter column jobq_seq_no	set data type numeric(18)
;
alter table job_queue_subreq alter column jobq_seq_no	set default 0
;

--	UPDATE INDEX
-- this index was created in the 4.0 update scripts.
-- but it's the same as the primary key, so drop it.
values 'Index jobq_subreq_idx may not exist, so an error indicating its non-existance can be ignored.'
;
drop index jobq_subreq_idx
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_SUBREQ' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_SUBREQ' );

--  ****************************************************************************
--	ALTER JOB_QUEUE_SUBREQ_TEXT
--  ****************************************************************************

--	alter column COLUMN
alter table job_queue_subreq_text alter column jobq_seq_no set data type numeric(18)
;
alter table job_queue_subreq_text alter column jobq_seq_no set default 0
;


CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_SUBREQ_TEXT' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_SUBREQ_TEXT' );
--  ****************************************************************************
--  ALTER JOB_QUEUE_COURSE 
--  ****************************************************************************


--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
drop index jobq_course_idx
;

--	add column COLUMNS
alter table job_queue_course	add column   evalflg  		char(1)
;
alter table job_queue_course	add column   source_id  	varchar(20)
;
alter table job_queue_course	add column   source_cd  	varchar(10)
;


--	MODIFY COLUMNS

alter table job_queue_course alter column   int_seq_no drop identity
;
alter table job_queue_course alter column   int_seq_no set data type numeric(18)
;
alter table job_queue_course alter column   int_seq_no set generated by default as identity
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_COURSE' );


alter table job_queue_course alter column   jobq_seq_no set data type numeric(18)
;
alter table job_queue_course alter column   jobq_seq_no set default 0
;
alter table job_queue_course alter column   jobq_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_COURSE' );


alter table job_queue_course alter column   user_seq_no set data type numeric(18)
;
alter table job_queue_course alter column   user_seq_no set default 0
;
alter table job_queue_course alter column   user_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_COURSE' );


--	UPDATE PRIMARY KEY
alter table job_queue_course drop primary key
;
alter table job_queue_course add constraint PK_JOB_QUEUE_COURSE primary key(jobq_seq_no, rtabx, stabx, user_seq_no)
;

--	RECREATE INDEX:  jobq_course_idx
create index jobq_course_idx on job_queue_course (int_seq_no)
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_COURSE' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_COURSE' );

commit;
--  ****************************************************************************
--  ALTER JOB_QUEUE_ACCEPT
--  ****************************************************************************


--	DROP EXISTING INDEX, TRIGGER, AND SEQUENCE

drop index jobq_accept_idx
;

--	MODIFY COLUMNS
alter table job_queue_accept alter column int_seq_no drop identity
;
alter table job_queue_accept alter column   int_seq_no set data type numeric(18)
;
alter table job_queue_accept alter column int_seq_no set generated by default as identity
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_ACCEPT' );

alter table job_queue_accept alter column   jobq_seq_no set data type numeric(18)
;
alter table job_queue_accept alter column   jobq_seq_no set default 0
;
alter table job_queue_accept alter column   jobq_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_ACCEPT' );

alter table job_queue_accept alter column   user_seq_no set data type numeric(18)
;
alter table job_queue_accept alter column   user_seq_no set default 0
;
alter table job_queue_accept alter column   user_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_ACCEPT' );


--	UPDATE PRIMARY KEY
alter table job_queue_accept drop primary key
;
alter table job_queue_accept add constraint PK_JOB_QUEUE_ACCEPT primary key(jobq_seq_no, rtabx, stabx, user_seq_no)
;

--	RECREATE INDEX: jobq_accept_idx
create index jobq_accept_idx on job_queue_accept (jobq_seq_no, rtabx, stabx, reject, user_seq_no)
;
--	RECREATE INDEX: jobq_accept_idx2
create index jobq_accept_idx2 on job_queue_accept (int_seq_no)
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_ACCEPT' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_ACCEPT' );

commit;
--  ****************************************************************************
--  ALTER JOB_QUEUE_OUT
--  ****************************************************************************

--  remove invalid data from job_queue_out

--  DARwin would save audits with a fatal COBOL error using the same value of '0'
-- 	in user_seq_no for all rows of the audit.  These must be removed so the 
-- 	new primary key can be created correctly.  (u.achieve audits do not have this problem)

delete from job_queue_out
where user_seq_no = 0 and lasera > '1'
;

--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE

drop index jobq_out_idx
;

--	MODIFY COLUMNS
alter table job_queue_out alter column int_seq_no drop identity
;
alter table job_queue_out alter column int_seq_no set data type numeric(18)
;
alter table job_queue_out alter column int_seq_no set generated by default as identity
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_OUT' );


alter table job_queue_out alter column  jobq_seq_no set data type numeric(18)
;
alter table job_queue_out alter column  jobq_seq_no set default 0
;
alter table job_queue_out alter column  jobq_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_OUT' );


alter table job_queue_out alter column	user_seq_no set data type numeric(18)
;
alter table job_queue_out alter column  user_seq_no set default 0
;
alter table job_queue_out alter column  user_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_OUT' );


--	UPDATE PRIMARY KEY
alter table job_queue_out drop primary key
;

alter table job_queue_out add constraint PK_JOB_QUEUE_OUT primary key(jobq_seq_no, user_seq_no)
;

--	UPDATE INDEX
create index jobq_out_idx on job_queue_out (int_seq_no)
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_OUT' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_OUT' );

commit;
--  ****************************************************************************
--  ALTER JOB_QUEUE_REPORT
--  ****************************************************************************

--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
drop index jobq_report_idx
;

-- 	MODIFY COLUMNS
alter table job_queue_report alter column int_seq_no drop identity
;
alter table job_queue_report alter column  int_seq_no set data type numeric(18)
;
alter table job_queue_report alter column int_seq_no set generated by default as identity
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_REPORT' );


alter table job_queue_report alter column	jobq_seq_no set data type numeric(18)
;
alter table job_queue_report alter column   jobq_seq_no set default 0
;
alter table job_queue_report alter column   jobq_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_REPORT' );


--	ENSURE NO NULL VALUES EXIST IN REPORT_TYPE COLUMN
update job_queue_report
set report_type = ' '
where report_type is null;
commit;

alter table job_queue_report alter column	report_type	set data type varchar(10)
;
alter table job_queue_report alter column   report_type set default ' '
;
alter table job_queue_report alter column   report_type set not null
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_REPORT' );

--	UPDATE PRIMARY KEY
alter table job_queue_report drop primary key
;
alter table job_queue_report add constraint PK_J_Q_REPORT primary key(jobq_seq_no, report_type)
;	

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_REPORT' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_REPORT' );

commit;
--  ****************************************************************************
--  ALTER JOB_QUEUE_MARKERS
--  ****************************************************************************

--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
drop index jobq_markers_idx
;

--	MODIFY COLUMNS
alter table job_queue_markers alter column int_seq_no drop identity
;
alter table job_queue_markers alter column int_seq_no set data type numeric(18)
;
alter table job_queue_markers alter column int_seq_no set generated by default as identity
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_MARKERS' );


alter table job_queue_markers alter column  jobq_seq_no set data type numeric(18)
;
alter table job_queue_markers alter column	jobq_seq_no set default 0
;
alter table job_queue_markers alter column	jobq_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_MARKERS' );


update job_queue_markers
set user_seq_no = 0
where user_seq_no is null;
commit;

alter table job_queue_markers alter column  user_seq_no	set data type numeric(18)
;
alter table job_queue_markers alter column	user_seq_no set default 0
;
alter table job_queue_markers alter column	user_seq_no set not null
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_MARKERS' );


--	UPDATE PRIMARY KEY
alter table job_queue_markers drop primary key
;
alter table job_queue_markers add constraint PK_J_Q_MARKER primary key(jobq_seq_no, user_seq_no)
;

--	RECREATE INDEX: jobq_markers_idx
create index jobq_markers_idx on job_queue_markers (int_seq_no)
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_MARKERS' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_MARKERS' );

commit;
--  ****************************************************************************
--  ALTER JOB_QUEUE_EXCEPTIONS
--  ****************************************************************************
	
--	DROP OBSOLETE INDEX
drop index jobq_exceptions_idx
;


-- Remove Abandoned Exception Output Data
-- THIS DELETE DOES NOT AFFECT STUDENT RECORDS IN ANY WAY,
-- NOR DOES THE DELETE AFFECT SAVED AUDITS.
-- The delete only removes exceptions that are in the job_queue_exception
-- table that are orphaned and no longer associated with an audit report.

delete from job_queue_exceptions
    where   jobq_seq_no is null
    or      user_seq_no is null
;
commit;

--	MODIFY COLUMNS
alter table job_queue_exceptions alter column int_seq_no drop identity
;
alter table job_queue_exceptions alter column int_seq_no set data type numeric(18)
;
alter table job_queue_exceptions alter column int_seq_no set generated by default as identity
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_EXCEPTIONS' );


alter table job_queue_exceptions alter column   jobq_seq_no set data type numeric(18)  
;
alter table job_queue_exceptions alter column   jobq_seq_no set default 0
;
alter table job_queue_exceptions alter column   jobq_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_EXCEPTIONS' );


alter table job_queue_exceptions alter column   user_seq_no set data type numeric(18)
;
alter table job_queue_exceptions alter column   user_seq_no set default 0
;
alter table job_queue_exceptions alter column   user_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_EXCEPTIONS' );

--	UPDATE PRIMARY KEY
alter table job_queue_exceptions drop primary key
;
alter table job_queue_exceptions add constraint PK_J_Q_EXCEPTION primary key(jobq_seq_no, user_seq_no)
;

-- RECREATE INDEX: jobq_exceptions_idx 
create index jobq_exceptions_idx on job_queue_exceptions (int_seq_no)
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_EXCEPTIONS' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_EXCEPTIONS' );

commit;
--  ****************************************************************************
--  ALTER JOB_QUEUE_INCL_TEXT
--  ****************************************************************************


--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
drop index jobq_incl_text_idx
;

-- Remove Abandoned Incl_Text Output Data
-- THIS DELETE DOES NOT AFFECT STUDENT RECORDS IN ANY WAY,
-- NOR DOES THE DELETE AFFECT SAVED AUDITS.
-- The delete only removes text that is in the job_queue_incl_text
-- table that is orphaned and no longer associated with an audit report.

delete from job_queue_incl_text
    where   jobq_seq_no is null
;
commit;

-- 	MODIFY COLUMNS
alter table job_queue_incl_text alter column int_seq_no drop identity
;
alter table job_queue_incl_text alter column int_seq_no set data type numeric(18)
;
alter table job_queue_incl_text alter column int_seq_no set generated by default as identity
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_INCL_TEXT' );


alter table job_queue_incl_text alter column jobq_seq_no set data type numeric(18) 
;
alter table job_queue_incl_text alter column jobq_seq_no set default 0
;
alter table job_queue_incl_text alter column jobq_seq_no set not null
;
CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_INCL_TEXT' );


update job_queue_incl_text
set text_type = ' '
where text_type is null;
commit;

alter table job_queue_incl_text alter column text_type	set data type char(1)
;
alter table job_queue_incl_text alter column text_type set default ' '
;
alter table job_queue_incl_text alter column text_type set not null
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_INCL_TEXT' );

--	UPDATE PRIMARY KEY
alter table job_queue_incl_text drop primary key
;
alter table job_queue_incl_text add constraint PK_JOB_QUEUE_INCL_TEXT primary key(jobq_seq_no, text_type)
;

-- UPDATE INDEX
create index jobq_incl_text_idx on job_queue_incl_text (int_seq_no)
;

CALL SYSPROC.ADMIN_CMD( 'REORG TABLE JOB_QUEUE_INCL_TEXT' );
CALL SYSPROC.ADMIN_CMD( 'RUNSTATS ON TABLE JOB_QUEUE_INCL_TEXT' );

commit;

--==================================================================
--	Re-Create Foreign Key Constraints on Job Queue Output Tables
--==================================================================

alter table job_queue_accept
   add constraint FK_JOB_QUEUE_ACCEPT_JOB_QUEUE_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
		on delete restrict on update restrict 
;

alter table job_queue_course
   add constraint FK_JOB_QUEUE_COURSE_JOB_QUEUE_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
		on delete restrict on update restrict 
;

alter table JOB_QUEUE_EXCEPTIONS
   add constraint FK_JQEXC_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
		on delete restrict on update restrict 
;

alter table JOB_QUEUE_INCL_TEXT
   add constraint FK_JQINCL_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
		on delete restrict on update restrict 
;

alter table JOB_QUEUE_MARKERS
   add constraint FK_JQMRK_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
		on delete restrict on update restrict 
;

alter table JOB_QUEUE_OUT
    add constraint FK_JOBQ_OUT_REF_JOBQ_RUN foreign key(JOBQ_SEQ_NO)
	references JOB_QUEUE_RUN(INT_SEQ_NO)
		on delete restrict on update restrict 
;

alter table JOB_QUEUE_REPORT
   add constraint FK_JQREP_REF_JQRUN foreign key (JOBQ_SEQ_NO)
      references JOB_QUEUE_RUN (INT_SEQ_NO)
		on delete restrict on update restrict 
;

alter table job_queue_req
    add constraint FK_job_queue_req_job_queue_run foreign key (jobq_seq_no) 
    	references job_queue_run (int_seq_no)
		on delete restrict on update restrict 
;

alter table job_queue_req_text
   add constraint FK_JQRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
		on delete restrict on update restrict 
;

alter table job_queue_subreq
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
		on delete restrict on update restrict 
;

alter table job_queue_subreq_text
   add constraint FK_JQSRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
		on delete restrict on update restrict 
;
commit;

