-- Create the Banner to Uachieve Crosswalk Table (SZBCCMD)

CREATE TABLE szbccmd
(
	szbccmd_instcd                 	VARCHAR(3)    	NOT NULL,                                                                                                                                                              
	szbccmd_dprog                  	VARCHAR(15)		NOT NULL,                                                                                                                                                                            
	szbccmd_camp_code				VARCHAR(3),                                                                                                                                                                              
	szbccmd_coll_code               VARCHAR(6),                                                                                                                                                                             
	szbccmd_degc_code               VARCHAR(6),                                                                                                                                                                             
	szbccmd_majr_code               VARCHAR(4),                                                                                                                                                                             
	szbccmd_conc_code               VARCHAR(4),                                                                                                                                                                              
	szbccmd_activity_date          	DATE 			NOT NULL,                                                                                                                                                                                        
	szbccmd_user                   	VARCHAR(30)  	NOT NULL 
)

-- Create the Banner to Uachieve Institution Table (SZVINST)

CREATE TABLE szvinst
(
	szvinst_instidq              	VARCHAR(2)  	NOT NULL,                                                                                                                                                                             
	szvinst_instid                 	VARCHAR(8) 		NOT NULL,                                                                                                                                                                              
	szvinst_activity_date          	DATE       		NOT NULL,                                                                                                                                                                                   
	szvinst_user                   	VARCHAR(30)   	NOT NULL,                                                                                                                                                                          
	szvinst_instcd                 	VARCHAR(3) 		NOT NULL,                                                                                                                                                                             
	szvinst_include_gpa             VARCHAR(1),                                                                                                                                                                              
	szvinst_include_repeat     		VARCHAR(1),                                                                                                                                                                              
	szvinst_desc                	VARCHAR(30),                                                                                                                                                                             
	szvinst_dprog_flag            	VARCHAR(1),                                                                                                                                                                              
	szvinst_add_ind               	VARCHAR(2),                                                                                                                                                                              
	szvinst_deg_ind                	VARCHAR(1),                                                                                                                                                                              
	szvinst_lyt                     CHAR(6),                                                                                                                                                                                  
	szvinst_server_name             VARCHAR(30),                                                                                                                                                                             
	szvinst_web_mast_add            VARCHAR(120),                                                                                                                                                                            
	szvinst_web_user                VARCHAR(8)					DEFAULT 'WWW_USER',                                                                                                                                                                                                                                                                                                                                                        
	szvinst_dptitle2                VARCHAR(65),                                                                                                                                                                             
	szvinst_case_ind                VARCHAR(1)					DEFAULT 'N',                                                                                                                                                                              
	szvinst_wild_card               VARCHAR(1)					DEFAULT '*',                                                                                                                                                                              
	szvinst_comkey                  CHAR(5),                                                                                                                                                                                  
	szvinst_whatif                  CHAR(1),                                                                                                                                                                                  
	szvinst_refart                  CHAR(1),                                                                                                                                                                                  
	szvinst_evalsw                  CHAR(1)						DEFAULT 'S',                                                                                                                                                                                  
	szvinst_marker                  VARCHAR(9),                                                                                                                                                                              
	szvinst_select_text             VARCHAR(40),                                                                                                                                                                             
	szvinst_selected_text           VARCHAR(40),                                                                                                                                                                             
	szvinst_acatlyt_no              NUMERIC(1),                                                                                                                                                                                     
	szvinst_ia_url                  VARCHAR(60),                                                                                                                                                                             
	szvinst_ia_ind                  CHAR(1),
	CONSTRAINT pk_szvinst PRIMARY KEY nonclustered (szvinst_instidQ, szvinst_instid, szvinst_instcd) 
)