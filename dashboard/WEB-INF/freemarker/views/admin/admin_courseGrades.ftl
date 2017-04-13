

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
				<td>${courseGrade.gradeListName}</td>
				<td>${courseGrade.grade}</td>
				<td>${courseGrade.gpaPoints}</td>
				<td>
					<#if courseGrade.excludeFromGpa>
						true
					<#else>
						false
					</#if>
				</td>
				<td>
					<button type="button" onclick="removeCourseGrade('${courseGrade.id}')" class="btn btn-danger" ><i class="icon-trash"></i> Delete</button>
				</td>
			</tr>
		</#list>
		</table>
		<input type="hidden" value="" name="deleteId" id="deleteId"/>
		<input type="hidden" value="true" name="delete" />
		</form>
		
		<h2>Add New</h2>
		<form name="addCourseGrade" class="form-horizontal" role="form" action="admin_courseGrades.html" method="POST" >
			
			
			<@d.inputRow name="gradeList" label="Grade List" max="50" value="" />
			<@d.inputRow name="grade" label="Grade " max="4" value="" />
			<@d.inputRow name="gpaPoints" label="GPA Points" max="16" value="0" />
			<@d.checkBox name="exclude" label="Exclude from Calculation" value="true" checked="false" />
			<@d.submitButtons />
			<input type="hidden" name="create" value="true"/>
		</form>

<#include "admin_bot.ftl">