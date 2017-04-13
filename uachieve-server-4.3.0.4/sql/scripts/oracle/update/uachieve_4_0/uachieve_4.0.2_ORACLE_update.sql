/*==============================================================*/
/* DBMS name:      Oracle               */
/* Created on:     10/09/2008                         */
/* Database Modification Script to                               */
/*Update u.achieve 4.0.[0-1] to u.achieve 4.0.2                    */
/*==============================================================*/
CREATE TABLE JOB_QUEUE_OUT ( 
    INT_SEQ_NO 	NUMBER NOT NULL,
    JOBQ_SEQ_NO	NUMBER NOT NULL,
    USER_SEQ_NO	NUMBER NULL,
    RTABX      	CHAR(3) NULL,
    STABX      	CHAR(3) NULL,
    REQSTATUS  	CHAR(1) NULL,
    SRNO       	CHAR(2) NULL,
    SRSTATUS   	CHAR(1) NULL,
    OPTLINE    	CHAR(1) NULL,
    LASERA     	CHAR(1) NULL,
    LASERB     	CHAR(1) NULL,
    DAROUT     	VARCHAR2(255) NULL,
    CONSTRAINT PK_JOB_QUEUE_OUT PRIMARY KEY(INT_SEQ_NO)
)
/
ALTER TABLE JOB_QUEUE_OUT
    ADD ( CONSTRAINT FK_JOBQ_OUT_REF_JOBQ_RUN
	FOREIGN KEY(JOBQ_SEQ_NO)
	REFERENCES JOB_QUEUE_RUN(INT_SEQ_NO)
	)
/
create sequence jobqo_seq_no
    start with 1
    increment by 1
    maxvalue 999999999;
/
create index jobq_out_idx on job_queue_out (jobq_seq_no)
/
create or replace trigger tib_job_queue_out before insert
on job_queue_out for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
if :new.int_seq_no is null THEN
    select jobqo_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;
end;
/
