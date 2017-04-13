<#macro accordionHeaderCourse course incart>
	<#assign h3iddept = "${course.dept}"?trim />
	<#assign h3idnumb = "${course.number}"?trim />
	<#if !prefs.isAccessibleView()>
	
	
	<h3 id="h3_${h3iddept}_${h3idnumb}" class="expand">
	<table class="expand" width="100%"><tr><td width="2%" class="expand_td"></td><td width="18%">${course.dept}${course.number}</td>
	<#else>
	<h3><table class="expand" width="100%"><tr><td width="20%">${course.dept}${course.number}</td>
	</#if>
	<td width="60%">${course.title}</td><td width="20%" align="right">
	<#if course.chosenSession??>
		<#if course.registered>
		<span class="course-status registered">Registered</span> <br />
		<#else>
		<span class="course-status">Added</span> <br />
		</#if>
	</#if>
	
	<#if incart >
		<span class="course-status">In cart</span>
	</#if>
	</td></tr></table>
	<#if !prefs.isAccessibleView()>
		
	</#if>  </h3>
	<div class="collapse dd_${h3iddept}_${h3idnumb}" id="dd_${h3iddept}_${h3idnumb}">
</#macro>

<#macro accordionHeader text description>
	<#if !prefs.isAccessibleView()>
		<h3 id="h3_busy_times" class="expand">
			
				<table width="100%">
					<tr>
						<td width="2%" class="expand_td"></td>
						<td width="18%">${text}</td>
						<td width="60%">&nbsp;</td>
						<td width="20%" align="right">${description}</td>
					</tr>
				</table>
			
		</h3>
	<#else>
		<h3>
			<table width="100%">
				<tr>
					<td width="20%">${text}</td>
					<td width="60%">&nbsp;</td>
					<td width="20%" align="right">${description}</td>
				</tr>
			</table> 
		</h3>
	</#if>
	<div class="collapse dd_busy_times" id="dd_busy_times">
</#macro>

<#macro accordionFooter>
		</div>

</#macro>

<#macro courseTitle course divid incart>

	<#if prefs.isAccessibleView()>
		<div class="title">
			<table class="course-title" width="100%">
			<tr width="100%">
			<td class="course" width="8%">
				
				</td>
				<td class="course-description" width="62%"><div class="scrollable-description">${course.description}</div></td>
				<td width="30%" class="saved-session">
					<form method="POST" action="removeCoursePost">
						<input type="hidden" name="depart" value="${course.dept}">
						<input type="hidden" name="departNum" value="${course.number}">
						<input type="submit" value="<@spring.message "rw.schedule.remove_selection"/>"/>
					</form>
				<br />
				<#if course.chosenSession??>
					<#list course.chosenSession.sessionDecorator.simpleFormat as sessionText>
						${sessionText} <br />
					
					</#list>
				</#if>
				 </td>
				</tr> 
			</table>
				
		</div> 
		
		<form action="sched_save" method="POST"> 
		<#if course.sessions?size \gt  0>
			<button type="submit" name="_eventId_savesession" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" 
				role="button" aria-disabled="false" <#if incart >disabled="disabled"</#if>><span class="ui-button-text"><@spring.message "rw.schedule.add_selection"/></span></button>
			<br/>
		</#if>
	
	<#else>
		<#assign formid = "f${divid}" />
		<form id="${formid}" method="POST" action="sched_save"> 
		<div class="title">
			<table class="course-title" width="100%">
				<tr width="100%">
					<td class="course" width="8%">
						<#if course.sessions?size \gt  0>
							<button type="submit" class="btn btn-success" style="width: 80px;"
								role="button" aria-disabled="false" <#if incart >disabled="true"</#if> 
								<#if incart >title="Course already in cart, cannot add." alt="Course already in cart, cannot add."
								<#else>title="Click to add the selected session." alt="Click to add the selected session."</#if>>
								<i class="icon-plus-sign icon-white"></i> <@spring.message "rw.schedule.add_selection"/></button>
						</#if>
					</td>
					<td class="course-description" width="62%">
						<div class="scrollable-description">${course.description}</div>
					</td>
					<td width="30%" class="saved-session">
						<button class="btn btn-danger" onclick="removeCourse('${course.noFormatId}','${formid}')" 
							 alt="Click to delete this course." title="Click to delete this course.">
							<i class="icon-trash icon-white"></i> Delete</button>
						<br />
						<#assign icidx = 0 />
						<#if course.chosenSession??>
							<#list course.chosenSession.sessionDecorator.simpleFormat as sessionText>
								<#if icidx != 0><br /><#assign icidx = 1 /></#if>${sessionText} 
							
							</#list>
						</#if>
					</td>
				</tr> 
			</table>
	</div> 
	</#if>
	
</#macro>

<#macro infoTab userCommand>
	
	<div class="info_tab">
			<form name="courseinfo_1" action="" method="POST">
			
			<table>
		  	<tr>
		  		<td class="td-info-user"><@spring.message "rw.schedule.name"/>:</td>
		  		<td>${userCommand.currentUser.name}</td>
		  	</tr>
		  	<tr>
		  		<#if !prefs.isAccessibleView()>
		  			<td class="td-info-user"><@spring.message "rw.schedule.yearTerm"/>:</td>
		  		</#if>
		  		<td>
		  		
		  				<@spring.bind "userCommand.currentUser.currentYearTerm.yearTerm.yearTerm" />
		  				
		  				<#if !prefs.isAccessibleView()>
							  <select size="1" name="currentUser.currentYearTerm.yearTerm.yearTerm" 
							  	id="currentUser.currentYearTerm.yearTerm.yearTerm" >
							  <#list userCommand.availTerms as availTerm >
							  	<#if userCommand.currentUser.currentYearTerm.yearTerm.yearTerm == availTerm.yearTerm >
							  		<option value="${availTerm.yearTerm}" selected="selected">${availTerm.displayTerm}</option>
							  	<#else>
						      		<option value="${availTerm.yearTerm}">${availTerm.displayTerm}</option>
						      	</#if>
						      </#list>
				     		  </select>
				     		  <input type="submit" value="<@spring.message "rw.schedule.yearTerm.change"/>" onclick="return submitGotoYearTerm(this)"/>
				     		  
						<#else>
							<h4>Change: <@spring.message "rw.schedule.yearTerm"/></h4>
							<#list userCommand.availTerms as availTerm >
							<#if userCommand.currentUser.currentYearTerm.yearTerm.yearTerm == availTerm.yearTerm >
								<li><a href="gotoYearTerm/${availTerm.yearTerm}" id="selected">Current: ${availTerm.displayTerm}</a></li>
							<#else>
								<li><a href="gotoYearTerm/${availTerm.yearTerm}" id="not-selected">${availTerm.displayTerm}</a></li>
							</#if>
							</#list>
							</br>
						</#if>
				</td>
			</tr>
		  	<tr>
		  		<td class="td-info-user"><@spring.message "rw.schedule.eligible"/>:</td>
		  		<#if !prefs.isAccessibleView()>
			  		<#if userCommand.currentUser.currentYearTerm.canRegister>
			  			<td style="color: green;"> <#else> <td style="color: red;"> 
		  			</#if> 
		  		<#else> <td> </#if>	
		  			<#assign registerText=userCommand.currentUser.currentYearTerm.firstDayToRegister>
		  			<#if registerText = "">
		  				<@spring.message "rw.schedule.dateNotFound"/>
		  			<#else>
		  				${registerText}
		  			</#if>
		  			
		  		</td>
		  	</tr>
		  </table>
		  </form>
		  <form name="sched_info" action="sched_info" method="POST">
		  <#assign noneSelected = true />
		  <hr />
		  <div class="action_header">
		  
		  <#if !prefs.isAccessibleView()>
			  <input type="checkbox" id="selectAllCourses" name="selectAllCourses" onclick="toggleSelectAllCourses();" />
			  <#assign remove_selection>
			  	<@spring.message "rw.schedule.remove_selection"/>
			  </#assign>
			  <#assign register_selection>
			  	<@spring.message "rw.schedule.register"/>
			  </#assign>
			  
			  <#assign otherActions = {"prompt":"Other Actions...", "register":"${register_selection}","delete":"${remove_selection}"} />
	
			  <@spring.bind "userCommand.otherAction" />
			  <@spring.formSingleSelect "userCommand.otherAction", otherActions />
			  <input type="submit" value="<@spring.message "rw.schedule.action"/>" name="_eventId_moreActions"  alt="More actions" 
			  <#if userCommand.currentUser.currentYearTerm.canRegister> 
			  	onclick="javascript:otherActionsSubmit(true);" 
			  <#else>
			  	onclick="javascript:otherActionsSubmit(false);" 
			  </#if>/>
			  <input type="hidden" id="redirectLink" name="redirectLink" value="${userCommand.redirectLink}"/>
		  <#else>
				<input type="submit" value="<@spring.message "rw.schedule.remove_selection"/>" name="remove selection" alt="remove selection" 
				onclick="javascript: form.action='infoRemove';"/>
				<#if userCommand.currentUser.currentYearTerm.canRegister> 
					<input type="submit" value="<@spring.message "rw.schedule.register"/>" name="register selection" alt="register selection" 
					onclick="javascript: form.action='registerCourse';  window.open('${userCommand.redirectLink}');"/>
		  		<#else>
		  			<input type="submit" value="<@spring.message "rw.schedule.register"/>" name="register selection" alt="register selection" disabled/>
		  		</#if>
		  </#if>
		    
		  </div>
		  <#assign altRow = true />
		  
			  <#if !prefs.isAccessibleView()>
			  	<div id="course-section-wrapper">
				<table class="" width="100%" >
			  <#else>
				<table class="" width="100%" border="1">
			  </#if>
			  
			  <#assign maxCourseSize = userCommand.currentSchedule.courseSize - 1 />
			  <#assign courseArray = userCommand.currentSchedule.courseArray />
			
			<#list 0..maxCourseSize as courseIndex>
			
			
			
				<#if courseArray[courseIndex]?? && courseArray[courseIndex].chosenSession??>
					<#if noneSelected>
						<!-- <tr><th></th><th class="th-info-course">Course</th><th class="th-info-course">Section</th> <th class="th-info-course">Time</th></tr>
						--><#assign noneSelected = false />
					</#if>
					<#if altRow>
  	 				 	<tr class="altInfoRow">
  	 				 	<#assign altRow = false />
  	 				<#else>
  	 					 <tr>
  	 					 <#assign altRow = true />
  	 				</#if>
					<td class="td-info-course">
						<@spring.bind "userCommand.currentSchedule.courseArray[${courseIndex}].selected" />
						<input type="checkbox" name="${spring.status.expression}" value="true" onclick="toggleSelectAllControlCheckbox();" />
						<input type="hidden" name="_${spring.status.expression}">
					</td>
					<td class="td-info-coursen">${courseArray[courseIndex].dept}${courseArray[courseIndex].number}</td>
					<td class="td-info-section">${courseArray[courseIndex].chosenSession.sessionId}</td>
					<td class="td-info-time">
						<table class="tb-simple">
							<#list courseArray[courseIndex].chosenSession.sessionDecorator.simpleSplitFormat as sessionInfo>
								<tr>
									<td class="simple-time">${sessionInfo[0]! ""}</td>
									<td class="simple-day">${sessionInfo[1]! ""}</td>
								</tr>
							</#list>
						</table>
					</td>
					</tr>
				</#if>
			</#list>	
		  
		  </table>
		  <#if !prefs.isAccessibleView()>
		  </div>
		  </#if>
		  </form>
		  <br/>
		  <div class="help_text">
		  <hr/>
		  <form action="findCourses" id="formTitleSearch" >
			<input type="text" name="titleSearch" class="search-query" placeholder="Find Courses..."/>
			<div id="findCHelp"></div>
			</form>
			<br />
			<br />
		  ${userCommand.scheduleHelp}
    	  </div>
		  	</div>
		 
  
</#macro> 

<#macro sessionHeader tableId="">
<div class="crscontainer"> 
<#if !prefs.isAccessibleView()>
	<table class="table table-striped table-super-condensed" width="100%" <#if tableId?length gt 0>id="course_table_${tableId}" name="course_table_${tableId}" </#if>> 
<#else>
	<table class="table table-striped table-condensed" width="100%" <#if tableId?length gt 0>id="course_table_${tableId}" name="course_table_${tableId}" </#if> border="1"> 
</#if>
	<thead>
	<tr class="cshl"> 
		<th class="srth"><@spring.message "rw.schedule.available"/></th> 
		<th class="srth"><@spring.message "rw.schedule.section"/></th>
		<th class="cshr srth">Start</th> 
		<th class="cshr srth">End</th>
		<th class="spacer"></th>
		<th>M</th> 
		<th>T</th> 
		<th>W</th> 
		<th>H</th> 
		<th>F</th> 
		<th>S</th> 
		<th>S</th> 
		<th class="spacer"></th>
		<th class="cshl srth"><@spring.message "rw.schedule.instructor"/></th> 
		<th class="srth"><@spring.message "rw.schedule.seats"/></th> 
		<th class="cshl srth"><@spring.message "rw.schedule.room"/></th>
		<th class="cshl srth"><@spring.message "rw.schedule.campus"/></th>
		<th class="cshl srth"><@spring.message "rw.schedule.delivery"/></th>		
	</tr> 
	</thead>
</#macro>

<#macro displayOptionsBar>
<div id="optionsBar">
	<table id="optionsBar">
			<tr>
			<td>
			<#if !prefs.isAccessibleView()>
				<#if userCommand.hideConflicts>
					<input type="checkbox" id="hideConflict" onclick="hideConflict()" checked="checked"/>
				<#else>
					<input type="checkbox" id="hideConflict" onclick="hideConflict()" />
				</#if>
			</#if>
			</td>
			<td>
			<#if !prefs.isAccessibleView()>
				<#if userCommand.hideConflicts>
					<@spring.message "rw.schedule.hide_conflicts" />
				<#else>
					<@spring.message "rw.schedule.hide_conflicts" />
				</#if>
			</#if>
			</td>
			</tr>
			<tr>
			<td><i class="icon-refresh"></i>
			</td><td><#assign refresh_enr_url>
				<@spring.url relativeUrl="/sec/refreshEnrolledCourses"/></#assign>
			<a href="${refresh_enr_url}"><@spring.message "rw.schedule.refresh" /></a></td>
			</tr>
			</table>
</div>
</#macro>

<#macro sessionLinkRow divid>
		
</#macro>

<#macro sessionFooter>
</table>
</div>
</#macro>
