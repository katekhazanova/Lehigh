<@layout.head "Update Log Levels">
	<style type="text/css">
		#logLevels { font-family: monospace; height: 400px; width: 100%; }
		.verticalListing { width: 100%; }
		pre { font-size: 108%; }
	</style>
</@layout.head>

<@layout.body>

	<h1>Update Log Levels</h1>

	<#if success??>
		<p class="alert alert-success">Log levels were updated.</p>
	</#if>

	<p class="alert alert-info">
		This page is only accessible in debug mode - this page 
		will not be accessible in production.<br />  To disable debug mode, see <strong>selfservice.properties</strong>; look for
		the property named <strong>uachieve.selfservice.debug</strong> near the bottom of the file.
	</p>

	<form method="POST" class="focusable">
			<p>Valid logging levels are: debug, info, warn, error, fatal</p>
			<table class="verticalListing">
			  <tr>
			  	<th>Log Levels</th>
			  	<td><textarea class="form-control" name="logLevels" id="logLevels"><#list currentLoggers as logger>${logger.name}=${logger.level}
</#list></textarea></td>
			  </tr>
			  <tr>
			  	<td>&nbsp;</td><td><@h.submit src='' title='Update' /></td></tr> 
			  </tr>
			</table>   
	</form>
	
	<h2>All Loggers</h2>
	<pre>
<#list allLoggers as logger>${logger.name}
</#list>
	</pre>
	
</@layout.body>
