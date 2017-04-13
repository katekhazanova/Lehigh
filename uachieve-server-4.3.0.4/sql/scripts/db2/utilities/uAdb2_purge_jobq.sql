--==============================================================*/
-- uAchieve Release: DARwin 4.0                                */
-- DBMS name:      DB2 Version 8                                */
-- Created on:     10/05/2008                                   */
--                                                              */
-- Script to purge all audit requests that are marked as        */ 
-- having been run (have a status other than 'N' or 'S'),       */
-- and all audit reports that are over 7 days old.              */
--                                                              */
--==============================================================*/

delete from  job_queue_course where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from  job_queue_accept where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from  job_queue_subreq_text where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from  job_queue_subreq where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from  job_queue_req_text where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from  job_queue_req where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from  job_queue_report where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from  job_queue_out where jobq_seq_no in (Select int_seq_no from job_queue_run where rundate < current date - 7 day)
commit

delete from job_queue_run where rundate < current date - 7 day
commit

delete from job_queue_sysin where jobid IN (select jobid from job_queue_list where status in ('D', 'E'))
commit

delete from job_queue_detail where jobid IN (select jobid from job_queue_list where status in ('D', 'E'))
delete from job_queue_list where status NOT  in ('N', 'S')
commit