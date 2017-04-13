alter table dprog add type_code CHAR(3)  NULL
/
alter table sub_req modify skipbct NUMBER(1) NULL
/

--==============================================================
-- Table: DPROG_TYPE                                            
--==============================================================
CREATE TABLE dprog_type (
   instidq              char(2)               not null,
   instid               char(8)               not null,
   instcd               char(3)               not null,
   type_code            char(3)               not null,
   label	            varchar2(30)           null,
   type_order           integer               not null,
   constraint PK_dprog_type primary key (instidq, instid, instcd, type_code)
)
/

ALTER TABLE dprog_type
	ADD CONSTRAINT uc_dprog_type
	UNIQUE (instidq, instid, instcd, type_order)
/

--==============================================================
-- Table: WHATIF_ELEMENT_TYPE_ASSOC                             
--==============================================================
CREATE TABLE whatif_element_type_assoc ( 
	int_seq_no    		NUMBER(9) 				NOT NULL,
	instidq		       	char(2) 				NOT NULL,
	instid		       	char(8) 				NOT NULL,
	instcd	        	char(3) 				NOT NULL,
	element		       	char(15)				NOT NULL,
	dprog_type		   	char(3) 				NOT NULL,
	label	         	varchar2(30) 			NULL,
	forced_mapping		char(1) 				DEFAULT 'N' NOT NULL,
	reqd_values		   	integer					DEFAULT 0 NOT NULL,
	max_values	    	integer					DEFAULT 0 NOT NULL,
	parent_element		char(15) 				NOT NULL,
	fyt		           	char(6) 				NOT NULL,
	lyt		           	char(6) 				NOT NULL,
	group_order		   	integer					NOT NULL,
	forced_catalog_year	char(1)					DEFAULT 'N' NOT NULL,
	CONSTRAINT pk_weta PRIMARY KEY (int_seq_no)
)
/

--==============================================================
-- Include to drop constraint, alter column, and re-add the 	
-- constraint in-case WHATIF_ELEMENT_TYPE_ASSOC already existed.
--==============================================================
ALTER TABLE whatif_element_type_assoc DROP CONSTRAINT uc_wi_element_type_assoc
/

ALTER TABLE whatif_element_type_assoc MODIFY ( parent_element CHAR(15) NOT NULL)
/

ALTER TABLE whatif_element_type_assoc
	ADD CONSTRAINT uc_wi_element_type_assoc
	UNIQUE (instidq, instid, instcd, element, dprog_type, fyt, parent_element)	
/

ALTER TABLE whatif_element_type_assoc
	ADD CONSTRAINT fk_weta_relation_dprog_type
	FOREIGN KEY(instidq, instid, instcd, dprog_type)
	REFERENCES dprog_type(instidq, instid, instcd, type_code)
/

--==============================================================
-- Table: WHATIF_FORCED_MARKER	                                
--==============================================================
CREATE TABLE whatif_forced_marker  ( 
	int_seq_no	     	NUMBER(9)	 		NOT NULL,
	weta_int_seq_no		NUMBER(9)	 		NOT NULL,
	element_value	  	char(15) 			NOT NULL,
	forced_marker	  	char(9) 			NOT NULL,
	forced_val	     	char(15)			NOT NULL,
	forced_type	    	char(1) 			NOT NULL,
	fyt	            	char(6) 			NOT NULL,
	lyt	            	char(6) 			NOT NULL,
	exclude 	       	char(1) 			NOT NULL,
	ref_instidq	    	varchar2(2) 			NOT NULL,
	ref_instid 	    	varchar2(8) 			NOT NULL,
	ref_instcd	     	varchar2(3) 			NOT NULL,
	CONSTRAINT pk_wi_forced_marker PRIMARY KEY(int_seq_no)
	)
/

ALTER TABLE whatif_forced_marker
	ADD CONSTRAINT fk_wi_ele_type_assoc
	FOREIGN KEY(weta_int_seq_no)
	REFERENCES whatif_element_type_assoc(int_seq_no)
/

--==============================================================
-- Table: WHATIF_ELEMENT_FILTER	                                
--==============================================================
CREATE TABLE whatif_element_filter  ( 
	int_seq_no    	NUMBER(9) 			NOT NULL,
	instidq       	char(2) 			NOT NULL,
	instid        	char(8) 			NOT NULL,
	instcd        	char(3) 			NOT NULL,
	dprog         	char(15) 			NOT NULL,
	element       	char(15) 			NOT NULL,
	filter_pattern	char(25) 			NOT NULL,
	fyt           	char(6) 			NOT NULL,
	lyt           	char(6) 			NOT NULL,
	exclude       	char(1) 			NOT NULL,
	ref_instidq   	varchar2(2) 			NOT NULL,
	ref_instid    	varchar2(8) 			NOT NULL,
	ref_instcd    	varchar2(3) 			NOT NULL,
	CONSTRAINT pk_wi_element_filter PRIMARY KEY (int_seq_no)
	)
/

--============================================================
-- CREATE INDEXES
--============================================================

create sequence weta_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence forced_marker_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence element_filter_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/
--==============================================================
-- CREATE TRIGGERS												
--==============================================================
--  Before insert trigger "tib_whatif_ele_type_assoc" for table "WHATIF_ELEMENT_TYPE_ASSOC"
create or replace trigger tib_whatif_ele_type_assoc before insert
on whatif_element_type_assoc for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select weta_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/

--  Before insert trigger "tib_whatif_forced_marker" for table "WHATIF_FORCED_MARKER"
create or replace trigger tib_whatif_forced_marker before insert
on whatif_forced_marker for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select forced_marker_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/

--  Before insert trigger "tib_whatif_element_filter" for table "WHATIF_ELEMENT_FILTER"
create or replace trigger tib_whatif_element_filter before insert
on whatif_element_filter for each row
declare
    next_seq_no numeric;
begin

--  set generated int_seq_no
	if :new.int_seq_no is null THEN
    select element_filter_seq_no.nextval
    into next_seq_no
    from dual;
    :new.int_seq_no := next_seq_no;
end if;

end;
/
