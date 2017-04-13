<!DOCTYPE html>
<html lang="en-US">
	<head>	
		<#assign jawr=JspTaglibs["/WEB-INF/tlds/jawr.tld"]>
		<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
		
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
		<@jawr.style src="/bundles/yui.css" media="all" />
		<@jawr.style src="/bundles/bootstrap.css" media="all" />
		<@jawr.style src="/bundles/fontawesome.css" media="all"  />
		<@jawr.style src="/bundles/dashboard.css" media="all"  />
		<@jawr.style src="/bundles/default.css" title="default" media="all"  />
		<@jawr.style src="/bundles/highcontrast.css" title="highcontrast" media="all"  />
		<@jawr.style src="/bundles/common.css" media="all"  />
		<@jawr.script src="/bundles/bootstrap.js" />
		<@jawr.script src="/bundles/accessibility.js" />
		<@jawr.script src="/bundles/dashboard.js" />
		<@jawr.script src="/bundles/jquery.js"/>
		<@jawr.script src="/bundles/yui.js" />
		<@jawr.script src="/bundles/switcher.js" />
		<!--[if lt IE 9]>
          <@jawr.script src="/bundles/respond.js" />
        <![endif]-->
			
		<title>${title}</title>
		<link rel="icon" type="image/ico" href="<@spring.url relativeUrl="/images/favicon.ico" />"/>
		
		
		<script type="text/javascript"> if (top.frames.length!=0) top.location=self.document.location; </script>
		
		
		${head}
	</head>
	<body class="yui-skin-sam">
				
			<#assign admin_gen_url><@spring.url relativeUrl="/admin/admin_general"/></#assign>
			<#assign admin_sched_url><@spring.url relativeUrl="/admin/admin_schedule"/></#assign>
			<#assign admin_home_url><@spring.url relativeUrl="/admin/admin_Home"/></#assign>
			<#assign admin_index_url><@spring.url relativeUrl="/admin/index_home"/></#assign>
			<#assign admin_remote_url><@spring.url relativeUrl="/admin/admin_remote"/></#assign>
			
			
		<ul class="skiplist dontprint">
			<li class="skip"><a href="#main" id="skpnav" role="link">Skip navigation links.</a></li>
		</ul>
		
	<@security.authorize ifAnyGranted="SEC_Advisees=r,SEC_Domains=r,SEC_Users=r,SEC_Roles=r,SEC_Group_Members=r,SEC_Groups=r,
			UDIR_Roadmaps=r, UDIR_Plans=r, UDIR_Advisor=r,UDIR_Publisher=r,SS_ROLE_ANONYMOUS=r, SS_ROLE_USER=r,DASH_Reports=r,UDIR_Admin=r, SB_ADMIN_EDIT=r">
		
		
		<header role="banner" class="hidden-print">
			<div id="header" class="hidden-xs hidden-sm">
				<div id="headerLogo" class=" first">
					<#include "/includes/header.ftl" />	
				</div>
				<div id="headerInfo" class="pull-right">
					<span class="pull-right">${userFullName!''}</span>
					<#if !page.properties["meta.view"]??>
					<br/>
					<br/>
					<br/>
						<span class="pull-right">
							<#include "/includes/themebuttons.ftl" />
						</span>
					</#if>
				</div>	
			</div>
			<#if !page.properties["meta.view"]??>
				<#include "/includes/menu.ftl" />
			</#if>
		</header>
	</@security.authorize>
		
		
		<@security.authorize ifNoneGranted="SEC_Advisees=r,SEC_Domains=r,SEC_Users=r,SEC_Roles=r,SEC_Group_Members=r,SEC_Groups=r,
			UDIR_Roadmaps=r, UDIR_Plans=r, UDIR_Advisor=r,UDIR_Publisher=r,SS_ROLE_ANONYMOUS=r, SS_ROLE_USER=r,DASH_Reports=r,UDIR_Admin=r,SB_ADMIN_EDIT=r">
		<header role="banner" class="hidden-print">
			<div id="header" class="hidden-xs hidden-sm">
				<div id="headerLogo" class=" first">
					<#include "/includes/header.ftl" />	
				</div>
			</div>
			<nav class="navbar navbar-default main-menu" >
				&nbsp;
			</nav>
		</header>
		</@security.authorize>
			
			
			
			
			
		
			<div class="container" style="margin-top: 20px;" id="main" role="main">				
				<div>
				${body}
				</div>
			</div>
				<#include "/includes/footer.ftl" />	
			
	</body>
</html>