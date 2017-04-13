select  *
from stu_acadrec a
where stu_mast_no = 7500318 and
--original home courses
      source_id = 'MIAMI' and
      source_cd in ('ISF', ' ') and
     ((evalflg not in ('E', 'D') and 
	   cdpmask = '               ') 
	   or
-- evaluated courses from evalgrps where certify <> P
      (evalflg = 'E' and 
	   cdpmask = 'DALE' and 
	   exists (select null 
	  		   from stu_egrp_courses c, stu_evalgrp e
	           where c.stu_mast_no = a.stu_mast_no and
					 c.source_id = a.source_id and
					 c.source_cd = a.source_cd and
					 c.cdpmask = a.cdpmask and
					 c.crs_num = a.crs_num and
					 c.crs_seq = a.crs_seq and
					 c.stu_mast_no = e.stu_mast_no and
					 c.evalgrp = e.evalgrp and
					 e.instcd = 'ISF' and 
					 e.dpmask = 'DALE' and 
					 e.certify <> 'P')))
