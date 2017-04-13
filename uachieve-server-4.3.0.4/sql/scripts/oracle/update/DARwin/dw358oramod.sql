/*==============================================================*/
/* DARwin Release: DARwin 3.5.8                                */
/* DBMS name:      Oracle 10g			                        */
/* Created on:     11/24/2008 8:43 AM                           */
/*                                                              */
/* Script name:    dw358oramod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.8 format from a 3.5.7.x format      */
/*                                                              */
/* Copyright(c) 2006-2008 Miami University, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/*table alters, add new columns                                 */
/*==============================================================*/

CREATE TABLE JOB_QUEUE_DESTINATION (
JOBID CHAR(16) NOT NULL,
USERID VARCHAR2(30) NOT NULL,
DESTINATION_URL VARCHAR2(255) NOT NULL,
OUTPUT_FORMAT CHAR(1),
SEND_ERROR_COUNT INTEGER DEFAULT 0 NOT NULL,
SEND_ERROR_MESSAGE VARCHAR2(255),
STATUS CHAR(1) NOT NULL,
SEND_DATE DATE,
NEXT_SEND_DATE DATE
)
/

ALTER TABLE JOB_QUEUE_DESTINATION ADD (
PRIMARY KEY (JOBID, USERID)
)
/

CREATE INDEX IX_JOB_QUEUE_DEST_NXT_SND_DATE ON JOB_QUEUE_DESTINATION
(STATUS, NEXT_SEND_DATE)
/
Alter table adv_master
add userid char(30)
/


Alter table adv_authcodes
drop Primary Key 
/


Alter table adv_authcodes
  modify ( auth_code varchar(10) not null)
/
 
 Alter table adv_authcodes
Add constraint PK_ADV_AUTHCODES Primary Key (adv_id, auth_code)
/
