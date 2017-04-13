select instidq, instid, instcd, rname "ReqName", rqfyt "FYT",  
	   ac1, ac2, rc1, rc2, rconda, rcondr
from   req_main
where (ac1 != ' ' and ac1 is not null) or
	  (ac2 != ' ' and ac2 is not null)or
	  (rc1 != ' ' and rc1 is not null) or
	  (rc2 != ' ' and rc2 is not null) or
	  (rconda != ' ' and rconda is not null) or
	  (rcondr != ' ' and rcondr is not null) 
order by ac1, ac2, rc1, rc2, rconda, rcondr, instidq, instid, instcd, rname, rqfyt
	  