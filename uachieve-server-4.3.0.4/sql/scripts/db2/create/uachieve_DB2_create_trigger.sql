--================================================================
-- DBMS name:      IBM DB2                                            
-- Created on:     7/23/2010                                      
-- Last Updated:   4/22/2016                                      
-- Script name:    uachieve_DB2_create_trigger.sql                
-- Purpose:        Creates triggers for the u.achieve server      
--                                                                
-- Beginning with 4.2, we have moved all the security tables      
-- and any other tables specific to u.achieve self-service to     
-- the Dashboard installation scripts.                            
--                                                                
-- This script now contains only those tables specific to the     
-- u.achieve server.                                              
--                                                                
-- Copyright(c) 1998-2016 CollegeSource, Inc. All Rights Reserved 
--                                                                
--================================================================

SET SCHEMA UA43_CREATE;

---before insert, timestamp, user
---create or replace trigger

create or replace trigger ti_com
	NO CASCADE BEFORE INSERT ON COM   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
	begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_cond_condes
	NO CASCADE BEFORE INSERT ON COND_CODES	
	REFERENCING NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_crse_bank
	NO CASCADE BEFORE INSERT ON COURSE_BANK	
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_crs_convert
	NO CASCADE BEFORE INSERT ON CRS_CONVERT   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_dprog
	NO CASCADE BEFORE INSERT ON DPROG   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_dprog_req
	NO CASCADE BEFORE INSERT ON DPROG_REQ	
	REFERENCING NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_gmaster
	NO CASCADE BEFORE INSERT ON GMASTER   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_job_queue_list
	NO CASCADE BEFORE INSERT ON JOB_QUEUE_LIST   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_mastref
	NO CASCADE BEFORE INSERT ON MASTREF   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_mastref_address
	NO CASCADE BEFORE INSERT ON MASTREF_ADDRESS
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_mastref_seg
	NO CASCADE BEFORE INSERT ON MASTREF_SEG
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_repeat
	NO CASCADE BEFORE INSERT ON REPEAT   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_req_main
	NO CASCADE BEFORE INSERT ON REQ_MAIN	 
	REFERENCING NEW AS n	 
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_req_text
	NO CASCADE BEFORE INSERT ON REQ_TEXT	
	REFERENCING NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_req_xy
	NO CASCADE BEFORE INSERT ON REQ_XY   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_string
	NO CASCADE BEFORE INSERT ON STRING   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_string_crse
	NO CASCADE BEFORE INSERT ON STRING_CRSE
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_acadrec
	NO CASCADE BEFORE INSERT ON STU_ACADREC
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_address
	NO CASCADE BEFORE INSERT ON STU_ADDRESS
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_demo
	NO CASCADE BEFORE INSERT ON STU_DEMO	
	REFERENCING NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_dprog
	NO CASCADE BEFORE INSERT ON STU_DPROG   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_evalgrp
	NO CASCADE BEFORE INSERT ON STU_EVALGRP   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_exceptions
	NO CASCADE BEFORE INSERT ON STU_EXCEPTIONS   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_exc_courses
	NO CASCADE BEFORE INSERT ON STU_EXC_COURSES   
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_info
	NO CASCADE BEFORE INSERT ON STU_MASTER   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_marker_req
	NO CASCADE BEFORE INSERT ON STU_MARKER_REQ
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_stu_trans_deg
	NO CASCADE BEFORE INSERT ON STU_TRANS_DEGREE	
	REFERENCING NEW AS n	 
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_sub_req
	NO CASCADE BEFORE INSERT ON SUB_REQ	 
	REFERENCING NEW AS n	 
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_sub_req_ar
	NO CASCADE BEFORE INSERT ON SUB_REQ_AR
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_sub_req_text
	NO CASCADE BEFORE INSERT ON SUB_REQ_TEXT   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_transfer_inst
	NO CASCADE BEFORE INSERT ON TRANSFER_INST
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_tca_master
	NO CASCADE BEFORE INSERT ON TCA_MASTER
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_tca_segment
	NO CASCADE BEFORE INSERT ON TCA_SEGMENT
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_tca_rule
	NO CASCADE BEFORE INSERT ON TCA_RULE   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_tca_source
	NO CASCADE BEFORE INSERT ON TCA_SOURCE   
	REFERENCING NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_tca_target
	NO CASCADE BEFORE INSERT ON TCA_TARGET
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger ti_chartcat
	NO CASCADE BEFORE INSERT ON CHART_CATEGORIES
	REFERENCING NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end

;
 

---before update, timestamp, user
---create or replace trigger

create or replace trigger tu_com
	NO CASCADE BEFORE UPDATE ON COM   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_cond_condes
	NO CASCADE BEFORE UPDATE ON COND_CODES	
	REFERENCING OLD AS o NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_crse_bank
	NO CASCADE BEFORE UPDATE ON COURSE_BANK	
	REFERENCING OLD AS o NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_crs_convert
	NO CASCADE BEFORE UPDATE ON CRS_CONVERT   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_dprog
	NO CASCADE BEFORE UPDATE ON DPROG   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_dprog_req
	NO CASCADE BEFORE UPDATE ON DPROG_REQ	
	REFERENCING OLD AS o NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_gmaster
	NO CASCADE BEFORE UPDATE ON GMASTER   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_job_queue_list
	NO CASCADE BEFORE UPDATE ON JOB_QUEUE_LIST   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_mastref
	NO CASCADE BEFORE UPDATE ON MASTREF   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_mastref_address
	NO CASCADE BEFORE UPDATE ON MASTREF_ADDRESS
	REFERENCING OLD AS o NEW AS n	
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_mastref_seg
	NO CASCADE BEFORE UPDATE ON MASTREF_SEG
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_repeat
	NO CASCADE BEFORE UPDATE ON REPEAT   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_req_main
	NO CASCADE BEFORE UPDATE ON REQ_MAIN	 
	REFERENCING OLD AS o NEW AS n	 
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_req_text
	NO CASCADE BEFORE UPDATE ON REQ_TEXT	
	REFERENCING OLD AS o NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_req_xy
	NO CASCADE BEFORE UPDATE ON REQ_XY   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_string
	NO CASCADE BEFORE UPDATE ON STRING   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_string_crse
	NO CASCADE BEFORE UPDATE ON STRING_CRSE
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_acadrec
	NO CASCADE BEFORE UPDATE ON STU_ACADREC
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_address
	NO CASCADE BEFORE UPDATE ON STU_ADDRESS
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_demo
	NO CASCADE BEFORE UPDATE ON STU_DEMO	
	REFERENCING OLD AS o NEW AS n	
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_dprog
	NO CASCADE BEFORE UPDATE ON STU_DPROG   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_evalgrp
	NO CASCADE BEFORE UPDATE ON STU_EVALGRP   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_exceptions
	NO CASCADE BEFORE UPDATE ON STU_EXCEPTIONS   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_exc_courses
	NO CASCADE BEFORE UPDATE ON STU_EXC_COURSES   
	REFERENCING OLD AS o NEW AS n    
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_info
	NO CASCADE BEFORE UPDATE ON STU_MASTER   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_marker_req
	NO CASCADE BEFORE UPDATE ON STU_MARKER_REQ
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_stu_trans_deg
	NO CASCADE BEFORE UPDATE ON STU_TRANS_DEGREE	
	REFERENCING OLD AS o NEW AS n	 
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_sub_req
	NO CASCADE BEFORE UPDATE ON SUB_REQ	 
	REFERENCING OLD AS o NEW AS n	 
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_sub_req_ar
	NO CASCADE BEFORE UPDATE ON SUB_REQ_AR
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_sub_req_text
	NO CASCADE BEFORE UPDATE ON SUB_REQ_TEXT   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL  
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_transfer_inst
	NO CASCADE BEFORE UPDATE ON TRANSFER_INST
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_tca_master
	NO CASCADE BEFORE UPDATE ON TCA_MASTER
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_tca_segment
	NO CASCADE BEFORE UPDATE ON TCA_SEGMENT
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_tca_rule
	NO CASCADE BEFORE UPDATE ON TCA_RULE   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_tca_source
	NO CASCADE BEFORE UPDATE ON TCA_SOURCE   
	REFERENCING OLD AS o NEW AS n   
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_tca_target
	NO CASCADE BEFORE UPDATE ON TCA_TARGET
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;

create or replace trigger tu_chartcat
	NO CASCADE BEFORE UPDATE ON CHART_CATEGORIES
	REFERENCING OLD AS o NEW AS n
	FOR EACH ROW MODE DB2SQL
		begin atomic
		if n.last_mod_date is null then
			set n.last_mod_date = current timestamp;
		end if;
		if n.last_mod_user is null then
			set n.last_mod_user = user;
		end if;
	end
;
