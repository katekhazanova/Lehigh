/*============================================================*/
/* Releasee:       u.achieve 4.2                              */
/* DBMS name:      Oracle                                     */
/* Created on:     3/14/2014                                  */
/*                                                            */
/* Purpose:        Updates u.achieve 4.1.[1-6] tables to the  */
/*                 u.achieve 4.2 format                       */
/*                                                            */
/* Copyright(c) 2014 CollegeSource, Inc. All Rights Reserved. */
/*                                                            */
/*============================================================*/


/*==============================================================*/
/* Table: job_queue_exceptions                                  */
/*==============================================================*/
alter table 
	job_queue_exceptions 
add (
		COURSE				VARCHAR2(15),
		RCOURSE				VARCHAR2(15),
   		CLINE				VARCHAR2(27),
   		PSNAME              VARCHAR2(15),
   		RNAME               VARCHAR2(9),
   		AUTH_ID             VARCHAR2(30),
   		AUTH_DATE           VARCHAR2(12),
   		AUTH_CODE           VARCHAR2(10)
   	)
/

/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
alter table 
	job_queue_course
add (
   		PSEUDO               CHAR(1)
   	)
/

/*==============================================================*/
/* Column: report_type                                          */
/* Tables: job_queue_list, job_queue_run, job_queue_report      */
/*==============================================================*/

alter table 
	job_queue_list
modify
(
    REPORT_TYPE 	varchar2(10)
)
/

alter table 
	job_queue_run
modify
(
    REPORT_TYPE 	varchar2(10)
)
/

alter table 
	job_queue_report
modify
(
    REPORT_TYPE 	varchar2(10)
)
/

