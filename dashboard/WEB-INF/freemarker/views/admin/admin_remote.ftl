
<#include "admin_top.ftl">
	
	<h1 id="pagetitle" tabindex="0">Remote</h1>
	<br />
	<form name ="updateGeneral" class="form-horizontal" role="form" action="admin_remote.html" method="POST" >
	
		<@d.inputRow name="regURL" label="Registration System Link" max="200" value=admin_regURL />
		<@d.inputRow name="udirectURL" label="u.direct Link" max="200" value=admin_udirectURL />
		<@d.inputRow name="selfserviceURL" label="Self-Service Link" max="200" value=admin_selfserviceURL />
		<@d.inputRow name="helpURL" label="Help Link" max="200" value=admin_helpURL />
		<@d.inputRow name="dashboardURL" label="Dashboard Link " max="200" value=admin_dashboardURL />
		<@d.inputRow name="cDepartmentPrefix" label="SIS Course Department Prefix" max="10" value=cDepartmentPrefix tooltip=true />
		<@d.inputRow name="cDepartmentSuffix" label="SIS Course Department Suffix" max="10" value=cDepartmentSuffix tooltip=true />
		<@d.inputRow name="cNumberPrefix" label="SIS Course Number Prefix" max="10" value=cNumberPrefix tooltip=true />
		<@d.inputRow name="cNumberSuffix" label="SIS Course Number Suffix" max="10" value=cNumberSuffix tooltip=true />
		<@d.submitButtons />
	</form>

	
	<div id="filler_bot">
	</div>

<#include "admin_bot.ftl">