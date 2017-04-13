select Future_OS = 
	CASE test_os
		when 'no answer' then prod_os
		when 'no migration' then prod_os
		else test_os
	end,
	prod_os 
from tech_survey
order by Future_OS, prod_os
compute count(prod_os) by Future_OS
