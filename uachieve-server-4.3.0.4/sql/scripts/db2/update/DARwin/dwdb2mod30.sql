alter table ANALYSIS
   drop primary key;

alter table ANALYSIS_COURSES
   drop primary key;

alter table ANALYSIS_REQ
   drop primary key;

alter table COM
   drop primary key;

alter table COND_CODES
   drop primary key;

alter table COURSE_BANK
   drop primary key;

alter table CRS_CONVERT
   drop primary key;


alter table DPROG
   drop primary key;

alter table DPROG_REQ
   drop primary key;

alter table GMASTER
   drop primary key;

alter table JOB_QUEUE_COURSE
   drop primary key;

alter table JOB_QUEUE_DETAIL
   drop primary key;

alter table JOB_QUEUE_LIST
   drop primary key;

alter table JOB_QUEUE_OUT
   drop primary key;

alter table JOB_QUEUE_RUN
   drop primary key;

alter table JOB_QUEUE_SYSIN
   drop primary key;

alter table MASTREF
   drop primary key;

alter table MASTREF_ADDRESS
   drop primary key;

alter table MASTREF_SEG
   drop primary key;

alter table "REPEAT"
   drop primary key;

alter table REQ_MAIN
   drop primary key;

alter table REQ_TEXT
   drop primary key;

alter table REQ_XY
   drop primary key;

alter table SECURE_IMPORT
   drop primary key;

alter table SECURE_INST
   drop primary key;

alter table SECURE_MASTER
   drop primary key;

alter table STRING
   drop primary key;

alter table STRING_CRSE
   drop primary key;

alter table STU_ACADREC
   drop primary key;

alter table STU_ADDRESS
   drop primary key;

alter table STU_DEMO
   drop primary key;

alter table STU_DPROG
   drop primary key;

alter table STU_EGRP_COURSES
   drop primary key;

alter table STU_EVALGRP
   drop primary key;

alter table STU_EXCEPTIONS
   drop primary key;

alter table STU_EXC_COURSES
   drop primary key;

alter table STU_MARKER_REQ
   drop primary key;

alter table STU_MASTER
   drop primary key;

alter table STU_TRANS_DEGREE
   drop primary key;

alter table SUB_REQ
   drop primary key;

alter table SUB_REQ_AR
   drop primary key;

alter table SUB_REQ_TEXT
   drop primary key;

alter table TCA_MASTER
   drop primary key;

alter table TCA_RULE
   drop primary key;

alter table TCA_SOURCE
   drop primary key;

alter table TCA_TARGET
   drop primary key;

drop table "tmp_ANALYSIS";

create table "tmp_ANALYSIS"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   COMPLETE             VARCHAR(1),
   IP                   VARCHAR(1),
   SEQOUT               VARCHAR(1),
   REQCT                INTEGER,
   SREQCT               NUMERIC,
   USERID               CHAR(30),
   SOPRID               CHAR(8),
   STUNO                VARCHAR(13),
   STUNAME              VARCHAR(35),
   DPROG                VARCHAR(15),
   INSTCD               VARCHAR(3),
   DPMASK               CHAR(15),
   DEGREE_DATE          VARCHAR(10),
   CATLYT               VARCHAR(6),
   RUNTIME              CHAR(9),
   RUNDATE              CHAR(10),
   INSTID               CHAR(8),
   JOBID                CHAR(16),
   INSTIDQ              CHAR(2)
);

insert into "tmp_ANALYSIS" (INT_SEQ_NO, COMPLETE, IP, SEQOUT, REQCT, SREQCT, USERID, SOPRID, STUNO, STUNAME, DPROG, INSTCD, DPMASK, DEGREE_DATE, CATLYT, RUNTIME, RUNDATE, INSTID, JOBID, INSTIDQ)
select INT_SEQ_NO, COMPLETE, IP, SEQOUT, REQCT, SREQCT, USERID, SOPRID, STUNO, STUNAME, DPROG, INSTCD, DPMASK, DEGREE_DATE, CATLYT, RUNTIME, RUNDATE, INSTID, JOBID, INSTIDQ
from ANALYSIS;

drop table ANALYSIS;

drop table "tmp_ANALYSIS_COURSES";

create table "tmp_ANALYSIS_COURSES"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   JOBQ_SEQ_NO          NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   COURSE               VARCHAR(15),
   PASSFAIL             VARCHAR(1),
   YEARTM               CHAR(6),
   CREDIT               NUMERIC(7,5)
);

insert into "tmp_ANALYSIS_COURSES" (INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, COURSE, PASSFAIL, YEARTM, CREDIT)
select INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, COURSE, PASSFAIL, YEARTM, CREDIT
from ANALYSIS_COURSES;

drop table ANALYSIS_COURSES;

drop table "tmp_ANALYSIS_REQ";

create table "tmp_ANALYSIS_REQ"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   JOBQ_SEQ_NO          NUMERIC(9)             not null,
   RCT                  NUMERIC(2),
   SRCT                 NUMERIC(3),
   RNAME                VARCHAR(9),
   PSNAME               VARCHAR(15),
   RNO                  NUMERIC(2),
   SNO                  NUMERIC(3),
   MET                  VARCHAR(1),
   FMET                 VARCHAR(1),
   SEQOUT               VARCHAR(1),
   REQCT                NUMERIC(2),
   GOTCT                NUMERIC(3),
   REQHRS               NUMERIC(5,2),
   GOTHRS               NUMERIC(5,2),
   REQGPA               NUMERIC(4,3),
   GOTGPA               NUMERIC(4,3),
   GOTGPAHRS            NUMERIC(5,2),
   GOTGPAPTS            NUMERIC(9,5)
);

insert into "tmp_ANALYSIS_REQ" (INT_SEQ_NO, JOBQ_SEQ_NO, RCT, SRCT, RNAME, PSNAME, RNO, SNO, MET, FMET, SEQOUT, REQCT, GOTCT, REQHRS, GOTHRS, REQGPA, GOTGPA, GOTGPAHRS, GOTGPAPTS)
select INT_SEQ_NO, JOBQ_SEQ_NO, RCT, SRCT, RNAME, PSNAME, RNO, SNO, MET, FMET, SEQOUT, REQCT, GOTCT, REQHRS, GOTHRS, REQGPA, GOTGPA, GOTGPAHRS, GOTGPAPTS
from ANALYSIS_REQ;

drop table ANALYSIS_REQ;

drop table "tmp_COM";

create table "tmp_COM"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   COMKEY               CHAR(5)                not null,
   COMFIELD             CHAR(10)               not null,
   COMVALUE             VARCHAR(255),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_COM" (INSTIDQ, INSTID, INSTCD, COMKEY, COMFIELD, COMVALUE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, COMKEY, COMFIELD, COMVALUE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from COM;

drop table COM;

drop table "tmp_COND_CODES";

create table "tmp_COND_CODES"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   COMKEY               CHAR(5)                not null,
   SEQ_NO               INTEGER                not null,
   COND_CODE            CHAR(1),
   COURSE_CC_DESC       CHAR(80),
   SYSTEM_CC_DESC       CHAR(80),
   LAST_MOD_DATE        TIMESTAMP,
   LAST_MOD_USER        VARCHAR(30)
);

insert into "tmp_COND_CODES" (INSTIDQ, INSTID, INSTCD, COMKEY, SEQ_NO, COND_CODE, COURSE_CC_DESC, SYSTEM_CC_DESC, LAST_MOD_DATE, LAST_MOD_USER)
select INSTIDQ, INSTID, INSTCD, COMKEY, SEQ_NO, COND_CODE, COURSE_CC_DESC, SYSTEM_CC_DESC, LAST_MOD_DATE, LAST_MOD_USER
from COND_CODES;

drop table COND_CODES;

drop table "tmp_COURSE_BANK";

create table "tmp_COURSE_BANK"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   COURSE               CHAR(15)               not null,
   PFLG                 CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_COURSE_BANK" (INSTIDQ, INSTID, INSTCD, COURSE, PFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, COURSE, PFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from COURSE_BANK;

drop table COURSE_BANK;

drop table "tmp_CRS_CONVERT";

create table "tmp_CRS_CONVERT"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2),
   INSTID               CHAR(8),
   INSTCD               CHAR(3),
   USER_SEQ_NO          INTEGER,
   OLDCRSE              CHAR(15),
   NEWCRSE              CHAR(15),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_CRS_CONVERT" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, OLDCRSE, NEWCRSE, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, OLDCRSE, NEWCRSE, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from CRS_CONVERT;

drop table CRS_CONVERT;

drop table "tmp_DPROG";

create table "tmp_DPROG"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   DPROG                CHAR(15)               not null,
   DPFYT                CHAR(6)                not null,
   LYT                  CHAR(6),
   DPTITLE1             VARCHAR(65),
   DPTITLE2             VARCHAR(65),
   WEBTITLE             VARCHAR(50),
   COLLEGE              VARCHAR(10),
   MAJOR                VARCHAR(10),
   DEGREE               VARCHAR(10),
   LOCATION             VARCHAR(10),
   DPCIPS               CHAR(6),
   DPMASK               CHAR(15),
   DPSTATUS             CHAR(1),
   EFILTER              CHAR(15),
   INSTPAD              VARCHAR(44),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   DPTYPE               CHAR(1)
);

insert into "tmp_DPROG" (INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, LYT, DPTITLE1, DPTITLE2, WEBTITLE, COLLEGE, MAJOR, DEGREE, LOCATION, DPCIPS, DPMASK, DPSTATUS, EFILTER, INSTPAD, MEMO, LAST_MOD_USER, LAST_MOD_DATE, DPTYPE)
select INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, LYT, DPTITLE1, DPTITLE2, WEBTITLE, COLLEGE, MAJOR, DEGREE, LOCATION, DPCIPS, DPMASK, DPSTATUS, EFILTER, INSTPAD, MEMO, LAST_MOD_USER, LAST_MOD_DATE, DPTYPE
from DPROG;

drop table DPROG;

drop table "tmp_DPROG_REQ";

create table "tmp_DPROG_REQ"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   DPROG                CHAR(15)               not null,
   DPFYT                CHAR(6)                not null,
   USER_SEQ_NO          INTEGER,
   DPRNAME              CHAR(9)                not null,
   GRP1                 CHAR(1),
   GRP2                 CHAR(1),
   ORFLG                CHAR(1),
   OPTFLG               CHAR(1),
   SUMGRP               CHAR(1),
   CRLINK               CHAR(1),
   ALTCFLG              CHAR(1),
   SORTFLG              CHAR(1),
   EXTEND               CHAR(1),
   CALCGRP              CHAR(1),
   CALCFLG              CHAR(1),
   RUNSTATUS            CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_DPROG_REQ" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, USER_SEQ_NO, DPRNAME, GRP1, GRP2, ORFLG, OPTFLG, SUMGRP, CRLINK, ALTCFLG, SORTFLG, EXTEND, CALCGRP, CALCFLG, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, USER_SEQ_NO, DPRNAME, GRP1, GRP2, ORFLG, OPTFLG, SUMGRP, CRLINK, ALTCFLG, SORTFLG, EXTEND, CALCGRP, CALCFLG, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from DPROG_REQ;

drop table DPROG_REQ;

drop table "tmp_GMASTER";

create table "tmp_GMASTER"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2),
   INSTID               CHAR(8),
   INSTCD               CHAR(3),
   LINE_TYPE            CHAR(1),
   USER_SEQ_NO          INTEGER,
   GRADE                CHAR(4),
   RGRADE               CHAR(4),
   GPAPT                NUMERIC(4,3),
   GPACAL               CHAR(1),
   ADDCR                CHAR(1),
   ADDCT                CHAR(1),
   PSEUDO               CHAR(1),
   FORCE                CHAR(1),
   IP                   CHAR(1),
   CTLCD                CHAR(2),
   ACTION               CHAR(1),
   RUFLG                CHAR(1),
   CONDG                CHAR(6),
   DELIG                CHAR(1),
   REPLAC               CHAR(1),
   CREDITCK             CHAR(1),
   LCREDIT              NUMERIC(4,2),
   HCREDIT              NUMERIC(4,2),
   AC                   CHAR(1),
   RC                   CHAR(1),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_GMASTER" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, LINE_TYPE, USER_SEQ_NO, GRADE, RGRADE, GPAPT, GPACAL, ADDCR, ADDCT, PSEUDO, FORCE, IP, CTLCD, ACTION, RUFLG, CONDG, DELIG, REPLAC, CREDITCK, LCREDIT, HCREDIT, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, LINE_TYPE, USER_SEQ_NO, GRADE, RGRADE, GPAPT, GPACAL, ADDCR, ADDCT, PSEUDO, FORCE, IP, CTLCD, ACTION, RUFLG, CONDG, DELIG, REPLAC, CREDITCK, LCREDIT, HCREDIT, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from GMASTER;

drop table GMASTER;

drop table "tmp_JOB_QUEUE_COURSE";

create table "tmp_JOB_QUEUE_COURSE"
(
   DETAIL_SEQ_NO        NUMERIC(9)             not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   CRS_YT               CHAR(6)                not null,
   CRS_NUM              CHAR(15)               not null,
   RCREDIT              NUMERIC(7,5),
   GRADE                CHAR(4),
   CTITLE               VARCHAR(29),
   PFLG                 CHAR(1),
   IFLG1                CHAR(3),
   IFLG2                CHAR(3)
);

insert into "tmp_JOB_QUEUE_COURSE" (DETAIL_SEQ_NO, INSTID, INSTCD, CRS_YT, CRS_NUM, RCREDIT, GRADE, CTITLE, PFLG, IFLG1, IFLG2)
select DETAIL_SEQ_NO, INSTID, INSTCD, CRS_YT, CRS_NUM, RCREDIT, GRADE, CTITLE, PFLG, IFLG1, IFLG2
from JOB_QUEUE_COURSE;

drop table JOB_QUEUE_COURSE;

drop table "tmp_JOB_QUEUE_DETAIL";

create table "tmp_JOB_QUEUE_DETAIL"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   JOBID                CHAR(16)               not null,
   USERID               CHAR(30)               not null,
   USER_SEQ_NO          INTEGER                not null,
   STUNO                CHAR(13),
   COMKEY               CHAR(5),
   EVALSW               CHAR(1),
   F1OR2                CHAR(1),
   REPORT               CHAR(1),
   PNTREQ               CHAR(1),
   LISTALL              CHAR(1),
   TEST                 CHAR(1),
   FDPROG               CHAR(15),
   FCATLYT              CHAR(6),
   SINSTID              CHAR(8),
   SINSTCD              CHAR(3),
   FDPMASK              CHAR(15),
   TIME_TOKEN           CHAR(6),
   LASERTEXT            CHAR(1),
   FORMAT               CHAR(1),
   PARSEFLG             CHAR(8),
   REVART               CHAR(1),
   BINSTID              CHAR(8),
   BINSTCD              CHAR(3),
   BYTAKEN              CHAR(6),
   SOPRID               CHAR(8)
);

insert into "tmp_JOB_QUEUE_DETAIL" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, STUNO, COMKEY, EVALSW, F1OR2, REPORT, PNTREQ, LISTALL, TEST, FDPROG, FCATLYT, SINSTID, SINSTCD, FDPMASK, TIME_TOKEN, LASERTEXT, FORMAT, PARSEFLG, REVART, BINSTID, BINSTCD, BYTAKEN, SOPRID)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, STUNO, COMKEY, EVALSW, F1OR2, REPORT, PNTREQ, LISTALL, TEST, FDPROG, FCATLYT, SINSTID, SINSTCD, FDPMASK, TIME_TOKEN, LASERTEXT, FORMAT, PARSEFLG, REVART, BINSTID, BINSTCD, BYTAKEN, SOPRID
from JOB_QUEUE_DETAIL;

drop table JOB_QUEUE_DETAIL;

drop table "tmp_JOB_QUEUE_LIST";

create table "tmp_JOB_QUEUE_LIST"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   JOBID                CHAR(16)               not null,
   USERID               CHAR(30)               not null,
   STATUS               CHAR(1),
   PRIORITY             INTEGER,
   STARTDATE            CHAR(10),
   STARTTIME            CHAR(5),
   EXTERNAL_EVAL        CHAR(1),
   READ_SYSIN           CHAR(1),
   SERVERNAME           CHAR(10),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_JOB_QUEUE_LIST" (INSTIDQ, INSTID, INSTCD, JOBID, USERID, STATUS, PRIORITY, STARTDATE, STARTTIME, EXTERNAL_EVAL, READ_SYSIN, SERVERNAME, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, JOBID, USERID, STATUS, PRIORITY, STARTDATE, STARTTIME, EXTERNAL_EVAL, READ_SYSIN, SERVERNAME, LAST_MOD_USER, LAST_MOD_DATE
from JOB_QUEUE_LIST;

drop table JOB_QUEUE_LIST;

drop table "tmp_JOB_QUEUE_OUT";

create table "tmp_JOB_QUEUE_OUT"
(
   INT_SEQ_NO           NUMERIC(9)             not null default -1,
   JOBQ_SEQ_NO          NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   RTABX                CHAR(2),
   REQSTATUS            CHAR(1),
   STABX                CHAR(3),
   SRNO                 CHAR(2),
   SRSTATUS             CHAR(1),
   OPTLINE              CHAR(1),
   LASERA               CHAR(1),
   LASERB               CHAR(1),
   DAROUT               VARCHAR(255)
);

insert into "tmp_JOB_QUEUE_OUT" (INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, RTABX, REQSTATUS, STABX, SRNO, SRSTATUS, OPTLINE, LASERA, LASERB, DAROUT)
select INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, RTABX, REQSTATUS, STABX, SRNO, SRSTATUS, OPTLINE, LASERA, LASERB, DAROUT
from JOB_QUEUE_OUT;

drop table JOB_QUEUE_OUT;

drop table "tmp_JOB_QUEUE_RUN";

create table "tmp_JOB_QUEUE_RUN"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2),
   INSTID               CHAR(8),
   INSTCD               CHAR(3),
   JOBID                CHAR(16),
   USERID               CHAR(30),
   SOPRID               CHAR(8),
   STUNO                CHAR(13),
   DPROG                CHAR(15),
   DPMASK               CHAR(15),
   CATLYT               CHAR(6),
   BINSTID              CHAR(8),
   BINSTCD              CHAR(3),
   RUNDATE              CHAR(10),
   JOBQ_SYSOUT_USED     CHAR(1),
   RUNTIME              CHAR(8),
   NCOL                 CHAR(1),
   COMPLETE             CHAR(1),
   IP                   CHAR(1)
);

insert into "tmp_JOB_QUEUE_RUN" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, SOPRID, STUNO, DPROG, DPMASK, CATLYT, BINSTID, BINSTCD, RUNDATE, JOBQ_SYSOUT_USED, RUNTIME, NCOL, COMPLETE, IP)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, SOPRID, STUNO, DPROG, DPMASK, CATLYT, BINSTID, BINSTCD, RUNDATE, JOBQ_SYSOUT_USED, RUNTIME, NCOL, COMPLETE, IP
from JOB_QUEUE_RUN;

drop table JOB_QUEUE_RUN;

drop table "tmp_JOB_QUEUE_SYSIN";

create table "tmp_JOB_QUEUE_SYSIN"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2),
   INSTID               CHAR(8),
   INSTCD               CHAR(3),
   JOBID                CHAR(16),
   USERID               CHAR(30),
   USER_SEQ_NO          INTEGER,
   SYSIN                CHAR(80)
);

insert into "tmp_JOB_QUEUE_SYSIN" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, SYSIN)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, SYSIN
from JOB_QUEUE_SYSIN;

drop table JOB_QUEUE_SYSIN;

drop table "tmp_MASTREF";

create table "tmp_MASTREF"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   MRFYT                CHAR(6)                not null,
   LYT                  CHAR(6),
   INAME                VARCHAR(60),
   ITYPE                CHAR(2),
   STATUS               CHAR(1),
   CRSCASE              CHAR(1),
   GRDCASE              CHAR(1),
   SOURCEIDQ            CHAR(2),
   BACC                 CHAR(1),
   ACTC                 CHAR(1),
   AGCLC                CHAR(2),
   HONORS               CHAR(1),
   REPEATF              CHAR(1),
   CSCALE               CHAR(1),
   CASSIGN              CHAR(1),
   CEXCESS              CHAR(1),
   CFINAL               CHAR(1),
   DCOURSE              CHAR(15),
   DPFLG                CHAR(1),
   GRULE                CHAR(1),
   GPARULE              CHAR(1),
   DGRADE               CHAR(4),
   D0GRADE              CHAR(4),
   CRSMASK              CHAR(15),
   REFUCOND1            CHAR(3),
   REFUCOND2            CHAR(3),
   REFUCOND3            CHAR(3),
   GRDREQ               CHAR(1),
   GPASCALE             CHAR(1),
   UNITSCALE            NUMERIC(6,4),
   DINSTID              CHAR(8),
   DINSTCD              CHAR(3),
   DEPTBGN              NUMERIC(2),
   DEPTEND              NUMERIC(2),
   CRSBGN               NUMERIC(2),
   CRSEND               NUMERIC(2),
   RPTINSTID            CHAR(8),
   TAINSTID             CHAR(8),
   TAINSTCD             CHAR(3),
   REFONLY              CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_MASTREF" (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, LYT, INAME, ITYPE, STATUS, CRSCASE, GRDCASE, SOURCEIDQ, BACC, ACTC, AGCLC, HONORS, REPEATF, CSCALE, CASSIGN, CEXCESS, CFINAL, DCOURSE, DPFLG, GRULE, GPARULE, DGRADE, D0GRADE, CRSMASK, REFUCOND1, REFUCOND2, REFUCOND3, GRDREQ, GPASCALE, UNITSCALE, DINSTID, DINSTCD, DEPTBGN, DEPTEND, CRSBGN, CRSEND, RPTINSTID, TAINSTID, TAINSTCD, REFONLY, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, LYT, INAME, ITYPE, STATUS, CRSCASE, GRDCASE, SOURCEIDQ, BACC, ACTC, AGCLC, HONORS, REPEATF, CSCALE, CASSIGN, CEXCESS, CFINAL, DCOURSE, DPFLG, GRULE, GPARULE, DGRADE, D0GRADE, CRSMASK, REFUCOND1, REFUCOND2, REFUCOND3, GRDREQ, GPASCALE, UNITSCALE, DINSTID, DINSTCD, DEPTBGN, DEPTEND, CRSBGN, CRSEND, RPTINSTID, TAINSTID, TAINSTCD, REFONLY, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from MASTREF;

drop table MASTREF;

drop table "tmp_MASTREF_ADDRESS";

create table "tmp_MASTREF_ADDRESS"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   MRFYT                CHAR(6)                not null,
   USER_SEQ_NO          INTEGER,
   ADDRESS1             VARCHAR(35),
   ADDRESS2             VARCHAR(35),
   CITY                 VARCHAR(30),
   STATE                VARCHAR(2),
   ZIP                  VARCHAR(10),
   COUNTRY              VARCHAR(3),
   LOCATIONQ            VARCHAR(2),
   LOCATIONID           VARCHAR(25),
   CONTACTCD            VARCHAR(2),
   CONTACTNAME          VARCHAR(35),
   COMMNOQ              VARCHAR(2),
   FAX                  VARCHAR(25),
   PHONE                VARCHAR(25),
   E_MAIL               VARCHAR(80),
   FROM_DATE            CHAR(8),
   TO_DATE              CHAR(8),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_MASTREF_ADDRESS" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, CONTACTCD, CONTACTNAME, COMMNOQ, FAX, PHONE, E_MAIL, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, CONTACTCD, CONTACTNAME, COMMNOQ, FAX, PHONE, E_MAIL, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from MASTREF_ADDRESS;

drop table MASTREF_ADDRESS;

drop table "tmp_MASTREF_SEG";

create table "tmp_MASTREF_SEG"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   MRFYT                CHAR(6)                not null,
   USER_SEQ_NO          INTEGER,
   LTYPE                CHAR(1),
   I2UFLG               CHAR(1),
   GRADE                CHAR(4),
   AC                   CHAR(1),
   RC                   CHAR(1),
   U2IFLG               CHAR(1),
   UGRADE               CHAR(4),
   ACU                  CHAR(3),
   RCU                  CHAR(3),
   GPAPT                NUMERIC(4,3),
   GPACAL               CHAR(1),
   ADDCR                CHAR(1),
   ADDCT                CHAR(1),
   COND1                CHAR(1),
   COND2                CHAR(1),
   UCOND1               CHAR(3),
   UCOND2               CHAR(3),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_MASTREF_SEG" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, LTYPE, I2UFLG, GRADE, AC, RC, U2IFLG, UGRADE, ACU, RCU, GPAPT, GPACAL, ADDCR, ADDCT, COND1, COND2, UCOND1, UCOND2, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, LTYPE, I2UFLG, GRADE, AC, RC, U2IFLG, UGRADE, ACU, RCU, GPAPT, GPACAL, ADDCR, ADDCT, COND1, COND2, UCOND1, UCOND2, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from MASTREF_SEG;

drop table MASTREF_SEG;

drop table "tmp_REPEAT";

create table "tmp_REPEAT"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2),
   INSTID               CHAR(8),
   INSTCD               CHAR(3),
   USER_SEQ_NO          INTEGER,
   COURSE               CHAR(15),
   CTITLE               VARCHAR(29),
   HMAX                 NUMERIC(4,1),
   CHFLAG               CHAR(1),
   AC                   CHAR(1),
   RC                   CHAR(1),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_REPEAT" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, COURSE, CTITLE, HMAX, CHFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, COURSE, CTITLE, HMAX, CHFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "REPEAT";

drop table "REPEAT";

drop table "tmp_REQ_MAIN";

create table "tmp_REQ_MAIN"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null,
   LYT                  CHAR(6),
   REQSRQ               NUMERIC(2),
   REQHRS               NUMERIC(4,1),
   REQGPA               NUMERIC(4,3),
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
   USECT                NUMERIC(2),
   IPLIST               CHAR(1),
   NOCOMPL              CHAR(1),
   REQCT                NUMERIC(2),
   REQCTF               CHAR(1),
   MAXHRS               NUMERIC(4,1),
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
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_REQ_MAIN" (INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, LYT, REQSRQ, REQHRS, REQGPA, AC1, AC2, RC1, RC2, ASSIGNC, REUSE, NOLIST, PSNAME, REFCYCLE, RQTYPE, REQSRQF, REQHRSF, REQGPAF, USECT, IPLIST, NOCOMPL, REQCT, REQCTF, MAXHRS, RCONDA, RCONDR, VARR, LOKOVR1, LNOOVR1, LOKOVR2, LNOOVR2, RACTL, ASSIGNC2, REFDIR, REFFLD, REFSUB, REFVAL, RTITLE1, RTITLE2, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, LYT, REQSRQ, REQHRS, REQGPA, AC1, AC2, RC1, RC2, ASSIGNC, REUSE, NOLIST, PSNAME, REFCYCLE, RQTYPE, REQSRQF, REQHRSF, REQGPAF, USECT, IPLIST, NOCOMPL, REQCT, REQCTF, MAXHRS, RCONDA, RCONDR, VARR, LOKOVR1, LNOOVR1, LOKOVR2, LNOOVR2, RACTL, ASSIGNC2, REFDIR, REFFLD, REFSUB, REFVAL, RTITLE1, RTITLE2, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from REQ_MAIN;

drop table REQ_MAIN;

drop table "tmp_REQ_TEXT";

create table "tmp_REQ_TEXT"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null,
   USER_SEQ_NO          INTEGER,
   RTEXT_TYPE           CHAR(1),
   TEXT                 VARCHAR(65),
   LOKOVR1              CHAR(1),
   LNOOVR1              CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_REQ_TEXT" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, RTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, RTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from REQ_TEXT;

drop table REQ_TEXT;

drop table "tmp_REQ_XY";

create table "tmp_REQ_XY"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null,
   USER_SEQ_NO          INTEGER,
   XY_TYPE              CHAR(1),
   MAXGRPC              NUMERIC(2),
   MAXHRC               NUMERIC(4,1),
   SKIPDUP              CHAR(1),
   CTCOND               CHAR(1),
   ASSIGNM              CHAR(1),
   MAXCTC               NUMERIC(2),
   MAXSRC               NUMERIC(2),
   CTPSNAME             CHAR(15),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_REQ_XY" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, XY_TYPE, MAXGRPC, MAXHRC, SKIPDUP, CTCOND, ASSIGNM, MAXCTC, MAXSRC, CTPSNAME, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, XY_TYPE, MAXGRPC, MAXHRC, SKIPDUP, CTCOND, ASSIGNM, MAXCTC, MAXSRC, CTPSNAME, LAST_MOD_USER, LAST_MOD_DATE
from REQ_XY;

drop table REQ_XY;

drop table "tmp_SECURE_IMPORT";

create table "tmp_SECURE_IMPORT"
(
   USERID               CHAR(30)               not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null
);

insert into "tmp_SECURE_IMPORT" (USERID, INSTIDQ, INSTID, INSTCD)
select USERID, INSTIDQ, INSTID, INSTCD
from SECURE_IMPORT;

drop table SECURE_IMPORT;

drop table "tmp_SECURE_INST";

create table "tmp_SECURE_INST"
(
   USERID               CHAR(30)               not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   SOPRID               CHAR(8),
   SMASK                CHAR(8),
   UPDATE_PIN           CHAR(1)
);

insert into "tmp_SECURE_INST" (USERID, INSTIDQ, INSTID, INSTCD, SOPRID, SMASK, UPDATE_PIN)
select USERID, INSTIDQ, INSTID, INSTCD, SOPRID, SMASK, UPDATE_PIN
from SECURE_INST;

drop table SECURE_INST;

drop table "tmp_SECURE_MASTER";

create table "tmp_SECURE_MASTER"
(
   USERID               CHAR(30)               not null,
   REFUSERID            CHAR(30),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_SECURE_MASTER" (USERID, REFUSERID, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select USERID, REFUSERID, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from SECURE_MASTER;

drop table SECURE_MASTER;

drop table "tmp_STRING";

create table "tmp_STRING"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2),
   INSTID               CHAR(8),
   INSTCD               CHAR(3),
   USER_SEQ_NO          INTEGER,
   STYPE                CHAR(1),
   STYPEQ               CHAR(1),
   COND                 CHAR(1),
   LIMCT                NUMERIC(2),
   LIMHRS               NUMERIC(4,2),
   CTLCD                CHAR(2),
   AC                   CHAR(1),
   RC                   CHAR(1),
   AEFLG                CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STRING" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, STYPE, STYPEQ, COND, LIMCT, LIMHRS, CTLCD, AC, RC, AEFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, STYPE, STYPEQ, COND, LIMCT, LIMHRS, CTLCD, AC, RC, AEFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from STRING;

drop table STRING;

drop table "tmp_STRING_CRSE";

create table "tmp_STRING_CRSE"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   STR_INT_SEQ_NO       NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   COURSE               CHAR(15),
   CTITLE               VARCHAR(29),
   AC                   CHAR(1),
   RC                   CHAR(1),
   AEFLG                CHAR(1),
   PFLG                 CHAR(1),
   EFFDTE               CHAR(12),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STRING_CRSE" (INT_SEQ_NO, STR_INT_SEQ_NO, USER_SEQ_NO, COURSE, CTITLE, AC, RC, AEFLG, PFLG, EFFDTE, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STR_INT_SEQ_NO, USER_SEQ_NO, COURSE, CTITLE, AC, RC, AEFLG, PFLG, EFFDTE, LAST_MOD_USER, LAST_MOD_DATE
from STRING_CRSE;

drop table STRING_CRSE;

drop table "tmp_STU_ACADREC";

create table "tmp_STU_ACADREC"
(
   STU_MAST_NO          NUMERIC(9)             not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   CDPMASK              CHAR(15)               not null,
   CRS_YT               CHAR(6)                not null,
   CRS_NUM              CHAR(15)               not null,
   CRS_SEQ              CHAR(3)                not null,
   SECTION              CHAR(3),
   PFLG                 CHAR(1),
   RCREDIT              NUMERIC(7,5),
   GRADE                CHAR(4),
   CTITLE               VARCHAR(29),
   RTEXT                CHAR(2),
   CONDC                CHAR(12),
   CLINE                CHAR(27),
   XCOURSE              CHAR(15),
   ECREDIT              NUMERIC(7,5),
   GPAHRS               NUMERIC(7,5),
   GPAPTS               NUMERIC(9,5),
   LINKNO               CHAR(2),
   XPFLG                CHAR(1),
   RTITLE               CHAR(29),
   EVALFLG              CHAR(1)                not null,
   BACC                 CHAR(1),
   ACTC                 CHAR(1),
   AGCLC                CHAR(2),
   HONORS               CHAR(1),
   REPEATF              CHAR(1),
   IFLG1                CHAR(3),
   IFLG2                CHAR(3),
   IFLG3                CHAR(3),
   IFLG4                CHAR(3),
   IFLG5                CHAR(3),
   ACOURSE1             CHAR(15),
   APFLG1               CHAR(1),
   ACOURSE2             CHAR(15),
   APFLG2               CHAR(1),
   ACOURSE3             CHAR(15),
   APFLG3               CHAR(1),
   GRADEQ               CHAR(3),
   RGRADE               CHAR(4),
   CERTIFY              CHAR(1)                not null,
   SUBJ_AREA            CHAR(17),
   GRADELEV             CHAR(2),
   DRPDATE              CHAR(6),
   OVACADSRC            CHAR(2),
   SECURITY_FLAG        CHAR(1),
   DATA_SOURCE          CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_ACADREC" (STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ, SECTION, PFLG, RCREDIT, GRADE, CTITLE, RTEXT, CONDC, CLINE, XCOURSE, ECREDIT, GPAHRS, GPAPTS, LINKNO, XPFLG, RTITLE, EVALFLG, BACC, ACTC, AGCLC, HONORS, REPEATF, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, GRADEQ, RGRADE, CERTIFY, SUBJ_AREA, GRADELEV, DRPDATE, OVACADSRC, SECURITY_FLAG, DATA_SOURCE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ, SECTION, PFLG, RCREDIT, GRADE, CTITLE, RTEXT, CONDC, CLINE, XCOURSE, ECREDIT, GPAHRS, GPAPTS, LINKNO, XPFLG, RTITLE, EVALFLG, BACC, ACTC, AGCLC, HONORS, REPEATF, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, GRADEQ, RGRADE, CERTIFY, SUBJ_AREA, GRADELEV, DRPDATE, OVACADSRC, SECURITY_FLAG, DATA_SOURCE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from STU_ACADREC;

drop table STU_ACADREC;

drop table "tmp_STU_ADDRESS";

create table "tmp_STU_ADDRESS"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   STU_MAST_NO          NUMERIC(9)             not null,
   SOURCE_ID            CHAR(8)                not null,
   ADDRESS_TYPE         VARCHAR(2),
   ADDRNAME             VARCHAR(35),
   NAMETYPECD           VARCHAR(2),
   ADDRESS1             VARCHAR(35),
   ADDRESS2             VARCHAR(35),
   CITY                 VARCHAR(30),
   STATE                VARCHAR(2),
   ZIP                  VARCHAR(10),
   COUNTRY              VARCHAR(3),
   LOCATIONQ            VARCHAR(2),
   LOCATIONID           VARCHAR(25),
   ENTITYIDCD           VARCHAR(2),
   REFNOQ               VARCHAR(2),
   REFNO                VARCHAR(30),
   INDRELCD             VARCHAR(2),
   FROM_DATE            CHAR(8),
   TO_DATE              CHAR(8),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_ADDRESS" (INT_SEQ_NO, STU_MAST_NO, SOURCE_ID, ADDRESS_TYPE, ADDRNAME, NAMETYPECD, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, ENTITYIDCD, REFNOQ, REFNO, INDRELCD, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_MAST_NO, SOURCE_ID, ADDRESS_TYPE, ADDRNAME, NAMETYPECD, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, ENTITYIDCD, REFNOQ, REFNO, INDRELCD, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from STU_ADDRESS;

drop table STU_ADDRESS;

drop table "tmp_STU_DEMO";

create table "tmp_STU_DEMO"
(
   STU_MAST_NO          NUMERIC(9)             not null,
   SOURCE_ID            CHAR(8)                not null,
   STUNAME              VARCHAR(35),
   STUIDQ               CHAR(2),
   STUIDDESC            VARCHAR(80),
   DOB                  CHAR(6),
   BIRTHCOUNTRY         CHAR(3),
   BIRTHSTATE           CHAR(2),
   BIRTHCOUNTY          CHAR(5),
   BIRTHCITY            VARCHAR(30),
   CITIZENSTATUS        CHAR(2),
   CITIZENCOUNTRY       CHAR(3),
   NATIVELANG           CHAR(3),
   ENGLPROF             CHAR(3),
   MARITAL              CHAR(1),
   GENDER               CHAR(1),
   RACE                 CHAR(1),
   HSGRADTYPE           CHAR(3),
   HSGRADDATE           CHAR(8),
   HS                   VARCHAR(30),
   TCTLAST              CHAR(6),
   NODFLT               CHAR(1),
   BDVERIF              CHAR(2),
   SPOKENINHOME         CHAR(3),
   CORRESLANG           CHAR(3),
   SUBNATQ              CHAR(2),
   SUBNATIONAL          VARCHAR(20),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_DEMO" (STU_MAST_NO, SOURCE_ID, STUNAME, STUIDQ, STUIDDESC, DOB, BIRTHCOUNTRY, BIRTHSTATE, BIRTHCOUNTY, BIRTHCITY, CITIZENSTATUS, CITIZENCOUNTRY, NATIVELANG, ENGLPROF, MARITAL, GENDER, RACE, HSGRADTYPE, HSGRADDATE, HS, TCTLAST, NODFLT, BDVERIF, SPOKENINHOME, CORRESLANG, SUBNATQ, SUBNATIONAL, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, SOURCE_ID, STUNAME, STUIDQ, STUIDDESC, DOB, BIRTHCOUNTRY, BIRTHSTATE, BIRTHCOUNTY, BIRTHCITY, CITIZENSTATUS, CITIZENCOUNTRY, NATIVELANG, ENGLPROF, MARITAL, GENDER, RACE, HSGRADTYPE, HSGRADDATE, HS, TCTLAST, NODFLT, BDVERIF, SPOKENINHOME, CORRESLANG, SUBNATQ, SUBNATIONAL, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from STU_DEMO;

drop table STU_DEMO;

drop table "tmp_STU_DPROG";

create table "tmp_STU_DPROG"
(
   STU_MAST_NO          NUMERIC(9)             not null,
   INSTCD               CHAR(3)                not null,
   DPROG                CHAR(15)               not null,
   DRCATLYT             CHAR(6),
   DPMASK               CHAR(15),
   ACATLYT1             CHAR(6),
   ACATLYT2             CHAR(6),
   ACATLYT3             CHAR(6),
   ACATLYT4             CHAR(6),
   ACATLYT5             CHAR(6),
   ACATLYT6             CHAR(6),
   ACATLYT7             CHAR(6),
   ACATLYT8             CHAR(6),
   ACATLYT9             CHAR(6),
   WHATIF               CHAR(1),
   DEGREECD             CHAR(3),
   ENTRYYR              CHAR(4),
   EXITYR               CHAR(4),
   TRMODMET             CHAR(1),
   DEGREESTATUS         CHAR(1),
   HONORSLEVEL          CHAR(3),
   MEMO                 VARCHAR(255),
   DEGREE_DATE          CHAR(10),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_DPROG" (STU_MAST_NO, INSTCD, DPROG, DRCATLYT, DPMASK, ACATLYT1, ACATLYT2, ACATLYT3, ACATLYT4, ACATLYT5, ACATLYT6, ACATLYT7, ACATLYT8, ACATLYT9, WHATIF, DEGREECD, ENTRYYR, EXITYR, TRMODMET, DEGREESTATUS, HONORSLEVEL, MEMO, DEGREE_DATE, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, INSTCD, DPROG, DRCATLYT, DPMASK, ACATLYT1, ACATLYT2, ACATLYT3, ACATLYT4, ACATLYT5, ACATLYT6, ACATLYT7, ACATLYT8, ACATLYT9, WHATIF, DEGREECD, ENTRYYR, EXITYR, TRMODMET, DEGREESTATUS, HONORSLEVEL, MEMO, DEGREE_DATE, LAST_MOD_USER, LAST_MOD_DATE
from STU_DPROG;

drop table STU_DPROG;

drop table "tmp_STU_EGRP_COURSES";

create table "tmp_STU_EGRP_COURSES"
(
   STU_MAST_NO          NUMERIC(9)             not null,
   EVALGRP              CHAR(3)                not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   CDPMASK              CHAR(15)               not null,
   CRS_YT               CHAR(6)                not null,
   CRS_NUM              CHAR(15)               not null,
   CRS_SEQ              CHAR(3)                not null
);

insert into "tmp_STU_EGRP_COURSES" (STU_MAST_NO, EVALGRP, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ)
select STU_MAST_NO, EVALGRP, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ
from STU_EGRP_COURSES;

drop table STU_EGRP_COURSES;

drop table "tmp_STU_EVALGRP";

create table "tmp_STU_EVALGRP"
(
   STU_MAST_NO          NUMERIC(9)             not null,
   EVALGRP              CHAR(3)                not null,
   INSTCD               CHAR(3),
   DPMASK               CHAR(15),
   SOURCE_ID            CHAR(8),
   SOURCE_CD            CHAR(3),
   EVALLOCK             CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   CERTIFY              CHAR(1)
);

insert into "tmp_STU_EVALGRP" (STU_MAST_NO, EVALGRP, INSTCD, DPMASK, SOURCE_ID, SOURCE_CD, EVALLOCK, MEMO, LAST_MOD_USER, LAST_MOD_DATE, CERTIFY)
select STU_MAST_NO, EVALGRP, INSTCD, DPMASK, SOURCE_ID, SOURCE_CD, EVALLOCK, MEMO, LAST_MOD_USER, LAST_MOD_DATE, CERTIFY
from STU_EVALGRP;

drop table STU_EVALGRP;

drop table "tmp_STU_EXCEPTIONS";

create table "tmp_STU_EXCEPTIONS"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   STU_MAST_NO          NUMERIC(9),
   INSTCD               CHAR(3)                not null,
   DPMASK               CHAR(15)               not null,
   DPROG                CHAR(15)               not null,
   USER_SEQ_NO          INTEGER,
   CTLCD                CHAR(2),
   ACTION               CHAR(1),
   RUFLG                CHAR(1),
   YEARTM               CHAR(6),
   AC1                  CHAR(1),
   AC2                  CHAR(1),
   RC1                  CHAR(1),
   RC2                  CHAR(1),
   COURSE               CHAR(15),
   RCOURSE              CHAR(15),
   CLINE                CHAR(27),
   REQHRS               NUMERIC(5,2),
   MAXHRS               NUMERIC(5,2),
   REQSRQ               NUMERIC(3),
   MAXCT                NUMERIC(3),
   VAL                  NUMERIC(3),
   MATCHCTL             CHAR(1),
   EFFDTE               CHAR(12),
   REQGPA               NUMERIC(5,3),
   ASSIGNC              CHAR(1),
   MAXHRSCK             CHAR(1),
   PSNAME               CHAR(15),
   RNAME                CHAR(9),
   MEMO                 VARCHAR(255),
   AUTH_ID              VARCHAR(30),
   AUTH_DATE            CHAR(12),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_EXCEPTIONS" (INT_SEQ_NO, STU_MAST_NO, INSTCD, DPMASK, DPROG, USER_SEQ_NO, CTLCD, ACTION, RUFLG, YEARTM, AC1, AC2, RC1, RC2, COURSE, RCOURSE, CLINE, REQHRS, MAXHRS, REQSRQ, MAXCT, VAL, MATCHCTL, EFFDTE, REQGPA, ASSIGNC, MAXHRSCK, PSNAME, RNAME, MEMO, AUTH_ID, AUTH_DATE, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_MAST_NO, INSTCD, DPMASK, DPROG, USER_SEQ_NO, CTLCD, ACTION, RUFLG, YEARTM, AC1, AC2, RC1, RC2, COURSE, RCOURSE, CLINE, REQHRS, MAXHRS, REQSRQ, MAXCT, VAL, MATCHCTL, EFFDTE, REQGPA, ASSIGNC, MAXHRSCK, PSNAME, RNAME, MEMO, AUTH_ID, AUTH_DATE, LAST_MOD_USER, LAST_MOD_DATE
from STU_EXCEPTIONS;

drop table STU_EXCEPTIONS;

drop table "tmp_STU_EXC_COURSES";

create table "tmp_STU_EXC_COURSES"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   STU_INT_SEQ_NO       NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   COURSE               CHAR(15),
   RCOURSE              CHAR(15),
   MATCHCTL             CHAR(1),
   EFFDTE               CHAR(12),
   AC                   CHAR(1),
   RC                   CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_EXC_COURSES" (INT_SEQ_NO, STU_INT_SEQ_NO, USER_SEQ_NO, COURSE, RCOURSE, MATCHCTL, EFFDTE, AC, RC, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_INT_SEQ_NO, USER_SEQ_NO, COURSE, RCOURSE, MATCHCTL, EFFDTE, AC, RC, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from STU_EXC_COURSES;

drop table STU_EXC_COURSES;

drop table "tmp_STU_MARKER_REQ";

create table "tmp_STU_MARKER_REQ"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   STU_MAST_NO          NUMERIC(9)             not null,
   INSTCD               CHAR(3)                not null,
   DPROG                CHAR(15)               not null,
   USER_SEQ_NO          INTEGER,
   MARKER               CHAR(9),
   DRVAL                CHAR(15),
   DRTYPE               CHAR(1),
   DRINSTCD             CHAR(3),
   DRCATLYT             CHAR(6),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_MARKER_REQ" (INT_SEQ_NO, STU_MAST_NO, INSTCD, DPROG, USER_SEQ_NO, MARKER, DRVAL, DRTYPE, DRINSTCD, DRCATLYT, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, STU_MAST_NO, INSTCD, DPROG, USER_SEQ_NO, MARKER, DRVAL, DRTYPE, DRINSTCD, DRCATLYT, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from STU_MARKER_REQ;

drop table STU_MARKER_REQ;

drop table "tmp_STU_MASTER";

create table "tmp_STU_MASTER"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8),
   STUNO                CHAR(13),
   TCTLAST              CHAR(6),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   NODFLT               CHAR(1),
   PIN                  VARCHAR(20)
);

insert into "tmp_STU_MASTER" (INT_SEQ_NO, INSTIDQ, INSTID, STUNO, TCTLAST, MEMO, LAST_MOD_USER, LAST_MOD_DATE, NODFLT, PIN)
select INT_SEQ_NO, INSTIDQ, INSTID, STUNO, TCTLAST, MEMO, LAST_MOD_USER, LAST_MOD_DATE, NODFLT, PIN
from STU_MASTER;

drop table STU_MASTER;

drop table "tmp_STU_TRANS_DEGREE";

create table "tmp_STU_TRANS_DEGREE"
(
   STU_MAST_NO          NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER                not null,
   SEGTITLE             CHAR(5),
   ACADFOSCODE          CHAR(1),
   SEGLITERAL           VARCHAR(75),
   FIELDOFSTUDY         VARCHAR(20),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_STU_TRANS_DEGREE" (STU_MAST_NO, USER_SEQ_NO, SEGTITLE, ACADFOSCODE, SEGLITERAL, FIELDOFSTUDY, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select STU_MAST_NO, USER_SEQ_NO, SEGTITLE, ACADFOSCODE, SEGLITERAL, FIELDOFSTUDY, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from STU_TRANS_DEGREE;

drop table STU_TRANS_DEGREE;

drop table "tmp_SUB_REQ";

create table "tmp_SUB_REQ"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   RNAME                CHAR(9)                not null,
   RQFYT                CHAR(6)                not null,
   USER_SEQ_NO          INTEGER,
   SREQNO               INTEGER,
   REQCT                NUMERIC(2),
   REQCTF               CHAR(1),
   REQHRS               NUMERIC(4,1),
   REQHRSF              CHAR(1),
   REQGPA               NUMERIC(4,3),
   REQGPAF              CHAR(1),
   MAXHRS               NUMERIC(4,1),
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
   MAXCT                NUMERIC(2),
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
   GRPMIN               NUMERIC(2),
   GRPMAX               NUMERIC(2),
   VARC                 CHAR(1),
   HCMIN                NUMERIC(2),
   HCMAX                NUMERIC(2),
   XREFSR               CHAR(1),
   REFGNO               NUMERIC(2),
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
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_SUB_REQ" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, SREQNO, REQCT, REQCTF, REQHRS, REQHRSF, REQGPA, REQGPAF, MAXHRS, MAXHRSCK, ALLRES, AC1, AC2, AC3, AC4, AC5, ACOR, RC1, RC2, RC3, RC4, RC5, RCAND, ACTL, ASSIGNC, ASSIGNC2, ASSIGNM, SREUSE, SKIPBCT, NOLIST, NOSEQNO, REQFLG, IPLIST, IGNORECL, GPAWEIGHT, SEQCHK, MAXCT, CTCOND0, CTCOND1, CTCOND2, CTCOND3, CTCOND4, CTCOND5, CTCOND6, CTCOND7, CTCOND8, CTCOND9, CTCOND10, CTCOND11, CTCOND12, CTCOND13, CTCOND14, CONDA, CONDR, LISTSR, NEGREQ, PNTDESCR, GPA, AONLY, CALPHA, GRP, GRPMIN, GRPMAX, VARC, HCMIN, HCMAX, XREFSR, REFGNO, EORDER, ETOPDOWN, ESTOP, ELIMIT, REFDIR, REFFLD, REFSUB, REFVAL, REFCYCLE, SELRA, SORTFLG, SREQOR, ACTLX, ASSIGNCX, REVARTL, MATCHONE, LTOPDOWN, SELIP, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, SREQNO, REQCT, REQCTF, REQHRS, REQHRSF, REQGPA, REQGPAF, MAXHRS, MAXHRSCK, ALLRES, AC1, AC2, AC3, AC4, AC5, ACOR, RC1, RC2, RC3, RC4, RC5, RCAND, ACTL, ASSIGNC, ASSIGNC2, ASSIGNM, SREUSE, SKIPBCT, NOLIST, NOSEQNO, REQFLG, IPLIST, IGNORECL, GPAWEIGHT, SEQCHK, MAXCT, CTCOND0, CTCOND1, CTCOND2, CTCOND3, CTCOND4, CTCOND5, CTCOND6, CTCOND7, CTCOND8, CTCOND9, CTCOND10, CTCOND11, CTCOND12, CTCOND13, CTCOND14, CONDA, CONDR, LISTSR, NEGREQ, PNTDESCR, GPA, AONLY, CALPHA, GRP, GRPMIN, GRPMAX, VARC, HCMIN, HCMAX, XREFSR, REFGNO, EORDER, ETOPDOWN, ESTOP, ELIMIT, REFDIR, REFFLD, REFSUB, REFVAL, REFCYCLE, SELRA, SORTFLG, SREQOR, ACTLX, ASSIGNCX, REVARTL, MATCHONE, LTOPDOWN, SELIP, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from SUB_REQ;

drop table SUB_REQ;

drop table "tmp_SUB_REQ_AR";

create table "tmp_SUB_REQ_AR"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   SUB_INT_SEQ_NO       NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   AR_TYPE              CHAR(1)                not null,
   COURSE               CHAR(15),
   MATCHCTL             CHAR(1),
   CTITLE               VARCHAR(29),
   TFLG                 CHAR(1),
   CREDITLIM            CHAR(1),
   CRSFLAG              CHAR(3),
   AC                   CHAR(1),
   RC                   CHAR(1),
   EFFDTE               CHAR(12),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_SUB_REQ_AR" (INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, AR_TYPE, COURSE, MATCHCTL, CTITLE, TFLG, CREDITLIM, CRSFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, AR_TYPE, COURSE, MATCHCTL, CTITLE, TFLG, CREDITLIM, CRSFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from SUB_REQ_AR;

drop table SUB_REQ_AR;

drop table "tmp_SUB_REQ_TEXT";

create table "tmp_SUB_REQ_TEXT"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   SUB_INT_SEQ_NO       NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   SRTEXT_TYPE          CHAR(1),
   TEXT                 VARCHAR(55),
   LOKOVR1              CHAR(1),
   LNOOVR1              CHAR(1),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_SUB_REQ_TEXT" (INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, SRTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, SRTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, LAST_MOD_USER, LAST_MOD_DATE
from SUB_REQ_TEXT;

drop table SUB_REQ_TEXT;

drop table "tmp_TCA_MASTER";

create table "tmp_TCA_MASTER"
(
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   DPMASK               CHAR(15)               not null,
   FYT                  CHAR(6)                not null,
   LYT                  CHAR(6),
   INAME                VARCHAR(60),
   UNIV_DPMASK          CHAR(1),
   DINSTID              CHAR(8),
   DINSTCD              CHAR(3),
   TASTATUS             CHAR(1),
   MEMO                 VARCHAR(255),
   LAST_MOD_DATE        TIMESTAMP,
   LAST_MOD_USER        VARCHAR(30)
);

insert into "tmp_TCA_MASTER" (INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, LYT, INAME, UNIV_DPMASK, DINSTID, DINSTCD, TASTATUS, MEMO, LAST_MOD_DATE, LAST_MOD_USER)
select INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, LYT, INAME, UNIV_DPMASK, DINSTID, DINSTCD, TASTATUS, MEMO, LAST_MOD_DATE, LAST_MOD_USER
from TCA_MASTER;

drop table TCA_MASTER;

drop table "tmp_TCA_RULE";

create table "tmp_TCA_RULE"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   INSTIDQ              CHAR(2)                not null,
   INSTID               CHAR(8)                not null,
   INSTCD               CHAR(3)                not null,
   SOURCE_ID            CHAR(8)                not null,
   SOURCE_CD            CHAR(3)                not null,
   DPMASK               CHAR(15)               not null,
   FYT                  CHAR(6)                not null,
   TSEG                 CHAR(7)                not null,
   USER_SEQ_NO          INTEGER,
   COND                 CHAR(1),
   LIMCT                NUMERIC(2),
   LIMHRS               NUMERIC(4,2),
   CTLCD                CHAR(2),
   AC                   CHAR(1),
   RC                   CHAR(1),
   TASTATUS             CHAR(1),
   PRIVATE_NOTE         VARCHAR(255),
   MEMO                 VARCHAR(255),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_TCA_RULE" (INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, TSEG, USER_SEQ_NO, COND, LIMCT, LIMHRS, CTLCD, AC, RC, TASTATUS, PRIVATE_NOTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, TSEG, USER_SEQ_NO, COND, LIMCT, LIMHRS, CTLCD, AC, RC, TASTATUS, PRIVATE_NOTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from TCA_RULE;

drop table TCA_RULE;

drop table "tmp_TCA_SOURCE";

create table "tmp_TCA_SOURCE"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   TCA_RULE_SEQ_NO      NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   COURSE               CHAR(15),
   PFLG                 CHAR(1),
   CTITLE               VARCHAR(29),
   TFLG                 CHAR(1),
   LIMHRS               NUMERIC(4,2),
   CTLCD                CHAR(2),
   AC                   CHAR(1),
   RC                   CHAR(1),
   COND                 CHAR(1),
   EFFDTE               CHAR(12),
   LOWEFFDTE            CHAR(6),
   HIEFFDTE             CHAR(6),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP
);

insert into "tmp_TCA_SOURCE" (INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, CTLCD, AC, RC, COND, EFFDTE, LOWEFFDTE, HIEFFDTE, LAST_MOD_USER, LAST_MOD_DATE)
select INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, CTLCD, AC, RC, COND, EFFDTE, LOWEFFDTE, HIEFFDTE, LAST_MOD_USER, LAST_MOD_DATE
from TCA_SOURCE;

drop table TCA_SOURCE;

drop table "tmp_TCA_TARGET";

create table "tmp_TCA_TARGET"
(
   INT_SEQ_NO           NUMERIC(9)             not null,
   TCA_RULE_SEQ_NO      NUMERIC(9)             not null,
   USER_SEQ_NO          INTEGER,
   COURSE               CHAR(15),
   PFLG                 CHAR(1),
   CTITLE               VARCHAR(29),
   TFLG                 CHAR(1),
   LIMHRS               NUMERIC(4,2),
   FORCEHRS             CHAR(1),
   COND                 CHAR(1),
   IFLG1                CHAR(3),
   IFLG2                CHAR(3),
   IFLG3                CHAR(3),
   IFLG4                CHAR(3),
   IFLG5                CHAR(3),
   ACOURSE1             CHAR(15),
   APFLG1               CHAR(1),
   ACOURSE2             CHAR(15),
   APFLG2               CHAR(1),
   ACOURSE3             CHAR(15),
   APFLG3               CHAR(1),
   LAST_MOD_USER        VARCHAR(30),
   LAST_MOD_DATE        TIMESTAMP,
   TASTATUS             CHAR(1)
);

insert into "tmp_TCA_TARGET" (INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, FORCEHRS, COND, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, LAST_MOD_USER, LAST_MOD_DATE, TASTATUS)
select INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, FORCEHRS, COND, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, LAST_MOD_USER, LAST_MOD_DATE, TASTATUS
from TCA_TARGET;

drop table TCA_TARGET;

create table adv_ctlcd
(
   adv_id               CHAR(20)               not null,
   ctlcd                CHAR(2)                not null,
   constraint P_Key_1 primary key (adv_id, ctlcd)
);

create table adv_dprogs
(
   adv_id               CHAR(20)               not null,
   dprog                CHAR(15)               not null,
   constraint P_Key_1 primary key (adv_id, dprog)
);

create table adv_functions
(
   adv_function         CHAR(40)               not null,
   adv_id               CHAR(20)               not null,
   instidq              CHAR(2)                not null,
   instid               CHAR(8)                not null,
   instcd               CHAR(3)                not null,
   authority            CHAR(1)                not null,
   constraint P_Key_1 primary key (adv_id, adv_function, instidq, instid, instcd)
);

create table adv_inst
(
   adv_id               CHAR(20)               not null,
   instidq              CHAR(2)                not null,
   instid               CHAR(8)                not null,
   instcd               CHAR(3)                not null,
   constraint P_Key_1 primary key (adv_id, instidq, instid, instcd)
);

create table adv_master
(
   adv_id               CHAR(20)               not null,
   pin                  CHAR(20),
   encrypted_pin        VARCHAR(80),
   "name"               VARCHAR(40),
   dept                 VARCHAR(40),
   ref_adv_id           VARCHAR(20),
   constraint P_Key_1 primary key (adv_id)
);

create table adv_req
(
   adv_id               CHAR(20)               not null,
   rname                CHAR(9)                not null,
   constraint P_Key_1 primary key (adv_id, rname)
);

create table analysis
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   complete             VARCHAR(1),
   ip                   VARCHAR(1),
   seqout               VARCHAR(1),
   reqct                INTEGER,
   sreqct               NUMERIC,
   userid               CHAR(30),
   soprid               CHAR(8),
   stuno                VARCHAR(13),
   stuname              VARCHAR(35),
   dprog                VARCHAR(15),
   instcd               VARCHAR(3)             default ' ',
   dpmask               CHAR(15),
   degree_date          VARCHAR(10),
   catlyt               VARCHAR(6),
   runtime              CHAR(9),
   rundate              CHAR(10),
   instid               CHAR(8)                default ' ',
   jobid                CHAR(16),
   instidq              CHAR(2)                default ' ',
   constraint P_Key_36 primary key (int_seq_no)
);

----set identity_insert analysis on;

insert into analysis (int_seq_no, complete, ip, seqout, reqct, sreqct, userid, soprid, stuno, stuname, dprog, instcd, dpmask, degree_date, catlyt, runtime, rundate, instid, jobid, instidq)
select INT_SEQ_NO, COMPLETE, IP, SEQOUT, REQCT, SREQCT, USERID, SOPRID, STUNO, STUNAME, DPROG, INSTCD, DPMASK, DEGREE_DATE, CATLYT, RUNTIME, RUNDATE, INSTID, JOBID, INSTIDQ
from "tmp_ANALYSIS";

----set identity_insert analysis off;

drop table "tmp_ANALYSIS";

create index analysis_idx on analysis (
   stuno                ASC,
   dprog                ASC,
   dpmask               ASC,
   catlyt               ASC,
   jobid                ASC
);

create table analysis_courses
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   jobq_seq_no          NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   course               VARCHAR(15),
   passfail             VARCHAR(1),
   yeartm               CHAR(6)                default '0000',
   credit               NUMERIC(7,5)           default 0,
   constraint P_Key_38 primary key (int_seq_no)
);

----set identity_insert analysis_courses on;

insert into analysis_courses (int_seq_no, jobq_seq_no, user_seq_no, course, passfail, yeartm, credit)
select INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, COURSE, PASSFAIL, YEARTM, CREDIT
from "tmp_ANALYSIS_COURSES";

--set identity_insert analysis_courses off;

drop table "tmp_ANALYSIS_COURSES";

create index analysis_crs_idx on analysis_courses (
   jobq_seq_no          ASC,
   user_seq_no          ASC
);

create table analysis_req
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   jobq_seq_no          NUMERIC(9)             not null default 0,
   rct                  NUMERIC(2),
   srct                 NUMERIC(3),
   rname                VARCHAR(9),
   psname               VARCHAR(15),
   rno                  NUMERIC(2),
   sno                  NUMERIC(3),
   met                  VARCHAR(1),
   fmet                 VARCHAR(1),
   seqout               VARCHAR(1),
   reqct                NUMERIC(2),
   gotct                NUMERIC(3),
   reqhrs               NUMERIC(5,2),
   gothrs               NUMERIC(5,2),
   reqgpa               NUMERIC(4,3),
   gotgpa               NUMERIC(4,3),
   gotgpahrs            NUMERIC(5,2),
   gotgpapts            NUMERIC(9,5)           default 0,
   constraint P_Key_37 primary key (int_seq_no)
);

--set identity_insert analysis_req on;

insert into analysis_req (int_seq_no, jobq_seq_no, rct, srct, rname, psname, rno, sno, met, fmet, seqout, reqct, gotct, reqhrs, gothrs, reqgpa, gotgpa, gotgpahrs, gotgpapts)
select INT_SEQ_NO, JOBQ_SEQ_NO, RCT, SRCT, RNAME, PSNAME, RNO, SNO, MET, FMET, SEQOUT, REQCT, GOTCT, REQHRS, GOTHRS, REQGPA, GOTGPA, GOTGPAHRS, GOTGPAPTS
from "tmp_ANALYSIS_REQ";

--set identity_insert analysis_req off;

drop table "tmp_ANALYSIS_REQ";

create index analysis_req_idx on analysis_req (
   jobq_seq_no          ASC,
   rct                  ASC,
   srct                 ASC
);

create index analysis_req_idx2 on analysis_req (
   jobq_seq_no          ASC,
   rno                  ASC,
   sno                  ASC
);

create table chart_categories
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   category_code        CHAR(1)                not null,
   category_name        CHAR(15),
   category_desc        VARCHAR(255),
   transcript           CHAR(1),
   total_hour           CHAR(1),
   total_gpa            CHAR(1),
   hidefromchart        CHAR(1),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_1 primary key (instidq, instid, instcd, category_code)
);

create index chart_cat_idx on chart_categories (
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   category_code        ASC,
   transcript           ASC,
   hidefromchart        ASC,
   total_hour           ASC
);

create table com
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   comkey               CHAR(5)                not null default ' ',
   comfield             CHAR(10)               not null,
   comvalue             VARCHAR(255),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_14 primary key (instidq, instid, instcd, comkey, comfield)
);

insert into com (instidq, instid, instcd, comkey, comfield, comvalue, memo, last_mod_user, last_mod_date)
select INSTIDQ, INSTID, INSTCD, COMKEY, COMFIELD, COMVALUE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_COM";

drop table "tmp_COM";

create unique index com_idx on com (
   comkey               ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   comfield             ASC
);

create table cond_codes
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   comkey               CHAR(5)                not null default ' ',
   seq_no               INTEGER                not null default 0,
   cond_code            CHAR(1),
   course_cc_desc       CHAR(80),
   system_cc_desc       CHAR(80),
   last_mod_date        TIMESTAMP,
   last_mod_user        VARCHAR(30),
   constraint P_Key_41 primary key (instidq, instid, instcd, comkey, seq_no)
);

insert into cond_codes (instidq, instid, instcd, comkey, seq_no, cond_code, course_cc_desc, system_cc_desc, last_mod_date, last_mod_user)
select INSTIDQ, INSTID, INSTCD, COMKEY, SEQ_NO, COND_CODE, COURSE_CC_DESC, SYSTEM_CC_DESC, LAST_MOD_DATE, LAST_MOD_USER
from "tmp_COND_CODES";

drop table "tmp_COND_CODES";

create table course_bank
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   course               CHAR(15)               not null,
   pflg                 CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_44 primary key (instidq, instid, instcd, course)
);

insert into course_bank (instidq, instid, instcd, course, pflg, memo, last_mod_user, last_mod_date)
select INSTIDQ, INSTID, INSTCD, COURSE, PFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_COURSE_BANK";

drop table "tmp_COURSE_BANK";

create table crs_convert
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                default ' ',
   instid               CHAR(8)                default ' ',
   instcd               CHAR(3)                default ' ',
   user_seq_no          INTEGER                default 0,
   oldcrse              CHAR(15),
   newcrse              CHAR(15),
   effdte               CHAR(12),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_4 primary key (int_seq_no)
);

--set identity_insert crs_convert on;

insert into crs_convert (int_seq_no, instidq, instid, instcd, user_seq_no, oldcrse, newcrse, effdte, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, OLDCRSE, NEWCRSE, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_CRS_CONVERT";

--set identity_insert crs_convert off;

drop table "tmp_CRS_CONVERT";

create index convert_idx on crs_convert (
   instid               ASC,
   instcd               ASC,
   instidq              ASC,
   user_seq_no          ASC
);

create table dprog
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   dprog                CHAR(15)               not null,
   dpfyt                CHAR(6)                not null default '0000',
   lyt                  CHAR(6)                default '9999',
   dptitle1             VARCHAR(65),
   dptitle2             VARCHAR(65),
   webtitle             VARCHAR(50),
   college              VARCHAR(10),
   major                VARCHAR(10),
   degree               VARCHAR(10),
   location             VARCHAR(10),
   dpcips               CHAR(6),
   dpmask               CHAR(15),
   dpstatus             CHAR(1),
   efilter              CHAR(15),
   instpad              VARCHAR(44),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   dptype               CHAR(1),
   constraint P_Key_1 primary key (instidq, instid, instcd, dprog, dpfyt)
);

insert into dprog (instidq, instid, instcd, dprog, dpfyt, lyt, dptitle1, dptitle2, webtitle, college, major, degree, location, dpcips, dpmask, dpstatus, efilter, instpad, memo, last_mod_user, last_mod_date, dptype)
select INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, LYT, DPTITLE1, DPTITLE2, WEBTITLE, COLLEGE, MAJOR, DEGREE, LOCATION, DPCIPS, DPMASK, DPSTATUS, EFILTER, INSTPAD, MEMO, LAST_MOD_USER, LAST_MOD_DATE, DPTYPE
from "tmp_DPROG";

drop table "tmp_DPROG";

create unique index dprog_idx on dprog (
   dprog                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   dpfyt                ASC,
   lyt                  ASC
);

create index webtitle_idx on dprog (
   webtitle             ASC,
   dprog                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   dpfyt                ASC,
   lyt                  ASC
);

create table dprog_req
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   dprog                CHAR(15)               not null,
   dpfyt                CHAR(6)                not null default '0000',
   user_seq_no          INTEGER                default 0,
   dprname              CHAR(9)                not null,
   grp1                 CHAR(1),
   grp2                 CHAR(1),
   orflg                CHAR(1),
   optflg               CHAR(1),
   sumgrp               CHAR(1),
   crlink               CHAR(1),
   altcflg              CHAR(1),
   sortflg              CHAR(1),
   extend               CHAR(1),
   calcgrp              CHAR(1),
   calcflg              CHAR(1),
   runstatus            CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   category             CHAR(1),
   constraint P_Key_2 primary key (int_seq_no)
);

----set identity_insert dprog_req on;

insert into dprog_req (int_seq_no, instidq, instid, instcd, dprog, dpfyt, user_seq_no, dprname, grp1, grp2, orflg, optflg, sumgrp, crlink, altcflg, sortflg, extend, calcgrp, calcflg, runstatus, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, DPROG, DPFYT, USER_SEQ_NO, DPRNAME, GRP1, GRP2, ORFLG, OPTFLG, SUMGRP, CRLINK, ALTCFLG, SORTFLG, EXTEND, CALCGRP, CALCFLG, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_DPROG_REQ";

--set identity_insert dprog_req off;

drop table "tmp_DPROG_REQ";

create index dprog_req_idx on dprog_req (
   dprog                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   dpfyt                ASC,
   user_seq_no          ASC
);

create table gmaster
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                default ' ',
   instid               CHAR(8)                default ' ',
   instcd               CHAR(3)                default ' ',
   line_type            CHAR(1)                default ' ',
   user_seq_no          INTEGER                default 0,
   grade                CHAR(4),
   rgrade               CHAR(4),
   gpapt                NUMERIC(4,3)           default 0,
   gpacal               CHAR(1),
   addcr                CHAR(1),
   addct                CHAR(1),
   pseudo               CHAR(1),
   force                CHAR(1),
   ip                   CHAR(1),
   ctlcd                CHAR(2),
   action               CHAR(1),
   ruflg                CHAR(1),
   condg                CHAR(6),
   delig                CHAR(1),
   replac               CHAR(1),
   creditck             CHAR(1),
   lcredit              NUMERIC(4,2)           default 0,
   hcredit              NUMERIC(4,2)           default 0,
   ac                   CHAR(1),
   rc                   CHAR(1),
   effdte               CHAR(12),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_3 primary key (int_seq_no)
);

--set identity_insert gmaster on;

insert into gmaster (int_seq_no, instidq, instid, instcd, line_type, user_seq_no, grade, rgrade, gpapt, gpacal, addcr, addct, pseudo, force, ip, ctlcd, action, ruflg, condg, delig, replac, creditck, lcredit, hcredit, ac, rc, effdte, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, LINE_TYPE, USER_SEQ_NO, GRADE, RGRADE, GPAPT, GPACAL, ADDCR, ADDCT, PSEUDO, FORCE, IP, CTLCD, ACTION, RUFLG, CONDG, DELIG, REPLAC, CREDITCK, LCREDIT, HCREDIT, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_GMASTER";

--set identity_insert gmaster off;

drop table "tmp_GMASTER";

create index gmaster_idx on gmaster (
   instid               ASC,
   instcd               ASC,
   instidq              ASC,
   user_seq_no          ASC
);

create table job_queue_accept
(
   jobq_seq_no          NUMERIC(9)             not null default 0,
   rtabx                CHAR(3)                not null,
   stabx                CHAR(3)                not null,
   ctabx                CHAR(4)                not null,
   course               VARCHAR(15),
   title                VARCHAR(29),
   reject               CHAR(1),
   used                 CHAR(1),
   logic                CHAR(1),
   required             CHAR(1),
   cmprtitle            CHAR(1),
   rangecourse          CHAR(15),
   lowyt                CHAR(6),
   highyt               CHAR(6),
   constraint P_KEY_1 primary key (jobq_seq_no, rtabx, stabx, ctabx)
);

create index jobq_accept_idx on job_queue_accept (
   jobq_seq_no          ASC,
   rtabx                ASC,
   stabx                ASC,
   ctabx                ASC,
   reject               ASC
);

create table job_queue_course
(
   jobq_seq_no          NUMERIC(9)             not null,
   rtabx                CHAR(3)                not null,
   stabx                CHAR(3)                not null,
   etabx                CHAR(3)                not null,
   yt                   CHAR(6),
   edit_yt              CHAR(4),
   course               VARCHAR(15),
   xcourse              VARCHAR(15),
   rcredit              NUMERIC(10,5),
   credit               NUMERIC(10,5),
   gpahrs               NUMERIC(10,5),
   gpapts               NUMERIC(10,5),
   gpa                  NUMERIC(10,5),
   grade                CHAR(4),
   rgrade               CHAR(4),
   ip                   CHAR(1),
   whatif               CHAR(1),
   ctitle               VARCHAR(29),
   rtitle               VARCHAR(29),
   stitle               VARCHAR(29),
   cvttitle             VARCHAR(29),
   alttitle             VARCHAR(29),
   constraint P_KEY_1 primary key (jobq_seq_no, rtabx, stabx, etabx)
);

insert into job_queue_course (jobq_seq_no, rtabx, stabx, etabx, rcredit, grade, ctitle)
select ?, ?, ?, ?, RCREDIT, GRADE, CTITLE
from "tmp_JOB_QUEUE_COURSE";

--Drop canceled because cannot give value to mandatory columns
--drop table "tmp_JOB_QUEUE_COURSE";
create table job_queue_detail
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   jobid                CHAR(16)               not null,
   userid               CHAR(30)               not null,
   user_seq_no          INTEGER                not null default 0,
   stuno                CHAR(13),
   comkey               CHAR(5),
   evalsw               CHAR(1),
   f1or2                CHAR(1),
   report               CHAR(1),
   pntreq               CHAR(1),
   listall              CHAR(1),
   test                 CHAR(1),
   fdprog               CHAR(15),
   fcatlyt              CHAR(6),
   sinstid              CHAR(8),
   sinstcd              CHAR(3),
   fdpmask              CHAR(15),
   time_token           CHAR(6),
   lasertext            CHAR(1),
   format               CHAR(1),
   parseflg             CHAR(8),
   revart               CHAR(1),
   binstid              CHAR(8),
   binstcd              CHAR(3),
   bytaken              CHAR(6),
   soprid               CHAR(8),
   constraint P_Key_17 primary key (int_seq_no)
);

--set identity_insert job_queue_detail on;

insert into job_queue_detail (int_seq_no, instidq, instid, instcd, jobid, userid, user_seq_no, stuno, comkey, evalsw, f1or2, report, pntreq, listall, test, fdprog, fcatlyt, sinstid, sinstcd, fdpmask, time_token, lasertext, format, parseflg, revart, binstid, binstcd, bytaken, soprid)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, STUNO, COMKEY, EVALSW, F1OR2, REPORT, PNTREQ, LISTALL, TEST, FDPROG, FCATLYT, SINSTID, SINSTCD, FDPMASK, TIME_TOKEN, LASERTEXT, FORMAT, PARSEFLG, REVART, BINSTID, BINSTCD, BYTAKEN, SOPRID
from "tmp_JOB_QUEUE_DETAIL";

--set identity_insert job_queue_detail off;

drop table "tmp_JOB_QUEUE_DETAIL";

create index job_q_detail_idx on job_queue_detail (
   jobid                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   userid               ASC,
   user_seq_no          ASC
);

create table job_queue_list
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   jobid                CHAR(16)               not null,
   userid               CHAR(30)               not null,
   status               CHAR(1)                default 'N',
   priority             INTEGER                default 100,
   startdate            CHAR(10),
   starttime            CHAR(5),
   external_eval        CHAR(1),
   read_sysin           CHAR(1),
   servername           CHAR(10),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_16 primary key (instidq, instid, instcd, jobid, userid)
);

insert into job_queue_list (instidq, instid, instcd, jobid, userid, status, priority, startdate, starttime, external_eval, read_sysin, servername, last_mod_user, last_mod_date)
select INSTIDQ, INSTID, INSTCD, JOBID, USERID, STATUS, PRIORITY, STARTDATE, STARTTIME, EXTERNAL_EVAL, READ_SYSIN, SERVERNAME, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_JOB_QUEUE_LIST";

drop table "tmp_JOB_QUEUE_LIST";

create index job_q_list_idx on job_queue_list (
   status               ASC,
   startdate            ASC,
   starttime            ASC,
   priority             ASC
);

create index job_q_list_jobidx on job_queue_list (
   jobid                ASC
);

create table job_queue_out
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   jobq_seq_no          NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   rtabx                CHAR(2),
   reqstatus            CHAR(1),
   stabx                CHAR(3),
   srno                 CHAR(2),
   srstatus             CHAR(1),
   optline              CHAR(1),
   lasera               CHAR(1),
   laserb               CHAR(1),
   darout               VARCHAR(255),
   constraint P_Key_22 primary key (int_seq_no)
);

comment on table job_queue_out is
'Job Queue Output (Darout)';

comment on column job_queue_out.int_seq_no is
'Automatically generated sequence number.';

comment on column job_queue_out.jobq_seq_no is
'FK reference to int_seq_no column of job_queue_run table.';

comment on column job_queue_out.user_seq_no is
'Relative order for records with same key.';

comment on column job_queue_out.rtabx is
'Requirement Table (RTAB) index number. (00 if line is not part of a requirement)';

comment on column job_queue_out.reqstatus is
'Requirement type.';

comment on column job_queue_out.stabx is
'Sub-requirement Table (STAB) index.';

comment on column job_queue_out.srno is
'Relative (within requirement) sub-requirement number';

comment on column job_queue_out.srstatus is
'Sub-requirement Status.';

comment on column job_queue_out.optline is
'Optional line status output';

--set identity_insert job_queue_out on;

insert into job_queue_out (int_seq_no, jobq_seq_no, user_seq_no, rtabx, reqstatus, stabx, srno, srstatus, optline, lasera, laserb, darout)
select INT_SEQ_NO, JOBQ_SEQ_NO, USER_SEQ_NO, RTABX, REQSTATUS, STABX, SRNO, SRSTATUS, OPTLINE, LASERA, LASERB, DAROUT
from "tmp_JOB_QUEUE_OUT";

--set identity_insert job_queue_out off;

drop table "tmp_JOB_QUEUE_OUT";

create index job_q_out_idx on job_queue_out (
   jobq_seq_no          ASC,
   user_seq_no          ASC,
   rtabx                ASC,
   stabx                ASC,
   optline              ASC
);

create table job_queue_req
(
   jobq_seq_no          NUMERIC(9)             not null,
   rtabx                CHAR(3)                not null,
   rno                  CHAR(3),
   rname                VARCHAR(9),
   psname               VARCHAR(15),
   category             VARCHAR(15),
   summary_grp          VARCHAR(15),
   transcript           CHAR(1),
   total_hour           CHAR(1),
   total_gpa            CHAR(1),
   hidefromchart        CHAR(1),
   satisfied            CHAR(1),
   summary              CHAR(1),
   sortflg              CHAR(1),
   orreq                CHAR(1),
   optreq               CHAR(1),
   reqsrq               INTEGER,
   gotsrq               INTEGER,
   needsrq              INTEGER,
   reqct                INTEGER,
   gotct                INTEGER,
   ipct                 INTEGER,
   whatifct             INTEGER,
   needct               INTEGER,
   maxhrs               NUMERIC(10,5),
   reqhrs               NUMERIC(10,5),
   est_reqhrs           NUMERIC(10,5),
   gothrs               NUMERIC(10,5),
   iphrs                NUMERIC(10,5),
   whatifhrs            NUMERIC(10,5),
   needhrs              NUMERIC(10,5),
   gotgpahrs            NUMERIC(10,5),
   gotgpapts            NUMERIC(10,5),
   reqgpa               NUMERIC(10,5),
   gotgpa               NUMERIC(10,5),
   needgpa              NUMERIC(10,5),
   constraint P_KEY_1 primary key (jobq_seq_no, rtabx)
);

comment on table job_queue_req is
'Requirement Data Output';

create index jobq_req_idx on job_queue_req (
   jobq_seq_no          ASC,
   rtabx                ASC,
   rname                ASC,
   category             ASC,
   summary_grp          ASC,
   transcript           ASC,
   total_hour           ASC,
   hidefromchart        ASC,
   summary              ASC
);

create table job_queue_run
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                default ' ',
   instid               CHAR(8)                default ' ',
   instcd               CHAR(3)                default ' ',
   jobid                CHAR(16)               default ' ',
   userid               CHAR(30)               default ' ',
   soprid               CHAR(8)                default ' ',
   stuno                CHAR(13)               default ' ',
   dprog                CHAR(15)               default ' ',
   dpmask               CHAR(15)               default ' ',
   catlyt               CHAR(6)                default ' ',
   binstid              CHAR(8),
   binstcd              CHAR(3),
   rundate              CHAR(10),
   jobq_sysout_used     CHAR(1),
   runtime              CHAR(8),
   ncol                 CHAR(1),
   complete             CHAR(1),
   ip                   CHAR(1),
   constraint P_Key_23 primary key (int_seq_no)
);

--set identity_insert job_queue_run on;

insert into job_queue_run (int_seq_no, instidq, instid, instcd, jobid, userid, soprid, stuno, dprog, dpmask, catlyt, binstid, binstcd, rundate, jobq_sysout_used, runtime, ncol, complete, ip)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, SOPRID, STUNO, DPROG, DPMASK, CATLYT, BINSTID, BINSTCD, RUNDATE, JOBQ_SYSOUT_USED, RUNTIME, NCOL, COMPLETE, IP
from "tmp_JOB_QUEUE_RUN";

--set identity_insert job_queue_run off;

drop table "tmp_JOB_QUEUE_RUN";

create index jobq_run_idx on job_queue_run (
   stuno                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   soprid               ASC,
   dprog                ASC,
   dpmask               ASC,
   catlyt               ASC,
   userid               ASC
);

create table job_queue_subreq
(
   jobq_seq_no          NUMERIC(9)             not null,
   rtabx                CHAR(3)                not null,
   stabx                CHAR(3)                not null,
   sno                  CHAR(3),
   satisfied            CHAR(1),
   sortflg              CHAR(1),
   orsub                CHAR(1),
   optsub               CHAR(1),
   reqct                INTEGER,
   gotct                INTEGER,
   needct               INTEGER,
   ipct                 INTEGER,
   whatifct             INTEGER,
   maxhrs               NUMERIC(10,5),
   reqhrs               NUMERIC(10,5),
   est_reqhrsflg        CHAR(1),
   est_reqhrs           NUMERIC(10,5),
   gothrs               NUMERIC(10,5),
   iphrs                NUMERIC(10,5),
   whatifhrs            NUMERIC(10,5),
   needhrs              NUMERIC(10,5),
   reqgpa               NUMERIC(10,5),
   gotgpa               NUMERIC(10,5),
   needgpa              NUMERIC(10,5),
   gotgpahrs            NUMERIC(10,5),
   gotgpapts            NUMERIC(10,5)          default 0,
   constraint P_KEY_1 primary key (jobq_seq_no, rtabx, stabx)
);

create table job_queue_sysin
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                default ' ',
   instid               CHAR(8)                default ' ',
   instcd               CHAR(3)                default ' ',
   jobid                CHAR(16),
   userid               CHAR(30),
   user_seq_no          INTEGER                default 0,
   sysin                CHAR(80),
   constraint P_Key_46 primary key (int_seq_no)
);

--set identity_insert job_queue_sysin on;

insert into job_queue_sysin (int_seq_no, instidq, instid, instcd, jobid, userid, user_seq_no, sysin)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, JOBID, USERID, USER_SEQ_NO, SYSIN
from "tmp_JOB_QUEUE_SYSIN";

--set identity_insert job_queue_sysin off;

drop table "tmp_JOB_QUEUE_SYSIN";

create table mastref
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   source_id            CHAR(8)                not null default ' ',
   source_cd            CHAR(3)                not null default ' ',
   mrfyt                CHAR(6)                not null default '0000',
   lyt                  CHAR(6)                default '9999',
   iname                VARCHAR(60),
   itype                CHAR(2),
   status               CHAR(1),
   crscase              CHAR(1),
   grdcase              CHAR(1),
   sourceidq            CHAR(2),
   bacc                 CHAR(1),
   actc                 CHAR(1),
   agclc                CHAR(2),
   honors               CHAR(1),
   repeatf              CHAR(1),
   cscale               CHAR(1),
   cassign              CHAR(1),
   cexcess              CHAR(1),
   cfinal               CHAR(1),
   dcourse              CHAR(15),
   dpflg                CHAR(1),
   grule                CHAR(1),
   gparule              CHAR(1),
   dgrade               CHAR(4),
   d0grade              CHAR(4),
   crsmask              CHAR(15),
   refucond1            CHAR(3),
   refucond2            CHAR(3),
   refucond3            CHAR(3),
   grdreq               CHAR(1),
   gpascale             CHAR(1),
   unitscale            NUMERIC(6,4)           default 0,
   dinstid              CHAR(8),
   dinstcd              CHAR(3),
   deptbgn              NUMERIC(2)             default 0,
   deptend              NUMERIC(2)             default 0,
   crsbgn               NUMERIC(2)             default 0,
   crsend               NUMERIC(2)             default 0,
   rptinstid            CHAR(8),
   tainstid             CHAR(8),
   tainstcd             CHAR(3),
   refonly              CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_15 primary key (instidq, instid, instcd, source_id, source_cd, mrfyt)
);

insert into mastref (instidq, instid, instcd, source_id, source_cd, mrfyt, lyt, iname, itype, status, crscase, grdcase, sourceidq, bacc, actc, agclc, honors, repeatf, cscale, cassign, cexcess, cfinal, dcourse, dpflg, grule, gparule, dgrade, d0grade, crsmask, refucond1, refucond2, refucond3, grdreq, gpascale, unitscale, dinstid, dinstcd, deptbgn, deptend, crsbgn, crsend, rptinstid, tainstid, tainstcd, refonly, memo, last_mod_user, last_mod_date)
select INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, LYT, INAME, ITYPE, STATUS, CRSCASE, GRDCASE, SOURCEIDQ, BACC, ACTC, AGCLC, HONORS, REPEATF, CSCALE, CASSIGN, CEXCESS, CFINAL, DCOURSE, DPFLG, GRULE, GPARULE, DGRADE, D0GRADE, CRSMASK, REFUCOND1, REFUCOND2, REFUCOND3, GRDREQ, GPASCALE, UNITSCALE, DINSTID, DINSTCD, DEPTBGN, DEPTEND, CRSBGN, CRSEND, RPTINSTID, TAINSTID, TAINSTCD, REFONLY, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_MASTREF";

drop table "tmp_MASTREF";

create unique index mastref_idx on mastref (
   source_id            ASC,
   source_cd            ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   mrfyt                ASC,
   lyt                  ASC
);

create table mastref_address
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   source_id            CHAR(8)                not null default ' ',
   source_cd            CHAR(3)                not null default ' ',
   mrfyt                CHAR(6)                not null default '0000',
   user_seq_no          INTEGER                default 0,
   address1             VARCHAR(35),
   address2             VARCHAR(35),
   city                 VARCHAR(30),
   state                VARCHAR(2),
   zip                  VARCHAR(10),
   country              VARCHAR(3),
   locationq            VARCHAR(2),
   locationid           VARCHAR(25),
   contactcd            VARCHAR(2),
   contactname          VARCHAR(35),
   commnoq              VARCHAR(2),
   fax                  VARCHAR(25),
   phone                VARCHAR(25),
   e_mail               VARCHAR(80),
   from_date            CHAR(8),
   to_date              CHAR(8),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_33 primary key (int_seq_no)
);

--set identity_insert mastref_address on;

insert into mastref_address (int_seq_no, instidq, instid, instcd, source_id, source_cd, mrfyt, user_seq_no, address1, address2, city, state, zip, country, locationq, locationid, contactcd, contactname, commnoq, fax, phone, e_mail, from_date, to_date, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, CONTACTCD, CONTACTNAME, COMMNOQ, FAX, PHONE, E_MAIL, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_MASTREF_ADDRESS";

--set identity_insert mastref_address off;

drop table "tmp_MASTREF_ADDRESS";

create index mastref_addr_idx on mastref_address (
   source_id            ASC,
   source_cd            ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   mrfyt                ASC,
   user_seq_no          ASC
);

create table mastref_seg
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   source_id            CHAR(8)                not null default ' ',
   source_cd            CHAR(3)                not null default ' ',
   mrfyt                CHAR(6)                not null default '0000',
   user_seq_no          INTEGER                default 0,
   ltype                CHAR(1),
   i2uflg               CHAR(1),
   grade                CHAR(4),
   ac                   CHAR(1),
   rc                   CHAR(1),
   u2iflg               CHAR(1),
   ugrade               CHAR(4),
   acu                  CHAR(3),
   rcu                  CHAR(3),
   gpapt                NUMERIC(4,3)           default 0,
   gpacal               CHAR(1),
   addcr                CHAR(1),
   addct                CHAR(1),
   cond1                CHAR(1),
   cond2                CHAR(1),
   ucond1               CHAR(3),
   ucond2               CHAR(3),
   effdte               CHAR(12),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_32 primary key (int_seq_no)
);

--set identity_insert mastref_seg on;

insert into mastref_seg (int_seq_no, instidq, instid, instcd, source_id, source_cd, mrfyt, user_seq_no, ltype, i2uflg, grade, ac, rc, u2iflg, ugrade, acu, rcu, gpapt, gpacal, addcr, addct, cond1, cond2, ucond1, ucond2, effdte, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, MRFYT, USER_SEQ_NO, LTYPE, I2UFLG, GRADE, AC, RC, U2IFLG, UGRADE, ACU, RCU, GPAPT, GPACAL, ADDCR, ADDCT, COND1, COND2, UCOND1, UCOND2, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_MASTREF_SEG";

--set identity_insert mastref_seg off;

drop table "tmp_MASTREF_SEG";

create index master_idx on mastref_seg (
   source_id            ASC,
   source_cd            ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   mrfyt                ASC,
   user_seq_no          ASC
);

create table "repeat"
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                default ' ',
   instid               CHAR(8)                default ' ',
   instcd               CHAR(3)                default ' ',
   user_seq_no          INTEGER                default 0,
   course               CHAR(15),
   ctitle               VARCHAR(29),
   hmax                 NUMERIC(4,1)           default 0,
   chflag               CHAR(1),
   ac                   CHAR(1),
   rc                   CHAR(1),
   effdte               CHAR(12),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_5 primary key (int_seq_no)
);

--set identity_insert repeat on;

insert into "repeat" (int_seq_no, instidq, instid, instcd, user_seq_no, course, ctitle, hmax, chflag, ac, rc, effdte, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, COURSE, CTITLE, HMAX, CHFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_REPEAT";

--set identity_insert repeat off;

drop table "tmp_REPEAT";

create index repeat_idx on "repeat" (
   instid               ASC,
   instcd               ASC,
   instidq              ASC,
   user_seq_no          ASC
);

create table req_main
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   rname                CHAR(9)                not null,
   rqfyt                CHAR(6)                not null default '0000',
   lyt                  CHAR(6)                default '9999',
   reqsrq               NUMERIC(2)             default 0,
   reqhrs               NUMERIC(4,1)           default 0,
   reqgpa               NUMERIC(4,3)           default 0,
   ac1                  CHAR(1),
   ac2                  CHAR(1),
   rc1                  CHAR(1),
   rc2                  CHAR(1),
   assignc              CHAR(1),
   reuse                CHAR(1),
   nolist               CHAR(1),
   psname               CHAR(15),
   refcycle             CHAR(1),
   rqtype               CHAR(1),
   reqsrqf              CHAR(1),
   reqhrsf              CHAR(1),
   reqgpaf              CHAR(1),
   usect                NUMERIC(2)             default 0,
   iplist               CHAR(1),
   nocompl              CHAR(1),
   reqct                NUMERIC(2)             default 0,
   reqctf               CHAR(1),
   maxhrs               NUMERIC(4,1)           default 999.9,
   rconda               CHAR(1),
   rcondr               CHAR(1),
   varr                 CHAR(1),
   lokovr1              CHAR(1),
   lnoovr1              CHAR(1),
   lokovr2              CHAR(1),
   lnoovr2              CHAR(1),
   ractl                CHAR(1),
   assignc2             CHAR(1),
   refdir               CHAR(1),
   reffld               CHAR(1),
   refsub               CHAR(1),
   refval               CHAR(1),
   rtitle1              VARCHAR(58),
   rtitle2              VARCHAR(58),
   runstatus            CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   estreqhrs            NUMERIC(4,1),
   constraint P_Key_8 primary key (instidq, instid, instcd, rname, rqfyt)
);

insert into req_main (instidq, instid, instcd, rname, rqfyt, lyt, reqsrq, reqhrs, reqgpa, ac1, ac2, rc1, rc2, assignc, reuse, nolist, psname, refcycle, rqtype, reqsrqf, reqhrsf, reqgpaf, usect, iplist, nocompl, reqct, reqctf, maxhrs, rconda, rcondr, varr, lokovr1, lnoovr1, lokovr2, lnoovr2, ractl, assignc2, refdir, reffld, refsub, refval, rtitle1, rtitle2, runstatus, memo, last_mod_user, last_mod_date)
select INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, LYT, REQSRQ, REQHRS, REQGPA, AC1, AC2, RC1, RC2, ASSIGNC, REUSE, NOLIST, PSNAME, REFCYCLE, RQTYPE, REQSRQF, REQHRSF, REQGPAF, USECT, IPLIST, NOCOMPL, REQCT, REQCTF, MAXHRS, RCONDA, RCONDR, VARR, LOKOVR1, LNOOVR1, LOKOVR2, LNOOVR2, RACTL, ASSIGNC2, REFDIR, REFFLD, REFSUB, REFVAL, RTITLE1, RTITLE2, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_REQ_MAIN";

drop table "tmp_REQ_MAIN";

create unique index req_main_idx on req_main (
   rname                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   rqfyt                ASC,
   lyt                  ASC
);

create table req_text
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   rname                CHAR(9)                not null,
   rqfyt                CHAR(6)                not null default '0000',
   user_seq_no          INTEGER                default 0,
   rtext_type           CHAR(1),
   text                 VARCHAR(65),
   lokovr1              CHAR(1),
   lnoovr1              CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_10 primary key (int_seq_no)
);

--set identity_insert req_text on;

insert into req_text (int_seq_no, instidq, instid, instcd, rname, rqfyt, user_seq_no, rtext_type, text, lokovr1, lnoovr1, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, RTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_REQ_TEXT";

--set identity_insert req_text off;

drop table "tmp_REQ_TEXT";

create index req_text_idx on req_text (
   rname                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   rqfyt                ASC,
   rtext_type           ASC,
   user_seq_no          ASC
);

create table req_xy
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   rname                CHAR(9)                not null,
   rqfyt                CHAR(6)                not null default '0000',
   user_seq_no          INTEGER                default 0,
   xy_type              CHAR(1),
   maxgrpc              NUMERIC(2)             default 99,
   maxhrc               NUMERIC(4,1)           default 999.9,
   skipdup              CHAR(1),
   ctcond               CHAR(1),
   assignm              CHAR(1),
   maxctc               NUMERIC(2)             default 99,
   maxsrc               NUMERIC(2)             default 99,
   ctpsname             CHAR(15),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_9 primary key (int_seq_no)
);

--set identity_insert req_xy on;

insert into req_xy (int_seq_no, instidq, instid, instcd, rname, rqfyt, user_seq_no, xy_type, maxgrpc, maxhrc, skipdup, ctcond, assignm, maxctc, maxsrc, ctpsname, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, XY_TYPE, MAXGRPC, MAXHRC, SKIPDUP, CTCOND, ASSIGNM, MAXCTC, MAXSRC, CTPSNAME, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_REQ_XY";

--set identity_insert req_xy off;

drop table "tmp_REQ_XY";

create index req_xy_idx on req_xy (
   rname                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   rqfyt                ASC,
   user_seq_no          ASC
);

create table secure_import
(
   userid               CHAR(30)               not null,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   constraint P_Key_43 primary key (userid, instidq, instid, instcd)
);

insert into secure_import (userid, instidq, instid, instcd)
select USERID, INSTIDQ, INSTID, INSTCD
from "tmp_SECURE_IMPORT";

drop table "tmp_SECURE_IMPORT";

create table secure_inst
(
   userid               CHAR(30)               not null,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   soprid               CHAR(8),
   smask                CHAR(8),
   update_pin           CHAR(1),
   constraint P_Key_42 primary key (userid, instidq, instid, instcd)
);

insert into secure_inst (userid, instidq, instid, instcd, soprid, smask, update_pin)
select USERID, INSTIDQ, INSTID, INSTCD, SOPRID, SMASK, UPDATE_PIN
from "tmp_SECURE_INST";

drop table "tmp_SECURE_INST";

create table secure_master
(
   userid               CHAR(30)               not null,
   refuserid            CHAR(30),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_40 primary key (userid)
);

insert into secure_master (userid, refuserid, memo, last_mod_user, last_mod_date)
select USERID, REFUSERID, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_SECURE_MASTER";

drop table "tmp_SECURE_MASTER";

create table string
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                default ' ',
   instid               CHAR(8)                default ' ',
   instcd               CHAR(3)                default ' ',
   user_seq_no          INTEGER                default 0,
   stype                CHAR(1),
   stypeq               CHAR(1),
   cond                 CHAR(1),
   limct                NUMERIC(2)             default 0,
   limhrs               NUMERIC(4,2)           default 0,
   ctlcd                CHAR(2),
   ac                   CHAR(1),
   rc                   CHAR(1),
   aeflg                CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_6 primary key (int_seq_no)
);

--set identity_insert string on;

insert into string (int_seq_no, instidq, instid, instcd, user_seq_no, stype, stypeq, cond, limct, limhrs, ctlcd, ac, rc, aeflg, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, USER_SEQ_NO, STYPE, STYPEQ, COND, LIMCT, LIMHRS, CTLCD, AC, RC, AEFLG, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STRING";

--set identity_insert string off;

drop table "tmp_STRING";

create index string_idx on string (
   instid               ASC,
   instcd               ASC,
   instidq              ASC,
   user_seq_no          ASC
);

create table string_crse
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   str_int_seq_no       NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   course               CHAR(15),
   ctitle               VARCHAR(29),
   ac                   CHAR(1),
   rc                   CHAR(1),
   aeflg                CHAR(1),
   pflg                 CHAR(1),
   effdte               CHAR(12),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_7 primary key (int_seq_no)
);

--set identity_insert string_crse on;

insert into string_crse (int_seq_no, str_int_seq_no, user_seq_no, course, ctitle, ac, rc, aeflg, pflg, effdte, last_mod_user, last_mod_date)
select INT_SEQ_NO, STR_INT_SEQ_NO, USER_SEQ_NO, COURSE, CTITLE, AC, RC, AEFLG, PFLG, EFFDTE, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STRING_CRSE";

--set identity_insert string_crse off;

drop table "tmp_STRING_CRSE";

create index string_crse_idx on string_crse (
   str_int_seq_no       ASC,
   user_seq_no          ASC
);

create table stu_acadrec
(
   stu_mast_no          NUMERIC(9)             not null default 0,
   source_id            CHAR(8)                not null default ' ',
   source_cd            CHAR(3)                not null default ' ',
   cdpmask              CHAR(15)               not null default ' ',
   crs_yt               CHAR(6)                not null default '0000',
   crs_num              CHAR(15)               not null,
   crs_seq              CHAR(3)                not null default '001',
   section              CHAR(3),
   pflg                 CHAR(1),
   rcredit              NUMERIC(7,5)           default 0,
   grade                CHAR(4),
   ctitle               VARCHAR(29),
   rtext                CHAR(2),
   condc                CHAR(12),
   cline                CHAR(27),
   xcourse              CHAR(15),
   ecredit              NUMERIC(7,5)           default 0,
   gpahrs               NUMERIC(7,5)           default 0,
   gpapts               NUMERIC(9,5)           default 0,
   linkno               CHAR(2),
   xpflg                CHAR(1),
   rtitle               CHAR(29),
   evalflg              CHAR(1)                not null default ' ',
   bacc                 CHAR(1),
   actc                 CHAR(1),
   agclc                CHAR(2),
   honors               CHAR(1),
   repeatf              CHAR(1),
   iflg1                CHAR(3),
   iflg2                CHAR(3),
   iflg3                CHAR(3),
   iflg4                CHAR(3),
   iflg5                CHAR(3),
   acourse1             CHAR(15),
   apflg1               CHAR(1),
   acourse2             CHAR(15),
   apflg2               CHAR(1),
   acourse3             CHAR(15),
   apflg3               CHAR(1),
   gradeq               CHAR(3),
   rgrade               CHAR(4),
   certify              CHAR(1)                not null default ' ',
   subj_area            CHAR(17),
   gradelev             CHAR(2),
   drpdate              CHAR(6),
   ovacadsrc            CHAR(2),
   security_flag        CHAR(1),
   data_source          CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_21 primary key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
);

insert into stu_acadrec (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq, section, pflg, rcredit, grade, ctitle, rtext, condc, cline, xcourse, ecredit, gpahrs, gpapts, linkno, xpflg, rtitle, evalflg, bacc, actc, agclc, honors, repeatf, iflg1, iflg2, iflg3, iflg4, iflg5, acourse1, apflg1, acourse2, apflg2, acourse3, apflg3, gradeq, rgrade, certify, subj_area, gradelev, drpdate, ovacadsrc, security_flag, data_source, memo, last_mod_user, last_mod_date)
select STU_MAST_NO, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ, SECTION, PFLG, RCREDIT, GRADE, CTITLE, RTEXT, CONDC, CLINE, XCOURSE, ECREDIT, GPAHRS, GPAPTS, LINKNO, XPFLG, RTITLE, EVALFLG, BACC, ACTC, AGCLC, HONORS, REPEATF, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, GRADEQ, RGRADE, CERTIFY, SUBJ_AREA, GRADELEV, DRPDATE, OVACADSRC, SECURITY_FLAG, DATA_SOURCE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_ACADREC";

drop table "tmp_STU_ACADREC";

create unique index stu_acad_idx on stu_acadrec (
   stu_mast_no          ASC,
   source_id            ASC,
   source_cd            ASC,
   cdpmask              ASC,
   crs_yt               ASC,
   crs_num              ASC,
   crs_seq              ASC,
   evalflg              ASC,
   certify              ASC
);

create table stu_address
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   stu_mast_no          NUMERIC(9)             not null default 0,
   source_id            CHAR(8)                not null default ' ',
   address_type         VARCHAR(2),
   addrname             VARCHAR(35),
   nametypecd           VARCHAR(2),
   address1             VARCHAR(35),
   address2             VARCHAR(35),
   city                 VARCHAR(30),
   state                VARCHAR(2),
   zip                  VARCHAR(10),
   country              VARCHAR(3),
   locationq            VARCHAR(2),
   locationid           VARCHAR(25),
   entityidcd           VARCHAR(2),
   refnoq               VARCHAR(2),
   refno                VARCHAR(30),
   indrelcd             VARCHAR(2),
   from_date            CHAR(8),
   to_date              CHAR(8),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_28 primary key (int_seq_no)
);

--set identity_insert stu_address on;

insert into stu_address (int_seq_no, stu_mast_no, source_id, address_type, addrname, nametypecd, address1, address2, city, state, zip, country, locationq, locationid, entityidcd, refnoq, refno, indrelcd, from_date, to_date, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, STU_MAST_NO, SOURCE_ID, ADDRESS_TYPE, ADDRNAME, NAMETYPECD, ADDRESS1, ADDRESS2, CITY, STATE, ZIP, COUNTRY, LOCATIONQ, LOCATIONID, ENTITYIDCD, REFNOQ, REFNO, INDRELCD, FROM_DATE, TO_DATE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_ADDRESS";

--set identity_insert stu_address off;

drop table "tmp_STU_ADDRESS";

create table stu_demo
(
   stu_mast_no          NUMERIC(9)             not null default 0,
   source_id            CHAR(8)                not null default ' ',
   stuname              VARCHAR(35),
   stuidq               CHAR(2),
   stuiddesc            VARCHAR(80),
   dob                  CHAR(6),
   birthcountry         CHAR(3),
   birthstate           CHAR(2),
   birthcounty          CHAR(5),
   birthcity            VARCHAR(30),
   citizenstatus        CHAR(2),
   citizencountry       CHAR(3),
   nativelang           CHAR(3),
   englprof             CHAR(3),
   marital              CHAR(1),
   gender               CHAR(1),
   race                 CHAR(1),
   hsgradtype           CHAR(3),
   hsgraddate           CHAR(8),
   hs                   VARCHAR(30),
   tctlast              CHAR(6),
   nodflt               CHAR(1),
   bdverif              CHAR(2),
   spokeninhome         CHAR(3),
   correslang           CHAR(3),
   subnatq              CHAR(2),
   subnational          VARCHAR(20),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_18 primary key (stu_mast_no, source_id)
);

insert into stu_demo (stu_mast_no, source_id, stuname, stuidq, stuiddesc, dob, birthcountry, birthstate, birthcounty, birthcity, citizenstatus, citizencountry, nativelang, englprof, marital, gender, race, hsgradtype, hsgraddate, hs, tctlast, nodflt, bdverif, spokeninhome, correslang, subnatq, subnational, memo, last_mod_user, last_mod_date)
select STU_MAST_NO, SOURCE_ID, STUNAME, STUIDQ, STUIDDESC, DOB, BIRTHCOUNTRY, BIRTHSTATE, BIRTHCOUNTY, BIRTHCITY, CITIZENSTATUS, CITIZENCOUNTRY, NATIVELANG, ENGLPROF, MARITAL, GENDER, RACE, HSGRADTYPE, HSGRADDATE, HS, TCTLAST, NODFLT, BDVERIF, SPOKENINHOME, CORRESLANG, SUBNATQ, SUBNATIONAL, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_DEMO";

drop table "tmp_STU_DEMO";

create table stu_dprog
(
   stu_mast_no          NUMERIC(9)             not null default 0,
   instcd               CHAR(3)                not null default ' ',
   dprog                CHAR(15)               not null,
   drcatlyt             CHAR(6),
   dpmask               CHAR(15),
   acatlyt1             CHAR(6),
   acatlyt2             CHAR(6),
   acatlyt3             CHAR(6),
   acatlyt4             CHAR(6),
   acatlyt5             CHAR(6),
   acatlyt6             CHAR(6),
   acatlyt7             CHAR(6),
   acatlyt8             CHAR(6),
   acatlyt9             CHAR(6),
   whatif               CHAR(1),
   degreecd             CHAR(3),
   entryyr              CHAR(4),
   exityr               CHAR(4),
   trmodmet             CHAR(1),
   degreestatus         CHAR(1),
   honorslevel          CHAR(3),
   memo                 VARCHAR(255),
   degree_date          CHAR(10),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_19 primary key (stu_mast_no, instcd, dprog)
);

insert into stu_dprog (stu_mast_no, instcd, dprog, drcatlyt, dpmask, acatlyt1, acatlyt2, acatlyt3, acatlyt4, acatlyt5, acatlyt6, acatlyt7, acatlyt8, acatlyt9, whatif, degreecd, entryyr, exityr, trmodmet, degreestatus, honorslevel, memo, degree_date, last_mod_user, last_mod_date)
select STU_MAST_NO, INSTCD, DPROG, DRCATLYT, DPMASK, ACATLYT1, ACATLYT2, ACATLYT3, ACATLYT4, ACATLYT5, ACATLYT6, ACATLYT7, ACATLYT8, ACATLYT9, WHATIF, DEGREECD, ENTRYYR, EXITYR, TRMODMET, DEGREESTATUS, HONORSLEVEL, MEMO, DEGREE_DATE, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_DPROG";

drop table "tmp_STU_DPROG";

create table stu_egrp_courses
(
   stu_mast_no          NUMERIC(9)             not null default 0,
   evalgrp              CHAR(3)                not null default ' ',
   source_id            CHAR(8)                not null default ' ',
   source_cd            CHAR(3)                not null default ' ',
   cdpmask              CHAR(15)               not null default ' ',
   crs_yt               CHAR(6)                not null default '0000',
   crs_num              CHAR(15)               not null,
   crs_seq              CHAR(3)                not null default '001',
   constraint P_Key_39 primary key (stu_mast_no, evalgrp, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
);

insert into stu_egrp_courses (stu_mast_no, evalgrp, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
select STU_MAST_NO, EVALGRP, SOURCE_ID, SOURCE_CD, CDPMASK, CRS_YT, CRS_NUM, CRS_SEQ
from "tmp_STU_EGRP_COURSES";

drop table "tmp_STU_EGRP_COURSES";

create index stu_egrp_crs_idx2 on stu_egrp_courses (
   stu_mast_no          ASC,
   evalgrp              ASC
);

create index stu_egrp_crs_idx3 on stu_egrp_courses (
   cdpmask              ASC,
   crs_num              ASC,
   crs_seq              ASC,
   crs_yt               ASC,
   source_cd            ASC,
   source_id            ASC,
   stu_mast_no          ASC
);

create table stu_evalgrp
(
   stu_mast_no          NUMERIC(9)             not null default 0,
   evalgrp              CHAR(3)                not null default ' ',
   instcd               CHAR(3)                default ' ',
   dpmask               CHAR(15)               default ' ',
   source_id            CHAR(8)                default ' ',
   source_cd            CHAR(3)                default ' ',
   evallock             CHAR(1)                default ' ',
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   certify              CHAR(1)                default ' ',
   constraint P_Key_29 primary key (stu_mast_no, evalgrp)
);

insert into stu_evalgrp (stu_mast_no, evalgrp, instcd, dpmask, source_id, source_cd, evallock, memo, last_mod_user, last_mod_date, certify)
select STU_MAST_NO, EVALGRP, INSTCD, DPMASK, SOURCE_ID, SOURCE_CD, EVALLOCK, MEMO, LAST_MOD_USER, LAST_MOD_DATE, CERTIFY
from "tmp_STU_EVALGRP";

drop table "tmp_STU_EVALGRP";

create unique index stu_evalgrp_idx on stu_evalgrp (
   stu_mast_no          ASC,
   evalgrp              ASC,
   instcd               ASC,
   dpmask               ASC,
   source_id            ASC,
   source_cd            ASC,
   evallock             ASC
);

create table stu_exc_courses
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   stu_int_seq_no       NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   course               CHAR(15),
   rcourse              CHAR(15),
   matchctl             CHAR(1),
   effdte               CHAR(12),
   ac                   CHAR(1),
   rc                   CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_31 primary key (int_seq_no)
);

--set identity_insert stu_exc_courses on;

insert into stu_exc_courses (int_seq_no, stu_int_seq_no, user_seq_no, course, rcourse, matchctl, effdte, ac, rc, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, STU_INT_SEQ_NO, USER_SEQ_NO, COURSE, RCOURSE, MATCHCTL, EFFDTE, AC, RC, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_EXC_COURSES";

--set identity_insert stu_exc_courses off;

drop table "tmp_STU_EXC_COURSES";

create index stu_exc_crs_idx on stu_exc_courses (
   stu_int_seq_no       ASC,
   user_seq_no          ASC
);

create table stu_exceptions
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   stu_mast_no          NUMERIC(9)             default 0,
   instcd               CHAR(3)                not null default ' ',
   dpmask               CHAR(15)               not null default ' ',
   dprog                CHAR(15)               not null default ' ',
   user_seq_no          INTEGER                default 0,
   ctlcd                CHAR(2),
   action               CHAR(1),
   ruflg                CHAR(1),
   yeartm               CHAR(6),
   ac1                  CHAR(1),
   ac2                  CHAR(1),
   rc1                  CHAR(1),
   rc2                  CHAR(1),
   course               CHAR(15),
   rcourse              CHAR(15),
   cline                CHAR(27),
   reqhrs               NUMERIC(5,2),
   maxhrs               NUMERIC(5,2),
   reqsrq               NUMERIC(3),
   maxct                NUMERIC(3),
   val                  NUMERIC(3),
   matchctl             CHAR(1),
   effdte               CHAR(12),
   reqgpa               NUMERIC(5,3),
   assignc              CHAR(1),
   maxhrsck             CHAR(1),
   psname               CHAR(15),
   rname                CHAR(9),
   memo                 VARCHAR(255),
   auth_id              VARCHAR(30),
   auth_date            CHAR(12),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_30 primary key (int_seq_no)
);

--set identity_insert stu_exceptions on;

insert into stu_exceptions (int_seq_no, stu_mast_no, instcd, dpmask, dprog, user_seq_no, ctlcd, action, ruflg, yeartm, ac1, ac2, rc1, rc2, course, rcourse, cline, reqhrs, maxhrs, reqsrq, maxct, val, matchctl, effdte, reqgpa, assignc, maxhrsck, psname, rname, memo, auth_id, auth_date, last_mod_user, last_mod_date)
select INT_SEQ_NO, STU_MAST_NO, INSTCD, DPMASK, DPROG, USER_SEQ_NO, CTLCD, ACTION, RUFLG, YEARTM, AC1, AC2, RC1, RC2, COURSE, RCOURSE, CLINE, REQHRS, MAXHRS, REQSRQ, MAXCT, VAL, MATCHCTL, EFFDTE, REQGPA, ASSIGNC, MAXHRSCK, PSNAME, RNAME, MEMO, AUTH_ID, AUTH_DATE, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_EXCEPTIONS";

--set identity_insert stu_exceptions off;

drop table "tmp_STU_EXCEPTIONS";

create index stu_exceptions_idx on stu_exceptions (
   stu_mast_no          ASC,
   instcd               ASC,
   dprog                ASC,
   dpmask               ASC,
   user_seq_no          ASC
);

create table stu_marker_req
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   stu_mast_no          NUMERIC(9)             not null default 0,
   instcd               CHAR(3)                not null default ' ',
   dprog                CHAR(15)               not null,
   user_seq_no          INTEGER                default 0,
   marker               CHAR(9),
   drval                CHAR(15),
   drtype               CHAR(1),
   drinstcd             CHAR(3),
   drcatlyt             CHAR(6),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_20 primary key (int_seq_no)
);

--set identity_insert stu_marker_req on;

insert into stu_marker_req (int_seq_no, stu_mast_no, instcd, dprog, user_seq_no, marker, drval, drtype, drinstcd, drcatlyt, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, STU_MAST_NO, INSTCD, DPROG, USER_SEQ_NO, MARKER, DRVAL, DRTYPE, DRINSTCD, DRCATLYT, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_MARKER_REQ";

--set identity_insert stu_marker_req off;

drop table "tmp_STU_MARKER_REQ";

create index stu_marker_req_idx on stu_marker_req (
   stu_mast_no          ASC,
   instcd               ASC,
   dprog                ASC,
   user_seq_no          ASC
);

create table stu_master
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                default ' ',
   stuno                CHAR(13),
   tctlast              CHAR(6),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        DATE,
   nodflt               CHAR(1),
   pin                  VARCHAR(20),
   encrypted_pin        VARCHAR(80),
   constraint P_Key_35 primary key (int_seq_no)
);

--set identity_insert stu_master on;

insert into stu_master (int_seq_no, instidq, instid, stuno, tctlast, memo, last_mod_user, last_mod_date, nodflt, pin)
select INT_SEQ_NO, INSTIDQ, INSTID, STUNO, TCTLAST, MEMO, LAST_MOD_USER, LAST_MOD_DATE, NODFLT, PIN
from "tmp_STU_MASTER";

--set identity_insert stu_master off;

drop table "tmp_STU_MASTER";

create unique index stu_info_idx on stu_master (
   stuno                ASC,
   instidq              ASC,
   instid               ASC
);

create table stu_trans_degree
(
   stu_mast_no          NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                not null default 0,
   segtitle             CHAR(5),
   acadfoscode          CHAR(1),
   segliteral           VARCHAR(75),
   fieldofstudy         VARCHAR(20),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_34 primary key (stu_mast_no, user_seq_no)
);

insert into stu_trans_degree (stu_mast_no, user_seq_no, segtitle, acadfoscode, segliteral, fieldofstudy, memo, last_mod_user, last_mod_date)
select STU_MAST_NO, USER_SEQ_NO, SEGTITLE, ACADFOSCODE, SEGLITERAL, FIELDOFSTUDY, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_STU_TRANS_DEGREE";

drop table "tmp_STU_TRANS_DEGREE";

create table sub_req
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   rname                CHAR(9)                not null,
   rqfyt                CHAR(6)                not null default '0000',
   user_seq_no          INTEGER                default 0,
   sreqno               INTEGER                default 0,
   reqct                NUMERIC(2)             default 0,
   reqctf               CHAR(1),
   reqhrs               NUMERIC(4,1)           default 0,
   reqhrsf              CHAR(1),
   reqgpa               NUMERIC(4,3)           default 0,
   reqgpaf              CHAR(1),
   maxhrs               NUMERIC(4,1)           default 999.9,
   maxhrsck             CHAR(1),
   allres               CHAR(1),
   ac1                  CHAR(1),
   ac2                  CHAR(1),
   ac3                  CHAR(1),
   ac4                  CHAR(1),
   ac5                  CHAR(1),
   acor                 CHAR(1),
   rc1                  CHAR(1),
   rc2                  CHAR(1),
   rc3                  CHAR(1),
   rc4                  CHAR(1),
   rc5                  CHAR(1),
   rcand                CHAR(1),
   actl                 CHAR(1),
   assignc              CHAR(1),
   assignc2             CHAR(1),
   assignm              CHAR(1),
   sreuse               CHAR(1),
   skipbct              NUMERIC(1),
   nolist               CHAR(1),
   noseqno              CHAR(1),
   reqflg               CHAR(1),
   iplist               CHAR(1),
   ignorecl             CHAR(1),
   gpaweight            CHAR(1),
   seqchk               CHAR(1),
   maxct                NUMERIC(2)             default 99,
   ctcond0              CHAR(1),
   ctcond1              CHAR(1),
   ctcond2              CHAR(1),
   ctcond3              CHAR(1),
   ctcond4              CHAR(1),
   ctcond5              CHAR(1),
   ctcond6              CHAR(1),
   ctcond7              CHAR(1),
   ctcond8              CHAR(1),
   ctcond9              CHAR(1),
   ctcond10             CHAR(1),
   ctcond11             CHAR(1),
   ctcond12             CHAR(1),
   ctcond13             CHAR(1),
   ctcond14             CHAR(1),
   conda                CHAR(1),
   condr                CHAR(1),
   listsr               CHAR(1),
   negreq               CHAR(1),
   pntdescr             CHAR(1),
   gpa                  CHAR(1),
   aonly                CHAR(1),
   calpha               CHAR(1),
   grp                  CHAR(1),
   grpmin               NUMERIC(2)             default 0,
   grpmax               NUMERIC(2)             default 99,
   varc                 CHAR(1),
   hcmin                NUMERIC(2)             default 0,
   hcmax                NUMERIC(2)             default 99,
   xrefsr               CHAR(1),
   refgno               NUMERIC(2)             default 0,
   eorder               CHAR(1),
   etopdown             CHAR(1),
   estop                CHAR(1),
   elimit               CHAR(1),
   refdir               CHAR(1),
   reffld               CHAR(1),
   refsub               CHAR(1),
   refval               CHAR(1),
   refcycle             CHAR(1),
   selra                CHAR(1),
   sortflg              CHAR(1),
   sreqor               CHAR(1),
   actlx                CHAR(1),
   assigncx             CHAR(1),
   revartl              CHAR(1),
   matchone             CHAR(1),
   ltopdown             CHAR(1),
   selip                CHAR(1),
   runstatus            CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   esthrs               NUMERIC(4,1),
   esthrsflg            CHAR(1),
   constraint P_Key_11 primary key (int_seq_no)
);

comment on table sub_req is
'Sub-requirement definition';

--set identity_insert sub_req on;

insert into sub_req (int_seq_no, instidq, instid, instcd, rname, rqfyt, user_seq_no, sreqno, reqct, reqctf, reqhrs, reqhrsf, reqgpa, reqgpaf, maxhrs, maxhrsck, allres, ac1, ac2, ac3, ac4, ac5, acor, rc1, rc2, rc3, rc4, rc5, rcand, actl, assignc, assignc2, assignm, sreuse, skipbct, nolist, noseqno, reqflg, iplist, ignorecl, gpaweight, seqchk, maxct, ctcond0, ctcond1, ctcond2, ctcond3, ctcond4, ctcond5, ctcond6, ctcond7, ctcond8, ctcond9, ctcond10, ctcond11, ctcond12, ctcond13, ctcond14, conda, condr, listsr, negreq, pntdescr, gpa, aonly, calpha, grp, grpmin, grpmax, varc, hcmin, hcmax, xrefsr, refgno, eorder, etopdown, estop, elimit, refdir, reffld, refsub, refval, refcycle, selra, sortflg, sreqor, actlx, assigncx, revartl, matchone, ltopdown, selip, runstatus, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, RNAME, RQFYT, USER_SEQ_NO, SREQNO, REQCT, REQCTF, REQHRS, REQHRSF, REQGPA, REQGPAF, MAXHRS, MAXHRSCK, ALLRES, AC1, AC2, AC3, AC4, AC5, ACOR, RC1, RC2, RC3, RC4, RC5, RCAND, ACTL, ASSIGNC, ASSIGNC2, ASSIGNM, SREUSE, SKIPBCT, NOLIST, NOSEQNO, REQFLG, IPLIST, IGNORECL, GPAWEIGHT, SEQCHK, MAXCT, CTCOND0, CTCOND1, CTCOND2, CTCOND3, CTCOND4, CTCOND5, CTCOND6, CTCOND7, CTCOND8, CTCOND9, CTCOND10, CTCOND11, CTCOND12, CTCOND13, CTCOND14, CONDA, CONDR, LISTSR, NEGREQ, PNTDESCR, GPA, AONLY, CALPHA, GRP, GRPMIN, GRPMAX, VARC, HCMIN, HCMAX, XREFSR, REFGNO, EORDER, ETOPDOWN, ESTOP, ELIMIT, REFDIR, REFFLD, REFSUB, REFVAL, REFCYCLE, SELRA, SORTFLG, SREQOR, ACTLX, ASSIGNCX, REVARTL, MATCHONE, LTOPDOWN, SELIP, RUNSTATUS, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_SUB_REQ";

--set identity_insert sub_req off;

drop table "tmp_SUB_REQ";

create index sub_req_idx on sub_req (
   rname                ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   rqfyt                ASC,
   user_seq_no          ASC
);

create table sub_req_ar
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   sub_int_seq_no       NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   ar_type              CHAR(1)                not null,
   course               CHAR(15),
   matchctl             CHAR(1),
   ctitle               VARCHAR(29),
   tflg                 CHAR(1),
   creditlim            CHAR(1),
   crsflag              CHAR(3),
   ac                   CHAR(1),
   rc                   CHAR(1),
   effdte               CHAR(12),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_13 primary key (int_seq_no)
);

--set identity_insert sub_req_ar on;

insert into sub_req_ar (int_seq_no, sub_int_seq_no, user_seq_no, ar_type, course, matchctl, ctitle, tflg, creditlim, crsflag, ac, rc, effdte, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, AR_TYPE, COURSE, MATCHCTL, CTITLE, TFLG, CREDITLIM, CRSFLAG, AC, RC, EFFDTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_SUB_REQ_AR";

--set identity_insert sub_req_ar off;

drop table "tmp_SUB_REQ_AR";

create index sub_req_ar_idx on sub_req_ar (
   sub_int_seq_no       ASC,
   ar_type              DESC,
   user_seq_no          ASC
);

create table sub_req_text
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   sub_int_seq_no       NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   srtext_type          CHAR(1),
   text                 VARCHAR(55),
   lokovr1              CHAR(1),
   lnoovr1              CHAR(1),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_12 primary key (int_seq_no)
);

comment on table sub_req_text is
'Sub-requirement Text';

--set identity_insert sub_req_text on;

insert into sub_req_text (int_seq_no, sub_int_seq_no, user_seq_no, srtext_type, text, lokovr1, lnoovr1, last_mod_user, last_mod_date)
select INT_SEQ_NO, SUB_INT_SEQ_NO, USER_SEQ_NO, SRTEXT_TYPE, TEXT, LOKOVR1, LNOOVR1, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_SUB_REQ_TEXT";

--set identity_insert sub_req_text off;

drop table "tmp_SUB_REQ_TEXT";

create index sub_req_text_idx on sub_req_text (
   sub_int_seq_no       ASC,
   srtext_type          ASC,
   user_seq_no          ASC
);

create table tca_master
(
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   source_id            CHAR(8)                not null default ' ',
   source_cd            CHAR(3)                not null default ' ',
   dpmask               CHAR(15)               not null default ' ',
   fyt                  CHAR(6)                not null default '0000',
   lyt                  CHAR(6)                default '9999',
   iname                VARCHAR(60),
   univ_dpmask          CHAR(1),
   dinstid              CHAR(8),
   dinstcd              CHAR(3),
   tastatus             CHAR(1),
   memo                 VARCHAR(255),
   last_mod_date        TIMESTAMP,
   last_mod_user        VARCHAR(30),
   constraint P_Key_24 primary key (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
);

insert into tca_master (instidq, instid, instcd, source_id, source_cd, dpmask, fyt, lyt, iname, univ_dpmask, dinstid, dinstcd, tastatus, memo, last_mod_date, last_mod_user)
select INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, LYT, INAME, UNIV_DPMASK, DINSTID, DINSTCD, TASTATUS, MEMO, LAST_MOD_DATE, LAST_MOD_USER
from "tmp_TCA_MASTER";

drop table "tmp_TCA_MASTER";

create unique index tca_master_idx on tca_master (
   source_id            ASC,
   source_cd            ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   dpmask               ASC,
   fyt                  ASC,
   lyt                  ASC,
   tastatus             ASC
);

create table tca_rule
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   instidq              CHAR(2)                not null default ' ',
   instid               CHAR(8)                not null default ' ',
   instcd               CHAR(3)                not null default ' ',
   source_id            CHAR(8)                not null default ' ',
   source_cd            CHAR(3)                not null default ' ',
   dpmask               CHAR(15)               not null default ' ',
   fyt                  CHAR(6)                not null default '0000',
   tseg                 CHAR(7)                not null default ' ',
   user_seq_no          INTEGER                default 0,
   cond                 CHAR(1),
   limct                NUMERIC(2)             default 0,
   limhrs               NUMERIC(4,2)           default 0,
   ctlcd                CHAR(2),
   ac                   CHAR(1),
   rc                   CHAR(1),
   tastatus             CHAR(1),
   private_note         VARCHAR(255),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_25 primary key (int_seq_no)
);

--set identity_insert tca_rule on;

insert into tca_rule (int_seq_no, instidq, instid, instcd, source_id, source_cd, dpmask, fyt, tseg, user_seq_no, cond, limct, limhrs, ctlcd, ac, rc, tastatus, private_note, memo, last_mod_user, last_mod_date)
select INT_SEQ_NO, INSTIDQ, INSTID, INSTCD, SOURCE_ID, SOURCE_CD, DPMASK, FYT, TSEG, USER_SEQ_NO, COND, LIMCT, LIMHRS, CTLCD, AC, RC, TASTATUS, PRIVATE_NOTE, MEMO, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_TCA_RULE";

--set identity_insert tca_rule off;

drop table "tmp_TCA_RULE";

create index tca_rule_idx on tca_rule (
   source_id            ASC,
   source_cd            ASC,
   instidq              ASC,
   instid               ASC,
   instcd               ASC,
   dpmask               ASC,
   fyt                  ASC,
   tseg                 ASC,
   user_seq_no          ASC,
   tastatus             ASC
);

create table tca_source
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   tca_rule_seq_no      NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   course               CHAR(15),
   pflg                 CHAR(1),
   ctitle               VARCHAR(29),
   tflg                 CHAR(1),
   limhrs               NUMERIC(4,2)           default 0,
   ctlcd                CHAR(2),
   ac                   CHAR(1),
   rc                   CHAR(1),
   cond                 CHAR(1),
   effdte               CHAR(12),
   loweffdte            CHAR(6),
   hieffdte             CHAR(6),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_26 primary key (int_seq_no)
);

--set identity_insert tca_source on;

insert into tca_source (int_seq_no, tca_rule_seq_no, user_seq_no, course, pflg, ctitle, tflg, limhrs, ctlcd, ac, rc, cond, effdte, loweffdte, hieffdte, last_mod_user, last_mod_date)
select INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, CTLCD, AC, RC, COND, EFFDTE, LOWEFFDTE, HIEFFDTE, LAST_MOD_USER, LAST_MOD_DATE
from "tmp_TCA_SOURCE";

--set identity_insert tca_source off;

drop table "tmp_TCA_SOURCE";

create index tca_source_idx on tca_source (
   tca_rule_seq_no      ASC,
   user_seq_no          ASC
);

create table tca_target
(
   int_seq_no           NUMERIC(9)             not null generated by default as identity,
   tca_rule_seq_no      NUMERIC(9)             not null default 0,
   user_seq_no          INTEGER                default 0,
   course               CHAR(15),
   pflg                 CHAR(1),
   ctitle               VARCHAR(29),
   tflg                 CHAR(1),
   limhrs               NUMERIC(4,2)           default 0,
   forcehrs             CHAR(1),
   cond                 CHAR(1),
   iflg1                CHAR(3),
   iflg2                CHAR(3),
   iflg3                CHAR(3),
   iflg4                CHAR(3),
   iflg5                CHAR(3),
   acourse1             CHAR(15),
   apflg1               CHAR(1),
   acourse2             CHAR(15),
   apflg2               CHAR(1),
   acourse3             CHAR(15),
   apflg3               CHAR(1),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   tastatus             CHAR(1),
   constraint P_Key_27 primary key (int_seq_no)
);

--set identity_insert tca_target on;

insert into tca_target (int_seq_no, tca_rule_seq_no, user_seq_no, course, pflg, ctitle, tflg, limhrs, forcehrs, cond, iflg1, iflg2, iflg3, iflg4, iflg5, acourse1, apflg1, acourse2, apflg2, acourse3, apflg3, last_mod_user, last_mod_date, tastatus)
select INT_SEQ_NO, TCA_RULE_SEQ_NO, USER_SEQ_NO, COURSE, PFLG, CTITLE, TFLG, LIMHRS, FORCEHRS, COND, IFLG1, IFLG2, IFLG3, IFLG4, IFLG5, ACOURSE1, APFLG1, ACOURSE2, APFLG2, ACOURSE3, APFLG3, LAST_MOD_USER, LAST_MOD_DATE, TASTATUS
from "tmp_TCA_TARGET";

--set identity_insert tca_target off;

drop table "tmp_TCA_TARGET";

create index tca_target_idx on tca_target (
   tca_rule_seq_no      ASC,
   user_seq_no          ASC
);

create table whatif_courses
(
   stu_mast_no          NUMERIC(9)             not null,
   source_id            CHAR(8)                not null,
   source_cd            CHAR(3)                not null,
   cdpmask              CHAR(15)               not null,
   crs_yt               CHAR(6)                not null,
   crs_num              CHAR(15)               not null,
   crs_seq              CHAR(3)                not null,
   rcredit              NUMERIC(7,5),
   grade                CHAR(4),
   ctitle               VARCHAR(29),
   rtext                CHAR(2),
   cart                 CHAR(1),
   memo                 VARCHAR(255),
   last_mod_user        VARCHAR(30),
   last_mod_date        TIMESTAMP,
   constraint P_Key_1 primary key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
);

create unique index whatif_cart_idx on whatif_courses (
   stu_mast_no          ASC,
   source_id            ASC,
   source_cd            ASC,
   cdpmask              ASC,
   crs_yt               ASC,
   crs_num              ASC,
   crs_seq              ASC,
   cart                 ASC
);

create index whatif_cart2_idx on whatif_courses (
   stu_mast_no          ASC,
   cart                 ASC
);


create view vw_adv_ctlcd as
select adv_id, ctlcd from adv_ctlcd;


create view vw_adv_dprogs as
select adv_id, dprog from adv_dprogs;


create view vw_adv_functions as
select "adv_id", "adv_function", "authority", "instidq", "instid", "instcd"
from "adv_functions";


create view vw_adv_inst as
select
   "adv_id",
   "instidq",
   "instid",
   "instcd"
from
   "adv_inst";


create view vw_adv_master as
select adv_id, pin, encrypted_pin, name, dept, ref_adv_id from adv_master;


create view vw_adv_req as
select adv_id, rname from adv_req;


create view vw_stu_demo as
select "stu_mast_no", "source_id", "stuname", "stuidq", "stuiddesc", "dob", "birthcountry", "birthstate", "birthcounty", "birthcity", "citizenstatus", "citizencountry", "nativelang", "englprof", "marital", "gender", "race", "hsgradtype", "hsgraddate", "hs", "tctlast", "nodflt", "bdverif", "spokeninhome", "correslang", "subnatq", "subnational", "memo", "last_mod_user", "last_mod_date"
from "stu_demo";


create view vw_stu_master as
select "int_seq_no", "instidq", "instid", "stuno", "memo", "last_mod_user", "last_mod_date", "tctlast", "pin", "nodflt", "encrypted_pin" from "stu_master";

alter table adv_ctlcd
   add constraint F_Reference_38 foreign key (adv_id)
      references adv_master (adv_id)
      on delete restrict on update restrict;

alter table adv_dprogs
   add constraint F_Reference_37 foreign key (adv_id)
      references adv_master (adv_id)
      on delete restrict on update restrict;

alter table adv_functions
   add constraint F_Reference_35 foreign key (adv_id)
      references adv_master (adv_id)
      on delete restrict on update restrict;

alter table adv_inst
   add constraint F_Reference_36 foreign key (adv_id)
      references adv_master (adv_id)
      on delete restrict on update restrict;

alter table adv_req
   add constraint F_Reference_39 foreign key (adv_id)
      references adv_master (adv_id)
      on delete restrict on update restrict;

alter table analysis_req
   add constraint fk_anal_2_req foreign key (jobq_seq_no)
      references analysis (int_seq_no)
      on delete restrict on update restrict;

alter table analysis_courses
   add constraint fk_anal_req_2_crs foreign key (jobq_seq_no)
      references analysis_req (int_seq_no)
      on delete restrict on update restrict;

alter table dprog_req
   add constraint F_relation_183 foreign key (instidq, instid, instcd, dprog, dpfyt)
      references dprog (instidq, instid, instcd, dprog, dpfyt)
      on delete restrict on update restrict;

alter table job_queue_accept
   add constraint F_Reference_43 foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
      on delete restrict on update restrict;

alter table job_queue_course
   add constraint FK_JOBQ_CRS_REF_JOBQ_SUBREQ foreign key (jobq_seq_no, rtabx, stabx)
      references job_queue_subreq (jobq_seq_no, rtabx, stabx)
      on delete restrict on update restrict;

alter table job_queue_detail
   add constraint F_relation_4493 foreign key (instidq, instid, instcd, jobid, userid)
      references job_queue_list (instidq, instid, instcd, jobid, userid)
      on delete restrict on update restrict;

alter table job_queue_sysin
   add constraint F_ref_56906 foreign key (instidq, instid, instcd, jobid, userid)
      references job_queue_list (instidq, instid, instcd, jobid, userid)
      on delete restrict on update restrict;

alter table job_queue_out
   add constraint FK_JOBQ_OUT_REF_JOBQ_RUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
      on delete restrict on update restrict;

alter table job_queue_req
   add constraint FK_JOBQ_REQ_REF_JOBQ_RUN foreign key (jobq_seq_no)
      references job_queue_run (int_seq_no)
      on delete restrict on update restrict;

alter table job_queue_subreq
   add constraint FK_JOBQ_SUBREQ_REF_JOBQ_REQ foreign key (jobq_seq_no, rtabx)
      references job_queue_req (jobq_seq_no, rtabx)
      on delete restrict on update restrict;

alter table mastref_seg
   add constraint F_ref_15108 foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
      on delete restrict on update restrict;

alter table mastref_address
   add constraint F_ref_16608 foreign key (instidq, instid, instcd, source_id, source_cd, mrfyt)
      references mastref (instidq, instid, instcd, source_id, source_cd, mrfyt)
      on delete restrict on update restrict;

alter table sub_req
   add constraint F_relation_2577 foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
      on delete restrict on update restrict;

alter table req_text
   add constraint F_relation_2589 foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
      on delete restrict on update restrict;

alter table req_xy
   add constraint F_relation_2607 foreign key (instidq, instid, instcd, rname, rqfyt)
      references req_main (instidq, instid, instcd, rname, rqfyt)
      on delete restrict on update restrict;

alter table secure_import
   add constraint fk_simp_2_smast foreign key (userid)
      references secure_master (userid)
      on delete restrict on update restrict;

alter table secure_inst
   add constraint fk_sinst_2_smast foreign key (userid)
      references secure_master (userid)
      on delete restrict on update restrict;

alter table string_crse
   add constraint F_relation_1118 foreign key (str_int_seq_no)
      references string (int_seq_no)
      on delete restrict on update restrict;

alter table stu_acadrec
   add constraint F_ref_23073 foreign key (stu_mast_no)
      references stu_master (int_seq_no)
      on delete restrict on update restrict;

alter table stu_egrp_courses
   add constraint F_ref_46007 foreign key (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
      references stu_acadrec (stu_mast_no, source_id, source_cd, cdpmask, crs_yt, crs_num, crs_seq)
      on delete restrict on update restrict;

alter table stu_address
   add constraint F_ref_12130 foreign key (stu_mast_no, source_id)
      references stu_demo (stu_mast_no, source_id)
      on delete restrict on update restrict;

alter table stu_demo
   add constraint F_ref_23034 foreign key (stu_mast_no)
      references stu_master (int_seq_no)
      on delete restrict on update restrict;

alter table stu_dprog
   add constraint F_ref_23053 foreign key (stu_mast_no)
      references stu_master (int_seq_no)
      on delete restrict on update restrict;

alter table stu_marker_req
   add constraint F_relation_3307 foreign key (stu_mast_no, instcd, dprog)
      references stu_dprog (stu_mast_no, instcd, dprog)
      on delete restrict on update restrict;

alter table stu_egrp_courses
   add constraint fk_egrp_2_egrp_crs foreign key (stu_mast_no, evalgrp)
      references stu_evalgrp (stu_mast_no, evalgrp)
      on delete restrict on update restrict;

alter table stu_evalgrp
   add constraint fk_stu_eval_2_mast foreign key (stu_mast_no)
      references stu_master (int_seq_no)
      on delete restrict on update restrict;

alter table stu_exc_courses
   add constraint F_ref_14062 foreign key (stu_int_seq_no)
      references stu_exceptions (int_seq_no)
      on delete restrict on update restrict;

alter table stu_exceptions
   add constraint F_ref_23068 foreign key (stu_mast_no)
      references stu_master (int_seq_no)
      on delete restrict on update restrict;

alter table stu_trans_degree
   add constraint F_ref_23058 foreign key (stu_mast_no)
      references stu_master (int_seq_no)
      on delete restrict on update restrict;

alter table sub_req_ar
   add constraint sreq_to_sreq_ar foreign key (sub_int_seq_no)
      references sub_req (int_seq_no)
      on delete restrict on update restrict;

alter table sub_req_text
   add constraint sreq_to_sreq_text foreign key (sub_int_seq_no)
      references sub_req (int_seq_no)
      on delete restrict on update restrict;

alter table tca_rule
   add constraint F_ref_10199 foreign key (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
      references tca_master (instidq, instid, instcd, source_id, source_cd, dpmask, fyt)
      on delete restrict on update restrict;

alter table tca_source
   add constraint F_ref_11057 foreign key (tca_rule_seq_no)
      references tca_rule (int_seq_no)
      on delete restrict on update restrict;

alter table tca_target
   add constraint F_ref_11060 foreign key (tca_rule_seq_no)
      references tca_rule (int_seq_no)
      on delete restrict on update restrict;

