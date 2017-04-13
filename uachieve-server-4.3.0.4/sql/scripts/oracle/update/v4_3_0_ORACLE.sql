/*=================================================================*/
/* Release:        u.achieve 4.3                                   */
/* DBMS name:      Oracle 10g/11g/12c                              */
/* Created on:     05/08/2015                                      */
/*                                                                 */
/* Purpose:        Database Modification Script to update          */
/*                 u.achieve 4.2.0 to u.achieve 4.3.0              */
/*                                                                 */
/* Highlights:     4.3.0.3                                         */
/*                 * moved delete of invalid job_queue_out data    */
/*                   so that it occurs before job_queue_out        */
/*                   indexes are dropped and rebuilt               */
/* Highlights:     4.3.0.2                                         */
/*                 * added new indexes to a few job_queue_tables   */
/*                   to improve delete performance.                */
/*                 * re-created sequence object and insert trigger */
/*                   for job_queue_out (removed in original 4.3.0  */
/*                   release.)                                     */
/* Highlights:     4.3.0                                           */
/*                 * new tables to aid in transfer rule editing    */
/*                   transfer_inst, tca_segment                    */
/*                 * increase string table limct to 3 digits       */
/*                 * update job_queue tables to identify           */
/*                   u.achieve server host                         */
/*                 * change data type of int_seq_no,               */
/*                   jobq_seq_no, and user_seq_no in               */
/*                   job_queue_tables to number                    */
/*                 * redefined primary key in some job_queue       */
/*                   tables                                        */
/*                                                                 */
/*=================================================================*/
/* DAP	7/7/15                                                     */
/*                                                                 */
/* The original version of this update script redefined primary    */
/* keys and removed sequence objects for several job_queue tables. */
/* For self-service compatability we must add the sequence objects */
/* back, and define a new index on the int_seq_no column.          */
/*                                                                 */
/* Updating job_queue tables to:                                   */
/*    * Handle identity values > 9 digits.                         */
/*    * Recreate sequence objects removed in original 4.3 script.  */
/*                                                                 */
/*  Copyright(c) 2015 CollegeSource, Inc. All Rights Reserved.     */
/*=================================================================*/



/*==============================================================*/
/* (Re)Create new transfer institution table (transfer_inst)    */
/*==============================================================*/

-- drop the transfer_inst table if it exists already.
-- we'll recreate it and populate it from tca_rule below
begin
	execute immediate 'drop table transfer_inst';
exception
	when others then
		if sqlcode != -942 then
			raise;
		end if;
end;
/

create table transfer_inst (
   instidq            char(2)                        default ' ' not null,
   instid             char(8)                        default ' ' not null,
   instcd             char(3)                        default ' ' not null,
   source_id          char(8)                        default ' ' not null,
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
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_transfer_inst" for table "transfer_inst"
create or replace trigger tib_transfer_inst before insert
on transfer_inst for each row

begin

--  update "Last Saved" information

IF  :new.last_mod_user IS NULL  or :new.last_mod_date IS NULL  THEN
    :new.last_mod_user := user;
  :new.last_mod_date := sysdate;
END IF;
    
end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_transfer_inst" for table "transfer_inst"
create or replace trigger tub_transfer_inst before update
on transfer_inst for each row

begin
--  update "Last Saved" information

  :new.last_mod_user := user;
  :new.last_mod_date := sysdate;

end;
/

-- populate transfer_inst from master reference table data

insert into TRANSFER_INST (INSTIDQ, INSTID, INSTCD, SOURCE_ID, INST_NAME)
    select instidq, instid, instcd, source_id, min(iname)
    from MASTREF
    group by instidq, instid, instcd, SOURCE_ID
/

select 'Rows contained in transfer_inst:', count(*) from transfer_inst
/

/*==============================================================*/
/* Create new transfer rule segment table (tca_segment)         */
/*==============================================================*/

-- drop the tca_segment table if it exists already.
-- we'll recreate it and populate it from tca_rule below

begin
	execute immediate 'drop table tca_segment';
exception
	when others then
		if sqlcode != -942 then
			raise;
		end if;
end;
/

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


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_tca_segment" for table "tca_segment"
create or replace trigger tib_tca_segment before insert
on tca_segment for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select tca_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

IF  :new.last_mod_user IS NULL  or :new.last_mod_date IS NULL  THEN
    :new.last_mod_user := user;
  :new.last_mod_date := sysdate;
END IF;
    
end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_tca_segment" for table "tca_segment"
create or replace trigger tub_tca_segment before update
on tca_segment for each row

begin
--  update "Last Saved" information

    :new.last_mod_user := user;
    :new.last_mod_date := sysdate;

end;
/

-- populate tca_segment from tca_rule data

insert into tca_segment (INSTIDQ, INSTID, INSTCD, SOURCE_ID, source_cd, dpmask, fyt, tseg)
    select distinct instidq, instid, instcd, source_id, source_cd, dpmask, fyt, tseg
    from tca_rule
/

select 'Rows contained in tca_segment:', count(*) from tca_segment
/

/*===============================================================*/
/* Modify String Table to handle Limit Count (limct) values > 99 */
/*===============================================================*/

-- string table
alter table string modify (
	limct	number(3)	default 0
	)
/

select count(*) as "Expected LimCt updates" from string where limct = 99
/

update string
set limct = 999 
where limct = 99
/

select count(*) as "Expected LimHrs updates" from string where limhrs = 99.9
/
update string
set limhrs = 999.9
where limhrs = 99.9
/

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
begin
    execute immediate 'alter table job_queue_list add   host_name  	varchar2(255)  null';
    execute immediate 'alter table job_queue_list add   host_ip  	varchar2(255)  null';
    execute immediate 'alter table job_queue_list add   uach_dir  	varchar2(255)  null';
exception
    when others then
        if sqlcode not in(-1430) then
            raise;
        end if;
end;
/

--  ****************************************************************************
--	ALTER JOB_QUEUE_DETAIL
--  ****************************************************************************

--	MODIFY COLUMN
alter table job_queue_detail modify (
	int_seq_no	number 
	)
/

begin
    execute immediate 'alter table job_queue_detail modify int_seq_no not null';
exception
    when others then
        if sqlcode not in(-1442) then       --- skip error if already defined as not null
            raise;
        end if;
end;
/

--	MODIFY SEQUENCE
alter sequence jobqd_seq_no
	nocycle
    nomaxvalue
/

--  Since we modified the sequence, we must re-apply the insert trigger
--  The trigger definition has NOT changed.

--  INSERT WITH int_seq_no, WITHOUT last_mod_user, date
--  Before insert trigger "tib_job_queue_detail" for table "job_queue_detail"
create or replace trigger tib_job_queue_detail before insert
on job_queue_detail for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN	
    select jobqd_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
    

end;
/
--  ****************************************************************************
--	ALTER JOB_QUEUE_SYSIN
--  ****************************************************************************

--	MODIFY COLUMN
alter table job_queue_sysin modify (
	int_seq_no	number 
	)
/

begin
    execute immediate 'alter table job_queue_sysin modify int_seq_no not null';
exception
    when others then
        if sqlcode not in(-1442) then       --- skip error if already defined as not null
            raise;
        end if;
end;
/

--	MODIFY SEQUENCE
alter sequence jobqsi_seq_no
	nocycle
    nomaxvalue
/

--  Since we modified the sequence, we must re-apply the insert trigger.
--  The trigger definition has NOT changed.


--  INSERT WITH int_seq_no, WITHOUT last_mod_user, date
--  Before insert trigger "tib_job_queue_sysin" for table "job_queue_sysin"
create or replace trigger tib_job_queue_sysin before insert
on job_queue_sysin for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN	
    select jobqsi_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/

-- *************************************
-- *************************************
--    Modify Job_Queue OUTPUT Tables
-- *************************************
-- *************************************

--	***********************************************
--	Drop Foreign keys on job_queue output tables
--	(Will recreate them at the end of script.)
--	***********************************************

begin
	execute immediate 'ALTER TABLE JOB_QUEUE_COURSE DROP CONSTRAINT FK_JOBQ_CRS_REF_JOBQ_SUBREQ';
exception
    when others then
        if sqlcode != -2443 then
            raise;
        end if;
end;
/

begin
	execute immediate 'ALTER TABLE JOB_QUEUE_ACCEPT DROP CONSTRAINT FK_JOB_QUEU_REFERENCE_JOB_QUEU';
exception
    when others then
        if sqlcode != -2443 then
            raise;
        end if;
end;
/

begin
	execute immediate 'ALTER TABLE JOB_QUEUE_EXCEPTIONS DROP CONSTRAINT FK_JQEXC_REF_JQRUN';
exception
    when others then
        if sqlcode != -2443 then
            raise;
        end if;
end;
/

begin
	execute immediate 'ALTER TABLE JOB_QUEUE_MARKERS DROP CONSTRAINT FK_JQMRK_REF_JQRUN';
exception
    when others then
        if sqlcode != -2443 then
            raise;
        end if;
end;
/

begin
	execute immediate 'ALTER TABLE JOB_QUEUE_OUT DROP CONSTRAINT FK_JOBQ_OUT_REF_JOBQ_RUN';
exception
    when others then
        if sqlcode != -2443 then
            raise;
        end if;
end;
/

begin
	execute immediate 'ALTER TABLE JOB_QUEUE_REPORT DROP CONSTRAINT FK_JQREP_REF_JQRUN';
exception
    when others then
        if sqlcode != -2443 then
            raise;
        end if;
end;
/

begin
	execute immediate 'ALTER TABLE JOB_QUEUE_INCL_TEXT DROP CONSTRAINT FK_JQINCL_REF_JQRUN';
exception
    when others then
        if sqlcode != -2443 then
            raise;
        end if;
end;
/


--  ****************************************************************************
--	ALTER JOB_QUEUE_RUN
--  ****************************************************************************

-- 	ADD COLUMNS
begin
    execute immediate 'alter table job_queue_run	add   dprog_type  	char(1)  null';
    execute immediate 'alter table job_queue_run	add   wifip_message	varchar2(255)  null';
    execute immediate 'alter table job_queue_run	add   incltop_text	varchar2(4000)  null';
    execute immediate 'alter table job_queue_run	add   host_name		varchar2(255)  null';
    execute immediate 'alter table job_queue_run	add   host_ip		varchar2(255)  null';
    execute immediate 'alter table job_queue_run	add   uach_dir  	varchar2(255)  null';
    execute immediate 'alter table job_queue_run	add   comkey	  	char(5)  null';
    execute immediate 'alter table job_queue_run	add   evalsw  		char(1)  null';
    execute immediate 'alter table job_queue_run	add   elapsed_ms  	number  null';                                
exception
    when others then
        if sqlcode not in(-1430) then
            raise;
        end if;
end;
/

--	MODIFY COLUMNS
alter table job_queue_run modify (
	int_seq_no		number , 
	detail_seq_no	number
	)
/

--	MODIFY SEQUENCE
alter sequence jobqr_seq_no
	nocycle
    nomaxvalue
/


--  Since we modified the sequence, we must re-apply the insert trigger.
--  The trigger definition has NOT changed.

--  INSERT WITH int_seq_no, WITHOUT last_mod_user, date
--  Before insert trigger "tib_job_queue_run" for table "job_queue_run"
create or replace trigger tib_job_queue_run before insert
on job_queue_run for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select jobqr_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/

--  ****************************************************************************
--	ALTER JOB_QUEUE_REQ
--  ****************************************************************************

--	ADD COLUMNS
begin
    execute immediate 'alter table job_queue_req	add   fyt  		char(6)  null';
    execute immediate 'alter table job_queue_req	add   catlyt  	char(6)  null';
exception
    when others then
        if sqlcode not in(-1430) then
            raise;
        end if;
end;
/
--	MODIFY COLUMN
alter table job_queue_req modify (
	jobq_seq_no	number  default 0
	)
/

--  ****************************************************************************
--	ALTER JOB_QUEUE_REQ_TEXT
--  ****************************************************************************

--	MODIFY COLUMN
alter table job_queue_req_text modify (
	jobq_seq_no	number  default 0
	)
/

--  ****************************************************************************
--	ALTER JOB_QUEUE_SUBREQ
--  ****************************************************************************

--	MODIFY COLUMN
alter table job_queue_subreq modify (
	jobq_seq_no	number  default 0
	)
/

--	UPDATE INDEX
-- this index was created in the 4.0 update scripts.
-- but it's the same as the primary key, so drop it.
begin
	execute immediate 'drop index jobq_subreq_idx';
exception
  	when others then
    	if sqlcode != -1418 then
      		raise;
    	end if;
end;
/
--  ****************************************************************************
--	ALTER JOB_QUEUE_SUBREQ_TEXT
--  ****************************************************************************

--	MODIFY COLUMN
alter table job_queue_subreq_text modify (
	jobq_seq_no	number  default 0
	)
/

--  ****************************************************************************
--  ALTER JOB_QUEUE_COURSE 
--  ****************************************************************************


--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
begin
  execute immediate 'drop index jobq_course_idx' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop index jobq_course_idx2' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop trigger tib_job_queue_course';
exception
  when others then
    if sqlcode != -4080 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop sequence jobqcrs_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

--	ADD COLUMNS
begin
    execute immediate 'alter table job_queue_course	add   evalflg  		char(1)  null';
    execute immediate 'alter table job_queue_course	add   source_id  	varchar2(20)  null';
    execute immediate 'alter table job_queue_course	add   source_cd  	varchar2(10)  null';
exception
    when others then
        if sqlcode not in(-1430) then
            raise;
        end if;
end;
/

--	MODIFY COLUMNS
alter table job_queue_course modify (
	int_seq_no	number  default 0,
	jobq_seq_no	number  default 0,
	user_seq_no number	default 0
	)
/


--	UPDATE PRIMARY KEY
alter table job_queue_course drop primary key drop index
/
alter table job_queue_course add constraint PK_JOB_QUEUE_COURSE primary key(jobq_seq_no, rtabx, stabx, user_seq_no)
/

--	RECREATE INDEX:  jobq_course_idx
create index jobq_course_idx on job_queue_course (int_seq_no)
/
create index jobq_course_idx2 on job_queue_course (jobq_seq_no)
/


--	RECREATE SEQUENCE OBJECT
begin
	declare 
		l_max number;
	begin
		select max(int_seq_no) into l_max from job_queue_course;
        if l_max is null then
            l_max := 0;
        end if;

        l_max := l_max + 1000;
		
		execute immediate 
			'create sequence JOBQCRS_SEQ_NO ' ||
			'start with ' || l_max ||
			' nomaxvalue minvalue 1 increment by 1 cache 20 noorder';
	end;
end;
/

--	RECREATE INSERT TRIGGER
CREATE OR REPLACE TRIGGER tib_job_queue_course before insert
on job_queue_course for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no <= 0 THEN
    select JOBQCRS_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/


--  ****************************************************************************
--  ALTER JOB_QUEUE_ACCEPT
--  ****************************************************************************


--	DROP EXISTING INDEX, TRIGGER, AND SEQUENCE

begin
  execute immediate 'drop index jobq_accept_idx' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop index jobq_accept_idx2' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop index jobq_accept_idx3' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop trigger tib_job_queue_accept';
exception
  when others then
    if sqlcode != -4080 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop sequence jobqacpt_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

--	MODIFY COLUMNS
alter table job_queue_accept modify (
	int_seq_no	number  default 0,
	jobq_seq_no	number  default 0,
	user_seq_no	number  default 0
	)
/


--	UPDATE PRIMARY KEY
alter table job_queue_accept drop primary key drop index
/
alter table job_queue_accept add constraint PK_JOB_QUEUE_ACCEPT primary key(jobq_seq_no, rtabx, stabx, user_seq_no)
/

--	RECREATE INDEX: jobq_accept_idx
create index jobq_accept_idx on job_queue_accept (jobq_seq_no, rtabx, stabx, reject, user_seq_no)
/
--	RECREATE INDEX: jobq_accept_idx2
create index jobq_accept_idx2 on job_queue_accept (int_seq_no)
/
--	RECREATE INDEX: jobq_accept_idx3                                       */
create index jobq_accept_idx3 on job_queue_accept (jobq_seq_no)
/

--	RECREATE SEQUENCE OBJECT
begin
	declare 
		l_max number;
	begin
		select max(int_seq_no) into l_max from job_queue_accept;
        if l_max is null then
            l_max := 0;
        end if;

        l_max := l_max + 1000;
		
		execute immediate 
			'create sequence JOBQACPT_SEQ_NO ' ||
			'start with ' || l_max ||
			' nomaxvalue minvalue 1 increment by 1 cache 20 noorder';
	end;
end;
/

--	RECREATE INSERT TRIGGER

CREATE OR REPLACE TRIGGER tib_job_queue_accept before insert
on job_queue_accept for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no <= 0 THEN
    select JOBQACPT_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/


--  ****************************************************************************
--  ALTER JOB_QUEUE_OUT
--  ****************************************************************************
--  remove invalid data from job_queue_out

--  DARwin would save audits with a fatal COBOL error using the same value of '0'
-- 	in user_seq_no for all rows of the audit.  These must be removed so the 
-- 	new primary key can be created correctly.  (u.achieve audits do not have this problem)

delete from job_queue_out
where user_seq_no = 0 and lasera > '1'
/

--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
begin
  execute immediate 'drop index jobq_out_idx' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop trigger tib_job_queue_out';
exception
  when others then
    if sqlcode != -4080 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop sequence jobqo_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

--	MODIFY COLUMNS
alter table job_queue_out modify (
	int_seq_no	number  default 0,
	jobq_seq_no	number  default 0, 
	user_seq_no number	default 0
	)
/


--	UPDATE PRIMARY KEY
alter table job_queue_out drop primary key drop index
/

alter table job_queue_out add constraint PK_JOB_QUEUE_OUT primary key(jobq_seq_no, user_seq_no)
/

--	RECREATE SEQUENCE OBJECT
begin
	declare 
		l_max number;
	begin
		select max(int_seq_no) into l_max from job_queue_out;
        if l_max is null then
            l_max := 0;
        end if;

        l_max := l_max + 1000;
		
		execute immediate 
			'create sequence JOBQO_SEQ_NO ' ||
			'start with ' || l_max ||
			' nomaxvalue minvalue 1 increment by 1 cache 20 noorder';
	end;
end;
/

--	RECREATE INSERT TRIGGER
CREATE OR REPLACE TRIGGER tib_job_queue_out before insert
on job_queue_out for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no <= 0 THEN
    select JOBQO_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/
--  ****************************************************************************
--  ALTER JOB_QUEUE_REPORT
--  ****************************************************************************

--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
begin
  execute immediate 'drop index jobq_report_idx' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop trigger tib_job_queue_report';
exception
  when others then
    if sqlcode != -4080 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop sequence jobqrpt_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/


-- 	MODIFY COLUMNS
alter table job_queue_report modify (
	int_seq_no	number          default 0,
	jobq_seq_no	number          default 0,
	report_type	varchar2(10)	default ' '
	)
/


--	UPDATE PRIMARY KEY
alter table job_queue_report drop primary key drop index
/
alter table job_queue_report add constraint PK_JOB_QUEUE_REPORT primary key(jobq_seq_no, report_type)
/	
--	RECREATE INDEX: jobq_report_idx
create index jobq_report_idx on job_queue_report (jobq_seq_no)
/

--  ****************************************************************************
--  ALTER JOB_QUEUE_MARKERS
--  ****************************************************************************

--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
begin
  execute immediate 'drop index jobq_markers_idx' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop trigger tib_job_queue_markers';
exception
  when others then
    if sqlcode != -4080 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop sequence jobqmrk_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/


--	MODIFY COLUMNS
alter table job_queue_markers modify (
	int_seq_no	number  default 0,
	jobq_seq_no	number  default 0,
	user_seq_no	number	default 0
	)
/


--	UPDATE PRIMARY KEY
alter table job_queue_markers drop primary key drop index
/
alter table job_queue_markers add constraint PK_JOB_QUEUE_MARKERS primary key(jobq_seq_no, user_seq_no)
/

--	RECREATE INDEX: jobq_markers_idx
create index jobq_markers_idx on job_queue_markers (int_seq_no)
/


--	RECREATE SEQUENCE OBJECT
begin
	declare 
		l_max number;
	begin
		select max(int_seq_no) into l_max from job_queue_markers;
        if l_max is null then
            l_max := 0;
        end if;

        l_max := l_max + 1000;
		
		execute immediate 
			'create sequence JOBQMRK_SEQ_NO ' ||
			'start with ' || l_max ||
			' nomaxvalue minvalue 1 increment by 1 cache 20 noorder';
	end;
end;
/

--	RECREATE INSERT TRIGGER
CREATE OR REPLACE TRIGGER tib_job_queue_markers before insert
on job_queue_markers for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no <= 0 THEN
    select JOBQMRK_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/


--  ****************************************************************************
--  ALTER JOB_QUEUE_EXCEPTIONS
--  ****************************************************************************
	
--	DROP OBSOLETE INDEX
begin
  execute immediate 'drop index jobq_exceptions_idx' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop trigger tib_job_queue_exceptions';
exception
  when others then
    if sqlcode != -4080 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop sequence jobqexc_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/


-- Remove Abandoned Exception Output Data
-- THIS DELETE DOES NOT AFFECT STUDENT RECORDS IN ANY WAY,
-- NOR DOES THE DELETE AFFECT SAVED AUDITS.
-- The delete only removes exceptions that are in the job_queue_exception
-- table that are orphaned and no longer associated with an audit report.

delete from job_queue_exceptions
    where   jobq_seq_no is null
    or      user_seq_no is null
/

--	MODIFY COLUMNS
alter table job_queue_exceptions modify (
	int_seq_no	number  default 0,
	jobq_seq_no	number  default 0,
	user_seq_no	number  default 0
	)
/

--	UPDATE PRIMARY KEY
alter table job_queue_exceptions drop primary key drop index
/
alter table job_queue_exceptions add constraint PK_JOB_QUEUE_EXCEPTIONS primary key(jobq_seq_no, user_seq_no)
/

-- RECREATE INDEX: jobq_exceptions_idx 
create index jobq_exceptions_idx on job_queue_exceptions (int_seq_no)
/


--	RECREATE SEQUENCE OBJECT
begin
	declare 
		l_max number;
	begin
		select max(int_seq_no) into l_max from job_queue_exceptions;
        if l_max is null then
            l_max := 0;
        end if;

        l_max := l_max + 1000;
		
		execute immediate 
			'create sequence JOBQEXC_SEQ_NO ' ||
			'start with ' || l_max ||
			' nomaxvalue minvalue 1 increment by 1 cache 20 noorder';
	end;
end;
/

CREATE OR REPLACE TRIGGER tib_job_queue_exceptions before insert
on job_queue_exceptions for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
if :new.int_seq_no <= 0 THEN
    select JOBQEXC_SEQ_NO.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/

--  ****************************************************************************
--  ALTER JOB_QUEUE_INCL_TEXT
--  ****************************************************************************


--	DROP OBSOLETE INDEX, TRIGGER, AND SEQUENCE
begin
  execute immediate 'drop index jobq_incl_text_idx' ;
exception
  when others then
    if sqlcode != -1418 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop trigger tib_job_queue_incl_text';
exception
  when others then
    if sqlcode != -4080 then
      raise;
    end if;
end;
/
begin
  execute immediate 'drop sequence jobq_inclt_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

-- Remove Abandoned Incl_Text Output Data
-- THIS DELETE DOES NOT AFFECT STUDENT RECORDS IN ANY WAY,
-- NOR DOES THE DELETE AFFECT SAVED AUDITS.
-- The delete only removes text that is in the job_queue_incl_text
-- table that is orphaned and no longer associated with an audit report.

delete from job_queue_incl_text
    where   jobq_seq_no is null
/

-- 	MODIFY COLUMNS
alter table job_queue_incl_text modify (
	int_seq_no	number      default 0,
	jobq_seq_no	number      default 0,
	text_type	char(1)		default ' '
	)
/

--	UPDATE PRIMARY KEY
alter table job_queue_incl_text drop primary key drop index
/
alter table job_queue_incl_text add constraint PK_JOB_QUEUE_INCL_TEXT primary key(jobq_seq_no, text_type)
/


--==================================================================
--	Re-Create Foreign Key Constraints on Job Queue Output Tables
--==================================================================

alter table job_queue_accept
   add constraint FK_JOB_QUEU_REFERENCE_JOB_QUEU foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
/

alter table job_queue_course
   add constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO, RTABX, STABX)
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
