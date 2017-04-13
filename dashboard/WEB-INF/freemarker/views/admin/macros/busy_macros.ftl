<#assign start = {"0:00":"12:00 am", "0:30":"12:30 am", "1:00":"1:00 am", "1:30":"1:30 am","2:00":"2:00 am", 
	"2:30":"2:30 am", "3:00":"3:00 am", "3:30":"3:30 am", "4:00":"4:00 am", "4:30":"4:30 am", "5:00":"5:00 am", 
	"5:30":"5:30 am", "6:00":"6:00 am", "6:30":"6:30 am", "7:00":"7:00 am", "7:30":"7:30 am", "8:00":"8:00 am", 
	"8:30":"8:30 am", "9:00":"9:00 am", "9:30":"9:30 am", "10:00":"10:00 am", "10:30":"10:30 am", "11:00":"11:00 am", 
	"11:30":"11:30 am", "12:00":"12:00 pm", "12:30":"12:30 pm", "13:00":"1:00 pm", "13:30":"1:30 pm", "14:00":"2:00 pm", 
	"14:30":"2:30 pm", "15:00":"3:00 pm", "15:30":"3:30 pm", "16:00":"4:00 pm", "16:30":"4:30 pm", "17:00":"5:00 pm", 
	"17:30":"5:30 pm", "18:00":"6:00 pm", "18:30":"6:30 pm", "19:00":"7:00 pm", "19:30":"7:30 pm", "20:00":"8:00 pm", 
	"20:30":"8:30 pm", "21:00":"9:00 pm", "21:30","9:30 pm", "22:00":"10:00 pm", "22:30":"10:30 pm", "23:00":"11:00 pm", 
	"23:30":"11:30 pm"} />

<#assign end = {"0:30":"12:30 am", "1:00":"1:00 am", "1:30":"1:30 am","2:00":"2:00 am", 
	"2:30":"2:30 am", "3:00":"3:00 am", "3:30":"3:30 am", "4:00":"4:00 am", "4:30":"4:30 am", "5:00":"5:00 am", 
	"5:30":"5:30 am", "6:00":"6:00 am", "6:30":"6:30 am", "7:00":"7:00 am", "7:30":"7:30 am", "8:00":"8:00 am", 
	"8:30":"8:30 am", "9:00":"9:00 am", "9:30":"9:30 am", "10:00":"10:00 am", "10:30":"10:30 am", "11:00":"11:00 am", 
	"11:30":"11:30 am", "12:00":"12:00 pm", "12:30":"12:30 pm", "13:00":"1:00 pm", "13:30":"1:30 pm", "14:00":"2:00 pm", 
	"14:30":"2:30 pm", "15:00":"3:00 pm", "15:30":"3:30 pm", "16:00":"4:00 pm", "16:30":"4:30 pm", "17:00":"5:00 pm", 
	"17:30":"5:30 pm", "18:00":"6:00 pm", "18:30":"6:30 pm", "19:00":"7:00 pm", "19:30":"7:30 pm", "20:00":"8:00 pm", 
	"20:30":"8:30 pm", "21:00":"9:00 pm", "21:30","9:30 pm", "22:00":"10:00 pm", "22:30":"10:30 pm", "23:00":"11:00 pm", 
	"23:30":"11:30 pm","23:59":"11:59 pm"} />

<#macro displayEditorRow objectName>
	<#local objectPath = "userCommand.busyTimeCommand." + objectName />
	<#local labelPath = objectPath + ".label" />
	<#local daysPath = objectPath + ".days" />
	<#local allDayPath = objectPath + ".isAllDay" />
	<#local startTimePath = objectPath + ".startTime" />
	<#local endTimePath = objectPath + ".endTime" />
	
	<td> 
		<@spring.bind "${labelPath}" />
	  	<@spring.formInput "${labelPath}", 'size="20"' /><br /><font size="1">(Maximum characters: 50)</font><br/> 	
	</td>
	<td class="timeSelect">
		<input type="radio" name="busyTimeCommand.${objectName}.isAllDay" id="busyTimeCommand.${objectName}.isAllDay" value="true" onclick="toggleTimeDropdowns();" <#if "${allDayPath}"?eval>checked="checked"</#if> />
	  	All day --Or-- <br />
		<input type="radio" name="busyTimeCommand.${objectName}.isAllDay" id="busyTimeCommand.${objectName}.isAllDay" value="false" onclick="toggleTimeDropdowns();" <#if ! "${allDayPath}"?eval>checked="checked"</#if> />	
		<@spring.bind "${startTimePath}" />
		<#if "${allDayPath}"?eval>
			<@spring.formSingleSelect "${startTimePath}", start, "onchange='updateEndtime(\"busyTimeCommand.${objectName + \".startTime\"}\", \"busyTimeCommand.${objectName + \".endTime\"}\");' " />
		<#else>
			<@spring.formSingleSelect "${startTimePath}", start, "onchange='updateEndtime(\"busyTimeCommand.${objectName + \".startTime\"}\", \"busyTimeCommand.${objectName + \".endTime\"}\");' " />
		</#if>
	</td>
	<td class="timeSelect">
		to&nbsp;&nbsp;&nbsp;
		<@spring.bind "${endTimePath}" />
		<#if "${allDayPath}"?eval>
			<@spring.formSingleSelect "${endTimePath}", end/>
		<#else>
			<@spring.formSingleSelect "${endTimePath}", end />
		</#if>
	</td>
	<#list 0..6 as dayIndex>
		<td>
			<#local dayArray = daysPath?eval />
			<input type="hidden" name="_busyTimeCommand.${objectName}.days[${dayIndex}].checked" />
			<input type="checkbox" name="busyTimeCommand.${objectName}.days[${dayIndex}].checked" value="true"
            		<#if dayArray[dayIndex].checked >checked</#if>/>
		</td>
	</#list>
</#macro>