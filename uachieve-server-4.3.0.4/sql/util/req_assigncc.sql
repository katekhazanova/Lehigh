select instidq, instid, instcd, rname "ReqName", rqfyt "FYT",  
	   ractl, assignc, assignc2
from   req_main
where (assignc != ' ' and assignc is not null) or
	(assignc2 != ' ' and assignc2 is not null)
order by assignc, assignc2, instidq, instid, instcd, rname, rqfyt
	  