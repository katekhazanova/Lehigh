ALTER TABLE JOB_QUEUE_DETAIL
ADD COLUMN  D_WHATIF           CHAR(1)
;
ALTER TABLE JOB_QUEUE_ACCEPT
	ADD INNER_MEM CHAR(1)
	;
ALTER TABLE JOB_QUEUE_ACCEPT
	ADD INNER_BGN CHAR(1)
;
ALTER TABLE JOB_QUEUE_ACCEPT
	ADD INNER_END CHAR(1)
;
ALTER TABLE JOB_QUEUE_ACCEPT
	ADD OUTER_MEM CHAR(1)
;
ALTER TABLE JOB_QUEUE_ACCEPT
	ADD OUTER_BGN CHAR(1)
;
ALTER TABLE JOB_QUEUE_ACCEPT
	ADD OUTER_END CHAR(1)
;
ALTER TABLE JOB_QUEUE_ACCEPT
	ADD SYMBOL_BEFORE CHAR(5)
;
ALTER TABLE REQ_MAIN
	ADD LABEL VARCHAR(25);
ALTER TABLE SUB_REQ
	ADD LABEL VARCHAR(25);
ALTER TABLE JOB_QUEUE_REQ
   ADD LABEL VARCHAR(25);
ALTER TABLE JOB_QUEUE_SUBREQ
   ADD LABEL VARCHAR(25);
   
ALTER TABLE JOB_QUEUE_RUN
	ADD DETAIL_SEQ_NO NUMERIC(9)
;