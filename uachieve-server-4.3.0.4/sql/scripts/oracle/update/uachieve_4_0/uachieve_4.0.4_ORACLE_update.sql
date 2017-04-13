/*==============================================================*/
/* DBMS name:      Oracle               */
/* Created on:     10/09/2008                         */
/* Database Modification Script to                               */
/*Update u.achieve 4.0.[2-3] to u.achieve 4.0.4                    */
/*==============================================================*/
alter table job_queue_run 
	add ncol char(1) null;
/