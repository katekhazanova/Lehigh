/*==============================================================*/
/* DARwin Release: DARwin 3.5.3                                 */
/* DBMS name:      Microsoft SQL Server                         */
/* Created on:     10/10/2005 2:23:34 PM                        */
/*                                                              */
/* Script name:    dw353mssmod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.3 format from a 3.5.2 format      */
/*                                                              */
/* Copyright(c) 1995-2005 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

/*==============================================================*/
/*table alters, add new columns                                 */
/*==============================================================*/

alter table chart_categories
	add hide_gpa  char(1) null
go


alter table req_main
	add gpaname  char(15) null
go

alter table sub_req
	add gpaname  char(15) null
go

alter table job_queue_run
	add dptitle1             varchar(65)          null,
        dptitle2             varchar(65)          null,
        webtitle             varchar(50)          null
go   



alter table job_queue_req
	add  reqgpaf              char(1) 	     null,
     	     gpaname              char(15)           null,
             gpalowyt		  char(6)            null,
             gpahighyt            char(6)            null,
             hidden		  char(1)            null,
             hidecategorygpa      char(1)            null 
go
  
alter table job_queue_subreq
	add  reqgpaf              char(1) 	     null,
     	     gpaname              char(15)           null,
             gpalowyt		  char(6)            null,
             gpahighyt            char(6)            null,
             hidden		  char(1) 	     null 
go