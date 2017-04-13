/*==============================================================*/
/* Database name:  u.achieve 4.0                                */
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     9/29/2011 1:36:22 PM                         */
/*==============================================================*/

/* 
   Previous versions of u.achieve Server converted null values in sub_req.skipbct to -1
   and then saved the -1 back to the database table.  Saving the data was not intended,
   and the save has been removed from the Server.  This script resets -1 skipbct values
   back to null.
   
   This issue has no effect on audit results, but a -1 value is not represented well
   in the u.achieve Client.
   
*/

update sub_req
set skipbct = null
where skipbct = -1
/

-- removed TIB_SUB_REQ because it was bad, is now fixed in 4.0.14 script

--  UPDATE WITH last_mod_user, date
--  Before update trigger "tub_sub_req" for table "sub_req"
CREATE OR REPLACE TRIGGER TUB_SUB_REQ before update 
on sub_req for each row 
 
begin 
--  update "Last Saved" information 
IF TRIM(:new.last_mod_user) IS NULL THEN
	:new.last_mod_user := user;
END IF;
IF TRIM(:new.last_mod_date) IS NULL THEN   
	:new.last_mod_date := sysdate;
END IF;
 
end;
/