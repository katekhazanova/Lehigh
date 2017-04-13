/*********  PLEASE NOTE ***** PLEASE NOTE ***** PLEASE NOTE ********/
/* Two sequences were removed in 4.3.0.  If you are running this   */
/* script on a u.achieve version prior to 4.3.0, you should        */
/* uncomment the last 2 insert statements.  (See line 100)         */
/*=================================================================*/
/* Release:        u.achieve 4.3.0.2                               */
/* DBMS name:      Oracle 10g/11g/12c                              */
/* Created on:     09/29/2015                                      */
/*                                                                 */
/* Purpose:        Update 'start with' on sequence objects that    */
/*                 are out of sync with their data (sequence       */
/*                 currval < max(int_seq_no))                      */
/*                                                                 */
/* Notes:         Some sequences are used for multiple tables.     */
/*                This script will create a temp table to hold the */
/*                max int_seq_no value for each table, then group  */
/*                by the sequence so we can easily determine the   */
/*                max value for the sequence across multiple       */
/*                tables.   Finally, it will update the sequence   */
/*                definitions, but only for those tables that      */
/*                actually need it.                                */
/*=================================================================*/


create global temporary table temp_seq (
    seqname varchar(30), 
    tabname varchar(30), 
    maxseq numeric(9), 
    curval numeric(9), 
constraint pk_temp primary key (seqname, tabname)) 
on commit preserve rows
/

-- the following insert statements find the max int_seq_no for each  
-- table we're interested in, and insert the info into our temp table.
insert into temp_seq (seqname, tabname, maxseq, curval) values ('weta_seq_no', 'whatif_element_type_assoc', (select max(int_seq_no) from whatif_element_type_assoc), weta_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('forced_marker_seq_no', 'whatif_forced_marker', (select max(int_seq_no) from whatif_forced_marker), forced_marker_seq_no.nextval )
/	
insert into temp_seq (seqname, tabname, maxseq, curval) values ('element_filter_seq_no', 'whatif_element_filter', (select max(int_seq_no) from whatif_element_filter), element_filter_seq_no.nextval )
/	
insert into temp_seq (seqname, tabname, maxseq, curval) values ('seq_int_seq_no', 'string', (select max(int_seq_no) from string), seq_int_seq_no.nextval )
/	
insert into temp_seq (seqname, tabname, maxseq, curval) values ('seq_int_seq_no', 'string_crse', (select max(int_seq_no) from string_crse), seq_int_seq_no.nextval)
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('seq_int_seq_no', 'gmaster', (select max(int_seq_no) from gmaster), seq_int_seq_no.nextval)
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('seq_int_seq_no', 'repeat', (select max(int_seq_no) from repeat), seq_int_seq_no.nextval)
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('seq_int_seq_no', 'crs_convert', (select max(int_seq_no) from crs_convert), seq_int_seq_no.nextval)
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('dprog_seq_no', 'dprog_req', (select max(int_seq_no) from dprog_req), dprog_seq_no.nextval)
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('req_seq_no', 'req_text', (select max(int_seq_no) from req_text), req_seq_no.nextval)
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('req_seq_no', 'req_xy', (select max(int_seq_no) from req_xy), req_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('req_seq_no', 'sub_req', (select max(int_seq_no) from sub_req), req_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('req_seq_no', 'sub_req_text', (select max(int_seq_no) from sub_req_text), req_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('req_seq_no', 'sub_req_ar', (select max(int_seq_no) from sub_req_ar), req_seq_no.nextval)
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('stumast_seq_no', 'stu_master', (select max(int_seq_no) from stu_master), stumast_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('stumast_seq_no', 'stu_address', (select max(int_seq_no) from stu_address), stumast_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('stumast_seq_no', 'stu_marker_req', (select max(int_seq_no) from stu_marker_req), stumast_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('stuexc_seq_no', 'stu_exceptions', (select max(int_seq_no) from stu_exceptions), stuexc_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('stuexc_seq_no', 'stu_exc_courses', (select max(int_seq_no) from stu_exc_courses), stuexc_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('mref_seq_no', 'mastref_seg', (select max(int_seq_no) from mastref_seg), mref_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('mref_seq_no', 'mastref_address', (select max(int_seq_no) from mastref_address), mref_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('tca_seq_no', 'tca_rule', (select max(int_seq_no) from tca_rule), tca_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('tca_seq_no', 'tca_target', (select max(int_seq_no) from tca_target), tca_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('tca_seq_no', 'tca_source', (select max(int_seq_no) from tca_source), tca_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqd_seq_no', 'job_queue_detail', (select max(int_seq_no) from job_queue_detail), jobqd_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqsi_seq_no', 'job_queue_sysin', (select max(int_seq_no) from job_queue_sysin), jobqsi_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqr_seq_no', 'job_queue_run', (select max(int_seq_no) from job_queue_run), jobqr_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqo_seq_no', 'job_queue_out', (select max(int_seq_no) from job_queue_out), jobqo_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqcrs_seq_no', 'job_queue_course', (select max(int_seq_no) from job_queue_course), jobqcrs_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqacpt_seq_no', 'job_queue_accept', (select max(int_seq_no) from job_queue_accept), jobqacpt_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqmrk_seq_no', 'job_queue_markers', (select max(int_seq_no) from job_queue_markers), jobqmrk_seq_no.nextval )
/
insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqexc_seq_no', 'job_queue_exceptions', (select max(int_seq_no) from job_queue_exceptions), jobqexc_seq_no.nextval )
/
/********************************************************************************************************************************************************************************/
--  The next two sequence objects were removed in 4.3.0.  Uncomment the next two insert statements if you are running this script on a u.achieve version prior to 4.3.0.
/********************************************************************************************************************************************************************************/
--insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobq_inclt_seq_no', 'job_queue_incl_text', (select max(int_seq_no) from job_queue_incl_text), jobq_inclt_seq_no.nextval )
--/
--insert into temp_seq (seqname, tabname, maxseq, curval) values ('jobqrpt_seq_no', 'job_queue_report', (select max(int_seq_no) from job_queue_report), jobqrpt_seq_no.nextval )
--/
/********************************************************************************************************************************************************************************/

--  This select is somewhat useless - just a confirmation that our inserts worked
select * 
    from temp_seq
    order by seqname, tabname
/

--  The max value required for each sequence, accounting for usage across multiple tables.
select seqname "Sequence Name", max(maxseq) "Max Int_Seq_No", max(curval) "Current Seq Val", 
    (CASE WHEN max(curval) < max(maxseq) THEN 'Y' ELSE ' ' END) as "Needs Update" 
from temp_seq 
group by seqname
order by seqname
/

--  for each unique sequence defined in the temp table, update the definition
DECLARE
    seq_name        varchar2(100);
    new_start_val   numeric(18);

    cursor max_seq_cursor is
        select seqname, max(maxseq)
        from temp_seq
        where curval < maxseq
        group by seqname
        order by seqname;
BEGIN
    open max_seq_cursor;

    loop
        fetch max_seq_cursor into seq_name, new_start_val;
        EXIT WHEN max_seq_cursor%NOTFOUND;

        new_start_val := new_start_val + 100;
        dbms_output.put_line('Update Sequence: ' || seq_name || '.  New Start Value: ' || new_start_val);

        execute immediate 'drop sequence ' || seq_name;
        execute immediate 
			'create sequence ' ||seq_name  ||
			' start with ' || new_start_val ||
			' nomaxvalue minvalue 1 increment by 1 cache 20 noorder';
        
    end loop;

    close max_seq_cursor;
END;
/

--  clean up by dropping temp table
truncate table temp_seq
/
drop table temp_seq
/
