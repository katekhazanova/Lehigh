select m.stuno, m.instidq, m.instid, 
       e.stu_mast_no, e.evalgrp, e.instcd, e.dpmask, e.source_id, e.source_cd, e.evallock, e.certify
from stu_master m, stu_evalgrp e
where m.int_seq_no = e.stu_mast_no 
  and m.stuno = 'TEST'
