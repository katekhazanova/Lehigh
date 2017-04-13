alter table JOB_QUEUE_EXCEPTIONS add column COURSE		VARCHAR(15)
go
alter table JOB_QUEUE_EXCEPTIONS add column RCOURSE		VARCHAR(15)
go
alter table JOB_QUEUE_EXCEPTIONS add column CLINE		VARCHAR(27)
go
alter table JOB_QUEUE_EXCEPTIONS add column PSNAME   	VARCHAR(15)
go
alter table JOB_QUEUE_EXCEPTIONS add column RNAME    	VARCHAR(9)
go
alter table JOB_QUEUE_EXCEPTIONS add column AUTH_ID  	VARCHAR(30)
go
alter table JOB_QUEUE_EXCEPTIONS add column AUTH_DATE 	VARCHAR(12)
go
alter table JOB_QUEUE_EXCEPTIONS add column AUTH_CODE 	VARCHAR(10)
go

alter table JOB_QUEUE_COURSE 	 add column PSEUDO		CHAR(1)
go

alter table JOB_QUEUE_LIST		alter column REPORT_TYPE set data type VARCHAR(10)
go
alter table JOB_QUEUE_RUN 		alter column REPORT_TYPE set data type VARCHAR(10)
go
alter table JOB_QUEUE_REPORT	alter column REPORT_TYPE set data type VARCHAR(10)
go
 