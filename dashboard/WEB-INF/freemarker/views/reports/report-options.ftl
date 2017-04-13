<html>
<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
<head>
	<title>Reports Options</title>	
	<META name="userName" content="${userFullName!''}">	
</head>
<input type="hidden" id="pageGroup" value="reports"/>
<body class="yui-skin-sam"> 

	<h1>${reportLabel}</h1>
	
	
	<div class="col-md-6">
	<p>${reportDescription}</p>
	<br/>
	<br/>

	<form name="reportOptions" id="reportsForm"  role="form" target="_blank" action="<@spring.url relativeUrl="/reports/report-show.html" />" method="post">
			<#list reportParams as param>
			<#if !param.hidden>
				<div class="form-group">
					 <label for="${param.name}" class="col-sm-3 control-label">${param.label}: </label>
					 <div class="col-sm-9" style="margin-bottom: 10px;">
					<#if param.inputType = "textbox">
						<input class="form-control" name="${param.name}" type="text" 
							<#if "${param.name}"== "offTrack" > value = '1' </#if> 
							<#if "${param.name}"== "IDQ_Course_Search" || "${param.name}"== "instidq" > value = '${instidq}' </#if> 
							<#if "${param.name}"== "InstID_Course_Search"|| "${param.name}"== "instid" > value = '${instid}' </#if> 						
							<#if "${param.name}"== "CD_Course_Search" || "${param.name}"== "instcd"> value = '${instcd}' </#if>  
							<#if "${param.name}"!= "CD"> 
							<#if param.optional>placeholder="(OPTIONAL)" </#if></#if>>
					<#elseif param.inputType = "dropdown">
						<#assign values = param.listOfValues>
							<select class="form-control"  name="${param.name}">
							<#list values?keys as key>
								<option value="${key}">${values[key]}</option>
							</#list>
							</select>
					</#if>
						<span id="reportDesc" style="padding-bottom: 10px;">${param.description}</span>
					</div>
				</div>
				
			</#if>
			</#list>
			  <div class="form-group">
			  	<label class="col-sm-3 control-label">Output Type: </label>	
				<div class=" col-sm-9">
				  <div class="checkbox">
				<#list outputTypes as output>
					<#if output == "HTML">
						<input type="radio" name="outputType" value="${output}" checked>${output}
					<#else>
						<input type="radio" name="outputType" value="${output}" >${output}
					</#if>
				</#list>
			      </div>
			    </div>
			  </div>
			
		<div class="form-group">	
			<div class=" col-sm-10">
			<button type="submit" class="btn btn-primary">Submit</button>
			<input type="button" class="btn btn-default" onclick="window.location.href='<@spring.url relativeUrl="/reports/reports-console.html" />'"
			value="Back">
			</div>
		</div>
		<input name="report" value="${reportName}" style="display: none;">
		</form>
		</div>


</body>
</html>