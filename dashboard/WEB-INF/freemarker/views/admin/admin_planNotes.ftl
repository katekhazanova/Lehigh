

<#include "admin_top.ftl">


		<h1 id="pagetitle" tabindex="0">Plan Messages</h1>
		<br/>
		
		<form name="deletePlanNote" role="form" action="admin_planNotes.html" method="POST" >
		<table class="table table-striped" id="planNotes_table">
		<tr>
			<th>Defaulted</th><th>Description </th><th>Code </th><th></th>
		</tr>
		
		<#list planNotes as planNote>
			<tr class="adm-rw">
				<td><#if planNote.defaulted>true<#else>false</#if></td>
				<td>${planNote.description!''}</td>
				<td>${planNote.code!''}</td>
				<td>
					<button type="button" onclick="removePlanNote('${planNote.id}')" class="btn btn-danger" ><i class="icon-trash"></i> Delete</button>
				</td>
			</tr>
		</#list>
		</table>
		<input type="hidden" value="" name="deleteId" id="deleteId"/>
		<input type="hidden" value="true" name="delete" />
		</form>
		
		<h2>Add New</h2>
		<form name="addPlanNote" id="addPlanNote" class="form-horizontal" role="form" action="admin_planNotes.html" method="POST" >
			
			<@d.checkBox name="defaulted" label="Defaulted" value="true" checked="false" />
			<@d.inputRow name="description" label="Description" max="50" value="" />
			<@d.inputRow name="code" label="Code " max="2" value="" />
			<@d.submitButtons />
			<input type="hidden" name="create" value="true"/>
		</form>

<#include "admin_bot.ftl">