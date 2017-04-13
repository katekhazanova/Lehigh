/*==============================================================*/
/* DARwin Release: DARwin 3.5.3                                 */
/* DBMS name:      Oracle                                       */
/* Created on:     11-10-2005 2:23:34 PM                        */
/*                                                              */
/* Script name:    dw353oramod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.3 format from 3.5.1 format        */
/*                                                              */
/* Copyright(c) 1995-2004 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

alter table chart_categories
	add hide_gpa  char(1) null
;

alter table req_main
	add gpaname  char(15) null
;
alter table req_main
	add reqgpaf  char(1) null
;
alter table sub_req
	add gpaname  char(15) null
;
alter table sub_req
	add reqgpaf  char(1) null
;
alter table job_queue_run
	add dptitle1  varchar2(65) null
;

alter table job_queue_run
	add dptitle2  varchar2(65) null
;

alter table job_queue_run
	add webtitle  varchar2(50) null
;

alter table job_queue_req
	add reqgpaf  char(1) null
;

alter table job_queue_req
	add gpaname  char(15) null
;

alter table job_queue_req
	add gpalowyt  char(6) null
;

alter table job_queue_req
	add gpahighyt  char(6) null
;

alter table job_queue_req
	add hidden  char(1) null 
;

alter table job_queue_req
	add hidecategorygpa  char(1) null 
;

alter table job_queue_subreq
	add reqgpaf  char(1) null
;

alter table job_queue_subreq
	add gpaname  char(15) null
;

alter table job_queue_subreq
	add gpalowyt  char(6) null
;

alter table job_queue_subreq
	add gpahighyt  char(6) null 
;

alter table job_queue_subreq
	add hidden  char(1) null 
;

