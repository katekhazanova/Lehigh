<#macro url href><@s.url href /></#macro>
<#macro link href title="" target="_self" class="" role="" span=""><a href="<@s.url href />" class="${class}" title="${title}" alt="${title}" target="${target}" role="${role}">${title} ${span}</a></#macro>
<#macro img src title="" class="" id=""><img <#if id??>id="${id}"</#if> src="<@s.url src />" alt="${title}" title="${title}" class="${class}" /></#macro>
<#macro fa class="" title="" id=""><i <#if id??>id="${id}"</#if> title="${title}" class="${class}" ></i></#macro>
<#macro imgClick src title="" class="" alt="" onclick=""><img src="<@s.url src />" alt="${alt}" class="${class}" title="${title}" onclick="${onclick}"/></#macro>
<#macro css href><link rel="stylesheet" type="text/css" href="<@s.url href />" /></#macro>
<#macro script href><script type="text/javascript" src="<@s.url href />"></script></#macro>
<#macro imgLink src href title="" class="" onclick="" alt=""><a href="<@s.url href />" title="${title}" alt="${alt}"onclick=${onclick}><@img src=src title=title class=class /></a></#macro>

<#macro submit src title>
	<input type="submit" class="btn btn-primary" src="<@s.url />${src}" alt="${title}" value="${title}" />
</#macro>

<#macro buttonAsLink src href title class="" onclick="" id="">
	<a id="${id}" href="<@s.url />${href}" class="btn btn-primary" role="button" <#if onclick !="">onclick="${onclick}"</#if> style="font-style: normal;">${title}</a>
	<#-- <a id="${id}" href="<@s.url />${href}" <#if class !="">class="${class}"</#if> <#if onclick !="">onclick="${onclick}"</#if>><img class="button" src="<@s.url />${src}" alt="${title}" /></a> -->
</#macro>

<#-- helps with alternating the colors of table rows -->
<#function altcolor>
	<#if color?? && color="">
		<#assign color="tablelist-alt" />
	<#else>
		<#assign color = "" />
	</#if>
	<#return color />
</#function>


<#macro statusLegend>
	<div class="row hidden-xs">
		<div class="well col-md-3 col-sm-3">
			<h2 style="margin-top: 0px;">Legend</h2>
			<ul class="list-unstyled">
				<li>
					<span class="statusOK legend_status" style="float: left;" title="Requirement/Sub-Requirement Complete">
						<i class="fa fa-statusOK"><span class="sr-only">Requirement/Sub-Requirement Complete Image</span></i>
					</span>  - Complete
				</li>
				
				<li>
					<span class="statusPL legend_status" style="float: left;" title="Requirement/Sub-Requirement Complete with Planned Courses">
						<i class="fa fa-statusPL"><span class="sr-only">Requirement/Sub-Requirement Complete with Planned Courses Image</span></i> 
					</span> - Planned
				</li> 
			
				<li>
					<span class="statusIP legend_status" style="float: left;" title="Requirement/Sub-Requirement In Progress">
						<i class="fa fa-statusIP"><span class="sr-only">Requirement/Sub-Requirement In Progress Image</span></i> 
					</span> - In Progress
				</li> 
			
				<li>
					<span class="statusNO legend_status" style="float: left;" title="Requirement/Sub-Requirement Unfulfilled">
						<i class="fa fa-statusNO"><span class="sr-only">Requirement/Sub-Requirement Unfulfilled Image</span></i> 
					</span> - Unfulfilled
				</li>
			</ul>
		</div>
	</div>
	
</#macro>
<#macro statusx s t><span class="audittype-${s}"><i class="fa fa-${s}" aria-hidden="true"></i></span> ${t}</#macro>


<#macro formatDateTime dateTime=' '>
	<#if dateTime != ' '>
		${dateTime?datetime?string.long_short}
	</#if>
</#macro>


<#macro replyComment href title target="_self"><a href="<@s.url href />" title="${title}" alt="Reply" target="${target}" style="color: #5cb85c;"><i class="fa fa-reply fa-fw"></i></a></#macro>
<#macro editComment href title target="_self"><a href="<@s.url href />" title="${title}" alt="Edit" target="${target}" style="color: black;"><i class="fa fa-edit fa-fw"></i></a></#macro>
<#macro deleteComment href title target="_self"><a href="<@s.url href />" title="${title}" alt="Delete" target="${target}" style="color: #d9534f;"><i class="fa fa-trash-o fa-fw"></i></a></#macro>