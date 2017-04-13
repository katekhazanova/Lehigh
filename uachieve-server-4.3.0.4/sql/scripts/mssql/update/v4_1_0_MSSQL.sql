CREATE VIEW vw_red_property_domain_mapping as
SELECT [mapping_id], [entity_id], [entity_type], [property_id], [value], [instidq], [instid], [instcd], [description] 
	FROM [RED_PROPERTY_DOMAIN_MAPPING]
go

CREATE VIEW vw_red_user_group as
SELECT [USER_ID], [GROUP_ID] 
	FROM [RED_USER_GROUP]
go
alter table job_queue_run add graddate varchar(80)