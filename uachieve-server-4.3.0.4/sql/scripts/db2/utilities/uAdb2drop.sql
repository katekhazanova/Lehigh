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
go
drop table dprog 
go

-- sub-requirements
drop table sub_req_text 
go
drop table sub_req_ar 
go
drop table sub_req 
go

-- requirements
drop table req_xy 
go
drop table req_text 
go
drop table req_main 
go

/* *************************************** */
/* transfer evaluation                     */
/* *************************************** */

--  transfer articulation rules
drop table tca_target 
go
drop table tca_source 
go
drop table tca_rule 
go
drop table tca_master 
go

--  New tables in 4.3
drop table tca_segment
go
drop table transfer_inst
go

--  master reference tables
drop table mastref_seg 
go
drop table mastref_address 
go
drop table mastref 
go

/* *************************************** */
/* Support Tables                          */
/* *************************************** */

drop table crs_convert 
go

drop table course_bank 
go

drop table cond_codes 
go

drop table chart_categories 
go

drop table current_jobs 
go

drop table com 
go

drop table gmaster 
go

drop table include_text 
go

drop table repeat 
go

drop table string_crse 
go
drop table string 
go

/* *************************************** */
/* What-if Marker Setup                    */
/* *************************************** */
drop table whatif_forced_marker 
go
drop table whatif_element_filter 
go
drop table whatif_element_type_assoc 
go
drop table dprog_type 
go


/* *************************************** */
/* u.achieve Student                       */
/* *************************************** */

--  views
drop view vw_stu_demo
go
drop view vw_stu_master
go

--  demographics
drop table stu_address 
go
drop table stu_demo 
go

--  exceptions
drop table stu_exc_courses 
go
drop table stu_exceptions 
go

--  courses
drop table stu_egrp_courses 
go
drop table stu_evalgrp 
go
drop table stu_acadrec 
go

--  programs
drop table stu_marker_req 
go
drop table stu_dprog 
go

drop table stu_trans_degree 
go

--  primary table
drop table stu_master 
go



/* *************************************** */
/* Audit Request / Result (job_queue)      */
/* *************************************** */

--  audit request tables
drop table job_queue_sysin 
go
drop table job_queue_detail 
go
drop table job_queue_list 
go

--  audit output tables
drop table job_queue_out 
go
drop table job_queue_report 
go
drop table job_queue_exceptions 
go
drop table job_queue_markers 
go
drop table job_queue_incl_text 
go


drop table job_queue_course 
go
drop table job_queue_accept 
go

drop table job_queue_subreq_text 
go
drop table job_queue_subreq 
go

drop table job_queue_req_text 
go
drop table job_queue_req 
go

drop table job_queue_run 
go

drop table job_queue_destination 
go
