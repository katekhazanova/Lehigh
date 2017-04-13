

<#include "admin_top.ftl">


		<h1 id="pagetitle" tabindex="0">Catalog Course Grades</h1>
		<br/>
		
		<form name="deleteCourseGrade" role="form" action="admin_courseGrades.html" method="POST" >
		<table class="table table-striped" id="courseGrade_table">
		<tr>
			<th>Grade List </th><th>Grade </th><th>GPA Points</th><th>Exclude from Calculation</th><th></th>
		</tr>
		
		<#list courseGrades as courseGrade>
			<tr class="adm-rw">
				<td>${courseGrade.gradeListName!}</td>
				<td>${courseGrade.grade!}</td>
				<td>${courseGrade.gpaPoints!}</td>
				<td>
					<#if courseGrade.excludeFromGpa>
						true
					<#else>
						false
					</#if>
				</td>
				<td>
					
					<@security.authorize ifAnyGranted="UDIR_Admin=u  ">
						<button type="button" onclick="removeCourseGrade('${courseGrade.id}')" class="btn btn-danger" ><i class="icon-trash"></i> Delete</button>
					</@security.authorize>
				</td>
			</tr>
		</#list>
		</table>
		<input type="hidden" value="" name="deleteId" id="deleteId"/>
		<input type="hidden" value="true" name="delete" />
		</form>
		
		<h2>Add New</h2>
		<form name="addCourseGrade" class="form-horizontal" role="form" action="admin_courseGrades.html" method="POST" >
			
			
			<@d.inputRowAdminCheck name="gradeList" label="Grade List" max="50" value="" />
			<@d.inputRowAdminCheck name="grade" label="Grade " max="4" value="" />
			<@d.inputRowAdminCheck name="gpaPoints" label="GPA Points" max="16" value="0" />
			<@d.checkBoxAdminCheck name="exclude" label="Exclude from Calculation" value="true" checked="false" />
			<@security.authorize ifAnyGranted="UDIR_Admin=u  ">
				<@d.submitButtons />
			</@security.authorize>
			<input type="hidden" name="create" value="true"/>
		</form>

<#include "admin_bot.ftl">