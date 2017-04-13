<@layout.head title="Create ${pageContext.page.label}" />

<@layout.body>

<input type="hidden" id="pageGroup" value="courses"/>
<input type="hidden" id="mobilePageGroup" value="transferCourses"/>
<form role="form" method="post" action="../transfercourse/create.html" id="row" class="focusable">	
	<#if errors?? && errors?index_of("comp_id.crsNum") != -1>	
		<p class="alert alert-danger" role="alert" tabindex="0">There was an error relating to the Course field - make sure the Course field contains a valid string.</p>
	<#elseif validationErrors?? && validationErrors>
		<p class="alert alert-danger" role="alert" tabindex="0">There were errors - please fix them and try again.</p>
		<!--<#if errors??>${errors}</#if>-->
	</#if>
	<div class="row">
			<div class="form-group col-md-2" >
				<label for="comp_id.sourceId">School</label>
					<select class="form-control"  id="comp_id.sourceId" name="comp_id.sourceId">
						<#list institutioOptions as option>
							<option value="${option.name}|${option.label}" <#if chosenSourceId == "${option.name}|${option.label}">selected</#if>>${option.label}</option>
						</#list>	
					</select>
					
					<!-- Use this if you want a freeform input box for source_id -->
					<#--
						<input type="text" class="form-control" value="${chosenSourceId}" id="comp_id.sourceId" name="comp_id.sourceId">
					-->
			</div>
			
			<div class="form-group col-md-1" >
					<label for="comp_id.sourceCd">Cd</label>
					<input type="text" class="form-control" value="${chosenSourceCd}" id="comp_id.sourceCd" name="comp_id.sourceCd" maxlength="2">
			</div>
	</div>	
	<div class="row">		
			<div class="form-group col-md-2" >
				<label for="comp_id.crsYt">Term</label>
				<select class="form-control"  id="comp_id.crsYt" name="comp_id.crsYt" >
					<#list catalogYearTerms as option>
						<option value="${option.name}">${option.label}</option>
					</#list>							
				</select>
			</div>
			<div class="form-group col-md-2">
				<label for="comp_id.crsNum">Course</label>
				<input id="comp_id.crsNum" type="text" class="form-control" value="" name="comp_id.crsNum" maxlength="15">
			</div>
			<div class="form-group col-md-15">
				<label for="rcredit">RCredit</label>
				<input type="text" class="form-control" value="0.0" id="rcredit" name="rcredit" maxlength="5">
			</div>
			<div class="form-group col-md-1">
				<label for="grade">Grade</label>
				<!-- Use this if you want a dropdown of transfer grade options -->
				<#--
					<select class="form-control" id="grade" name="grade" >
						<#list gradeOptions as option>
							<option value="${option.name}">${option.label}</option>
						</#list>	
					</select>
				-->
				<input type="text" class="form-control" value=" " id="grade" name="grade" maxlength="4">
			</div>
			<div class="form-group col-md-3">
				<label for="ctitle">Title</label>
				<textarea id="ctitle" class="form-control" name="ctitle" style="height: 34px;" maxlength="30"></textarea>
			</div>
			<div class="form-group col-md-05">
				<label for="pflg">Pflg</label> <br>
				<input type="checkbox" value="P" id="pflg" name="pflg">
			</div>
			<div class="form-group col-md-1">
				<label for="iflg1">Iflg1</label>
				<input type="text" class="form-control" value="" id="iflg1" name="iflg1" maxlength="3">
			</div>
			<div class="form-group col-md-1">
				<label for="comp_id.crsSeq">Seq</label>
				<input type="text" class="form-control" value="001" id="comp_id.crsSeq" name="comp_id.crsSeq" maxlength="3">
			</div>
			
			<div class="form-group">
				<input type="submit" value="Add To List" title="Add To List" alt="Add To List" class="btn btn-primary" style="margin-left: 15px;">
				<a href="../transfercourse/list.html" title="Return" alt="Return" role="button" class="btn btn-default"> Return </a>
			</div>
	</div>
</form>



		

			<h1 class="cleared"><@s.message 'uachieve.selfservice.course.list.header'/></h1>

		
			<@p.masterView courseListPageContext />
			<br/>
</@layout.body>