/*==============================================================*/
/* DARwin Release: DARwin 3.5.6                                 */
/* DBMS name:      Oracle                                       */
/* Created on:     04-20-2007 4:23:34 PM                        */
/*                                                              */
/* Script name:    dw356oramod.sql                              */
/* Purpose:        Updates DARwin 3.5 tables to their           */
/*                 DARwin 3.5.6 format from 3.5.5 format        */
/*                                                              */
/* Copyright(c) 1995-2006 redLantern, LLC, All Rights Reserved */
/*                                                              */
/*==============================================================*/

ALTER TABLE job_queue_detail
   ADD d_whatif CHAR(1) default ' ';

ALTER TABLE job_queue_accept
   ADD inner_mem CHAR(1);
ALTER TABLE job_queue_accept
   ADD inner_bgn CHAR(1);
ALTER TABLE job_queue_accept
   ADD inner_end CHAR(1);
ALTER TABLE job_queue_accept
   ADD outer_mem CHAR(1);
ALTER TABLE job_queue_accept
   ADD outer_bgn CHAR(1);
ALTER TABLE job_queue_accept
   ADD outer_end CHAR(1);
ALTER TABLE job_queue_accept
   ADD symbol_before CHAR(5);

ALTER TABLE req_main
   ADD label VARCHAR2(25);
ALTER TABLE sub_req
   ADD label VARCHAR2(25);
ALTER TABLE job_queue_req
   ADD label VARCHAR2(25);
ALTER TABLE job_queue_subreq
   ADD label VARCHAR2(25);
   
ALTER TABLE job_queue_run
	ADD DETAIL_SEQ_NO NUMBER(9);