-- ###
-- Must use statement terminator @
-- ###

/*=================================================================*/
/* Release:        u.achieve 4.3                                   */
/* DBMS name:      DB2 LUW                                         */
/* Created on:     09/10/2015                                      */
/*                                                                 */
/* Purpose:        Database Modification Script to update          */
/*                 identity column 'next' values                   */
/*                                                                 */
/*=================================================================*/
/* Notes	                                                       */
/*                                                                 */
/* 1) Must set statement terminator to @ for this script.          */
/* 2) Procedure based on http://www.zinox.com/archives/163         */ 
/*                                                                 */
/*  Copyright(c) 2015 CollegeSource, Inc. All Rights Reserved.     */
/*=================================================================*/


-- define procedure to update identity column start values

CREATE PROCEDURE RESET_IDENTITY_START_VALUE
(
    IN schemaName VARCHAR(64), 
    IN tableName VARCHAR(64)
)
BEGIN

   DECLARE maxVal		NUMERIC(18);
   DECLARE maxStmt		VARCHAR(1000);
   DECLARE alterStmt	VARCHAR(1000);

   DECLARE s STATEMENT;
   DECLARE cur CURSOR FOR s;

   SET maxStmt = 'SELECT MAX(int_seq_no) FROM "' || schemaName || '"."' || tableName || '"';
   PREPARE s FROM maxStmt;
   
   -- Even though we only expect 1 result, need cursor so result can be assigned to maxVal
   SET maxVal = 0;
   OPEN cur;
      FETCH cur INTO maxVal;
   CLOSE cur;
   
   IF maxVal IS NULL THEN 
      SET maxVal = 0; 
   END IF;
   
   SET alterStmt = 'ALTER TABLE "' || schemaName || '"."' || tableName ||
           			'" ALTER COLUMN int_seq_no RESTART WITH ' || CHAR(maxVal + 1);
           
   EXECUTE IMMEDIATE alterStmt;
END
@


---- Call procedure to update start value of identity columns
--
---- AUDIT REQUEST TABLES
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_DETAIL')
@
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_SYSIN')
@

-- AUDIT OUTPUT TABLES
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_RUN')
@

CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_REPORT')
@
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_OUT')
@
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_MARKERS')
@
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_EXCEPTIONS')
@
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_INCL_TEXT')
@

CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_COURSE')
@
CALL RESET_IDENTITY_START_VALUE('UA43_UPDATE', 'JOB_QUEUE_ACCEPT')
@

---- Done!  remove procedure from schema
DROP PROCEDURE RESET_IDENTITY_START_VALUE( VARCHAR(64), VARCHAR(64) )
@

