/*==============================================================*/
/* Database name: 	u.achieve 4.0								*/
/* Description:	   	Function used to populate student dprogs  	*/
/*                 	in u.achieve from Banner					*/
/* DBMS name:      	ORACLE Version 10g  						*/
/* 																*/
/* Author:			Zach Lewis                         			*/
/* Created on:     	02/24/2012 									*/
/*==============================================================*/

-- **********************************
-- Create load_banner_students_dprog function
-- **********************************

-- Notes: --

-- The query to grab students from STU_MASTER can be modified to add 
-- conditions to what students are returned. 

-- The query to grab dprogs from Banner can be modified to add 
-- conditions to what results are returned or which fields. 

-- This example uses a database link (@BANNER) to access Banner 
-- from the u.achieve database. This should be changed to reflect 
-- how Banner is accessed from your database. 

CREATE OR REPLACE FUNCTION load_banner_students_dprog() RETURN number
IS	
	stu_rec_cnt number;
	
	CURSOR stu_cur IS
	    SELECT 
	    	int_seq_no,
			stuno,
			pidm
		FROM
			stu_master
		WHERE
			pidm IS NOT NULL;
			
BEGIN

    FOR stu_rec in stu_cur LOOP
    
    	stu_rec_cnt := stu_cur%ROWCOUNT;
    
    	-- DELETE ALL RECORDS FROM STU_DPROG FOR THE STUDENT
    	DELETE FROM 
    		stu_dprog 
    	WHERE
    		stu_mast_no = stu_rec.int_seq_no;      

        -- INSERT DPROG(S) INTO STU_DPROG
		INSERT INTO 
			stu_dprog(stu_mast_no, dprog, drcatlyt)
		SELECT
			stu_rec.int_seq_no,
			sf.sovlfos_majr_code || '-' || sc.sovlcur_degc_code AS dprog,
			sc.sovlcur_term_code_admit AS drcatlyt
		FROM
			sovlcur@BANNER sc, sovlfos@BANNER sf
		WHERE
			sf.sovlfos_pidm = stu_rec.pidm
			AND sf.sovlfos_pidm = sc.sovlcur_pidm
			AND sf.sovlfos_lcur_seqno = sc.sovlcur_seqno 
			AND sf.sovlfos_current_ind = sc.sovlcur_current_ind 
			AND sf.sovlfos_active_ind = sc.sovlcur_active_ind
			AND sc.sovlcur_current_ind = 'Y' 
			AND sc.sovlcur_active_ind = 'Y'  
			AND sc.sovlcur_lmod_code = 'LEARNER' 
			AND sf.sovlfos_lfst_code = 'MAJOR';
		
    END LOOP;
    
    RETURN stu_rec_cnt;
END;
/