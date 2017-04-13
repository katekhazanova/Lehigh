<#-- prints out the html for the nice looking table -->
<#macro fancyTable title id="" class="">
	<table class="fancytable ${class}" <#if id??>id="${id}"</#if>><tr>
	<#--td class="tl"></td><td class="tm">${title}</td><td class="tr"></td -->
	<td class="gradientHeader" colspan="3">${title}</td>
	</tr><tr><td class="ml"></td><td class="mm">
	<#nested />
	</td><td class="mr"></td></tr><tr><td class="bl"></td><td class="bm"></td><td class="br"></td></tr></table>
</#macro>

<#macro plainTable id="">
	<table class="fancytable" <#if id??>id="${id}"</#if>><tr><td></td><td>
	<#nested />
	</td><td></td></tr><tr><td></td><td></td><td></td></tr></table>
</#macro>

<#-- Sets up the title and head content for the @body macro.  Make sure 
	this macro is called before @body. -->
<#macro head title>
	<#assign title=title />
	<#assign head><#nested /></#assign>
</#macro>


<#-- Prints the layout for a page. -->
<#macro body hideMenu=false hideFooter=false autoScroll=false>
	<#include "doctype.ftl" />
	<html lang="en-US">
	<head>
		<#include "head.ftl" />
		${head}
	</head>
	<#if autoScroll>
		<body onScroll="document.cookie='ypos=' + window.pageYOffset" onLoad="window.scrollTo(0,readCookie('ypos'))">
	<#else>
		<body>
	</#if>
	<!-- menu -->
			<#if !hideMenu>
				<#include "menu.ftl" />
			</#if>
			
		<div class="container" style="margin-top: 20px;" id="main" role="main">					

			
			<!-- body -->		
			<div>
				<#nested />
			</div>

		</div>
		
		<!-- footer -->
			<#if !hideFooter>
				<#include "footer.ftl" />
			</#if>
	</body>
	</html>
</#macro>