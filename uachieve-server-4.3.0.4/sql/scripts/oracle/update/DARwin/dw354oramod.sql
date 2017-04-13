/*==============================================================*/
/* DARwin Release: DARwin 3.5.4                                 */
/* DBMS name:      Oracle                                       */
/* Created on:     07-20-2006 9:23:34 AM                        */
/*                                                              */
/* Script name:    dw354oramod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.4 format from 3.5.3 format        */
/*                                                              */
/* Copyright(c) 1995-2004 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

alter table tca_target 
	add hide_acourse1 char(1) null;
;

alter table tca_target 
	add hide_acourse2 char(1) null;
;

alter table tca_target 
	add hide_acourse3 char(1) null;
;

alter table tca_target 
	add hide_iflgs char(1) null;
;

alter table job_queue_accept 
	add hidden char(1) null;
;

alter table job_queue_subreq 
	add subreq_id NUMBER(9) null;
;