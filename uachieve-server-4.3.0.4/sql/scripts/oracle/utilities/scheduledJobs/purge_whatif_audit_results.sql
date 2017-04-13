/*==============================================================*/
/* DARwin Release: uAchieve 4.3                                 */
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     04/24/2015                                   */
/* Updated on:     04/24/2015                                   */
/*                                                              */
/* Script to purge all what-if audit results that are over      */ 
/* x hours old.                                                 */
/*                                                              */
/* Number of hours to keep audit data is determined by variable */
/* keepHours, which can be set to any integer value.            */
/* Default is 4.                                                */
/*                                                              */
/* For best results, schedule this job to run hourly.           */
/*==============================================================*/

declare
	keepHours int := 4;
	
    deleteCount int := 0;
    keepDate date := (sysdate - (keepHours/24));

    cursor outlist is
        select int_seq_no 
        from job_queue_run
        where rundate < keepDate
        and dprog_type = 'W';
    
begin

    select  count(*)
    from job_queue_run
    where rundate < keepDate
    and dprog_type = 'W';

    dbms_output.put_line('Delete what-if audit output created before ' || keepDate || '.  Number of audits being deleted is ' || deleteCount);

    for jobqrun_rec in outlist loop
        delete from job_queue_course
        where jobq_seq_no = jobqrun_rec.int_seq_no;
        
        delete from job_queue_accept
        where jobq_seq_no = jobqrun_rec.int_seq_no;

        delete from job_queue_subreq_text
        where jobq_seq_no = jobqrun_rec.int_seq_no;

        delete from job_queue_subreq
        where jobq_seq_no = jobqrun_rec.int_seq_no;

        delete from job_queue_req_text
        where jobq_seq_no = jobqrun_rec.int_seq_no;

        delete from job_queue_req
        where jobq_seq_no = jobqrun_rec.int_seq_no;
        
        delete from job_queue_report
        where jobq_seq_no = jobqrun_rec.int_seq_no;
        
        delete from job_queue_exceptions
        where jobq_seq_no = jobqrun_rec.int_seq_no;
        
        delete from job_queue_markers
        where jobq_seq_no = jobqrun_rec.int_seq_no;
        
        delete from job_queue_incl_text
        where jobq_seq_no = jobqrun_rec.int_seq_no;
                
        delete from job_queue_out
        where jobq_seq_no = jobqrun_rec.int_seq_no;
        
        delete from job_queue_run
        where int_seq_no = jobqrun_rec.int_seq_no;
    
        commit;
   end loop;
    
	exception
    	when others then rollback;
    	
end;
/