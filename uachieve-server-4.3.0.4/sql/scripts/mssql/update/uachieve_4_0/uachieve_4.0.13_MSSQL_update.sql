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

go