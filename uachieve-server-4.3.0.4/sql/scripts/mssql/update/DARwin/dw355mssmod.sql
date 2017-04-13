/*==============================================================*/
/* DARwin Release: DARwin 3.5.5                                 */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     01/20/2007 4:40:14 PM                        */
/*                                                              */
/* Script name:    dw355mssmod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.5 format from a 3.5.4 format      */
/*                                                              */
/* Copyright(c) 1995-2006 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/*table alters, add new columns                                 */
/*==============================================================*/


alter table job_queue_req 
	add group1 char(1) null
go
alter table job_queue_req 
	add group2 char(1) null
go
alter table job_queue_req 
	add reuse char(1) null
go

alter table job_queue_subreq 
	add reuse char(1) null
go

CREATE INDEX jobq_sysin_idx ON JOB_QUEUE_SYSIN
(INSTIDQ, INSTID, INSTCD, JOBID, USERID)
go
