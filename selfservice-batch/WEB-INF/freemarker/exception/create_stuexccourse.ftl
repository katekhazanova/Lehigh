<@layout.head title="Create ${pageContext.page.label}" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="exception"/>
	<#-- need to pass in save button image as saveButton param  cancelButton="/images/bt_Back2List.png" -->

<#if showAudit>
	<input type="hidden" id="exceptionMode" value="true"/>
	<input type="hidden" id="courseExc" value="true"/>

	<#include '/audit/exception_audit_header.ftl'/>
</#if>
<div class="row">
	
	<#if showAudit>
		<#include '/audit/exception_audit.ftl'/>
	</#if>
	
	<#if showAudit>
	<div class="col-md-5 ">
	<div class="well">
	</#if>

	<@p.detailView ctx=pageContext saveButton="Add To List" cancelText="Return" />
	<@p.masterView ctx=stuExcCoursePageContext deleteButton="Remove" deleteHeader="Remove" />
		
	<#if showAudit>
		</div> <!-- /well -->
	</div> <!-- /col-md-5 -->
	</#if>
</div> <!-- /row -->
	
</@layout.body>