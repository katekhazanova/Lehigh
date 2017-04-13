/*==============================================================*/
/* DARwin Release: DARwin 3.5.4                                 */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     07/20/2005 9:40:14 AM                        */
/*                                                              */
/* Script name:    dw354mssmod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.4 format from a 3.5.3 format      */
/*                                                              */
/* Copyright(c) 1995-2006 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/*table alters, add new columns                                 */
/*==============================================================*/

alter table tca_target 
	add hide_acourse1 char(1) null
go


alter table tca_target 
	add hide_acourse2 char(1) null
go


alter table tca_target 
	add hide_acourse3 char(1) null
go


alter table tca_target 
	add hide_iflgs char(1) null
go


alter table job_queue_accept 
	add hidden char(1) null
go


alter table job_queue_subreq 
	add subreq_id numeric(9) null
go
