select instidq, instid, instcd, rname "ReqName", rqfyt "FYT",  
	   ac1, ac2, ac3, ac4, ac5, rc1, rc2, rc3, rc4, rc5, conda, condr, 
	   ctcond0, ctcond1, ctcond2, ctcond3, ctcond4, ctcond5, ctcond6, ctcond7,
	   ctcond8, ctcond9, ctcond10, ctcond11, ctcond12, ctcond13, ctcond14
from   sub_req
where (ac1 != ' ' and ac1 is not null) or
	  (ac2 != ' ' and ac2 is not null)or
  	  (ac3 != ' ' and ac2 is not null)or
  	  (ac4 != ' ' and ac2 is not null)or
  	  (ac5 != ' ' and ac2 is not null)or
	  (rc1 != ' ' and rc1 is not null) or
	  (rc2 != ' ' and rc2 is not null) or
	  (rc3 != ' ' and rc1 is not null) or
	  (rc4 != ' ' and rc2 is not null) or
	  (rc5 != ' ' and rc1 is not null) or
	  (conda != ' ' and conda is not null) or
	  (condr != ' ' and condr is not null) or
	  (ctcond0 != ' ' and ctcond0 is not null) or
  	  (ctcond1 != ' ' and ctcond1 is not null) or
	  (ctcond2 != ' ' and ctcond2 is not null) or
	  (ctcond3 != ' ' and ctcond3 is not null) or
	  (ctcond4 != ' ' and ctcond4 is not null) or
	  (ctcond5 != ' ' and ctcond5 is not null) or
	  (ctcond6 != ' ' and ctcond6 is not null) or
	  (ctcond7 != ' ' and ctcond7 is not null) or
	  (ctcond8 != ' ' and ctcond8 is not null) or
	  (ctcond9 != ' ' and ctcond9 is not null) or
	  (ctcond10 != ' ' and ctcond10 is not null) or
	  (ctcond11 != ' ' and ctcond11 is not null) or
	  (ctcond12 != ' ' and ctcond12 is not null) or
	  (ctcond13 != ' ' and ctcond13 is not null) or
	  (ctcond14 != ' ' and ctcond14 is not null) 
order by ac1, ac2, rc1, rc2, conda, condr, 
	     instidq, instid, instcd, rname, rqfyt
	  