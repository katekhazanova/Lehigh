alter table job_queue_exceptions
   drop constraint FK_JQEXC_REF_JQRUN
go

alter table job_queue_incl_text
   drop constraint FK_JQINCL_REF_JQRUN
go

alter table job_queue_markers
   drop constraint FK_JQMRK_REF_JQRUN
go

alter table job_queue_report
   drop constraint FK_JQREP_REF_JQRUN 
go

alter table job_queue_req_text
   drop constraint FK_JQRTXT_REF_JQREQ 
go

alter table job_queue_subreq
   drop constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ
go

alter table job_queue_subreq_text
   drop constraint FK_JQSRTXT_REF_JQREQ 
go




/*==============================================================*/
/* Table: job_queue_req                                         */
/*==============================================================*/
alter table job_queue_req 
Add    hideheadtitle        char(1)               null,
       hideneedssummary     char(1)               null,
       hideselfrmcrs        char(1)               null,
       hidemtchdcrs         char(1)               null
go


/*==============================================================*/
/* Table: job_queue_run                                         */
/*==============================================================*/
alter table job_queue_run
	drop column JOBQ_SYSOUT_USED
go

/*==============================================================*/
/* Table: job_queue_subreq                                      */
/*==============================================================*/
alter table job_queue_subreq
	Add		hidetitle 			char(1)              null,
			hidesummary 			char(1)              null,
			hideselfrmcrs 		char(1)              null,
			hidestucrs 			char(1)              null
go

alter table job_queue_exceptions
   add constraint FK_JQEXC_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_incl_text
   add constraint FK_JQINCL_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_markers
   add constraint FK_JQMRK_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_report
   add constraint FK_JQREP_REF_JQRUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
go

alter table job_queue_req_text
   add constraint FK_JQRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
go

alter table job_queue_subreq
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
go

alter table job_queue_subreq_text
   add constraint FK_JQSRTXT_REF_JQREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
go