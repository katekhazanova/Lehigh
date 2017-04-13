
set statistics io on
set showplan on
go

select  crs_yt, crs_num, a.section, rcredit, grade,
        rtext, condc, cline, xcourse, ctitle, ecredit,
        gpahrs, gpapts, linkno, source_id,
        source_cd, crs_seq, pflg, xpflg, evalflg,
        cdpmask, bacc, actc, agclc, honors,
        repeatf, iflg1, iflg2, iflg3, iflg4, iflg5,
        acourse1, apflg1, acourse2,
        apflg2, acourse3, apflg3,
        rtitle, gradeq, stu_mast_no
from    stu_acadrec a
where   stu_mast_no = @stu_mast_no and
        certify not in ('P') and
        ( (evalflg <> 'E' and
           ( (source_id like '%%%%%%%%' and
              source_cd like '%%%') or
             (source_id = @instid and
              source_cd = @instcd)
           ) and
             (source_id + source_cd + cdpmask +
              crs_yt + crs_num + crs_seq) not in
                 (select (c.source_id  + c.source_cd +
                          c.cdpmask + c.crs_yt +
                          c.crs_num + c.crs_seq)
                  from stu_egrp_courses c, stu_evalgrp e
                  where e.stu_mast_no = c.stu_mast_no and
                        e.evalgrp = c.evalgrp and
                        e.stu_mast_no = @stu_mast_no and
                        e.instcd = @instcd and
                        e.dpmask = '               ')
                  ) or
                    (evalflg = 'E' and
                     source_id = @instid and
                     source_cd = @instcd and
                     cdpmask = '               ')
               )
order by stu_mast_no, source_id, source_cd, cdpmask,
         crs_yt, crs_num, crs_seq


set statistics io off
set showplan off
go			  
