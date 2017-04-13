update sub_req_ar
set course = substring(course, 1, 3) + ' ' + substring(course, 4, 10)
where (matchctl is null or matchctl not in ('$', 'N'))
and substring(course, 1,1) not in ('%', '*')
and sub_int_seq_no in (
	  select int_seq_no
	  from sub_req
	  where instidq = '73' 
	  and instid = '002984')
