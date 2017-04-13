--/*==============================================================*/
--/* DBMS name:      Microsoft SQL Server 2005           						                                                         */
--/* Created on:     4/14/2008 12:55:40 PM                                                                                                   */
--/*==============================================================*/
--/*==============================================================*/
--/* CREATE TABLES                                                */
--/*==============================================================*/
create table RED_APP_FN (
   APP_FN               varchar(255)         not null,
   APP_ID               varchar(255)         null,
   FN_DESC              varchar(1024)        null,
   constraint PK_RED_APP_FN primary key (APP_FN)
)
go

create table RED_GROUP (
   GROUP_ID             varchar(255)         not null,
   GROUP_DESC           varchar(1024)        null,
   constraint PK_RED_GROUP primary key nonclustered (GROUP_ID)
)
go

create table RED_ORG_DOMAIN_MAPPING (
   MAPPING_ID           numeric(9)           not null identity,
   USER_ID				varchar(40)			 null,
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
go

create table RED_PROPERTY_DESC 
(
	property_id	varchar(20)				not null,
	description	varchar(100)			not null,
	constraint 	PK_RED_PROPERTY_DESC 	primary key (property_id)
)
go

create table RED_PROPERTY_DOMAIN_MAPPING (
   mapping_id           numeric(9)           identity(1, 1),
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
go

create table RED_REALM (
   USER_ID              varchar(40)          not null,
   MEMBER_ID            varchar(40)          not null,
   IS_GROUP             bit                  null,
   constraint PK_RED_REALM primary key (USER_ID, MEMBER_ID)
)
go

create table RED_ROLES (
   ROLE_ID			varchar(255)         	not null,
   APP_FN			varchar(255)         	not null,
   CAN_READ			char(1)					not null	default 0,
   CAN_UPDATE		char(1)					not null	default 0,
   CAN_CREATE		char(1)					not null	default 0,
   CAN_DELETE		char(1)					not null 	default 0,
   constraint PK_RED_ROLES primary key (ROLE_ID, APP_FN),
   constraint FK_ROLE_TO_APP_FN foreign key (APP_FN) references RED_APP_FN (APP_FN)
)
go

create table RED_ROLE_MAPPING (
   GROUP_ID             varchar(255)         not null,
   ROLE_ID              varchar(255)         not null,
   constraint PK_RED_ROLE_MAPPING primary key (GROUP_ID, ROLE_ID)
)
go

create table RED_USER (
   USER_ID              varchar(40)          not null,
   FIRST_NAME           varchar(40)          null,
   LAST_NAME            varchar(40)          null,
   PASSWORD             varchar(40)          not null,
   STU_ID               varchar(40)          null,
   EMAIL                varchar(255)         null,
   NOTES                varchar(4000)		 null,
   constraint PK_RED_USER primary key nonclustered (USER_ID)
)
go

create table RED_USER_GROUP (
   USER_ID              varchar(40)          not null,
   GROUP_ID             varchar(40)          not null,
   constraint PK_RED_USER_GROUP primary key (USER_ID, GROUP_ID)
)
go


--/*==============================================================*/
--/* CREATE INDEXES												  */
--/*==============================================================*/
create index red_property_dom_map_idx on red_property_domain_mapping (
   entity_id,
   entity_type,
   property_id
)
go


--/*==============================================================*/
--/* CREATE CONSTRAINTS                                           */
--/*==============================================================*/
alter table RED_ROLES
   add constraint FK_RED_ROLES_RED_APP_FN foreign key (APP_FN)
      references RED_APP_FN (APP_FN)
         on update cascade
go