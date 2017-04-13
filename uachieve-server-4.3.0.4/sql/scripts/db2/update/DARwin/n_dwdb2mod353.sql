
DROP TRIGGER   TI_REQ_MAIN
;
DROP TRIGGER   TI_REQ_XY
;
DROP TRIGGER    TI_SUB_REQ
;
 
 DROP TRIGGER TU_REQ_MAIN
 ;

 
 DROP TRIGGER TU_chartcat
 ;


 DROP TRIGGER Ti_chartcat
 ;

---DROP CONSTRAINTS


ALTER TABLE CHART_CATEGORIES
    DROP PRIMARY KEY 
; 


ALTER TABLE SUB_REQ
   DROP FOREIGN KEY F_RELATION_2577
;

ALTER TABLE SUB_REQ
   DROP PRIMARY KEY
;


ALTER TABLE REQ_MAIN
   DROP PRIMARY KEY
;

 

ALTER TABLE JOB_QUEUE_SUBREQ
   DROP FOREIGN KEY FK_JOBQ_SUBREQ_REF
;
 
ALTER TABLE JOB_QUEUE_REQ
    DROP FOREIGN KEY FK_JOBQ_REQ_REF_JO
;
 
 
ALTER TABLE JOB_QUEUE_REQ
    DROP PRIMARY KEY 
; 
 
ALTER TABLE JOB_QUEUE_RUN
    DROP PRIMARY KEY 
;  
 
 
ALTER TABLE JOB_QUEUE_SUBREQ
    DROP PRIMARY KEY 
; 
  
 
--- DROP TEMP TABLES IF NEEDED & RENAME OLD VERSION TABLES
DROP TABLE TMP_REQ_MAIN
;

RENAME TABLE REQ_MAIN TO TMP_REQ_MAIN
;

DROP TABLE TMP_SUB_REQ
;

RENAME TABLE SUB_REQ TO TMP_SUB_REQ
;

DROP TABLE TMP_JOB_QUEUE_REQ
;

RENAME TABLE JOB_QUEUE_REQ TO TMP_JOB_QUEUE_REQ
;

DROP TABLE TMP_JOB_QUEUE_SUBREQ
;

DROP TABLE TMP_JOB_QUEUE_RUN
;

RENAME TABLE JOB_QUEUE_RUN TO TMP_JOB_QUEUE_RUN
;



RENAME TABLE JOB_QUEUE_SUBREQ TO TMP_JOB_QUEUE_SUBREQ
;

DROP TABLE TMP_CHART_CATEGORIES
;

RENAME TABLE CHART_CATEGORIES TO TMP_CHART_CATEGORIES
;


DROP INDEX CHART_CAT_IDX ;








----CREATE TABLES USING INSERT INTO

--==============================================================
-- TABLE: CHART_CATEGORIES
--==============================================================
CREATE TABLE CHART_CATEGORIES
(
   INSTIDQ              CHAR(2)                NOT NULL DEFAULT ' ',
   INSTID               CHAR(8)                NOT NULL DEFAULT ' ',
   INSTCD               CHAR(3)                NOT NULL DEFAULT ' ',
   CATEGORY_CODE        CHAR(1)                NOT NULL,
   CATEGORY_NAME        CHAR(15),
   CATEGORY_DESC        VARCHAR(255),
   TRANSCRIPT           CHAR(1),
   TOTAL_HOUR           CHAR(1),
   TOTAL_GPA            CHAR(1),
   HIDEFROMCHART        CHAR(1),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   HIDE_GPA             CHAR(1),
   CONSTRAINT P_KEY_1 PRIMARY KEY (INSTIDQ, INSTID, INSTCD, CATEGORY_CODE)
) 
;

INSERT INTO CHART_CATEGORIES(
   INSTIDQ            ,
   INSTID,
   INSTCD,
   CATEGORY_CODE ,
   CATEGORY_NAME,
   CATEGORY_DESC,
   TRANSCRIPT,
   TOTAL_HOUR,
   TOTAL_GPA,
   HIDEFROMCHART ,
   LAST_MOD_USER,
   LAST_MOD_DATE)
   SELECT
   INSTIDQ   ,
   INSTID,
   INSTCD,
   CATEGORY_CODE ,
   CATEGORY_NAME,
   CATEGORY_DESC,
   TRANSCRIPT,
   TOTAL_HOUR,
   TOTAL_GPA,
   HIDEFROMCHART ,
   LAST_MOD_USER,
   LAST_MOD_DATE
   FROM TMP_CHART_CATEGORIES
   ;


DROP TABLE TMP_CHART_CATEGORIES
;

--==============================================================
-- INDEX: CHART_CAT_IDX
--==============================================================
CREATE INDEX CHART_CAT_IDX ON CHART_CATEGORIES (
   INSTIDQ              ASC,
   INSTID               ASC,
   INSTCD               ASC,
   CATEGORY_CODE        ASC,
   TRANSCRIPT           ASC,
   HIDEFROMCHART        ASC,
   TOTAL_HOUR           ASC
)
;








--==============================================================
-- TABLE: JOB_QUEUE_REQ
--==============================================================
CREATE TABLE JOB_QUEUE_REQ
(
   JOBQ_SEQ_NO          NUMERIC(9)             NOT NULL,
   RTABX                CHAR(3)                NOT NULL,
   RNO                  CHAR(3),
   RNAME                VARCHAR(9),
   PSNAME               VARCHAR(15),
   CATEGORY             VARCHAR(15),
   SUMMARY_GRP          VARCHAR(15),
   TRANSCRIPT           CHAR(1),
   TOTAL_HOUR           CHAR(1),
   TOTAL_GPA            CHAR(1),
   HIDEFROMCHART        CHAR(1),
   SATISFIED            CHAR(1),
   SUMMARY              CHAR(1),
   SORTFLG              CHAR(1),
   ORREQ                CHAR(1),
   OPTREQ               CHAR(1),
   REQSRQ               INTEGER,
   GOTSRQ               INTEGER,
   NEEDSRQ              INTEGER,
   REQCT                INTEGER,
   GOTCT                INTEGER,
   IPCT                 INTEGER,
   WHATIFCT             INTEGER,
   NEEDCT               INTEGER,
   MAXHRS               NUMERIC(10,5),
   REQHRS               NUMERIC(10,5),
   EST_REQHRS           NUMERIC(10,5),
   GOTHRS               NUMERIC(10,5),
   IPHRS                NUMERIC(10,5),
   WHATIFHRS            NUMERIC(10,5),
   NEEDHRS              NUMERIC(10,5),
   GOTGPAHRS            NUMERIC(10,5),
   GOTGPAPTS            NUMERIC(10,5),
   REQGPA               NUMERIC(10,5),
   GOTGPA               NUMERIC(10,5),
   NEEDGPA              NUMERIC(10,5),
   REQGPAF              CHAR(1),
   GPANAME              CHAR(15),
   GPALOWYT		CHAR(6),
   GPAHIGHYT            CHAR(6),
   HIDDEN		CHAR(1),
   HIDECATEGORYGPA      CHAR(1),

   CONSTRAINT P_KEY_1 PRIMARY KEY (JOBQ_SEQ_NO, RTABX)
)
;


INSERT INTO JOB_QUEUE_REQ (JOBQ_SEQ_NO,
RTABX,           
RNO,              
RNAME,            
PSNAME,           
CATEGORY,         
SUMMARY_GRP,      
TRANSCRIPT,       
TOTAL_HOUR,       
TOTAL_GPA,        
HIDEFROMCHART,    
SATISFIED,        
SUMMARY,          
SORTFLG,          
ORREQ,            
OPTREQ,           
REQSRQ,           
GOTSRQ,           
NEEDSRQ,          
REQCT,            
GOTCT,            
IPCT,             
WHATIFCT,         
NEEDCT,           
MAXHRS,           
REQHRS,           
EST_REQHRS,       
GOTHRS,           
IPHRS,            
WHATIFHRS,        
NEEDHRS,          
GOTGPAHRS,        
GOTGPAPTS,        
REQGPA,           
GOTGPA,           
NEEDGPA)   
SELECT JOBQ_SEQ_NO,
RTABX,           
RNO,              
RNAME,            
PSNAME,           
CATEGORY,         
SUMMARY_GRP,      
TRANSCRIPT,       
TOTAL_HOUR,       
TOTAL_GPA,        
HIDEFROMCHART,    
SATISFIED,        
SUMMARY,          
SORTFLG,          
ORREQ,            
OPTREQ,           
REQSRQ,           
GOTSRQ,           
NEEDSRQ,          
REQCT,            
GOTCT,            
IPCT,             
WHATIFCT,         
NEEDCT,           
MAXHRS,           
REQHRS,           
EST_REQHRS,       
GOTHRS,           
IPHRS,            
WHATIFHRS,        
NEEDHRS,          
GOTGPAHRS,        
GOTGPAPTS,        
REQGPA,           
GOTGPA,           
NEEDGPA        
FROM TMP_JOB_QUEUE_REQ        
;                          
                           
DROP TABLE TMP_JOB_QUEUE_REQ  
;                          
                           
---
---
---


--==============================================================
-- TABLE: JOB_QUEUE_RUN
--==============================================================
CREATE TABLE JOB_QUEUE_RUN
(
   INT_SEQ_NO           NUMERIC(9)             NOT NULL GENERATED BY DEFAULT AS IDENTITY,
   INSTIDQ              CHAR(2)                DEFAULT ' ',
   INSTID               CHAR(8)                DEFAULT ' ',
   INSTCD               CHAR(3)                DEFAULT ' ',
   JOBID                CHAR(16)               DEFAULT ' ',
   USERID               CHAR(30)               DEFAULT ' ',
   SOPRID               CHAR(8)                DEFAULT ' ',
   STUNO                CHAR(13)               DEFAULT ' ',
   DPROG                CHAR(15)               DEFAULT ' ',
   DPMASK               CHAR(15)               DEFAULT ' ',
   CATLYT               CHAR(6)                DEFAULT ' ',
   BINSTID              CHAR(8),
   BINSTCD              CHAR(3),
   RUNDATE              CHAR(10),
   JOBQ_SYSOUT_USED     CHAR(1),
   RUNTIME              CHAR(8),
   NCOL                 CHAR(1),
   COMPLETE             CHAR(1),
   IP                   CHAR(1),
   DPTITLE1             CHAR(65),
   DPTITLE2             CHAR(65),
   WEBTITLE		CHAR(50),
   CONSTRAINT P_KEY_23 PRIMARY KEY (INT_SEQ_NO)
);



INSERT INTO JOB_QUEUE_RUN
   (INT_SEQ_NO,
   INSTIDQ,
   INSTID,
   INSTCD,
   JOBID,
   USERID,
   SOPRID,
   STUNO,
   DPROG,
   DPMASK,
   CATLYT,
   BINSTID,
   BINSTCD,
   RUNDATE,
   JOBQ_SYSOUT_USED,
   RUNTIME,
   NCOL,
   COMPLETE,
   IP)
  SELECT                          
  INT_SEQ_NO,
   INSTIDQ,
   INSTID,
   INSTCD,
   JOBID,
   USERID,
   SOPRID,
   STUNO,
   DPROG,
   DPMASK,
   CATLYT,
   BINSTID,
   BINSTCD,
   RUNDATE,
   JOBQ_SYSOUT_USED,
   RUNTIME,
   NCOL,
   COMPLETE,
   IP
   FROM TMP_JOB_QUEUE_RUN
;                 

drop table TMP_JOB_QUEUE_RUN;        
                           
---
---
---                           
--==============================================================
-- INDEX: JOBQ_REQ_IDX     
--==============================================================
CREATE INDEX JOBQ_REQ_IDX ON JOB_QUEUE_REQ (
   JOBQ_SEQ_NO          ASC,
   RTABX                ASC,
   RNAME                ASC,
   CATEGORY             ASC,
   SUMMARY_GRP          ASC,
   TRANSCRIPT           ASC,
   TOTAL_HOUR           ASC,
   HIDEFROMCHART        ASC,
   SUMMARY              ASC
)                          
;                          
                           
                           
--==============================================================
-- TABLE: JOB_QUEUE_SUBREQ 
--==============================================================
CREATE TABLE JOB_QUEUE_SUBREQ
(                          
   JOBQ_SEQ_NO          NUMERIC(9)             NOT NULL,
   RTABX                CHAR(3)                NOT NULL,
   STABX                CHAR(3)                NOT NULL,
   SNO                  CHAR(3),
   SATISFIED            CHAR(1),
   SORTFLG              CHAR(1),
   ORSUB                CHAR(1),
   OPTSUB               CHAR(1),
   REQCT                INTEGER,
   GOTCT                INTEGER,
   NEEDCT               INTEGER,
   IPCT                 INTEGER,
   WHATIFCT             INTEGER,
   MAXHRS               NUMERIC(10,5),
   REQHRS               NUMERIC(10,5),
   EST_REQHRSFLG        CHAR(1),
   EST_REQHRS           NUMERIC(10,5),
   GOTHRS               NUMERIC(10,5),
   IPHRS                NUMERIC(10,5),
   WHATIFHRS            NUMERIC(10,5),
   NEEDHRS              NUMERIC(10,5),
   REQGPA               NUMERIC(10,5),
   GOTGPA               NUMERIC(10,5),
   NEEDGPA              NUMERIC(10,5),
   GOTGPAHRS            NUMERIC(10,5),
   GOTGPAPTS            NUMERIC(10,5)          DEFAULT 0,
   REQGPAF              CHAR(1),
   GPANAME              CHAR(15),
   GPALOWYT		CHAR(6),
   GPAHIGHYT            CHAR(6),
   HIDDEN		CHAR(1),
   CONSTRAINT P_KEY_1 PRIMARY KEY (JOBQ_SEQ_NO, RTABX, STABX)
)
;




INSERT INTO JOB_QUEUE_SUBREQ (JOBQ_SEQ_NO,              
RTABX,                    
STABX,                    
SNO,                      
SATISFIED,                
SORTFLG,                  
ORSUB,                    
OPTSUB,                   
REQCT,                    
GOTCT,                    
NEEDCT,                   
IPCT,                     
WHATIFCT,                 
MAXHRS,                   
REQHRS,                   
EST_REQHRSFLG,            
EST_REQHRS,               
GOTHRS,                   
IPHRS,                    
WHATIFHRS,                
NEEDHRS,                  
REQGPA,                   
GOTGPA,                   
NEEDGPA,                  
GOTGPAHRS,                
GOTGPAPTS)   
SELECT JOBQ_SEQ_NO,              
RTABX,                    
STABX,                    
SNO,                      
SATISFIED,                
SORTFLG,                  
ORSUB,                    
OPTSUB,                   
REQCT,                    
GOTCT,                    
NEEDCT,                   
IPCT,                     
WHATIFCT,                 
MAXHRS,                   
REQHRS,                   
EST_REQHRSFLG,            
EST_REQHRS,               
GOTHRS,                   
IPHRS,                    
WHATIFHRS,                
NEEDHRS,                  
REQGPA,                   
GOTGPA,                   
NEEDGPA,                  
GOTGPAHRS,                
GOTGPAPTS         
FROM TMP_JOB_QUEUE_SUBREQ        
;                          
                           
DROP TABLE TMP_JOB_QUEUE_SUBREQ  
;              
            
--==============================================================
-- TABLE: REQ_MAIN
--==============================================================
CREATE TABLE REQ_MAIN
(
   INSTIDQ              CHAR(2)                NOT NULL DEFAULT ' ',
   INSTID               CHAR(8)                NOT NULL DEFAULT ' ',
   INSTCD               CHAR(3)                NOT NULL DEFAULT ' ',
   RNAME                CHAR(9)                NOT NULL,
   RQFYT                CHAR(6)                NOT NULL DEFAULT '0000',
   LYT                  CHAR(6)                DEFAULT '9999',
   REQSRQ               NUMERIC(2)             DEFAULT 0,
   REQHRS               NUMERIC(4,1)           DEFAULT 0,
   REQGPA               NUMERIC(4,3)           DEFAULT 0,
   AC1                  CHAR(1),
   AC2                  CHAR(1),
   RC1                  CHAR(1),
   RC2                  CHAR(1),
   ASSIGNC              CHAR(1),
   REUSE                CHAR(1),
   NOLIST               CHAR(1),
   PSNAME               CHAR(15),
   REFCYCLE             CHAR(1),
   RQTYPE               CHAR(1),
   REQSRQF              CHAR(1),
   REQHRSF              CHAR(1),
   REQGPAF              CHAR(1),
   USECT                NUMERIC(2)             DEFAULT 0,
   IPLIST               CHAR(1),
   NOCOMPL              CHAR(1),
   REQCT                NUMERIC(2)             DEFAULT 0,
   REQCTF               CHAR(1),
   MAXHRS               NUMERIC(4,1)           DEFAULT 999.9,
   RCONDA               CHAR(1),
   RCONDR               CHAR(1),
   VARR                 CHAR(1),
   LOKOVR1              CHAR(1),
   LNOOVR1              CHAR(1),
   LOKOVR2              CHAR(1),
   LNOOVR2              CHAR(1),
   RACTL                CHAR(1),
   ASSIGNC2             CHAR(1),
   REFDIR               CHAR(1),
   REFFLD               CHAR(1),
   REFSUB               CHAR(1),
   REFVAL               CHAR(1),
   RTITLE1              VARCHAR(58),
   RTITLE2              VARCHAR(58),
   RUNSTATUS            CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   ESTREQHRS            NUMERIC(4,1),
   GPANAME              CHAR(15),
   CONSTRAINT P_KEY_8 PRIMARY KEY (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
)
;

INSERT INTO REQ_MAIN (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, LYT, REQSRQ, REQHRS, REQGPA, AC1, AC2, RC1, RC2, ASSIGNC, REUSE, NOLIST, PSNAME, REFCYCLE, RQTYPE, REQSRQF, REQHRSF, REQGPAF, USECT, IPLIST, NOCOMPL, REQCT, REQCTF, MAXHRS, RCONDA, RCONDR, VARR, LOKOVR1, LNOOVR1, LOKOVR2, LNOOVR2, RACTL, ASSIGNC2, REFDIR, REFFLD, REFSUB, REFVAL, RTITLE1, RTITLE2, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE, ESTREQHRS)
SELECT INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, LYT, REQSRQ, REQHRS, REQGPA, AC1, AC2, RC1, RC2, ASSIGNC, REUSE, NOLIST, PSNAME, REFCYCLE, RQTYPE, REQSRQF, REQHRSF, REQGPAF, USECT, IPLIST, NOCOMPL, REQCT, REQCTF, MAXHRS, RCONDA, RCONDR, VARR, LOKOVR1, LNOOVR1, LOKOVR2, LNOOVR2, RACTL, ASSIGNC2, REFDIR, REFFLD, REFSUB, REFVAL, RTITLE1, RTITLE2, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE, ESTREQHRS
FROM TMP_REQ_MAIN
;

DROP TABLE TMP_REQ_MAIN
;


--==============================================================
-- TABLE: SUB_REQ
--==============================================================
CREATE TABLE SUB_REQ
(
   INT_SEQ_NO           NUMERIC(9)             NOT NULL GENERATED BY DEFAULT AS IDENTITY,
   INSTIDQ              CHAR(2)                NOT NULL DEFAULT ' ',
   INSTID               CHAR(8)                NOT NULL DEFAULT ' ',
   INSTCD               CHAR(3)                NOT NULL DEFAULT ' ',
   RNAME                CHAR(9)                NOT NULL,
   RQFYT                CHAR(6)                NOT NULL DEFAULT '0000',
   USER_SEQ_NO          INTEGER                DEFAULT 0,
   SREQNO               INTEGER                DEFAULT 0,
   REQCT                NUMERIC(2)             DEFAULT 0,
   REQCTF               CHAR(1),
   REQHRS               NUMERIC(4,1)           DEFAULT 0,
   REQHRSF              CHAR(1),
   REQGPA               NUMERIC(4,3)           DEFAULT 0,
   REQGPAF              CHAR(1),
   MAXHRS               NUMERIC(4,1)           DEFAULT 999.9,
   MAXHRSCK             CHAR(1),
   ALLRES               CHAR(1),
   AC1                  CHAR(1),
   AC2                  CHAR(1),
   AC3                  CHAR(1),
   AC4                  CHAR(1),
   AC5                  CHAR(1),
   ACOR                 CHAR(1),
   RC1                  CHAR(1),
   RC2                  CHAR(1),
   RC3                  CHAR(1),
   RC4                  CHAR(1),
   RC5                  CHAR(1),
   RCAND                CHAR(1),
   ACTL                 CHAR(1),
   ASSIGNC              CHAR(1),
   ASSIGNC2             CHAR(1),
   ASSIGNM              CHAR(1),
   SREUSE               CHAR(1),
   SKIPBCT              NUMERIC(1),
   NOLIST               CHAR(1),
   NOSEQNO              CHAR(1),
   REQFLG               CHAR(1),
   IPLIST               CHAR(1),
   IGNORECL             CHAR(1),
   GPAWEIGHT            CHAR(1),
   SEQCHK               CHAR(1),
   MAXCT                NUMERIC(2)             DEFAULT 99,
   CTCOND0              CHAR(1),
   CTCOND1              CHAR(1),
   CTCOND2              CHAR(1),
   CTCOND3              CHAR(1),
   CTCOND4              CHAR(1),
   CTCOND5              CHAR(1),
   CTCOND6              CHAR(1),
   CTCOND7              CHAR(1),
   CTCOND8              CHAR(1),
   CTCOND9              CHAR(1),
   CTCOND10             CHAR(1),
   CTCOND11             CHAR(1),
   CTCOND12             CHAR(1),
   CTCOND13             CHAR(1),
   CTCOND14             CHAR(1),
   CONDA                CHAR(1),
   CONDR                CHAR(1),
   LISTSR               CHAR(1),
   NEGREQ               CHAR(1),
   PNTDESCR             CHAR(1),
   GPA                  CHAR(1),
   AONLY                CHAR(1),
   CALPHA               CHAR(1),
   GRP                  CHAR(1),
   GRPMIN               NUMERIC(2)             DEFAULT 0,
   GRPMAX               NUMERIC(2)             DEFAULT 99,
   VARC                 CHAR(1),
   HCMIN                NUMERIC(2)             DEFAULT 0,
   HCMAX                NUMERIC(2)             DEFAULT 99,
   XREFSR               CHAR(1),
   REFGNO               NUMERIC(2)             DEFAULT 0,
   EORDER               CHAR(1),
   ETOPDOWN             CHAR(1),
   ESTOP                CHAR(1),
   ELIMIT               CHAR(1),
   REFDIR               CHAR(1),
   REFFLD               CHAR(1),
   REFSUB               CHAR(1),
   REFVAL               CHAR(1),
   REFCYCLE             CHAR(1),
   SELRA                CHAR(1),
   SORTFLG              CHAR(1),
   SREQOR               CHAR(1),
   ACTLX                CHAR(1),
   ASSIGNCX             CHAR(1),
   REVARTL              CHAR(1),
   MATCHONE             CHAR(1),
   LTOPDOWN             CHAR(1),
   SELIP                CHAR(1),
   RUNSTATUS            CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   ESTHRS               NUMERIC(4,1),
   ESTHRSFLG            CHAR(1),
   GPANAME              CHAR(15),
   CONSTRAINT P_KEY_11 PRIMARY KEY (INT_SEQ_NO)
)
;

INSERT INTO SUB_REQ (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, SREQNO, REQCT, REQCTF, REQHRS, REQHRSF, REQGPA, REQGPAF, MAXHRS, MAXHRSCK, ALLRES, AC1, AC2, AC3, AC4, AC5, ACOR, RC1, RC2, RC3, RC4, RC5, RCAND, ACTL, ASSIGNC, ASSIGNC2, ASSIGNM, SREUSE, SKIPBCT, NOLIST, NOSEQNO, REQFLG, IPLIST, IGNORECL, GPAWEIGHT, SEQCHK, MAXCT, CTCOND0, CTCOND1, CTCOND2, CTCOND3, CTCOND4, CTCOND5, CTCOND6, CTCOND7, CTCOND8, CTCOND9, CTCOND10, CTCOND11, CTCOND12, CTCOND13, CTCOND14, CONDA, CONDR, LISTSR, NEGREQ, PNTDESCR, GPA, AONLY, CALPHA, GRP, GRPMIN, GRPMAX, VARC, HCMIN, HCMAX, XREFSR, REFGNO, EORDER, ETOPDOWN, ESTOP, ELIMIT, REFDIR, REFFLD, REFSUB, REFVAL, REFCYCLE, SELRA, SORTFLG, SREQOR, ACTLX, ASSIGNCX, REVARTL, MATCHONE, LTOPDOWN, SELIP, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE, ESTHRS, ESTHRSFLG )
SELECT INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, SREQNO, REQCT, REQCTF, REQHRS, REQHRSF, REQGPA, REQGPAF, MAXHRS, MAXHRSCK, ALLRES, AC1, AC2, AC3, AC4, AC5, ACOR, RC1, RC2, RC3, RC4, RC5, RCAND, ACTL, ASSIGNC, ASSIGNC2, ASSIGNM, SREUSE, SKIPBCT, NOLIST, NOSEQNO, REQFLG, IPLIST, IGNORECL, GPAWEIGHT, SEQCHK, MAXCT, CTCOND0, CTCOND1, CTCOND2, CTCOND3, CTCOND4, CTCOND5, CTCOND6, CTCOND7, CTCOND8, CTCOND9, CTCOND10, CTCOND11, CTCOND12, CTCOND13, CTCOND14, CONDA, CONDR, LISTSR, NEGREQ, PNTDESCR, GPA, AONLY, CALPHA, GRP, GRPMIN, GRPMAX, VARC, HCMIN, HCMAX, XREFSR, REFGNO, EORDER, ETOPDOWN, ESTOP, ELIMIT, REFDIR, REFFLD, REFSUB, REFVAL, REFCYCLE, SELRA, SORTFLG, SREQOR, ACTLX, ASSIGNCX, REVARTL, MATCHONE, LTOPDOWN, SELIP, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE, ESTHRS, ESTHRSFLG 
FROM TMP_SUB_REQ
;

DROP TABLE TMP_SUB_REQ
;



---ALTER ADD IN CONSTRAINTS
  
ALTER TABLE JOB_QUEUE_REQ
   ADD CONSTRAINT FK_JOBQ_REQ_REF_JO FOREIGN KEY (JOBQ_SEQ_NO)
      REFERENCES JOB_QUEUE_RUN (INT_SEQ_NO)
      ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE JOB_QUEUE_SUBREQ
   ADD CONSTRAINT FK_JOBQ_SUBREQ_REF FOREIGN KEY (JOBQ_SEQ_NO, RTABX)
      REFERENCES JOB_QUEUE_REQ (JOBQ_SEQ_NO, RTABX)
      ON DELETE RESTRICT ON UPDATE RESTRICT
;
 

ALTER TABLE SUB_REQ
   ADD CONSTRAINT F_RELATION_2577 FOREIGN KEY (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      REFERENCES REQ_MAIN (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT)
      ON DELETE RESTRICT ON UPDATE RESTRICT
;


--RECREATE DROPPED TRIGGERS

CREATE TRIGGER TI_SUB_REQ NO CASCADE BEFORE INSERT ON SUB_REQ
REFERENCING NEW AS N	  FOR EACH ROW MODE DB2SQL  
SET N.LAST_MOD_DATE = CURRENT TIMESTAMP, N.LAST_MOD_USER = USER
;


 

CREATE TRIGGER TI_REQ_MAIN NO CASCADE BEFORE INSERT ON REQ_MAIN
REFERENCING NEW AS N	  FOR EACH ROW MODE DB2SQL  
SET N.LAST_MOD_DATE = CURRENT TIMESTAMP, N.LAST_MOD_USER = USER
;


CREATE TRIGGER TU_REQ_MAIN NO CASCADE BEFORE UPDATE ON REQ_MAIN
REFERENCING OLD AS OLD NEW AS N    FOR EACH ROW 
MODE DB2SQL  SET N.LAST_MOD_DATE = CURRENT TIMESTAMP, N.LAST_MOD_USER = USER
;


CREATE TRIGGER TI_REQ_XY    NO CASCADE BEFORE INSERT	ON REQ_XY    REFERENCING NEW AS N    FOR EACH ROW MODE DB2SQL  SET 
N.LAST_MOD_DATE = CURRENT TIMESTAMP, N.LAST_MOD_USER = USER
; 

   create trigger ti_chartcat    NO CASCADE BEFORE INSERT    on CHART_CATEGORIES	REFERENCING NEW AS n	FOR EACH ROW MODE 
DB2SQL	set n.last_mod_date = current timestamp, n.last_mod_user = user
; 


 create trigger tU_chartcat    NO CASCADE BEFORE UPDATE    on CHART_CATEGORIES    REFERENCING OLD AS OLD NEW AS n    FOR EACH ROW 
MODE DB2SQL  set n.last_mod_date = current timestamp, n.last_mod_user = user
;