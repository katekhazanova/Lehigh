/*==============================================================*/
/* Database name:  Database                                     */
/* DARwin Release: DARwin 3.0b1                                 */
/* DBMS name:      ORACLE Version 8i2 (8.1.6)                   */
/* Created on:     10/15/2001 1:49:34 PM                        */
/*                                                              */
/* Modifications:	1/29/02	Version 3.0b3                        */
/*                         Added ip, complete to job_queue_run  */
/*                         Modified stu_exceptions.auth_date    */
/*                            from char(10) to varchar2(12)     */
/*                         Removed creation of sequence objects */
/*                            (moved to trigger script)         */
/*                         Added update_pin to secure_inst      */
/*==============================================================*/


alter table analysis modify complete VARCHAR2(1)
/


alter table analysis modify ip VARCHAR2(1)
/


alter table analysis modify seqout VARCHAR2(1)
/


alter table analysis modify sreqct NUMBER
/


alter table analysis add userid CHAR(30)
/


alter table analysis add soprid CHAR(8)
/


alter table analysis add stuno VARCHAR2(13)
/


alter table analysis add stuname VARCHAR2(35)
/


alter table analysis add dprog VARCHAR2(15)
/


alter table analysis add instcd VARCHAR2(3) default ' '
/


alter table analysis add dpmask CHAR(15)
/


alter table analysis add degree_date VARCHAR2(10)
/


alter table analysis add catlyt VARCHAR2(6)
/


alter table analysis add runtime CHAR(9)
/


alter table analysis add rundate CHAR(10)
/


alter table analysis add instid CHAR(8) default ' '
/


alter table analysis add jobid CHAR(16)
/


alter table analysis add instidq CHAR(2) default ' '
/


alter table analysis_req modify psname VARCHAR2(15)
/


alter table analysis_req modify met VARCHAR2(1)
/


alter table analysis_req modify fmet VARCHAR2(1)
/


alter table analysis_req modify seqout VARCHAR2(1)
/


alter table analysis_req modify reqhrs NUMBER(5,2)
/


alter table analysis_req modify gothrs NUMBER(5,2)
/


alter table analysis_req modify gotgpahrs NUMBER(5,2)
/


alter table analysis_req add gotgpapts NUMBER(9,5) default 0
/


alter table dprog add dptype CHAR(1)
/


alter table dprog add webtitle VARCHAR2(50)
/


alter table job_queue_sysout modify sysout VARCHAR2(1)
/


alter table stu_master add nodflt CHAR(1)
/


alter table stu_master add pin VARCHAR2(20)
/


alter table tca_rule add private_note VARCHAR2(255)
/


alter table tca_target add tastatus CHAR(1)
/


alter table stu_exceptions modify reqhrs NUMBER(5,2)
/


alter table stu_exceptions modify maxhrs NUMBER(5,2)
/


alter table stu_exceptions modify reqsrq NUMBER(3)
/


alter table stu_exceptions modify maxct NUMBER(3)
/


alter table stu_exceptions modify val NUMBER(3)
/


alter table stu_exceptions modify reqgpa NUMBER(5,3)
/

alter table stu_exceptions modify auth_date VARCHAR2(12)
/

alter table analysis_courses modify course VARCHAR2(15)
/


alter table analysis_courses modify passfail VARCHAR2(1)
/


alter table analysis_courses add yeartm CHAR(6) default '0000'
/


alter table analysis_courses add credit NUMBER(7,5) default 0
/


alter table stu_evalgrp add certify CHAR(1) default ' '
/

alter table job_queue_run add complete CHAR(1) default ' '
/

alter table job_queue_run add ip CHAR(1) default ' '
/

alter table secure_inst add update_pin CHAR(1)
/

update sub_req_ar
	set tflg = 'C', matchctl = ' '
	where matchctl = 'C'
/

create sequence jobqd_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/

create sequence jobqsi_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/

create sequence jobqr_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/

create sequence jobqo_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/

create sequence jobqso_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/

create sequence analy_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/

create sequence dprog_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence req_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence mref_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence tca_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
/

create sequence stuexc_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/

create sequence stumast_seq_no
    start with 1
    increment by 1
    maxvalue 999999999
    cycle
/
