/*==============================================================*/
/* Version:        u.achieve Server 4.3                         */
/* DBMS name:      Oracle 10i/11g/12c                           */
/* Created on:     10/15/2001 1:53:06 PM                        */
/* Last Modified:  06/07/2015                                   */
/*                                                              */
/* Purpose:        Drop all u.achieve Server tables from        */
/*                 the currently connected database without     */
/*                 regard for logging or recovery.              */
/*                                                              */
/*                 Tables required by u.direct, Schedule Builder*/
/*                 Security, or other u.achieve Suite apps will */
/*                 NOT be dropped by this script.               */
/*==============================================================*/


/* *************************************** */
/* Programs and Requirements               */
/* *************************************** */

-- degree programs
drop table dprog_req 
/
drop table dprog 
/

-- sub-requirements
drop table sub_req_text 
/
drop table sub_req_ar 
/
drop table sub_req 
/

-- requirements
drop table req_xy 
/
drop table req_text 
/
drop table req_main 
/

/* *************************************** */
/* transfer evaluation                     */
/* *************************************** */

--  transfer articulation rules
drop table tca_target 
/
drop table tca_source 
/
drop table tca_rule 
/
drop table tca_master 
/

--  New tables in 4.3
drop table tca_segment
/
drop table transfer_inst
/

--  master reference tables
drop table mastref_seg 
/
drop table mastref_address 
/
drop table mastref 
/

/* *************************************** */
/* Support Tabkes                          */
/* *************************************** */

drop table crs_convert 
/

drop table course_bank 
/

drop table cond_codes 
/

drop table chart_categories 
/

drop table current_jobs 
/

drop table com 
/

drop table gmaster 
/

drop table include_text 
/

drop table repeat 
/

drop table string_crse 
/
drop table string 
/

/* *************************************** */
/* What-if Marker Setup                    */
/* *************************************** */
drop table whatif_forced_marker 
/
drop table whatif_element_filter 
/
drop table whatif_element_type_assoc 
/
drop table dprog_type 
/


/* *************************************** */
/* u.achieve Student                       */
/* *************************************** */

--  views
drop view vw_stu_demo
/
drop view vw_stu_master
/

--  demographics
drop table stu_address 
/
drop table stu_demo 
/

--  exceptions
drop table stu_exc_courses 
/
drop table stu_exceptions 
/

--  courses
drop table stu_egrp_courses 
/
drop table stu_evalgrp 
/
drop table stu_acadrec 
/

--  programs
drop table stu_marker_req 
/
drop table stu_dprog 
/

drop table stu_trans_degree 
/

--  primary table
drop table stu_master 
/



/* *************************************** */
/* Audit Request / Result (job_queue)      */
/* *************************************** */

--  audit request tables
drop table job_queue_sysin 
/
drop table job_queue_detail 
/
drop table job_queue_list 
/

--  audit output tables
drop table job_queue_out 
/
drop table job_queue_report 
/
drop table job_queue_exceptions 
/
drop table job_queue_markers 
/
drop table job_queue_incl_text 
/


drop table job_queue_course 
/
drop table job_queue_accept 
/

drop table job_queue_subreq_text 
/
drop table job_queue_subreq 
/

drop table job_queue_req_text 
/
drop table job_queue_req 
/

drop table job_queue_run 
/

drop table job_queue_destination 
/

begin
	execute immediate 'drop table job_queue_sysout';
exception
	when others then
		if sqlcode != -942 then
			raise;
		end if;
end;
/



/* ******************************************* */
/*         Dropping Sequence Objects           */
/* ******************************************* */

-- Current sequence objects

drop sequence seq_int_seq_no
/

drop sequence jobqd_seq_no
/

drop sequence jobqsi_seq_no
/

drop sequence jobqr_seq_no
/

drop sequence dprog_seq_no
/

drop sequence req_seq_no
/

drop sequence mref_seq_no
/

drop sequence tca_seq_no
/

drop sequence stuexc_seq_no
/

drop sequence stumast_seq_no
/

drop sequence weta_seq_no
/

drop sequence forced_marker_seq_no
/

drop sequence element_filter_seq_no
/

-- Obsolete Sequence objects.  Most of these were in use until u.achieve 4.3.
-- Depending on when you're running this script, they may or may not exist.
-- The exception just catches and discards 'sequence does not exist' errors.
-- All other errors will be raised.

begin
  execute immediate 'drop sequence jobqcrs_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence jobqacpt_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence jobqo_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence jobqso_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence jobqrpt_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence jobqmrk_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence jobqexc_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence jobq_inclt_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/

begin
  execute immediate 'drop sequence analy_seq_no';
exception
  when others then
    if sqlcode != -2289 then
      raise;
    end if;
end;
/