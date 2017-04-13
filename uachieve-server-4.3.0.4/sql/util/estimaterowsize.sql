
ACCEPT table PROMPT "Table name? "

SET head OFF
SET verify OFF
SET feedback OFF
SET newpage 0
SET pagesize 0

SPOOL temp.sql
PROMPT SELECT AVG(

SELECT 'NVL(VSIZE('||LOWER(column_name)||'),0) +'
FROM   user_tab_columns
WHERE  table_name = UPPER('&&table')
/
PROMPT 0) "Average Row Size"
PROMPT FROM &&table
PROMPT /
SPOOL OFF

SET head ON
SET verify ON
SET feedback ON
SET newpage 1
SET pagesize 15
START temp.sql
HOST rm temp.sql;

