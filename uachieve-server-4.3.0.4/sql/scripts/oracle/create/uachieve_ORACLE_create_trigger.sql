/*================================================================*/
/* Release:		  	u.achieve 4.3                                 */
/* DBMS name:      	ORACLE Version 10g/11i/12c                    */
/* Created on:     	6/27/2008 1:18:54 PM                          */
/* Last Updated:    10/05/2015            						  */
/*                                                                */
/* Script name: 	uachieve_oracle_create_trigger.sql            */
/* Purpose:        	Creates the u.achieve Server insert and       */
/*                  update triggers.                              */
/*                                                                */
/* 4.3.0.2:  * updated to preserve last_mod_user and last_mod_date*/
/*             when set on insert/update.                         */
/*                                                                */
/* Beginning with 4.2, we have moved all the security tables      */
/* and any other tables specific to u.achieve self-service to     */
/* the Dashboard installation scripts.                            */
/*                                                                */
/* This script now contains only those triggers for tables that   */
/* are specific to the u.achieve Server.                          */
/*                                                                */
/* Copyright(c) 1998-2015 CollegeSource, Inc. All Rights Reserved */
/*                                                                */
/*================================================================*/


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


--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_cond_codes" for table "cond_codes"
create or replace trigger tib_cond_codes before insert
on cond_codes for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_course_bank" for table "course_bank"
create or replace trigger tib_course_bank before insert
on course_bank for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_com" for table "com"
create or replace trigger tib_com before insert
on com for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_dprog" for table "dprog"
create or replace trigger tib_dprog before insert
on dprog for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_req_main" for table "req_main"
create or replace trigger tib_req_main before insert
on req_main for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_demo" for table "stu_demo"
create or replace trigger tib_stu_demo before insert
on stu_demo for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_trans_degree" for table "stu_trans_degree"
create or replace trigger tib_stu_trans_degree before insert
on stu_trans_degree for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_dprog" for table "stu_dprog"
create or replace trigger tib_stu_dprog before insert
on stu_dprog for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/



--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_acadrec" for table "stu_acadrec"
create or replace trigger tib_stu_acadrec before insert
on stu_acadrec for each row

begin

--  update "Last Saved" information


-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_evalgrp" for table "stu_evalgrp"
create or replace trigger tib_stu_evalgrp before insert
on stu_evalgrp for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/



--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_mastref" for table "mastref"
create or replace trigger tib_mastref before insert
on mastref for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_tca_master" for table "tca_master"
create or replace trigger tib_tca_master before insert
on tca_master for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_job_queue_list" for table "job_queue_list"
create or replace trigger tib_job_queue_list before insert
on job_queue_list for each row

begin

--  update "Last Saved" information


-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_string" for table "string"
create or replace trigger tib_string before insert
on string for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select seq_int_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_string_crse" for table "string_crse"
create or replace trigger tib_string_crse before insert
on string_crse for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select seq_int_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_gmaster" for table "gmaster"
create or replace trigger tib_gmaster before insert
on gmaster for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select seq_int_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_repeat" for table "repeat"
create or replace trigger tib_repeat before insert
on repeat for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select seq_int_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_crs_convert" for table "crs_convert"
create or replace trigger tib_crs_convert before insert
on crs_convert for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select seq_int_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_dprog_req" for table "dprog_req"
create or replace trigger tib_dprog_req before insert
on dprog_req for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select dprog_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_req_text" for table "req_text"
create or replace trigger tib_req_text before insert
on req_text for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select req_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_req_xy" for table "req_xy"
create or replace trigger tib_req_xy before insert
on req_xy for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select req_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_sub_req" for table "sub_req"
CREATE OR REPLACE TRIGGER TIB_SUB_REQ before insert 
on sub_req for each row 
declare 
    next_seq_no numeric; 
begin 
 
--  set generated int_seq_no 

	if :new.int_seq_no is null THEN
    select req_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
	end if;
 
--  update "Last Saved" information 
 
-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
     
end;

/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_sub_req_ar" for table "sub_req_ar"
create or replace trigger tib_sub_req_ar before insert
on sub_req_ar for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select req_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_sub_req_text" for table "sub_req_text"
create or replace trigger tib_sub_req_text before insert
on sub_req_text for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select req_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_master" for table "stu_master"
create or replace trigger tib_stu_master before insert
on stu_master for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stumast_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_address" for table "stu_address"
create or replace trigger tib_stu_address before insert
on stu_address for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stumast_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_exceptions" for table "stu_exceptions"
create or replace trigger tib_stu_exceptions before insert
on stu_exceptions for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stuexc_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_exc_courses" for table "stu_exc_courses"
create or replace trigger tib_stu_exc_courses before insert
on stu_exc_courses for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stuexc_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_stu_marker_req" for table "stu_marker_req"
create or replace trigger tib_stu_marker_req before insert
on stu_marker_req for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select stumast_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_mastref_address" for table "mastref_address"
create or replace trigger tib_mastref_address before insert
on mastref_address for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select mref_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_mastref_seg" for table "mastref_seg"
create or replace trigger tib_mastref_seg before insert
on mastref_seg for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select mref_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_tca_rule" for table "tca_rule"
create or replace trigger tib_tca_rule before insert
on tca_rule for each row
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

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_tca_source" for table "tca_source"
create or replace trigger tib_tca_source before insert
on tca_source for each row
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

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
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

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
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

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_transfer_inst" for table "transfer_inst"
create or replace trigger tib_transfer_inst before insert
on transfer_inst for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
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

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/


--  INSERT WITH int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_tca_target" for table "tca_target"
create or replace trigger tib_tca_target before insert
on tca_target for each row
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

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/


--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_cond_codes" for table "cond_codes"
create or replace trigger tub_cond_codes before update
on cond_codes for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_course_bank" for table "course_bank"
create or replace trigger tub_course_bank before update
on course_bank for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_com" for table "com"
create or replace trigger tub_com before update
on com for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_dprog" for table "dprog"
create or replace trigger tub_dprog before update
on dprog for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_req_main" for table "req_main"
create or replace trigger tub_req_main before update
on req_main for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_demo" for table "stu_demo"
create or replace trigger tub_stu_demo before update
on stu_demo for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/


--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_trans_degree" for table "stu_trans_degree"
create or replace trigger tub_stu_trans_degree before update
on stu_trans_degree for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_dprog" for table "stu_dprog"
create or replace trigger tub_stu_dprog before update
on stu_dprog for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_acadrec" for table "stu_acadrec"
create or replace trigger tub_stu_acadrec before update
on stu_acadrec for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_evalgrp" for table "stu_evalgrp"
create or replace trigger tub_stu_evalgrp before update
on stu_evalgrp for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_mastref" for table "mastref"
create or replace trigger tub_mastref before update
on mastref for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_tca_master" for table "tca_master"
create or replace trigger tub_tca_master before update
on tca_master for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_job_queue_list" for table "job_queue_list"
create or replace trigger tub_job_queue_list before update
on job_queue_list for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_string" for table "string"
create or replace trigger tub_string before update
on string for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_string_crse" for table "string_crse"
create or replace trigger tub_string_crse before update
on string_crse for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_gmaster" for table "gmaster"
create or replace trigger tub_gmaster before update
on gmaster for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_repeat" for table "repeat"
create or replace trigger tub_repeat before update
on repeat for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_crs_convert" for table "crs_convert"
create or replace trigger tub_crs_convert before update
on crs_convert for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_dprog_req" for table "dprog_req"
create or replace trigger tub_dprog_req before update
on dprog_req for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_req_text" for table "req_text"
create or replace trigger tub_req_text before update
on req_text for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_req_xy" for table "req_xy"
create or replace trigger tub_req_xy before update
on req_xy for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_sub_req" for table "sub_req"
CREATE OR REPLACE TRIGGER TUB_SUB_REQ before update 
on sub_req for each row 
 
begin 
--  update "Last Saved" information 

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;
 
end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_sub_req_ar" for table "sub_req_ar"
create or replace trigger tub_sub_req_ar before update
on sub_req_ar for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_sub_req_text" for table "sub_req_text"
create or replace trigger tub_sub_req_text before update
on sub_req_text for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_master" for table "stu_master"
create or replace trigger tub_stu_master before update
on stu_master for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/


--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_address" for table "stu_address"
create or replace trigger tub_stu_address before update
on stu_address for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_exceptions" for table "stu_exceptions"
create or replace trigger tub_stu_exceptions before update
on stu_exceptions for each row

begin
--  update "Last Saved" information
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_exc_courses" for table "stu_exc_courses"
create or replace trigger tub_stu_exc_courses before update
on stu_exc_courses for each row

begin
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_marker_req" for table "stu_marker_req"
create or replace trigger tub_stu_marker_req before update
on stu_marker_req for each row

begin
--  update "Last Saved" information

IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_mastref_address" for table "mastref_address"
create or replace trigger tub_mastref_address before update
on mastref_address for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_mastref_seg" for table "mastref_seg"
create or replace trigger tub_mastref_seg before update
on mastref_seg for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_tca_rule" for table "tca_rule"
create or replace trigger tub_tca_rule before update
on tca_rule for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_tca_source" for table "tca_source"
create or replace trigger tub_tca_source before update
on tca_source for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/



--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_tca_target" for table "tca_target"
create or replace trigger tub_tca_target before update
on tca_target for each row

begin
--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

-- *******************
-- New with DARwin 3.5
-- *******************

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_chart_categories" for table "chart_categories"
create or replace trigger tib_chart_categories before insert
on chart_categories for each row

begin

--  update "Last Saved" information

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
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

-- 	UACH-4136	10/01/15	DAP
--	user name is sometimes passed on the insert/update
IF (:new.last_mod_user is null) THEN
	:new.last_mod_user := user;
END IF;
IF (:new.last_mod_date is null) THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/


--  Before insert trigger "tib_whatif_ele_type_assoc" for table "WHATIF_ELEMENT_TYPE_ASSOC"
create or replace trigger tib_whatif_ele_type_assoc before insert
on whatif_element_type_assoc for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select weta_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/

--  Before insert trigger "tib_whatif_forced_marker" for table "WHATIF_FORCED_MARKER"
create or replace trigger tib_whatif_forced_marker before insert
on whatif_forced_marker for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select forced_marker_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/

--  Before insert trigger "tib_whatif_element_filter" for table "WHATIF_ELEMENT_FILTER"
create or replace trigger tib_whatif_element_filter before insert
on whatif_element_filter for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select element_filter_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/

--  ****************************************************************************
--  ALTER JOB_QUEUE_OUT
--  ****************************************************************************

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
--  ALTER JOB_QUEUE_COURSE
--  ****************************************************************************

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
--  ALTER JOB_QUEUE_MARKERS
--  ****************************************************************************

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
