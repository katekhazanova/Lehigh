CREATE VIEW VW_RED_PROPERTY_DOMAIN_MAPPING ( MAPPING_ID, ENTITY_ID, ENTITY_TYPE, PROPERTY_ID, VALUE, INSTIDQ, INSTID, INSTCD, DESCRIPTION )
AS
SELECT MAPPING_ID, ENTITY_ID, ENTITY_TYPE, PROPERTY_ID, VALUE, INSTIDQ, INSTID, INSTCD, DESCRIPTION 
	FROM RED_PROPERTY_DOMAIN_MAPPING
/

CREATE VIEW VW_RED_USER_GROUP ( USER_ID, GROUP_ID )
AS
SELECT USER_ID, GROUP_ID FROM RED_USER_GROUP
/

CREATE INDEX idx_stu_address_fk ON stu_address (
    stu_mast_no, source_id
)
/

create index idx_whatif_fm_fk on whatif_forced_marker (
weta_int_seq_no
)
/


create index idx_whatif_eta_fk on whatif_element_type_assoc (
instidq, instid, instcd, dprog_type
)
/
alter table job_queue_run add graddate varchar2(80) null
/

