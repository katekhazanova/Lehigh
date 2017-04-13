<@layout.head title="My Audit">
	<style>
		#doc2{min-width:510px; max-width:510px;}
		#bd{width:500px;}
	</style>
</@layout.head>
<@layout.body hideMenu=true hideFooter=true>
<#if canCreate >
<h3>A description of ${department}${number} is shown below.  Would you like to add this as a planned course?</h3>
<#assign createPage><@h.url "/plannedcourse/create.html?department=${department}&number=${number}"/></#assign>
<@h.buttonAsLink src="" href="REDIRECTINGBUTTON" title="Add" class="" onclick="window.opener.location='${createPage}';window.close();" />
<a href="#" class="btn btn-default" title="Cancel" onclick="window.close();">Cancel</a>
</#if>
</p>

<#if link!="">
<iframe src="${link}" frameborder="1" width="100%" height="100%" name="courseDescription" title="Course Description" style="width:800px;height:340px;">
</iframe>
<#else>
	<#if courseEntry??>
		<div class="bd">
			<div id="courseHeader">
				<span id="departmentTitle"><#if showDepartment && courseEntry.department??>${department}</#if><#if showCourseNumber && courseEntry.courseNumber??>${number}</#if></span>
				<span id="hoursTitle" <="" span="">
					<#if showHours && courseEntry.hours??> 
						<#if courseEntry.minimumHours != courseEntry.maximumHours> 
						 	(${courseEntry.minimumHours} - ${courseEntry.maximumHours}  ${hourLabel}s)
						<#else>
						  (${courseEntry.hours} ${hourLabel}s)
						</#if>
					</#if>
				</span>
			</div>
			<div id="courseTitle">
				<#if showTitle && courseEntry.courseTitle??>
					${courseEntry.courseTitle}
				</#if>
			</div>
			<div id="courseDescription">
				<#if showDescription && courseEntry.courseDescription??>
					${courseEntry.courseDescription}
				</#if>
			</div>
			<#if showPreCoReqDisplay && courseEntry.preReqString?? && courseEntry.coReqString??>
				<div id="coursePreCoRequirements">
					<table cellspacing="0" cellpadding="0" border="0" width="100%">
						<tbody>
							<#if courseEntry.preReqString != ''>
							<tr>
								<td class="preCoReqName" width="33%">Pre Requisites:</td>
								<td id="coursePreReqs" class="preCoReqValue">${courseEntry.preReqString}</td>
							</tr>
							</#if>
							<#if courseEntry.coReqString != ''>
							<tr>
								<td class="preCoReqName" width="33%">Co Requisites:</td>
								<td id="courseCoReqs" class="preCoReqValue">${courseEntry.coReqString}</td>
							</tr>
							</#if>
						</tbody>
					</table>
				</div>
			</#if>
			<#if courseEntry.customProperties??>
			<div id="courseOther">
				<table class="table" cellspacing="0" cellpadding="0" border="1" width="100%">
				<tbody>
					<#list courseEntry.customProperties?keys as propertyName>
						<tr>
							<td class="propertyName" width="33%">${propertyName}</td>
							<td id="custom_${propertyName}" class="propertyValue"><#if courseEntry.customProperties[propertyName]??>${courseEntry.customProperties[propertyName]}</#if></td>
						</tr>
					</#list>
				</tbody>
				</table>
			</div>
			</#if>
			<#if showAvailibility && courseEntry.termHeaders?? && courseEntry.availability??>
			<div id="courseAvailabilityTitle">
				${availabilityLabel}
			</div>
			<div id="courseAvailability">
				<table class="table" align="center" cellspacing="0" cellpadding="3" border="0">
				<tbody>
					<tr>
						<#list courseEntry.termHeaders as termHeader>
							<td class="availabilityTerms">${termHeader}</td>
						</#list>
					</tr>
					<tr id="termsRow">
						<#list courseEntry.availability as availability>
							<#assign term = courseEntry.terms[availability_index]?number>

							<#if term gt maxYearTermCode>
								<td class="availabilityBox"><i class="fa fa-termUnknownIcon" title="Course Availability Unknown"><span class="sr-only">Course Availability Unknown</span></i></td>
							<#else>
								<#if availability == "true">
									<td class="availabilityBox"><i class="fa fa-termAvailableIcon" title="Course Offered"><span class="sr-only">Course Offered</span></i></td>
								<#else>
									<td class="availabilityBox"><i class="fa fa-termNAIcon" title="Course Not Offered"><span class="sr-only">Course Not Offered</span></i></td>
								</#if>	
							</#if>
						</#list>
					</tr>
				</tbody>
				</table>
			</div>
			</#if>
		</div>
	<#else>
		<span class="alert alert-danger" role="alert" tabindex="0">Error: no course information could be found for the selected Catalog Course.</span>
	</#if>
	<br>
</#if>
	

</@layout.body>