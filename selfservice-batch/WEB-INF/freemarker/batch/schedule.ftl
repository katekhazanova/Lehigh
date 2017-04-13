<@layout.head title="Create ${pageContext.page.label}">
<#assign jawr=JspTaglibs["/WEB-INF/tld/jawr.tld"]>
</@layout.head>
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<@p.detailViewBeforeForm>
		<@batch.batchTabs step=3 />
	</@p.detailViewBeforeForm>
	<@p.detailViewBeforeSaveButton>
		<a class="btn btn-default" href="<@h.url href='/batch/share.html' />" role="button">Skip</a>
		<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_RESULTS perm="C">
			<input type="submit" class="btn btn-success" alt="Save & Continue" name="scheduleContinue" value="Save & Continue">
		</@sec.hasAppFnPerm>
	</@p.detailViewBeforeSaveButton>
	<@p.detailView ctx=pageContext saveButton="Save & Finish" />
		<script language="javascript">

            Protoplasm.use('datepicker').transform('#startDate',{'icon': '../js/protoplasm/datepicker/calendar.png'});
        	
        	Protoplasm.use('timepicker').transform('#startTime',{'use24hrs': 'true', 'icon': '../js/protoplasm/timepicker/clock.png'});
        	

        </script>
</@layout.body>