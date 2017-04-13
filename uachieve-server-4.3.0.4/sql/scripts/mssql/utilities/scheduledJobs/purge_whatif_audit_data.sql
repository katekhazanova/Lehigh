/*==============================================================*/
/* Database name:  uAchive 4.0                                  */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     10/05/2008 12:09:31 PM                       */
/* Updated on:     05/23/2013									*/
/*                                                              */
/* Script name:    uAmss_purge_jobq.sql                      	*/
/* Purpose:                                                     */
/* Script to purge all audit requests that are marked as        */ 
/* having been run (have a status of 'D' or 'E'),		        */
/* and all audit reports that are over 7 days old.              */
/*                                                              */
/* Copyright(c) 1998-2013 CollegeSource Inc, All Rights Reserved*/
/*                                                              */
/*==============================================================*/
declare @keepDate 	datetime,
		@keepHours	int;

set @keepHours = 4;
set @keepDate = dateadd(hour, -(@keepHours), getdate());

select @keepDate as 'Delete audit output created before...', count(*) as 'Audits being purged'
	from job_queue_run
	where rundate < @keepDate and dprog_type = 'W';

begin transaction
    delete from job_queue_course
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');
commit transaction;

begin transaction
    delete from job_queue_accept
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');
commit transaction;

begin transaction
    delete from job_queue_subreq_text
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');

    delete from job_queue_subreq
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');
commit transaction;

begin transaction
    delete from job_queue_req_text
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');

    delete from job_queue_req
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');
commit transaction

begin transaction
    delete from job_queue_exceptions
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');

    delete from job_queue_markers
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');

    delete from job_queue_incl_text
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');
commit transaction

begin transaction
    delete from job_queue_report
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');

    delete from job_queue_out
    where jobq_seq_no in 
        (select int_seq_no from job_queue_run
        where rundate < @keepDate and dprog_type = 'W');

    delete from job_queue_run
    where rundate < @keepDate and dprog_type = 'W';
commit transaction

select @keepDate as 'Delete audit requests created before...', count(*) as 'Requests being purged'
from job_queue_list
where status in ('D', 'E') and last_mod_date < @keepDate

begin transaction
    delete from job_queue_detail
    where jobid in (select jobid 
                from job_queue_list
                where status in ('D', 'E')
                and last_mod_date < @keepDate);


    delete from job_queue_sysin
    where jobid in (select jobid 
                from job_queue_list
                where status in ('D', 'E')
                and last_mod_date < @keepDate);

    delete from job_queue_list
    where status in ('D', 'E')
    and last_mod_date < @keepDate;
commit transaction;
go