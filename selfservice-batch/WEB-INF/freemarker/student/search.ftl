<#assign security=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<@layout.head title='Student Search' />

<@layout.body>
<input type="hidden" id="pageGroup" value="students"/>
<input type="hidden" id="mobilePageGroup" value="studentsearch"/>
<div class="row">
	<div class="col-md-12">
		<h1><@s.message 'uachieve.selfservice.student.search.header' /></h1>
		
		<div class="col-md-6">
			<h2><@s.message 'uachieve.selfservice.student.search.idPrompt' /></h2>
			<form method="post" name="stunoForm" class="focusable form" role="form">
				<div class="form-group" >
					<input type="hidden" name="searchType" value="stuno" />
					<label for="stuno">Student ID</label>
					<@s.formInput path='studentSearch.stuno' />	
				</div>
				
				<@h.submit src="" title="Submit" /> 
				
				<div> <br>
				<@s.showErrors separator='' classOrStyle='alert alert-danger' /> 
				</div>
			</form>
		</div> <#-- /col-md-6 -->
		
		<div class="col-md-6">
			<h2><@s.message 'uachieve.selfservice.student.search.namePrompt' /></h2>
			<form method="post" class="focusable form" role="form">
				<div class="form-group">
					<input type="hidden" name="searchType" value="name" />
					<label for="firstName">First Name</label>
					<@s.formInput path='studentSearch.firstName' />
				</div>
				<div class="form-group">
					<label for="lastName">Last Name</label>
					<@s.formInput path='studentSearch.lastName' />
				</div>
				<@h.submit src="" title="Search" />
				<@help.tooltip text="You can search by a partial name as well as a full name. For example, searching for Jo will return students named both Jon and Jonathan." topic="search" />
				
				<div>
				<br>
				<@s.showErrors separator='' classOrStyle='alert alert-danger' />
				</div>
			</form>
		</div> <#-- /col-md-6 -->
	</div> <#-- /col-md-12 -->
</div> <#-- /row -->


<#if pageContext??>
	<#if missingStudents??>
		<p class="alert alert-warning">
			You have ${missingStudents?size} additional advisee<#if missingStudents?size gt 1>s</#if> not shown:
			 	<#list missingStudents as missingStudent>
			 		${missingStudent.sisId}
			 		<#if missingStudent_has_next>, </#if>
			 	</#list>
			. Please make sure that they exist in the u.achieve tables for this area.
		</p>
	</#if>
	<@p.masterView pageContext />
</#if>

<#if resultsFiltered??>
	<p class="alert alert-warning">Additional students found for that name: Check to make sure students are on your advisee list</p>
</#if>

<#if studentNotFound??>
	<#if notFoundInSecurity??>
		<p class="alert alert-warning">
		The student with stuno ${stuno_e!""} and name ${stuName_e!""} does not exist in the CollegeSource security tables.
	</p>
	<#else>
	<p class="alert alert-warning">
		The student with stuno ${stuno_e!""} and name ${stuName_e!""} does not exist in the u.achieve database.  
		<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COURSE perm="C">
			<#assign createUrl = "/student/create.html?stumaster=" + compressedStudent />
			<@h.link createUrl  "Create" /> this student?
		</@sec.hasAppFnPerm>
	</p>
	</#if>
</#if>
<br/>
<p>
<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_STUDENT perm="C">
	<a href="<@h.url "/student/create.html" />" class="biggerlink">Add a New Student</a>
</@sec.hasAppFnPerm>
</p>

<br/>
<#if showSearchCancel??>
	<@h.buttonAsLink src="/images/bt_cancel.gif" href="/audit/read.html" title="Cancel" />
</#if>
<#if uppercaseStuno>
	<input type="hidden" id="uppercaseStuno" value="true"/>
<#else>
	<input type="hidden" id="uppercaseStuno" value="false"/>
</#if>

</@layout.body>