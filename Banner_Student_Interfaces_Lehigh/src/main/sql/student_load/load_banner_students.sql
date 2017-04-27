/*==============================================================*/
/* Database name: 	u.achieve 4.0								*/
/* Description:	   	Function used to populate student tables  	*/
/*                 	in u.achieve from Banner					*/
/* DBMS name:      	ORACLE Version 10g  						*/
/* 																*/
/* Author:			Zach Lewis                         			*/
/* Created on:     	09/30/2011 									*/
/*==============================================================*/

-- **********************************
-- Create load_banner_students function
-- **********************************

-- Notes: --

-- The query to grab students from Banner can be modified to add 
-- conditions to what students are returned or which fields. 
 
-- This example uses a database link (@BANNER) to access Banner 
-- from the u.achieve database. This should be changed to reflect 
-- how Banner is accessed from your database. 

CREATE OR REPLACE FUNCTION load_banner_students(instid_in IN VARCHAR2, instidq_in IN VARCHAR2) RETURN number
IS	
	v_stu_mast_no varchar2(20);
	stu_rec_cnt number;
	
	CURSOR stu_cur IS
	    SELECT 
			sp.spriden_id AS sp_id,
			sp.spriden_pidm AS sp_pidm,
			sp.spriden_first_name AS first_name, 
			sp.spriden_last_name AS last_name
		FROM
			spriden@BANNER sp
		WHERE
			sp.spriden_change_ind IS NULL
			AND NOT EXISTS (
				SELECT 
					sm.stuno
				FROM 
					stu_master sm
				WHERE
					sm.stuno = sp.spriden_id
			);
			
BEGIN

    FOR stu_rec in stu_cur LOOP
    
    	stu_rec_cnt := stu_cur%ROWCOUNT;
    
    	-- INSERT STUNO, PIDM, INSTID, & INSTIDQ INTO STU_MASTER
        INSERT INTO 
        	stu_master(stuno, pidm, instid, instidq)
        VALUES 
        	(stu_rec.sp_id, stu_rec.sp_pidm, instid_in, instidq_in);
        
        -- GET INFO FROM STU_MASTER
        SELECT 
        	m.int_seq_no INTO v_stu_mast_no
      	FROM
        	stu_master m
     	WHERE
        	TRIM(m.stuno) = stu_rec.sp_id;
        	
        -- INSERT STUNAME INTO STU_DEMO 	
        INSERT INTO 
        	stu_demo(stu_mast_no, stuname)
        VALUES 
        	(v_stu_mast_no, stu_rec.first_name || ' ' || stu_rec.last_name);
          	
    END LOOP;
    
    RETURN stu_rec_cnt;
END;
/