-- Stu-master table alteration: adding pidm column
begin
    execute immediate 'alter table stu_master 	add 	pidm 	number(10) 	null';
    execute immediate 'create unique index pidm_idx	on stu_master (pidm asc)';
exception
    when others then
        if sqlcode not in(-1430) then		-- don't throw 'column already exists' error
            raise;							-- but raise all others
        end if;
end;
/


-- Stu_master table trigger changes

CREATE OR REPLACE TRIGGER TIB_STU_MASTER
BEFORE INSERT
ON DARS.STU_MASTER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
declare
    next_seq_no numeric;
 pidm_in numeric;
begin
--  set generated int_seq_no
IF :NEW.INT_SEQ_NO IS NULL OR :NEW.INT_SEQ_NO < 0 THEN
 select stumast_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
END IF;
IF :NEW.STUNO IS NOT NULL AND :NEW.PIDM IS NULL THEN
   Select Spriden_Pidm
       INTO pidm_in
     from Spriden
     WHERE
     Spriden_id = RTRIM(:New.stuno)
     and
     Spriden_Change_ind is null;
 :new.pidm := pidm_in;
END IF; 
--  update "Last Saved" information
    :new.last_mod_user := user;
    :new.last_mod_date := sysdate;
end;
/


-- Exception table trigger changes

CREATE OR REPLACE TRIGGER tib_stu_exceptions BEFORE INSERT 
ON stu_exceptions for each row
declare
    next_seq_no numeric;
begin
--  set generated int_seq_no
   IF :NEW.INT_SEQ_NO IS NULL OR :NEW.INT_SEQ_NO < 0 THEN
    select stuexc_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
END IF;
--  update "Last Saved" information
    :new.last_mod_user := user;
    :new.last_mod_date := sysdate;
end;
/

commit;

