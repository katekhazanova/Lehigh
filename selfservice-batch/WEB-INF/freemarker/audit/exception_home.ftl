<@layout.head title="My Audit" />
<@layout.body hideMenu=printerFriendly>
<#assign redauth=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<input type="hidden" id="pageGroup" value="audits"/>
<#if !useFile>
<#-- ========== DISPLAY AUDIT ========== -->
<#if showAudit>
	<input type="hidden" id="exceptionMode"value="true"/>
  	<div class="row">
  	<h1 class="sr-only">Exception Mode</h1>
  	<h2 class="sr-only">Student and Audit Information</h2>
		<div class="col-md-2" style="font-size:16px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
			${audit.prefixName!''} ${audit.firstName!''} ${audit.middleName!''} ${audit.lastName!''} ${audit.suffixName!''} ${audit.stuName!''}
		</div>
		<div class="col-md-3" style="font-size:16px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
				<#if audit.dptitle1??>${audit.dptitle1!''} <br /></#if>
					<#if audit.dptitle2??>${audit.dptitle2!''} <br /></#if>
					<#if audit.webtitle??>${audit.webtitle!''} <br/></#if>
		</div>
		<div class="col-md-2" style="font-size:16px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
			${audit.dprog!''}
		</div>
		<div class="col-md-2" style="font-size:16px;margin-bottom: 10px;font-weight: 500; line-height: 1.1; margin-top:10px;">
			${termService.getFriendlyNameFromCode(audit.catlyt)!audit.catlyt}
		</div>
		<div class="col-md-3 pull-right">
			<a class="btn btn-default" href="<@s.url />/audit/read.html">Exit Exception Mode</a>
		</div>
	</div>
	
	<hr style="margin-top: 0px;">
	
	<div class="row">
		<div id="ExceptionAdded" class="col-md-offset-3 col-md-6 alert alert-success" style="display:none;">
			<center><strong>Success!</strong> One or more Exceptions have been recently added please run the audit for them to apply.</center>
		</div>
		<div id="loadingAudit" class="col-md-offset-3 col-md-6 alert alert-info" style="display:none;">
			<#assign updateMsg = "updating every ${auditConfig.auditPollingRate} seconds" />
			<center><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> <strong>Loading...</strong> The audit you requested is running, ${updateMsg}</center>
		</div>
	</div>
	
	<#-- ========== AUDIT MENU ========== -->
<div class="row">
<h2 class="sr-only">Audit Result Details</h2>
  	<div class="col-md-7">				
	<#if displayHtmlReport()>
		<div id="auditResults">
			<div id="auditMenu">
				<#--
					Adds the "Open All Sections" and "Close All Sections" links to the top of the audit.
					This toolbar is hidden initially (display:none;) and is only displayed to user agents that have javascript enabled.
					See selfservice.audit.initAudit() javascript for more info.
				-->
				<div class="aligncenter auditHeaderMessage">
					<@s.message 'audit.htmlHeaderMessage' />
				</div>
				
				<p id="expandCollapseAllLinks" style="display:none;">
					<a href="#" id="expandAll">Open All Sections</a> <span class="spacer">&nbsp;</span> 
					<a href="#" id="collapseAll">Close All Sections</a>
				</p>
						
				<#if !printerFriendly>
					<@help.tooltip topic="auditresults" />
				</#if>		
				
			</div> <!-- end auditMenu -->
	
			<#-- ========== AUDIT REPORT ========== -->
			<#--${report}-->
			<br/>
			<@readerDumper reader=reportReader />
			
			<#assign collapseReqs = auditConfig.autoCollapseStandardView />
			
			<script type="text/javascript">
				Event.observe(window, 'load', function() {
					selfservice.audit.initAudit('<@h.url href="/plannedcourse/preview.html" />', ${auditConfig.specialEffects?string}, '${seriesIdentifierClass}', ${collapseReqs?string});
				}); 
			</script>
		</div>
	</#if>
	</div>
	<div id="exceptionList" class="col-md-5" >
		      <h2 style="margin-bottom: 0px;">Exceptions</h2>
		      <br/>
		      	<table id="currentExceptions" class="table table-striped table-bordered table-hover table-condensed">
		      	<tr>
		      		<th>ctlcd</th>
		      		<th>Note</th>
		      		<th>Auth by</th>
		      		<th>Auth Date</th>
					<#--<th>Delete</th>-->
					
		      	</tr>
		      	<#list exceptions as exception>
		      	<tr id="exception-${exception.intSeqNo?c}">
		      	<td>${exception.ctlcd}</td>
		      	<td>${exception.cline!''}</td>
		      	<td><#if exception.authId?? >${exception.authId}</#if></td>
		      	<td><#if exception.authDate?? >${exception.authDate}</#if></td>
		      	<#--<td>
		      		<#if deleteMap[exception.ctlcd] == "true">
		      		<button id="remove-exception-${exception.intSeqNo?c}" class="btn btn-danger btn-xs"  onclick="removeException('${exception.intSeqNo?c}','${exception.ctlcd}')"><i class="fa fa-trash-o"></i></button>
		      		</#if>
		      	</td>-->
		      	</tr>
		      	</#list>
		      	</table>
  	</div>
	
  	<div id="exceptMod" class="col-md-5" style="display: none;">
		<div class="well">
			<h4 style="margin-top: 0px;"><span class="exceptMod-editName"></span> Exception</h4>
			
			<div class="row">
				<div class="col-md-12">
					<label class="control-label" style="text-align: left;"><span class="exceptMod-reqText-label"></span></label>
				</div>
				<div class="col-md-12">
					<span class="exceptMod-reqText"></span>
				</div>
			</div>
    		
			<ul id="two-step-nav" class="nav nav-tabs"  role="navigation" style="margin: 15px 0px 15px 0px;">
			  <li id="exceptMod-nav-step1" class="active"><a href="#" onclick="showExceptMod1()">1. <span id="nav-step1-label"></span></a></li>
			  <li style="display: none;"  id="exceptMod-nav-step2" ><a href="#" onclick="showExceptMod2()">2. <span id="nav-step2-label"></span></a></li>
			   <li style="display: none;" id="exceptMod-nav-step3" ><a href="#" onclick="showExceptMod3()">3. <span id="nav-step3-label"></span></a></li>
			</ul>
			
			<div class="row reqMod" style="display: none;">
				<div  class="col-md-6">
					<div id="reqSubCountLabel" class="reqSubCountEditBox"  style="font-weight: bold;">
						Required Sub-requirements
					</div>
					<div class="reqSubCountEditBox" >
						<form>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td style="padding-right: 5px;"><span style="font-style: italic;color: #777;">Original Value: </span></td>
									<td> </td>
									<td id="req-sub-count-org" style="text-align: center;color: #777;"> 2</td>
									<td> </td>
								</tr>
								<tr>
									<td style="padding-right: 5px;"><span>Adjust by: </span></td>
									<td class="reqMod-step1"><input type="button" aria-label="Decriment Required Sub-requirements" class="reqAdjustButton btn btn-default" value=" - " onclick="this.form.subCount.value--;" style="margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step1"><input type="text" aria-label="Required Sub-requirements" id="req-sub-count-edit" class="req-count-edit form-control" name="subCount" value="0" maxlength="3" style="padding: 0px; width:60px;height:23px;text-align: center;" /></td>
									<td class="reqMod-step1"><input type="button" aria-label="Incriment Required Sub-requirements" class="reqAdjustButton btn btn-default" value=" + " onclick="this.form.subCount.value++;" style="margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step2"></td>
									<td id="req-sub-count-show" class="reqMod-step2">0</td>
									<td class="reqMod-step2"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="col-md-6">
					<div style="font-weight: bold;">
						Required <@s.message 'uachieve.selfservice.course.credit.label'/>s
					</div>
					<div>
						<form>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td style="padding-right: 5px;"><span style="font-style: italic;color: #777;">Original Value: </span></td>
									<td> </td>
									<td id="req-hour-count-org" style="text-align: center;color: #777;"> 0</td>
									<td> </td>
								</tr>
								<tr>
									<td style="padding-right: 5px;"><span>Adjust by: </span></td>
									<td class="reqMod-step1"><input type="button" aria-label="Decriment Required <@s.message 'uachieve.selfservice.course.credit.label'/>s" class="reqAdjustButton btn btn-default" value=" - " onclick="this.form.hourCount.value--;" style="font-size:12px;margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step1"><input type="text" aria-label="Required <@s.message 'uachieve.selfservice.course.credit.label'/>s" id="req-hour-count-edit" class="req-count-edit-decimal form-control" name="hourCount" value="0.00" maxlength="12" style="padding: 0px; width:60px;height:23px;text-align: center;" /></td>
									<td class="reqMod-step1"><input type="button" aria-label="Incriment Required <@s.message 'uachieve.selfservice.course.credit.label'/>s" class="reqAdjustButton btn btn-default" value=" + " onclick="this.form.hourCount.value++;" style="font-size:12px;margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step2"></td>
									<td id="req-hour-count-show" class="reqMod-step2">0.00</td>
									<td class="reqMod-step2"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>	
				
			<div class="row reqMod" style="display: none;">	
				<div class="col-md-6">
					<div class="requiredCourseCountEditBox" style="font-weight: bold;">
						Required Course Count
					</div>
					<div class="requiredCourseCountEditBox" >
						<form>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td style="padding-right: 5px;"><span style="font-style: italic;color: #777;">Original Value: </span></td>
									<td> </td>
									<td id="req-course-count-org" style="text-align: center;color: #777;"> 0</td>
									<td> </td>
								</tr>
								<tr>
									<td style="padding-right: 5px;"><span>Adjust by: </span></td>
									<td class="reqMod-step1"><input type="button" aria-label="Decriment Required Course Count" class="reqAdjustButton btn btn-default" value=" - " onclick="this.form.courseCount.value--;" style="font-size:12px;margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step1"><input type="text" aria-label="Required Course Count" id="req-course-count-edit" class="req-count-edit form-control" name="courseCount" value="0" maxlength="3" style="padding: 0px; width:60px;height:23px;text-align: center;" /></td>
									<td class="reqMod-step1"><input type="button" aria-label="Incriment Required Course Count" class="reqAdjustButton btn btn-default" value=" + " onclick="this.form.courseCount.value++;" style="font-size:12px;margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step2"></td>
									<td id="req-course-count-show" class="reqMod-step2">0</td>
									<td class="reqMod-step2"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="col-md-6">
					<div style="font-weight: bold;">
						Required GPA
					</div>
					<div>
						<form>
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td style="padding-right: 5px;"><span style="font-style: italic;color: #777;">Original Value: </span></td>
									<td> </td>
									<td id="req-gpa-count-org" style="text-align: center;color: #777;"> 0</td>
									<td> </td>
								</tr>
								<tr>
									<td style="padding-right: 5px;"><span>Adjust by: </span></td>
									<td class="reqMod-step1"><input type="button" aria-label="Decriment Required GPA" class="reqAdjustButton btn btn-default" value=" - " onclick="this.form.gpaCount.value--;" style="font-size:12px;margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step1"><input type="text" aria-label="Required GPA" id="req-gpa-count-edit" class="req-count-edit-decimal form-control" name="gpaCount" value="0.00" maxlength="12" style="padding: 0px; width:60px;height:23px;text-align: center;" /></td>
									<td class="reqMod-step1"><input type="button" aria-label="Incriment Required GPA" class="reqAdjustButton btn btn-default" value=" + " onclick="this.form.gpaCount.value++;" style="font-size:12px;margin:0;padding:0;width:23px;height:23px;" ></td>
									<td class="reqMod-step2"></td>
									<td id="req-gpa-count-show" class="reqMod-step2">0.00</td>
									<td class="reqMod-step2"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
			
			<div id="addReqAdjustBox" class="courseMod-step2 row" style="margin-bottom: 10px; text-decoration: underline; display: none; cursor: pointer;"> 
   				<a id="showReqAdustButton" href="#" onclick="showReqAdjust()">Need to modify the subrequirement? Click here.</a>
   				<a id="hideReqAdustButton" href="#" onclick="hideReqAdjust()" style="display: none;">Cancel subrequirement changes? Click here.</a>
   			</div>
			
			<div class="courseMod-step1 row" style="display: none;">
				<div class="col-md-6">
					<div class="manaul-add-course"  style="font-style: italic;">
						Find the course you want to use:
					</div>
					<div class="manaul-add-course col-md-12" style="padding-left: 0px;">
						<table class="table">
							<tr>
   									<td style="border-top: 0px;padding-bottom: 2px;font-weight: bold;">Dept</td>
   									<td style="border-top: 0px;padding-bottom: 2px;font-weight: bold;">Course</td>
   									<td style="border-top: 0px;padding-bottom: 2px;"></td>
							</tr>
							<tr style="border-top: 0px;">
								<td style="border-top: 0px;padding-top: 0px; "> <input style="width: 65px;" type="text" class="form-control" id="departSearch" size="4"> </td>
								<td style="border-top: 0px;padding-top: 0px; "> <input style="width: 65px;" type="text" class="form-control" id="numberSearch"> </td>
								<td style="border-top: 0px;padding-top: 4px;"> <button class="reqAddCourse btn btn-success btn-xs" alt="Add Course" title="Add Course" onclick="manualAddChosenCourse()"><i class="fa fa-plus"><span class="sr-only">add course</span></i></button> </td>
							</tr>
						</table>
					</div>
					
					<div style="font-style: italic;">
						<span class="manaul-add-course">OR</span> <span id="course-list-label"></span>
					</div>
					<div id="course-taken-list" class="col-md-12" style=" overflow: auto; height: 200px;">
						<table id="course-taken-table">
							<tbody>
								<#assign pastTerm = ''>
								<#list pastCourses as course>
									<#if course.yt != pastTerm>
										<tr>
											<td><span class="exc-term">${course.yt}</span></td>
											<td></td>
										</tr>
									</#if>
									<tr class="taken-course" id="exc-course-${course.intSeqNo?c}" >
										<td  class="exc-stuff">
											<input type="hidden" id="exc-course-date-${course.intSeqNo?c}" value="${course.yt}">
											<span id="exc-course-name-${course.intSeqNo?c}" class="exc-course">${course.xcourse}</span>  <br>
											<span id="exc-course-hours-${course.intSeqNo?c}" class="exc-hours">(${course.credit} <@s.message 'uachieve.selfservice.course.credit.label'/>s)</span> <span id="exc-course-grade-${course.intSeqNo?c}" class="exc-grade">${course.grade!''}</span><br/>
											<span id="exc-course-title-${course.intSeqNo?c}" class="exc-title">${course.ctitle!""}</span>
										</td>
										<td class="exc-stuff">
											<button class="reqAddCourse btn btn-success btn-xs" style="margin-bottom: 7px;" onclick="addChosenCourse(${course.intSeqNo?c})"><i class="fa fa-plus"><span class="sr-only">add course</span></i></button>
										</td>
									</tr>
								<#assign pastTerm = course.yt>
								</#list>
							</tbody>
						</table>
					</div>
					<div id="course-remove-list" class="col-md-12" style=" overflow: auto; height: 200px;">
						<table id="removeListTable">
   						</table>
   					</div>
				</div>
				
				<div id="chosen-box" class="col-md-6" style="border:2px solid orange;">
					<div class="col-md-12">
						<span class="courseMod-chosen-label" style="font-style: italic;"></span>
					</div>
					<div class="col-md-12">
						<table id="chosen-course-table" style="display: none;">
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
				
				<div id="chosen-box2" class="col-md-6" style="display: none; border:2px solid orange;" >
					<div class="col-md-12">
						<span class="courseMod-chosen-label2" style="font-style: italic;"></span>
					</div>
					<div class="col-md-12">
						<table id="chosen-course-table2">
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div class="courseMod-step2 row" style="display: none;">
				<div class="col-md-6">
					<span class="courseMod-chosen-label" style="font-style: italic;"></span>
					<table id="final-course-table">
					</table>
				</div>
				<div class="exceptMod-final2 col-md-6">
					<span class=" courseMod-chosen-label2" style="font-style: italic;"></span>
					<table id="final-course-table2">
					</table>
				</div>
			</div>
			
			<div class="courseMod-step2 row" style="display: none;">
			
				<div class="col-md-12">
					<span style="font-style: italic;"> Into:</span>
				</div>
				<div class="col-md-12">
					<div class="exceptMod-reqText"></div>
					<div class="exc-title">
						Using pseudo of <span id="exceptMod-psuedo"></span>
					</div>
				</div>
			</div>
			
			<div class="forceComplete row" style="display: none;">
			   This Exception will force the current <span class="exceptMod-reqText-label"></span> to Completion.
			</div>
			
			<div class="row exceptMod-final" style="display: none;">
				  <div class="form-group" style="padding-top: 20px;">
				      <div class="checkbox-inline">
				          <input id="includeDprog" type="checkbox" checked> Restrict to this Degree Program.
				      </div>
				      <div class="checkbox-inline" id="rnameCheckbox">
				          <input id="includeRname" type="checkbox" checked> Restrict to this Requirement.
				      </div>
				  </div>
				<div class="col-md-12">
					<form class="form-horizontal" role="form">
						<div class="form-group">
						    <label class="col-md-25 control-label" style="text-align: left;">Audit Note</label>
						    <div class="col-md-95">
						      <input class="inputNote form-control" maxlength="27" >
						      <font class="small">(Maximum characters: 27)</font>
						    </div>
						</div>
						<div class="form-group">
						    <label class="col-md-25 control-label" style="text-align: left;">Memo</label>
						    <div class="col-md-95">
						      <textarea class="inputMemo form-control" rows="3" maxlength="255"></textarea>
						      <font class="small">(Maximum characters: 255)</font>
						    </div>
						</div>
						<div class="row">
						    <div class="col-md-6 ">
						       <label class=" control-label" style="text-align: left;">Authorized by</label>
						      <input class="inputAuthorized form-control" placeholder=" " style="width: 165px;" maxlength="30">
						   	  <font class="small">(Maximum characters: 30)</font>
						    </div>
						    
						    <div class="col-md-6" >
						      <label class=" control-label" style="text-align: left;">Date</label>
						      <input class="inputBy form-control" placeholder=" " style="width: 165px;" maxlength="27" >
						    </div>
						</div>
					</form>
				</div>
			</div>
			<br/>
			<hr style="margin-top: 5px;">
			<div class="row">
				<button id="exceptMod-back" class="btn btn-default" >Back</button>
	            <button id="exceptMod-next" class="btn btn-success" style="display: none;">Next</button>
	            <span id="exceptMod-coursePrompt" class="btn btn-info" style="display: none;">Select at least one course</span>
	            <span id="exceptMod-valuePrompt" class="btn btn-info" style="display: none;">Alter at least one value</span>
                <button class="exceptMod-final btn btn-primary" onclick="addAuditException('true')" style="display: none;">Save & Run Audit</button>
        		<button class="exceptMod-final btn btn-success" onclick="addAuditException('false')" style="display: none;">Save & Add Exception</button>
                <button  class="btn btn-default" onclick="showExceptionList()">Cancel</button>
	        </div>
	        <span id="exceptMod-requirements" class="sr-only" aria-live="polite" aria-atomic="true" aria-relevant="all"></span>
		</div> <!-- /Well -->
		
		<input type="hidden" id="exceptMod-change-step1" value="false"/>
		<input type="hidden" id="exceptMod-change-step2" value="false"/>
		<input type="hidden" id="selected-reqId" value=""/>
		<input type="hidden" id="selected-subreqId" value=""/>
		<input type="hidden" id="selected-fromId" value=""/>
		<input type="hidden" id="exceptionType" value=""/>
		<input type="hidden" id="hours-label" value="<@s.message 'uachieve.selfservice.course.credit.label'/>"/>
		<input type="hidden" id="reqAdjustButton" value="${reqMod}"/>
		<input type="hidden" id="forceCompleteButton" value="${forceComplete}"/>
		<input type="hidden" id="forceCourseButton" value="${forceCourse}"/>
		<input type="hidden" id="removeCourseButton" value="${removeCourse}"/>
		<input type="hidden" id="addCourseButton" value="${addCourse}"/>
		<input type="hidden" id="swapCourseButton" value="${swapCourse}"/>
		
		<script type="text/javascript" >
			var authCodes =[
			<#list authCodes as authCode>
				'${authCode?trim}',
			</#list>
			];
		</script>
		
	</div><!--/course mode col -->
</div><!-- /Page Row -->
<br>
<div class="row">
	<@h.statusLegend />
</div>
  	
</#if>
</#if>
</@layout.body>

<#function displayHtmlReport><#return reportType?string?upper_case == "HTM" /></#function>
<#function displayPdfReport> <#return reportType?string?upper_case == "PDF" /></#function>