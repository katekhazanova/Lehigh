/*================================================================*/
/* Release:			u.achieve 4.3                                 */
/* DBMS name:      	ORACLE Version 10g/11i/12c                    */
/* Created on: 		6/27/2008                                     */
/* Last Updated:   	6/09/2015                                     */
/* Script name: 	uachieve_oracle_private_synonym.sql           */
/*                                                                */
/* Purpose:        	Creates private synonyms in the current       */
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
/* We removed the creation of synonyms for the sequence objects.  */
/* It was unnecessary except in the rarest of circumstances.      */
/*                                                                */
/*================================================================*/

CREATE or REPLACE  SYNONYM com for uachieve.com
/
CREATE or REPLACE  SYNONYM cond_codes for uachieve.cond_codes
/
CREATE or REPLACE  SYNONYM course_bank for uachieve.course_bank
/
CREATE or REPLACE  SYNONYM chart_categories for uachieve.chart_categories
/
CREATE or REPLACE  SYNONYM current_jobs for uachieve.current_jobs
/

CREATE or REPLACE  SYNONYM crs_convert for uachieve.crs_convert
/
CREATE or REPLACE  SYNONYM string for uachieve.string
/
CREATE or REPLACE  SYNONYM string_crse for uachieve.string_crse
/
CREATE or REPLACE  SYNONYM gmaster for uachieve.gmaster
/
CREATE or REPLACE  SYNONYM repeat for uachieve.repeat
/
CREATE or REPLACE  SYNONYM include_text for uachieve.include_text



CREATE or REPLACE  SYNONYM dprog for uachieve.dprog
/
CREATE or REPLACE  SYNONYM dprog_req for uachieve.dprog_req
/

CREATE or REPLACE  SYNONYM req_main for uachieve.req_main
/
CREATE or REPLACE  SYNONYM req_text for uachieve.req_text
/
CREATE or REPLACE  SYNONYM req_xy for uachieve.req_xy
/

CREATE or REPLACE  SYNONYM sub_req for uachieve.sub_req
/
CREATE or REPLACE  SYNONYM sub_req_text for uachieve.sub_req_text
/
CREATE or REPLACE  SYNONYM sub_req_ar for uachieve.sub_req_ar
/

CREATE or REPLACE  SYNONYM stu_master for uachieve.stu_master
/
CREATE or REPLACE  SYNONYM stu_demo for uachieve.stu_demo
/
CREATE or REPLACE  SYNONYM stu_address for uachieve.stu_address
/
CREATE or REPLACE  SYNONYM stu_trans_degree for uachieve.stu_trans_degree
/
CREATE or REPLACE  SYNONYM stu_exceptions for uachieve.stu_exceptions
/
CREATE or REPLACE  SYNONYM stu_exc_courses for uachieve.stu_exc_courses
/
CREATE or REPLACE  SYNONYM stu_dprog for uachieve.stu_dprog
/
CREATE or REPLACE  SYNONYM stu_marker_req for uachieve.stu_marker_req
/
CREATE or REPLACE  SYNONYM stu_acadrec for uachieve.stu_acadrec
/
CREATE or REPLACE  SYNONYM stu_evalgrp for uachieve.stu_evalgrp
/
CREATE or REPLACE  SYNONYM stu_egrp_courses for uachieve.stu_egrp_courses
/

CREATE or REPLACE  SYNONYM vw_stu_demo for uachieve.vw_stu_demo
/
CREATE or REPLACE  SYNONYM vw_stu_master for uachieve.vw_stu_master
/

CREATE or REPLACE  SYNONYM transfer_inst for uachieve.transfer_inst
/

CREATE or REPLACE  SYNONYM mastref for uachieve.mastref
/
CREATE or REPLACE  SYNONYM mastref_seg for uachieve.mastref_seg
/
CREATE or REPLACE  SYNONYM mastref_address for uachieve.mastref_address
/

CREATE or REPLACE  SYNONYM tca_master for uachieve.tca_master
/
CREATE or REPLACE  SYNONYM tca_rule for uachieve.tca_rule
/
CREATE or REPLACE  SYNONYM tca_target for uachieve.tca_target
/
CREATE or REPLACE  SYNONYM tca_source for uachieve.tca_source
/
CREATE or REPLACE  SYNONYM tca_segment for uachieve.tca_segment
/


CREATE or REPLACE  SYNONYM job_queue_list for uachieve.job_queue_list
/
CREATE or REPLACE  SYNONYM job_queue_detail for uachieve.job_queue_detail
/
CREATE or REPLACE  SYNONYM job_queue_sysin for uachieve.job_queue_sysin
/

CREATE or REPLACE  SYNONYM job_queue_run for uachieve.job_queue_run
/
CREATE or REPLACE  SYNONYM job_queue_req for uachieve.job_queue_req
/
CREATE or REPLACE  SYNONYM job_queue_subreq for uachieve.job_queue_subreq
/
CREATE or REPLACE  SYNONYM job_queue_course for uachieve.job_queue_course
/
CREATE or REPLACE  SYNONYM job_queue_accept for uachieve.job_queue_accept
/
CREATE or REPLACE  SYNONYM job_queue_req_text for uachieve.job_queue_req_text
/
CREATE or REPLACE  SYNONYM job_queue_subreq_text for uachieve.job_queue_subreq_text
/

CREATE or REPLACE  SYNONYM job_queue_out for uachieve.job_queue_out
/
CREATE or REPLACE  SYNONYM job_queue_report for uachieve.job_queue_report
/
CREATE or REPLACE  SYNONYM job_queue_markers for uachieve.job_queue_markers
/
CREATE or REPLACE  SYNONYM job_queue_exceptions for uachieve.job_queue_exceptions
/
CREATE or REPLACE  SYNONYM job_queue_incl_text for uachieve.job_queue_incl_text
/

CREATE or REPLACE  SYNONYM job_queue_destination for uachieve.job_queue_destination
/

CREATE or REPLACE  SYNONYM DPROG_TYPE for uachieve.DPROG_TYPE
/
CREATE or REPLACE  SYNONYM WHATIF_ELEMENT_TYPE_ASSOC for uachieve.WHATIF_ELEMENT_TYPE_ASSOC
/
CREATE or REPLACE  SYNONYM WHATIF_FORCED_MARKER for uachieve.WHATIF_FORCED_MARKER
/
CREATE or REPLACE  SYNONYM WHATIF_ELEMENT_FILTER for uachieve.WHATIF_ELEMENT_FILTER
/
