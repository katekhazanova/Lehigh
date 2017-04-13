--==============================================================
-- DBMS name:      Oracle       				
-- Created on:     4/14/2008 12:55:40 PM                        
--==============================================================
--======================================================================================================
-- CREATE TABLES
--======================================================================================================


create table RED_APP_FN (
   APP_FN               varchar(255)         not null,
   APP_ID               varchar(255)         null,
   FN_DESC              varchar(1024)        null,
   constraint PK_RED_APP_FN primary key (APP_FN)
)
/

create table RED_GROUP (
   GROUP_ID             varchar(255)         not null,
   GROUP_DESC           varchar(1024)        null,
   constraint PK_RED_GROUP primary key (GROUP_ID)
)
/

create table RED_ORG_DOMAIN_MAPPING (
   MAPPING_ID           numeric(9)           not null,
   USER_ID		varchar(40)          null,
   GROUP_ID             varchar(255)         null,
   LEVEL_1          	varchar(255)         null,
   LEVEL_2              varchar(255)         null,
   LEVEL_3              varchar(255)         null,
   LEVEL_4             	varchar(255)         null,
   LEVEL_5              varchar(255)         null,
   LEVEL_6              varchar(255)         null,
   PROGRAM_NAME varchar(255)		  null,
   constraint PK_RED_ORG_DOMAIN_MAPPING primary key (MAPPING_ID)
)
/

create table RED_PROPERTY_DESC 
(
	property_id	varchar(20)				not null,
	description	varchar(100)			not null,
	constraint 	PK_RED_PROPERTY_DESC 	primary key (property_id)
)
/

create table red_property_domain_mapping (
   mapping_id           numeric(9)           not null,
   entity_id            varchar(20)          null,
   entity_type          varchar(20)          null,
   property_id          varchar(20)          null,
   value                varchar(255)         null,
   instidq              varchar(2)           null,
   instid               varchar(8)           null,
   instcd               varchar(3)           null,
   description			varchar(100)		 null,
   constraint 		PK_RED_PROPERTY_DOMAIN_MAPPING primary key (mapping_id)
)
/

create table RED_REALM (
   USER_ID              varchar(40)          not null,
   MEMBER_ID            varchar(40)          not null,
   IS_GROUP             char(1)                  null,
   constraint PK_RED_REALM primary key (USER_ID, MEMBER_ID)
)
/

create table RED_ROLES (
   ROLE_ID			varchar(255)         	not null,
   APP_FN			varchar(255)         	not null,
   CAN_READ			char(1)				default 0 not null,
   CAN_UPDATE		char(1)					default 0 not null,
   CAN_CREATE		char(1)					default 0 not null,
   CAN_DELETE		char(1)					default 0 not null,
   constraint PK_RED_ROLES primary key (ROLE_ID, APP_FN),
   constraint FK_ROLE_TO_APP_FN foreign key (APP_FN) references RED_APP_FN (APP_FN)
)
/

create table RED_ROLE_MAPPING (
   GROUP_ID             varchar(255)         not null,
   ROLE_ID              varchar(255)         not null,
   constraint PK_RED_ROLE_MAPPING primary key (GROUP_ID, ROLE_ID)
)
/

create table RED_USER (
   USER_ID              varchar(40)          not null,
   FIRST_NAME           varchar(40)          null,
   LAST_NAME            varchar(40)          null,
   PASSWORD             varchar(40)          not null,
   STU_ID               varchar(40)          null,
   EMAIL                varchar(255)         null,
   NOTES                varchar2(4000)		 null,
   constraint PK_RED_USER primary key (USER_ID)
)
/

create table RED_USER_GROUP (
   USER_ID              varchar(40)          not null,
   GROUP_ID             varchar(40)          not null,
   constraint PK_RED_USER_GROUP primary key (USER_ID, GROUP_ID)
)
/


--======================================================================================================
-- CREATE INDEXES
--======================================================================================================
create index red_property_dom_map_idx on red_property_domain_mapping (
   entity_id,
   entity_type,
   property_id
)
/


--======================================================================================================
-- CREATE SEQUENCES
--======================================================================================================
create sequence s_red_org_domain_mapping
/
create sequence s_red_property_domain_mapping
/


--======================================================================================================
-- CREATE SYNONYMS
--======================================================================================================

CREATE PUBLIC SYNONYM RED_APP_FN for RED_APP_FN
/
CREATE PUBLIC SYNONYM RED_GROUP for RED_GROUP
/
CREATE PUBLIC SYNONYM RED_ORG_DOMAIN_MAPPING for RED_ORG_DOMAIN_MAPPING
/
CREATE PUBLIC SYNONYM RED_PROPERTY_DESC for RED_PROPERTY_DESC
/
CREATE PUBLIC SYNONYM RED_PROPERTY_DOMAIN_MAPPING for RED_PROPERTY_DOMAIN_MAPPING
/
CREATE PUBLIC SYNONYM RED_REALM for RED_REALM
/
CREATE PUBLIC SYNONYM RED_ROLES for RED_ROLES
/
CREATE PUBLIC SYNONYM RED_ROLE_MAPPING for RED_ROLE_MAPPING
/
CREATE PUBLIC SYNONYM RED_USER for RED_USER
/
CREATE PUBLIC SYNONYM RED_USER_GROUP for RED_USER_GROUP
/
CREATE PUBLIC SYNONYM s_red_org_domain_mapping for s_red_org_domain_mapping
/
CREATE PUBLIC SYNONYM s_red_property_domain_mapping for s_red_property_domain_mapping
/

--======================================================================================================
-- CREATE TRIGGERS
--======================================================================================================
create or replace trigger TIB_RED_ORG_DOMAIN_MAPPING before insert
on RED_ORG_DOMAIN_MAPPING for each row
declare
    integrity_error  exception;
    errno            integer;
    errmsg           char(200);
    dummy            integer;
    found            boolean;

begin
    --  Column "MAPPING_ID" uses sequence S_RED_ORG_DOMAIN_MAPPING
    if :new.mapping_id is null then
	    select S_RED_ORG_DOMAIN_MAPPING.NEXTVAL INTO :new.MAPPING_ID from dual;
	end if;

--  Errors handling
exception
    when integrity_error then
       raise_application_error(errno, errmsg);
end;
/

create or replace trigger TIB_RED_PROP_DOMAIN_MAPPING before insert
on RED_PROPERTY_DOMAIN_MAPPING for each row
declare
    next_seq_no		 numeric(9);
begin
	
    --  Column "MAPPING_ID" uses sequence S_RED_PROPERTY_DOMAIN_MAPPING
    if :new.mapping_id is null then
	    select S_RED_PROPERTY_DOMAIN_MAPPING.NEXTVAL INTO next_seq_no from dual;
	    :new.mapping_id := next_seq_no;
	end if;
       
end;
/

commit;