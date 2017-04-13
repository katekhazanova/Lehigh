<@layout.head title="Add Exception - Choose Type">

	<style type="text/css">
		.unavailable { margin-top: 8em; }
	</style>
	
</@layout.head>

<@layout.body>
	<input type="hidden" id="pageGroup" value="exception"/>
	<h1><@s.message 'uachieve.selfservice.exception.typelist.header'/></h1>

	<#assign listUrl>${configuredExceptionTypesPageContext.listUrl}</#assign>
	<p><@h.link href=listUrl title="Return to list of exceptions" /></p>

	<@p.masterView configuredExceptionTypesPageContext />

	<#if unconfiguredExceptionTypes?size gt 0>
		<p class="notice unavailable">Some exception types are not configured.  <a href="#" id="show_unavailable_exceptions">Show unconfigured exception types.</a></p>
		<div id="unavailable_exceptions" style="display: none;">
			<@p.masterView unconfiguredExceptionTypesPageContext />
		</div>	
		
		<script type="text/javascript">
			Event.observe(window, 'load', function() {
				Event.observe('show_unavailable_exceptions', 'click', function (event) {
					Event.stop(event);
					if ($('unavailable_exceptions').visible()) {
						Effect.BlindUp('unavailable_exceptions');
					} else {
						Effect.BlindDown('unavailable_exceptions');
					}
				});
			});
		</script>
	</#if>


</@layout.body>