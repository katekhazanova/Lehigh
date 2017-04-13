select Future_DB = 
	CASE test_db
		when 'no answer' then prod_db
		when 'no migration' then prod_db
		else test_db
	end, prod_db
from tech_survey
order by Future_DB
compute count(prod_db) by Future_DB
