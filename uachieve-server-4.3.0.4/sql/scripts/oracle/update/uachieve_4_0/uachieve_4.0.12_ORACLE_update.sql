/*==============================================================*/
/* Database name:  u.achieve 4.0                                */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     6/27/2008 1:18:54 PM                         */
/*==============================================================*/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_job_queue_list" for table "job_queue_list"
create or replace trigger tib_job_queue_list before insert
on job_queue_list for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
    
end;
/

--  INSERT WITHOUT int_seq_no, WITH last_mod_user, date
--  Before insert trigger "tib_whatif_courses" for table "whatif_courses"
create or replace trigger tib_whatif_courses before insert
on whatif_courses for each row

begin

--  update "Last Saved" information

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_stu_exc_courses" for table "stu_exc_courses"
create or replace trigger tub_stu_exc_courses before update
on stu_exc_courses for each row

begin
IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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
IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
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

IF NOT UPDATING('last_mod_user') THEN
	:new.last_mod_user := user;
END IF;
IF NOT UPDATING('last_mod_date') THEN   
	:new.last_mod_date := sysdate;
END IF;

end;
/