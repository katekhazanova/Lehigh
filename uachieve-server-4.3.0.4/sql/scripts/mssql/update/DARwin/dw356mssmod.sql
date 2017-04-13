/*==============================================================*/
/* DARwin Release: DARwin 3.5.6                                 */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     08/20/2007 4:40:14 PM                        */
/*                                                              */
/* Script name:    dw356mssmod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.6 format from a 3.5.5 format      */
/*                                                              */
/* Copyright(c) 2005-2007 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/*table alters, add new columns                                 */
/*==============================================================*/


alter table job_queue_detail
	add d_whatif char(1) default ' ' not null
go
alter table job_queue_accept
	add inner_mem char(1)
go
alter table job_queue_accept
	add inner_bgn char(1)
go
alter table job_queue_accept
	add inner_end char(1)
go
alter table job_queue_accept
	add outer_mem char(1)
go
alter table job_queue_accept
	add outer_bgn char(1)
go
alter table job_queue_accept
	add outer_end char(1)
go
alter table job_queue_accept
	add symbol_before char(5)
go
alter table req_main
	add label varchar(25)
go
alter table sub_req
	add label varchar(25)
go
alter table job_queue_req
   add label varchar(25)
go
alter table job_queue_subreq
   add label varchar(25)
go
alter table job_queue_run
	add detail_seq_no numeric(9)
go