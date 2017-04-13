/*================================================================*/
/* Release:			u.achieve 4.3                                 */
/* DBMS name:      	ORACLE Version 10g/11i/12c                    */
/* Created on: 		6/27/2008                                     */
/* Last Updated:   	6/09/2015                                     */
/* Script name: 	uachieve_oracle_public_PUBLIC SYNONYM.sql            */
/*                                                                */
/* Purpose:        	Creates public PUBLIC SYNONYMs in the current        */
/*                  schema for the u.achieve Server tables and    */
/*                  views.                                        */
/*                                                                */
/* *** Beginning with 4.2 ***                                     */
/* We have moved all the security tables and any other tables     */
/* specific to u.achieve self-service to the Dashboard scripts.   */
/*                                                                */
/* This script now contains only those tables specific to the     */
/* u.achieve server.                                              */
/*                                                                */
/* *** Beginning with 4.3 ***                                     */
/* We removed the creation of PUBLIC SYNONYMs for the sequence objects.  */
/* It was unnecessary except in the rarest of circumstances.      */
/*                                                                */
/*================================================================*/

CREATE or REPLACE  PUBLIC SYNONYM com for uachieve.com
/
CREATE or REPLACE  PUBLIC SYNONYM cond_codes for uachieve.cond_codes
/
CREATE or REPLACE  PUBLIC SYNONYM course_bank for uachieve.course_bank
/
CREATE or REPLACE  PUBLIC SYNONYM chart_categories for uachieve.chart_categories
/
CREATE or REPLACE  PUBLIC SYNONYM current_jobs for uachieve.current_jobs
/

CREATE or REPLACE  PUBLIC SYNONYM crs_convert for uachieve.crs_convert
/
CREATE or REPLACE  PUBLIC SYNONYM string for uachieve.string
/
CREATE or REPLACE  PUBLIC SYNONYM string_crse for uachieve.string_crse
/
CREATE or REPLACE  PUBLIC SYNONYM gmaster for uachieve.gmaster
/
CREATE or REPLACE  PUBLIC SYNONYM repeat for uachieve.repeat
/
CREATE or REPLACE  PUBLIC SYNONYM include_text for uachieve.include_text



CREATE or REPLACE  PUBLIC SYNONYM dprog for uachieve.dprog
/
CREATE or REPLACE  PUBLIC SYNONYM dprog_req for uachieve.dprog_req
/

CREATE or REPLACE  PUBLIC SYNONYM req_main for uachieve.req_main
/
CREATE or REPLACE  PUBLIC SYNONYM req_text for uachieve.req_text
/
CREATE or REPLACE  PUBLIC SYNONYM req_xy for uachieve.req_xy
/

CREATE or REPLACE  PUBLIC SYNONYM sub_req for uachieve.sub_req
/
CREATE or REPLACE  PUBLIC SYNONYM sub_req_text for uachieve.sub_req_text
/
CREATE or REPLACE  PUBLIC SYNONYM sub_req_ar for uachieve.sub_req_ar
/

CREATE or REPLACE  PUBLIC SYNONYM stu_master for uachieve.stu_master
/
CREATE or REPLACE  PUBLIC SYNONYM stu_demo for uachieve.stu_demo
/
CREATE or REPLACE  PUBLIC SYNONYM stu_address for uachieve.stu_address
/
CREATE or REPLACE  PUBLIC SYNONYM stu_trans_degree for uachieve.stu_trans_degree
/
CREATE or REPLACE  PUBLIC SYNONYM stu_exceptions for uachieve.stu_exceptions
/
CREATE or REPLACE  PUBLIC SYNONYM stu_exc_courses for uachieve.stu_exc_courses
/
CREATE or REPLACE  PUBLIC SYNONYM stu_dprog for uachieve.stu_dprog
/
CREATE or REPLACE  PUBLIC SYNONYM stu_marker_req for uachieve.stu_marker_req
/
CREATE or REPLACE  PUBLIC SYNONYM stu_acadrec for uachieve.stu_acadrec
/
CREATE or REPLACE  PUBLIC SYNONYM stu_evalgrp for uachieve.stu_evalgrp
/
CREATE or REPLACE  PUBLIC SYNONYM stu_egrp_courses for uachieve.stu_egrp_courses
/

CREATE or REPLACE  PUBLIC SYNONYM vw_stu_demo for uachieve.vw_stu_demo
/
CREATE or REPLACE  PUBLIC SYNONYM vw_stu_master for uachieve.vw_stu_master
/

CREATE or REPLACE  PUBLIC SYNONYM transfer_inst for uachieve.transfer_inst
/

CREATE or REPLACE  PUBLIC SYNONYM mastref for uachieve.mastref
/
CREATE or REPLACE  PUBLIC SYNONYM mastref_seg for uachieve.mastref_seg
/
CREATE or REPLACE  PUBLIC SYNONYM mastref_address for uachieve.mastref_address
/

CREATE or REPLACE  PUBLIC SYNONYM tca_master for uachieve.tca_master
/
CREATE or REPLACE  PUBLIC SYNONYM tca_rule for uachieve.tca_rule
/
CREATE or REPLACE  PUBLIC SYNONYM tca_target for uachieve.tca_target
/
CREATE or REPLACE  PUBLIC SYNONYM tca_source for uachieve.tca_source
/
CREATE or REPLACE  PUBLIC SYNONYM tca_segment for uachieve.tca_segment
/


CREATE or REPLACE  PUBLIC SYNONYM job_queue_list for uachieve.job_queue_list
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_detail for uachieve.job_queue_detail
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_sysin for uachieve.job_queue_sysin
/

CREATE or REPLACE  PUBLIC SYNONYM job_queue_run for uachieve.job_queue_run
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_req for uachieve.job_queue_req
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_subreq for uachieve.job_queue_subreq
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_course for uachieve.job_queue_course
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_accept for uachieve.job_queue_accept
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_req_text for uachieve.job_queue_req_text
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_subreq_text for uachieve.job_queue_subreq_text
/

CREATE or REPLACE  PUBLIC SYNONYM job_queue_out for uachieve.job_queue_out
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_report for uachieve.job_queue_report
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_markers for uachieve.job_queue_markers
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_exceptions for uachieve.job_queue_exceptions
/
CREATE or REPLACE  PUBLIC SYNONYM job_queue_incl_text for uachieve.job_queue_incl_text
/

CREATE or REPLACE  PUBLIC SYNONYM job_queue_destination for uachieve.job_queue_destination
/

CREATE or REPLACE  PUBLIC SYNONYM DPROG_TYPE for uachieve.DPROG_TYPE
/
CREATE or REPLACE  PUBLIC SYNONYM WHATIF_ELEMENT_TYPE_ASSOC for uachieve.WHATIF_ELEMENT_TYPE_ASSOC
/
CREATE or REPLACE  PUBLIC SYNONYM WHATIF_FORCED_MARKER for uachieve.WHATIF_FORCED_MARKER
/
CREATE or REPLACE  PUBLIC SYNONYM WHATIF_ELEMENT_FILTER for uachieve.WHATIF_ELEMENT_FILTER
/
