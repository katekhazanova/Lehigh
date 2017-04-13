select prod_os, test_os from tech_survey
order by prod_os, test_os
compute count(prod_os) by prod_os
