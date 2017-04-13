<#assign form=JspTaglibs["/WEB-INF/tld/spring-form.tld"] />

<@layout.head title="Program Matcher">
<#if programGroups?keys?size == 0>
	<META HTTP-EQUIV="refresh" CONTENT="10;URL=viewSearchResults.html">
</#if>

</@layout.head>
<@layout.body>
	<input type="hidden" id="pageGroup" value="audits"/>
<input type="hidden" id="mobilePageGroup" value="programMatcher"/>

	<span id="alertbox" class="sr-only" role="alert"></span>
	
	<div class="row">
	<h1 class="sr-only">Program Matcher</h1>
			<div id="p_groups" class="col-md-3">
			
				<#assign auditRequestOptionsPageContext = auditRequestOptionsPageContext/>
				
				<div id="prggrp_col_1">
					<h2>Program Groups</h2>
					<input type="text" class="form-control" id="programGroupSearch"  placeholder="Filter by program group title" autofocus/>
				</div>
				<div class="overflow">
					<#assign ddid = 1 />
					<#if programGroups?keys?size == 0>
						<i class="fa fa-spinner fa-spin" title="Still Loading"></i>
						<span> Loading Program Groups</span>
					</#if>
					<#list programGroups?keys as key>
						<#assign name>${programGroups[key].ngram}</#assign>
						<#assign ename>${programGroups[key].engram}</#assign>
						<#assign count>${programGroups[key].count}</#assign>
						<#assign maxMatch>${programGroups[key].maxMatch}</#assign>
					    
						<#if count != "0">
							<a href="#" id="prg_${ddid}" data-name="${name}" class="list-base prgGrp prgLink" onclick="loadPrograms('${ename}', 'prg_${ddid}')">
							<span class="prgTitle" id="id_">${name}</span>
							<span class="prgCount">(${count})</span>
							<span class="maxMatch" style="display: none;">${maxMatch}%</span>
							
							</a>
							<#assign ddid = ddid + 1 />
						</#if>
					</#list>
				
				</div>
	
			</div> <!-- col-md-3 -->
			<div class="col-md-9" id="programs_title">
			<div class="col-md-9"><h2><span id="filterNum">0</span> Program<span id="filterNumS">s</span> Found </h2></div>
			<div id="auditList" class="col-md-3" >
					<@h.link href='/audit/list.html?autoPoll=true' class="btn btn-success" title='View Submitted Audits'/>
				</div>
				<div class="col-md-6 p_header">
					<input type="text" class="form-control" id="programSearch"  placeholder="Filter by program title" autofocus/>
				</div>
				<div id="key" class="col-md-6" >
				<br>
					<span class="badge badge-applied" title="Represents hours applied"><span class="sr-only">Represents hours applied</span> &nbsp; </span> = Hours matched 
					<span class="badge badge-completed" title="Represents hours completed"><span class="sr-only">Represents hours completed</span> &nbsp; </span> = Hours completed 
					<span class="badge badge-totalhrs" title="Represents total hours needed"><span class="sr-only">Represents total hours needed</span> &nbsp; </span> = Total hours needed
				</div>
			</div> <!-- col-md-9 -->
			<div class="col-md-9 overflow" id="programs"> 
				<#if programGroups?keys?size == 0>
					<i class="fa fa-spinner fa-spin" title="Still Loading"></i>
					<span> Loading Programs</span>
				</#if>
			</div>	
		
	</div> <!-- row -->



<script type='text/javascript'>

$j(document).ready(function() {

	$j.ajaxSetup({ cache: false });
	$j('#auditList').hide();
	loadPrograms('View all Programs', 'prg_1');

});
</script>
</@layout.body>