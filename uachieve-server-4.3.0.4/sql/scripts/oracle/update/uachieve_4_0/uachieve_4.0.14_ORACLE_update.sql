alter table job_queue_course add PASSFAIL CHAR(1)  NULL
/
alter table job_queue_course add ADDCT    INTEGER  NULL
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
 
IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
     
end;

/