select distinct comkey, count(*)
from com
group by comkey;

select distinct instidq || instid || instcd as "Cond Codes", comkey, count(*)
from cond_codes
group by instidq, instid, instcd, comkey;

select distinct instidq || instid || instcd as "course_bank", count(*)
from course_bank
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "string", count(*)
from string
group by instidq, instid, instcd;

select distinct s.instidq || s.instid || s.instcd as "string_course", count(s.instid)
from string_crse sc, string s
where sc.str_int_seq_no = s.int_seq_no
group by s.instidq, s.instid, s.instcd;

select distinct instidq || instid || instcd as "Gmaster", count(*)
from gmaster
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "repeat", count(*)
from repeat
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "Convert", count(*)
from crs_convert
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "dprog", count(*)
from dprog
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "dprog_req", count(*)
from dprog_req
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "req_main", count(*)
from req_main
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "req_text", count(*)
from req_text
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "req_xy", count(*)
from req_xy
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "sub_req", count(*)
from sub_req
group by instidq, instid, instcd;

select distinct sr.instidq || sr.instid || sr.instcd as "sub_req_text", count(srt.text)
from sub_req sr, sub_req_text srt
where sr.int_seq_no = srt.sub_int_seq_no
group by sr.instidq, sr.instid, sr.instcd;

select distinct sr.instidq || sr.instid || sr.instcd as "sub_req_ar", count(sra.int_seq_no)
from sub_req sr, sub_req_ar sra
where sr.int_seq_no = sra.sub_int_seq_no
group by sr.instidq, sr.instid, sr.instcd;

select distinct instidq || instid || instcd as "mastref", count(*)
from mastref
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "mastref_seg", count(*)
from mastref_seg
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "mastref_address", count(*)
from mastref_address
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "tca_master", count(*)
from tca_master
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "tca_rule", count(*)
from tca_rule
group by instidq, instid, instcd;

select distinct tr.instidq || tr.instid || tr.instcd as "tca_target", count(tt.int_seq_no)
from tca_rule tr, tca_target tt
where tr.int_seq_no = tt.tca_rule_seq_no
group by tr.instidq, tr.instid, tr.instcd;

select distinct tr.instidq || tr.instid || tr.instcd as "tca_source", count(ts.int_seq_no)
from tca_rule tr, tca_source ts
where tr.int_seq_no = ts.tca_rule_seq_no
group by tr.instidq, tr.instid, tr.instcd;

select distinct instidq || instid  as "stu_master", count(*)
from stu_master
group by instidq, instid;

select distinct sm.instidq || sm.instid as "stu_demo", count(child.stu_mast_no)
from stu_master sm, stu_demo child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_address", count(child.stu_mast_no)
from stu_master sm, stu_address child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_trans_degree", count(child.stu_mast_no)
from stu_master sm, stu_trans_degree child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_exceptions", count(child.stu_mast_no)
from stu_master sm, stu_exceptions child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_dprog", count(child.stu_mast_no)
from stu_master sm, stu_dprog child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_marker", count(child.stu_mast_no)
from stu_master sm, stu_marker_req child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_acadrec", count(child.stu_mast_no)
from stu_master sm, stu_acadrec child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_evalgrp", count(child.stu_mast_no)
from stu_master sm, stu_evalgrp child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct sm.instidq || sm.instid as "stu_egrp_courses", count(child.stu_mast_no)
from stu_master sm, stu_egrp_courses child
where sm.int_seq_no = child.stu_mast_no
group by sm.instidq, sm.instid;

select distinct instidq || instid || instcd as "job_queue_list", count(*)
from job_queue_list
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "job_queue_detail", count(*)
from job_queue_detail
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "job_queue_sysin", count(*)
from job_queue_sysin
group by instidq, instid, instcd;

select distinct instidq || instid || instcd as "job_queue_run", count(*)
from job_queue_run
group by instidq, instid, instcd;

select distinct jr.instidq || jr.instid || jr.instcd as "job_queue_out", count(jo.int_seq_no)
from job_queue_run jr, job_queue_out jo
where jr.int_seq_no = jo.jobq_seq_no
group by jr.instidq, jr.instid, jr.instcd;

