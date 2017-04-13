
<#macro refresher id>
	<input class="image refresher" name="refresh" type="image" src="" alt="Refresh" />
	<#-- span that will hold a spinner image when refreshing -->
	<span id="${id}_spinner">&nbsp;</span>
</#macro>


<form name="blackoutForm" id="blackoutForm" method="post">
		<input type="hidden" name="pageRefresh" id="pageRefresh" value="false" />
		<table class="verticalListing">
			<tr>
				<th>Description</th>
				<td><@s.formInput path='blackout.description' /></td>
				<td>&nbsp;</td>
				<td><@s.showErrors separator='' classOrStyle='alert alert-danger' /></td>
			</tr>
			<tr>
				<th>Datasource</th>
				<td><@s.formSingleSelect 'blackout.datasource' datasources /></td>
				<td>&nbsp;</td>
				<td><@s.showErrors separator='' classOrStyle='alert alert-danger' /></td>
			</tr>
			<tr>
				<th>Frequency</th>
				<td>
					<#assign frequencies = {"d":"Daily", "w":"Weekly", "m":"Monthly"} >
					<@s.formSingleSelect 'blackout.frequency' frequencies />
					<@refresher "frequency" />
				</td>
				<td>&nbsp;</td>
				<td><@s.showErrors separator='' classOrStyle='alert alert-danger' /></td>
			</tr>
			<#if blackout.frequency == 'w'>
				<tr>
					<th>Day of the Week</th>
					<td>
						<input type="checkbox" id="monday" name="monday" value="Y" <#if blackout.isMonday()> checked</#if>>Mon
						<input type="checkbox" id="tuesday" name="tuesday" value="Y" <#if blackout.isTuesday()> checked</#if>>Tue
						<input type="checkbox" id="wednesday" name="wednesday" value="Y" <#if blackout.isWednesday()> checked</#if>>Wed	
						<input type="checkbox" id="thursday" name="thursday" value="Y" <#if blackout.isThursday()> checked</#if>>Th
						<input type="checkbox" id="friday" name="friday" value="Y" <#if blackout.isFriday()> checked</#if>>Fri
						<input type="checkbox" id="saturday" name="staurday" value="Y" <#if blackout.isSaturday()> checked</#if>>Sat
						<input type="checkbox" id="sunday" name="sunday" value="Y" <#if blackout.isSunday()> checked</#if>>Sun
					</td>
					<td>&nbsp;</td>
					<td><@s.showErrors separator='' classOrStyle='alert alert-danger' /></td>
				</tr>
			</#if>
			<#if blackout.frequency == 'm'>
				<tr>
	
					<th>Day of the Month</th>
					<td><@s.formSingleSelect 'blackout.dayofthemonth' days /></td>
					<td>&nbsp;</td>
					<td><@s.showErrors separator='' classOrStyle='alert alert-danger' /></td>
				</tr>
			</#if>
			<tr>
				<th>Start</th>
				<td><@s.formInput path='blackout.starttime' /></td>
				<td><@help.tooltip text="Enter time in the format HH:MM:SS" topic="startTime" /></td>
				<td><@s.showErrors separator='' classOrStyle='alert alert-danger' /></td>
			</tr>
			<tr>
				<th>End</th>
				<td><@s.formInput path='blackout.endtime' /></td>
				<td><@help.tooltip text="Enter time in the format HH:MM:SS" topic="startTime" /></td>
				<td><@s.showErrors separator='' classOrStyle='alert alert-danger' /></td>
			</tr>
			<tr>
				<td class="pages-savebar">&nbsp;</td>
				<td colspan="3">
					<input class="btn btn-primary" type="submit" value="Save">
					<a class="btn btn-default" href="../blackout/list.html" role="button">Cancel</a>
				
				</td>
			</tr>
		</table>
	</form>
	
	<script>
		Event.observe(window, 'load', function() 
		{
			<#-- hide the refresh buttons if the browser supports javascript -->
			var i, refreshers = $$('input.refresher');
			for(i = 0; i < refreshers.length; i++) 
			{
				refreshers[i].hide();
			}
	
			function refreshOnChange(theId) 
			{
				if($(theId)) 
				{
					Event.observe(theId, 'change', function () 
					{
						// signal that this is a page refresh
						$('pageRefresh').value = true;
						// refresh...
						$(theId + '_spinner').innerHTML = '<@h.img src="/images/small_loading.gif" title="Refreshing..." />';
						document.blackoutForm.submit();
					});
				}
			}
			refreshOnChange("frequency");
		});
		Protoplasm.use('timepicker').transform('#starttime',{'use24hrs': 'true', 'icon': '../js/protoplasm/timepicker/clock.png'});
		Protoplasm.use('timepicker').transform('#endtime',{'use24hrs': 'true', 'icon': '../js/protoplasm/timepicker/clock.png'});
	</script>