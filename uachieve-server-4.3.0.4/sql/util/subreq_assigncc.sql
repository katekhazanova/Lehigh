select instidq, instid, instcd, rname "ReqName", rqfyt "FYT", user_seq_no "Sub Req #", 
	   actl, assignc, actlx, assigncx, assignc2, assignm
from   sub_req
where (assignc != ' ' and assignc is not null) or
	  (assigncx != ' ' and assigncx is not null) or
	  (assignc2 != ' ' and assignc2 is not null) or
	  (assignm != ' ' and assignm is not null)
order by assignc, assignc2, assigncx, assignm, instidq, instid, instcd, rname, rqfyt