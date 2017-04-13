/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2000/2005               */
/* Created on:     10/09/2008                         */
/* Database Modification Script to                               */
/*Update u.achieve 4.0.0-1 to u.achieve 4.0.2                    */
/*==============================================================*/

IF (EXISTS 
        (SELECT * FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_NAME = 'job_queue_out'))

    BEGIN         
        DROP TABLE job_queue_out
    END
go
       
CREATE TABLE job_queue_out  ( 
            int_seq_no 	numeric(9,0) IDENTITY(1,1) NOT NULL,
            jobq_seq_no	numeric(9,0) NOT NULL,
            user_seq_no	int null,
            rtabx      	char(3) NULL,
            reqstatus  	char(1) NULL,
            stabx      	char(3) NULL,
            srno       	char(2) NULL,
            srstatus   	char(1) NULL,
            optline    	char(1) NULL,
            lasera     	char(1) NULL,
            laserb     	char(1) NULL,
            darout     	varchar(255) NULL,
            CONSTRAINT PK_JOB_QUEUE_OUT PRIMARY KEY(int_seq_no)
)
go

ALTER TABLE job_queue_out
        ADD CONSTRAINT FK_JOBQ_OUT_REF_JOBQ_RUN
        FOREIGN KEY(jobq_seq_no)
        REFERENCES dbo.job_queue_run(int_seq_no)
go

CREATE INDEX jobq_out_idx on job_queue_out (
            jobq_seq_no ASC
    )
go