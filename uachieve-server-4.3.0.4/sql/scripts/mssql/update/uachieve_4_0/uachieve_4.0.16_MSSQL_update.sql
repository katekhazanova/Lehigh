alter table dprog add type_code char(3) null
go



/*==============================================================*/
/* Table: DPROG_TYPE                                            */
/*==============================================================*/
CREATE TABLE dprog_type (
   instidq              char(2)               not null,
   instid               char(8)               not null,
   instcd               char(3)               not null,
   type_code            char(3)               not null,
   label	            varchar(30)           null,
   type_order           int                   not null,
   constraint PK_dprog_type primary key (instidq, instid, instcd, type_code)
)
GO

ALTER TABLE dprog_type
	ADD CONSTRAINT uc_dprog_type
	UNIQUE (instidq, instid, instcd, type_order)
GO

/*==============================================================*/
/* Table: WHATIF_ELEMENT_TYPE_ASSOC                             */
/*==============================================================*/
CREATE TABLE whatif_element_type_assoc ( 
	int_seq_no    	numeric(18,0) 			IDENTITY(1,1) NOT NULL,
	instidq		       	char(2) 				NOT NULL,
	instid		       	char(8) 				NOT NULL,
	instcd	        	char(3) 				NOT NULL,
	element		       	char(15)				NOT NULL,
	dprog_type		   	char(3) 				NOT NULL,
	label	         	varchar(30) 			NULL,
	forced_mapping		char(1) 				NOT NULL  DEFAULT 'N',
	reqd_values		   	int 					NOT NULL  DEFAULT 0,
	max_values	    	int 					NOT NULL  DEFAULT 0,
	parent_element		char(15) 				NOT NULL,
	fyt		           	char(6) 				NOT NULL,
	lyt		           	char(6) 				NOT NULL,
	group_order		   	int 					NOT NULL,
	forced_catalog_year	char(1)					NOT NULL  DEFAULT 'N',
	CONSTRAINT pk_weta PRIMARY KEY (int_seq_no)
)
GO

/*==============================================================*/
/* Include to drop constraint, alter column, and re-add the 	*/
/* constraint in-case WHATIF_ELEMENT_TYPE_ASSOC already existed.*/
/*==============================================================*/
if (exists(select * from information_schema.table_constraints
            where table_name = 'whatif_element_type_assoc'
            and constraint_name = 'whatif_element_type_assoc'))
    begin
        ALTER TABLE whatif_element_type_assoc DROP CONSTRAINT uc_wi_element_type_assoc
    end
GO

ALTER TABLE whatif_element_type_assoc ALTER COLUMN parent_element CHAR(15) NOT NULL
GO

ALTER TABLE whatif_element_type_assoc
	ADD CONSTRAINT uc_wi_element_type_assoc
	UNIQUE (instidq, instid, instcd, element, dprog_type, fyt, parent_element)	
GO

ALTER TABLE whatif_element_type_assoc
	ADD CONSTRAINT fk_weta_relation_dprog_type
	FOREIGN KEY(instidq, instid, instcd, dprog_type)
	REFERENCES dprog_type(instidq, instid, instcd, type_code)
GO

/*==============================================================*/
/* Table: WHATIF_FORCED_MARKER	                                */
/*==============================================================*/
CREATE TABLE whatif_forced_marker  ( 
	int_seq_no	     	numeric(18,0) 		IDENTITY(1,1) NOT NULL,
	weta_int_seq_no		numeric(18,0) 		NOT NULL,
	element_value	  	char(15) 			NOT NULL,
	forced_marker	  	char(9) 			NOT NULL,
	forced_val	     	char(15)			NOT NULL,
	forced_type	    	char(1) 			NOT NULL,
	fyt	            	char(6) 			NOT NULL,
	lyt	            	char(6) 			NOT NULL,
	exclude 	       	char(1) 			NOT NULL,
	ref_instidq	    	varchar(2) 			NOT NULL,
	ref_instid 	    	varchar(8) 			NOT NULL,
	ref_instcd	     	varchar(3) 			NOT NULL,
	CONSTRAINT pk_wi_forced_marker PRIMARY KEY(int_seq_no)
	)
GO
ALTER TABLE whatif_forced_marker
	ADD CONSTRAINT fk_wi_ele_type_assoc
	FOREIGN KEY(weta_int_seq_no)
	REFERENCES whatif_element_type_assoc(int_seq_no)
GO

/*==============================================================*/
/* Table: WHATIF_ELEMENT_FILTER	                                */
/*==============================================================*/
CREATE TABLE whatif_element_filter  ( 
	int_seq_no    	numeric(18,0) 		IDENTITY(1,1) NOT NULL,
	instidq       	char(2) 			NOT NULL,
	instid        	char(8) 			NOT NULL,
	instcd        	char(3) 			NOT NULL,
	dprog         	char(15) 			NOT NULL,
	element       	char(15) 			NOT NULL,
	filter_pattern	char(25) 			NOT NULL,
	fyt           	char(6) 			NOT NULL,
	lyt           	char(6) 			NOT NULL,
	exclude       	char(1) 			NOT NULL,
	ref_instidq   	varchar(2) 			NOT NULL,
	ref_instid    	varchar(8) 			NOT NULL,
	ref_instcd    	varchar(3) 			NOT NULL,
	CONSTRAINT pk_wi_element_filter PRIMARY KEY (int_seq_no)
	)
GO