<@layout.head title="Create ${pageContext.page.label}" />

<@layout.body>

<#if showAudit>
	<input type="hidden" id="exceptionMode" value="true"/>
	
	<script type="text/javascript" >
		var pseudoList =[
		<#if pseudoList??>
		<#list pseudoList as pseudo>
			'${pseudo}',
		</#list>
		</#if>
		];
	</script>
	
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
		<input type="hidden" id="pageGroup" value="exception"/>
		<#-- only show StuExcCourses if the action type (action) of the parent StuException == R -->
		<#if showStuExcCourses>	
			<@p.detailViewInsideForm>
				<input type="hidden" name="courseEdit" id="courseEdit" value="" />
				<input type="hidden" name="courseEditId" id="courseEditId" value="" />
			</@p.detailViewInsideForm>
			<@p.detailViewAfterForm>
				<@p.masterView ctx=stuExcCoursePageContext deleteButton="Remove" deleteHeader="Remove" />
				<br/>
			</@p.detailViewAfterForm>
		</#if>
		<@p.detailView ctx=pageContext saveButton="Save" /> 
		
	<#if showAudit>
	<div class="row">
	<div class="col-md-12" style="margin-top: 10px;">
                <button class="exceptMod-final btn btn-primary" onclick="addAltException('true')" style="">Save &amp; Run Audit</button>
        		<button class="exceptMod-final btn btn-success" onclick="addAltException('false')" style="">Save &amp; Add Exception</button>
				<a class="btn btn-default" href="<@s.url />/audit/exception_home.html">Cancel</a>
	        </div>
		</div>
		<script type="text/javascript">
			Event.observe(window, 'load', function() {
				selfservice.exception.initExceptions();
			});
		</script>
	</#if>

	<#if showAudit>
		</div> <!-- /well -->
	</div> <!-- /col-md-5 -->
	</#if>
</div> <!-- /row -->

</@layout.body>