

ALTER TABLE TCA_TARGET
ADD COLUMN  HIDE_ACOURSE1        CHAR(1)
;

ALTER TABLE TCA_TARGET
ADD COLUMN  HIDE_ACOURSE2        CHAR(1)
;

ALTER TABLE TCA_TARGET
ADD COLUMN  HIDE_ACOURSE3        CHAR(1)
;

ALTER TABLE TCA_TARGET
ADD COLUMN  HIDE_IFLGS           CHAR(1)
;

ALTER TABLE JOB_QUEUE_ACCEPT
ADD COLUMN  HIDDEN               CHAR(1)
;

ALTER TABLE JOB_QUEUE_SUBREQ
ADD COLUMN  SUBREQ_ID           NUMERIC(9)
;

