/*==============================================================*/
/* DARwin Release: DARwin 3.5.7                                 */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     04/03/2007 1:33 PM                        */
/*                                                              */
/* Script name:    dw357mssmod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.7 format from a 3.5.6 format      */
/*                                                              */
/* Copyright(c) 2006-2008 Miami University, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/*table alters, add new columns                                 */
/*==============================================================*/


alter table job_queue_subreq
	add stitle varchar(55)
go

alter table req_main
 add auth_code1  varchar(10)
go
 
alter table req_main
 add  auth_code2  varchar(10)
go
 
alter table stu_exceptions
 add  auth_code  varchar(10)
go

Create table adv_authcodes(
 adv_id char(20) constraint PK_ADV_AUTHCODES Primary Key,
 auth_code varchar(10), 
 constraint fk_adv_mstr_auth_codes  Foreign Key(adv_id)
 References adv_master(adv_id))
 go