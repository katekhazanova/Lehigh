
select "stu_egrp_courses with like statement"
select " " 

set statistics io on
set showplan on
go

select * from stu_egrp_courses
   where stu_mast_no = @stu_mast_no
   and evalgrp in
      (select evalgrp from stu_evalgrp
           where stu_mast_no = @stu_mast_no
           and instcd = @instcd
           and dpmask = '               '
           and source_id like '%%%%%%%%'
           and source_cd like '%%%' 
		   and evallock <> 'L')
go

set statistics io off
set showplan off
go			  

select "stu_egrp_courses without like statement"
set statistics io on
set showplan on
go
					  
select * from stu_egrp_courses
   where stu_mast_no = @stu_mast_no
   and evalgrp in
      (select evalgrp from stu_evalgrp
              where stu_mast_no = @stu_mast_no
              and instcd = @instcd
              and dpmask = '               '
    		  and evallock <> 'L')
go

set statistics io off
set showplan off
go			  
