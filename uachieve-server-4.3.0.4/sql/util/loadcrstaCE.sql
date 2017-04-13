                select  a.*
                from stu_acadrec a
                where a.stu_mast_no = :ws-stumastno and
   				 	 (
-- original source courses not in an existing, matching evalgrp						
                      (a.source_id like :ws-force-sid and
                       a.source_cd like :ws-force-scd and
					   a.evalflg not in ('D', 'E') and 
                          not exists (select null
                              from stu_egrp_courses c, stu_evalgrp e
							  where c.stu_mast_no = a.stu_mast_no and
								 c.source_id = a.source_id and
								 c.source_cd = a.source_cd and
					 			 c.cdpmask = a.cdpmask and
 					 		 	 c.crs_yt = a.crs_yt and
					 			 c.crs_num = a.crs_num and
					 			 c.crs_seq = a.crs_seq and
					 			 c.stu_mast_no = e.stu_mast_no and
					 			 c.evalgrp = e.evalgrp and                                 
								 e.instcd = :ws-instcd and
								 e.dpmask = :ws-dpmask )
						) 
					or
					    (
-- home courses
						   (a.source_id = :ws-instid and a.source_cd in (:ws-instcd,:ws-hinstcd)) and  
-- 		original
						   (a.evalflg not in ('E', 'D') and a.cdpmask = '               ') 

				           or
-- 		evaluated coures from evalgrps where certify <> P
				           (a.evalflg = 'E' and a.cdpmask = :ws-dpmask and exists 
					          (select null
                               from stu_egrp_courses c, stu_evalgrp e
		        			   where c.stu_mast_no = a.stu_mast_no and
							         c.source_id = a.source_id and
      						         c.source_cd = a.source_cd and
					 		         c.cdpmask = a.cdpmask and
					 		         c.crs_num = a.crs_num and
					 		         c.crs_seq = a.crs_seq and
					 		         c.stu_mast_no = e.stu_mast_no and
					 		         c.evalgrp = e.evalgrp and
							         e.instcd = :ws-instcd and  
                                     e.dpmask = :ws-dpmask and
							         e.certify <> 'P')
							)
						)
					) 

              order by stu_mast_no, source_id, source_cd, cdpmask,
                      crs_yt, crs_num, crs_seq
