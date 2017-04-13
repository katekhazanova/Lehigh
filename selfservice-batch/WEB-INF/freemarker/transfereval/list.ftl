<#assign redauth=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>
<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="transferEvals"/>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.transfereval.list.header'/></h1>
	<p><@s.message 'uachieve.selfservice.transfereval.list.text'/></p>

	<#--
		Adds the "Export All" and "Lock/Unlock All" links to the top of the form right where the "Add" button would be.
	 
		This toolbar is hidden initially (display:none;) and is only displayed to user agents that have javascript enabled.
		See selfservice.transfereval.initTransferEvals() javascript for more info.
	-->
	<@redauth.authorize ifAnyGranted="SS_AREA_TRANSFEREVAL=U">
		<@p.masterViewBeforeAddButton>
			<span id="transferEvalListToolbar" style="display:none;">
				<a id="transferEvalListExportAll" href="#"><i class="fa fa-external-link"></i> Export All</a>
				| 
				<a id="transferEvalListLockUnlockAll" href="#"><i class="fa fa-lock"></i> Lock / <i class="fa fa-unlock-alt"></i> Unlock All</a>
			</span>
		</@p.masterViewBeforeAddButton>
	</@redauth.authorize>

	<#-- adds the "Save" button next to the delete button -->
	<@p.masterViewBeforeDeleteButton>
		<input class="btn btn-primary" type="submit" name="pages.editAll"  value="Save"  />
		<a href="?discardChanges=true" class="btn btn-default">Discard Changes</a>
		
	</@p.masterViewBeforeDeleteButton>

	<#if discardChanges>
		<p class="alert alert-warning">Your changes were discarded.</p>
	</#if>
	
	<#if flash.transferArticulationComplete?? && flash.transferArticulationComplete>
		<p class="alert alert-success">Transfer articulation completed successfully.</p>
	</#if>
	
<div class="row">
	<div class="col-md-12"
		<@p.masterView ctx=pageContext addButton="Run Transfer Evaluation"/>
	</div> <#-- /col-md-12 -->
	
	<div class="col-md-6 col-md-offset-3">
		<div class="well">
			<h3>Legend</h3>
			<p><span class="fa-stack" title="Source Course (school you transferred from)" style="text-align: left; width: 1em; height: 1em; line-height: 1em;vertical-align: top;"><i class="fa fa-long-arrow-right fa-stack-1x fa-rotate-45" style="margin-top: 3px; margin-left: 2px;"><span class="sr-only">Source Course Image</span></i><i class="fa fa-angle-double-right fa-stack-1x fa-rotate-45" aria-hidden="true"></i></span> Source Course (school you transferred from)</p>
			<p><i class="fa fa-bullseye" title="Target Course (school you transferred to)"><span class="sr-only">Target Course Image</span></i> Target Course (school you transferred to)</p>
			<p><i class="fa fa-lock" title="Permanent Transfer (cannot be edited)"><span class="sr-only">Permanent Transfer Image</span></i> Permanent Transfer (cannot be edited)</p>
		</div>

	</div> <#-- /col-md-3 col-md-offset-3 -->
</div> <#-- /row -->
	<script type="text/javascript">
		Event.observe(window, 'load', function() {
			selfservice.transfereval.initTransferEvals();
		});
	</script>

</@layout.body>