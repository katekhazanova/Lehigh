/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2000/2005               */
/* Created on:     10/09/2008                         */
/* Database Modification Script to                               */
/*Update u.achieve 4.0.[2-3] to u.achieve 4.0.4                    */
/*==============================================================*/
if not (exists(select * from information_schema.columns
                where table_name = 'job_queue_run'
                and column_name = 'ncol'))
    begin
        alter table job_queue_run add ncol char(1)  
    end
go
