/*==============================================================*/
/* Version:        u.achieve Server 4.3                         */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     10/15/2001 1:53:06 PM                        */
/* Last Modified:  06/05/2015                                   */
/*                                                              */
/* Purpose:        Drop all u.achieve Server tables from        */
/*                 the currently connected database without     */
/*                 regard for logging or recovery.              */
/*                                                              */
/*                 Tables required by u.direct, Schedule Builder*/
/*                 Security, or other u.achieve Suite apps will */
/*                 NOT be deleted by this script.               */
/*==============================================================*/


/* *************************************** */
/* Programs and Requirements               */
/* *************************************** */

-- degree programs
drop table dprog_req 
GO
drop table dprog 
GO

-- sub-requirements
drop table sub_req_text 
GO
drop table sub_req_ar 
GO
drop table sub_req 
GO

-- requirements
drop table req_xy 
GO
drop table req_text 
GO
drop table req_main 
GO

/* *************************************** */
/* transfer evaluation                     */
/* *************************************** */

--  transfer articulation rules
drop table tca_target 
GO
drop table tca_source 
GO
drop table tca_rule 
GO
drop table tca_master 
GO

drop table tca_segment 
GO
drop table transfer_inst 
GO

--  master reference tables
drop table mastref_seg 
GO
drop table mastref_address 
GO
drop table mastref 
GO

/* *************************************** */
/* Support Tabkes                          */
/* *************************************** */

drop table crs_convert 
GO

drop table course_bank 
GO

drop table cond_codes 
GO

drop table chart_categories 
GO

drop table current_jobs 
GO

drop table com 
GO

drop table gmaster 
GO

drop table include_text 
GO

drop table repeat 
GO

drop table string_crse 
GO
drop table string 
GO

--  what-if markers
drop table whatif_forced_marker 
GO
drop table whatif_element_filter 
GO
drop table whatif_element_type_assoc 
GO
drop table dprog_type 
GO


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
GO
drop table stu_demo 
GO

--  exceptions
drop table stu_exc_courses 
GO
drop table stu_exceptions 
GO

--  courses
drop table stu_egrp_courses 
GO
drop table stu_evalgrp 
GO
drop table stu_acadrec 
GO

--  programs
drop table stu_marker_req 
GO
drop table stu_dprog 
GO

drop table stu_trans_degree 
GO

--  primary table
drop table stu_master 
GO



/* *************************************** */
/* Audit Request / Result (job_queue)      */
/* *************************************** */

--  audit request tables
drop table job_queue_sysin 
GO
drop table job_queue_detail 
GO
drop table job_queue_list 
GO

--  audit output tables
drop table job_queue_out 
GO
drop table job_queue_report 
GO
drop table job_queue_exceptions 
GO
drop table job_queue_markers 
GO
drop table job_queue_incl_text 
GO


drop table job_queue_course 
GO
drop table job_queue_accept 
GO

drop table job_queue_subreq_text 
GO
drop table job_queue_subreq 
GO

drop table job_queue_req_text 
GO
drop table job_queue_req 
GO

drop table job_queue_run 
GO

drop table job_queue_destination 
GO

if exists (select 1 from sys.tables where name = 'job_queue_sysout')
	begin
		drop table job_queue_sysout
	end
GO
