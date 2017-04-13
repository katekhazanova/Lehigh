
<#include "admin_top.ftl">
	
	<h1 id="pagetitle" tabindex="0">Remote</h1>
	<br />
	<form name ="updateGeneral" class="form-horizontal" role="form" action="admin_remote.html" method="POST" >
	
		<@d.inputRowAdminCheck name="regURL" label="Registration System Link" max="200" value=admin_regURL />
		<@d.inputRowAdminCheck name="udirectURL" label="u.direct Link" max="200" value=admin_udirectURL />
		<@d.inputRowAdminCheck name="selfserviceURL" label="Self-Service Link" max="200" value=admin_selfserviceURL />
		<@d.inputRowAdminCheck name="helpURL" label="Help Link" max="200" value=admin_helpURL />
		<@d.inputRowAdminCheck name="dashboardURL" label="Dashboard Link " max="200" value=admin_dashboardURL />
		<@d.inputRowAdminCheck name="cDepartmentPrefix" label="SIS Course Department Prefix" max="10" value=cDepartmentPrefix tooltip=true />
		<@d.inputRowAdminCheck name="cDepartmentSuffix" label="SIS Course Department Suffix" max="10" value=cDepartmentSuffix tooltip=true />
		<@d.inputRowAdminCheck name="cNumberPrefix" label="SIS Course Number Prefix" max="10" value=cNumberPrefix tooltip=true />
		<@d.inputRowAdminCheck name="cNumberSuffix" label="SIS Course Number Suffix" max="10" value=cNumberSuffix tooltip=true />
		<@security.authorize ifAnyGranted="SB_ADMIN_EDIT=u ">
			<@d.submitButtons />
		</@security.authorize>
	</form>

	
	<div id="filler_bot">
	</div>

<#include "admin_bot.ftl">