/*==============================================================*/
/* DARwin Release: uAchieve 4.0                                 */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     10/05/2008                                   */
/* Updated on:     08/26/2014                                   */
/*                                                              */
/* Script to purge all audit requests that are marked as        */ 
/* having been run (have a status of'D' or 'E'),                */
/* and all audit reports that are over 7 days old.              */
/*                                                              */
/*==============================================================*/

declare
    deleteCount int := 0;
    keepDate date := (sysdate - 21);

    cursor outlist is
        select int_seq_no from job_queue_run
        where rundate < keepDate;
        
    cursor inlist is
        select jobid from job_queue_list
        where status in ('D', 'E')
        and last_mod_date < keepDate;
    
begin

    select  count(*)
    into deleteCount
    from job_queue_run
    where RUNDATE < keepDate;

    dbms_output.put_line('Delete audit  output  created before ' || keepDate || '.  Number of  audits  being deleted is ' || deleteCount);

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
    

    select  count(*)
        into deleteCount
        from job_queue_list
        where last_mod_date < keepDate
        and STATUS in ('D', 'E');

   dbms_output.put_line('Delete audit requests created before ' || keepDate || '.  Number of requests being deleted is ' || deleteCount);

    for jobqlist_rec in inlist loop
    
        delete from job_queue_detail
        where jobid = jobqlist_rec.jobid;

        delete from job_queue_sysin
        where jobid = jobqlist_rec.jobid;

        delete from job_queue_list
        where jobid = jobqlist_rec.jobid;

        commit;
    end loop;

    
exception
    when others then 
        rollback;
end;
/