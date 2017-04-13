/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2005/2008/2012          */
/* Created on:     03/14/2014                                   */
/* Database Modification Script to Update                       */
/* u.achieve 4.1.[1-6] to u.achieve 4.2.0                       */
/*==============================================================*/

/*==============================================================*/
/* Table: job_queue_exceptions                                  */
/*==============================================================*/
alter table job_queue_exceptions
    drop column last_mod_date
go

alter table job_queue_exceptions add
   course				varchar(15)			  null,
   rcourse				varchar(15)			  null,
   cline				varchar(27)           null,
   psname               varchar(15)           null,
   rname                varchar(9)            null,
   auth_id              varchar(30)           null,
   auth_date            varchar(12)           null,
   auth_code            varchar(10)           null,
   last_mod_date      	datetime              null
go

/*==============================================================*/
/* Table: job_queue_course                                      */
/*==============================================================*/
alter table job_queue_course add
	pseudo               char(1)               null
go

/*==============================================================*/
/* Some (very) early verisons of u.achieve defined a default    */
/* value for the report_type column.  If that default is still  */
/* in place, we can't update the column definition until we     */
/* remove the default constraint.                               */
/*==============================================================*/

declare @default_name varchar(256)

select @default_name = [name] 
from sys.default_constraints
where parent_object_id = object_id('job_queue_list')
and col_name(parent_object_id, parent_column_id) = 'report_type'

if @default_name > ' '
    begin
        exec('alter table dbo.job_queue_list drop constraint ' + @default_name)
    end
go


/*==============================================================*/
/* Column: report_type                                          */
/* Tables: job_queue_list, job_queue_run, job_queue_report      */
/*==============================================================*/
alter table job_queue_list alter column 
    report_type 	varchar(10) 	null
go

alter table job_queue_run alter column 
	report_type 	varchar(10) 	null
go

alter table job_queue_report alter column 
	report_type 	varchar(10) 	null
go
