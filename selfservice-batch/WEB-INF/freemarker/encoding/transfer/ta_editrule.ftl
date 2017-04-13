
<div class="row" style="padding-top: 10px;border-bottom: 1px solid #55ccdd;margin-left: 1px;margin-right: 1px;">
	<div class="col-md-2" style="align: middle;">
		<h4>Selected Segment:</h4>
	</div>
	<div class="col-md-4">
		<select class="form-control input-sm" id="segment-dd" onchange="changeSegment()" <#if segment??>autofocus</#if> >
			<#list segList as segment>
			<option <#if selectedRule.tseg = segment.tseg>selected</#if> value="${segment.tseg}">${segment.tseg} - ${segment.hint!''}</option>
			</#list>
		</select>
	</div>
	<div class="col-md-6">
		<span class="pull-right">
			<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
			Add new rule to this segment at line <input type="text" class="" id="insertRule" maxlength="9"  value="${ruleCount+1}" style="width: 30px;">
			<a href="#" onclick="addRule()" class="btn btn-success btn-xs" accesskey="r"><i class="fa fa-plus"></i> Add</a>
			</@redauth.authorize>
		</span>
	</div>
</div>

<div class="row" style="padding-top: 15px;">
	<div id="segmentSide" class="col-sm-2 col-md-2">
		<#include "ta_rule_list.ftl" />
	</div>
	<div id="ruleConent" class="col-sm-10 col-md-10">
	
		<input type="hidden" id="blankc" value="${blankc}"/>
		<input type="hidden" id="anyc" value="${anyc}"/>
	
		<div id="ruleForm" class="ruleGroup">
			<div class="row ruleHeader">
				<div class="col-md-8">
					<h3 class="noMarginTop">
						<a href="#" type="button"  data-toggle="collapse" data-target="#rule, #deleteRule" onclick="rotateChevron('ruleChevron1'); return false;" aria-expanded="true"  aria-controls="rule, deleteRule">
							<i id="ruleChevron1" class="fa fa-chevron-down" style="font-size: 14px;"></i>  
							Rule <span id="ruleLabel-number">${selectedRule.userSeqNo?c}</span> Control Area
						</a>
					</h3>
				</div>
				<div class="col-md-4 collapse in" id="deleteRule">
					<span class="pull-right">
						<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
						<button type="button" class="btn btn-danger btn-xs" title="Delete Rule" onclick="deleteSelectedRule()"><i class="fa fa-trash"></i> Delete Rule</button>
						</@redauth.authorize>
					</span>
				</div>
			</div>
			<div class="collapse in" id="rule">
				<div class="row">
				<div class="col-md-12" style="padding-left: 0px;">
					<input type="hidden" id="rule-intSeqNo" value="${selectedRule.intSeqNo?c}">
					<form role="form">
						<div class="form-group col-md-1">
							<label for="ruleNum">Rule #</label>
							<input type="text" class="form-control input-sm" value="${selectedRule.userSeqNo?c}" id="rule-userSeqNo"  name="ruleNum" maxlength="9" 
							onfocus="setVisibility('ta_rulenumHelp','inline')" onBlur="setVisibility('ta_rulenumHelp','none')">
						</div>
						<div class="form-group col-md-2">
							<label for="segment">Segment</label>
							<select class="form-control input-sm" id="rule-segment" name="rule-segment"
							onfocus="setVisibility('ta_tsegHelp','inline')" onBlur="setVisibility('ta_tsegHelp','none')">
							<#list segList as segment>
								<option <#if selectedRule.tseg = segment.tseg>selected</#if>  value="${segment.tseg}">${segment.tseg} - ${segment.hint!''}</option>
							</#list>
							</select>
						</div>
						<div class="form-group col-md-1">
							<label for="cond">Cond</label>
								<input type="text" class="form-control input-sm" id="rule-cond" value="${selectedRule.cond!''}"
									maxlength="1" onfocus="setVisibility('ta_condHelp','inline')" onBlur="setVisibility('ta_condHelp','none')";>
						</div>
						<div class="form-group col-md-1">
							<label for="limct">Min Ct</label>
							<input type="text" class="form-control input-sm" id="rule-limct" value="<#if selectedRule.limct?has_content>${selectedRule.limct?c}</#if>"
								maxlength="2" onfocus="setVisibility('ta_limctHelp','inline')" onBlur="setVisibility('ta_limctHelp','none')";>
						</div>
						<div class="form-group col-md-1">
							<label for="limhrs">Min Hrs</label>
							<input type="text" class="form-control input-sm" id="rule-limhrs" value="<#if selectedRule.limhrs?has_content>${selectedRule.limhrs?c}</#if>"
							maxlength="11" onfocus="setVisibility('ta_limhrsHelp','inline')" onBlur="setVisibility('ta_limhrsHelp','none')";>
						</div>
						<div class="form-group col-md-1">
							<label for="ctlcd">Ctl Cd</label>
							<input type="text" class="form-control input-sm" id="rule-ctlcd" value="${selectedRule.ctlcd!''}"
								maxlength="2"onfocus="setVisibility('ta_ctlcdHelp','inline')" onBlur="setVisibility('ta_ctlcdHelp','none')";>
						</div>
						<div class="form-group col-md-1">
							<label for="ac">Accept</label>
							<input type="text" class="form-control input-sm" id="rule-ac" value="${selectedRule.ac!''}"
								 maxlength="1" onfocus="setVisibility('ta_acHelp','inline')" onBlur="setVisibility('ta_acHelp','none')";>
						</div>
						<div class="form-group col-md-1">
							<label for="rc">Reject</label>
							<input type="text" class="form-control input-sm" id="rule-rc" value="${selectedRule.rc!''}"
								maxlength="1" onfocus="setVisibility('ta_rcHelp','inline')" onBlur="setVisibility('ta_rcHelp','none')";>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label for="rule-tastatus">Hide from Transferology <br>& Reference Audits</label>
									<span class="microhelp btn-microHelp" style="padding: 2px 3px 2px 5px; border-radius: 3px;" onfocus="setVisibility('ta_tastatus2Help','inline')" onBlur="setVisibility('ta_tastatus2Help','none')" tabindex="0">
										<i class="fa fa-lightbulb-o" ><span class="sr-only">click for microhelp</span></i>
									</span>
									<br>
									<input type="checkbox" id="rule-tastatus"   <#if selectedRule.tastatus?? && selectedRule.tastatus == "H">checked</#if> value="H" style="margin-left: 0px;margin-top: 0px; float: none;";>
						</div>
						<input type="hidden" value="${selectedRule.lastModDate!''}" id="rule_last_mod_date" />
						<input type="hidden" value="${selectedRule.lastModUser!''}" id="rule_last_mod_user" />
					</div>
					</div>
				</form>
			</div>
			<div class="row">
				<form role="form">
					<div class="form-group col-md-6">
						<label for="memo"><i class="fa fa-globe"></i> Public Memo</label>
						<textarea class="form-control input-sm" id="rule-public_memo" rows="1"
							maxlength="255" onfocus="setVisibility('ta_publicmemoHelp','inline')" onBlur="setVisibility('ta_publicmemoHelp','none')";>${selectedRule.memo!''}</textarea>
					</div>
					<div class="form-group col-md-6">
						<label for="private_note"><i class="fa fa-user-secret"></i> Private Memo</label>
						<textarea class="form-control input-sm" id="rule-private_note" rows="1"
							maxlength="255" onfocus="setVisibility('ta_privatenoteHelp','inline')" onBlur="setVisibility('ta_privatenoteHelp','none')";>${selectedRule.privateNote!''}</textarea>
					</div>
				</form>
			</div>
		</div>
	</div> 
	<div class="ruleGroup">
		<div class="row">
			<div class="col-md-12">
				<div class="row ruleHeader">
					<div class="col-md-8">
						<h3 class="noMarginTop" >
							<a href="#" type="button" data-toggle="collapse" data-target="#sourceCourses, #addSource" aria-expanded="true" aria-controls="sourceCourses, addSource" onclick="rotateChevron('ruleChevron2'); return false;">
								<i id="ruleChevron2" class="fa fa-chevron-down"  style="font-size: 14px;"></i> Transfer/Source Courses
							</a>
						</h3>
					</div>
					<div class="col-md-4 ruleBody collapse in" id="addSource">
						<span class="pull-right">
							<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
							<#if selectedSources?size  gt 0>
							 	<#assign sourceCount = selectedSources?size + 1 />
							<#else>
								<#assign sourceCount = 2 />
							</#if>
							Add source course at line <input type="text" class="" id="insertSource" value="${sourceCount}" style="width: 30px;">
							<button accesskey="t" type="button" class="btn btn-success btn-xs" onclick="addSourceRow()" title="Add Row"><i class="fa fa-plus"></i> Add</button>
							</@redauth.authorize>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="collapse in" id="sourceCourses">
			<div class="row">
				<div class="col-md-12 table-responsive">
					<table class="table table-bordered table-striped" id="sourceList">
						<thead>
							<tr>
								<th class="aligncenter"><i class="fa fa-bars"></i></th>
								<th class="aligncenter"><span class="fa-stack smallStack" title="Transfer/Source Course">
									<i class="fa fa-long-arrow-right fa-stack-1x fa-rotate-45" style="margin-top: 3px; margin-left: 2px;">
										<span class="sr-only">Transfer/Source Course</span>
									</i>
									<i class="fa fa-angle-double-right fa-stack-1x fa-rotate-45" aria-hidden="true"></i>
									</span></th>
								<th class="aligncenter">
									Course 
									<a href="#" type="button" data-toggle="popover" data-placement="top" data-container="body" data-content="Use the backslash '\' to automatically match the department begin/end when you save this rule."data-html="true" title="Course Help" onclick="return false;"><i class="fa fa-question"><span class="sr-only">Course Help</span></i></a>
								</th>
								<th class="aligncenter">P</th>
								<th class="aligncenter">Title</th>
								<th class="aligncenter">T</th>
								<th class="aligncenter">Min <br> Hours</th>
								<th class="aligncenter">AC</th>
								<th class="aligncenter">RC</th>
								<th class="aligncenter">Effective <br> Year/Term Range</th>
								<th class="aligncenter">Details</th>
								<th class="aligncenter">Delete</th>
							</tr>
						</thead>
						<tbody id="sortableSource">
							<#if selectedSources?has_content>
							<#list selectedSources as source>
							<tr id="sourceRow-${source_index+1}" class="ui-state-default">
								<td class="move aligncenter"><i class="fa fa-bars"><span class="sr-only">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i></td>
								<td class="userSeqNo aligncenter">${source.userSeqNo}</td>
								<td class="aligncenter">
									<div class="form-group has-feedback" style="margin-bottom: 0px;" title="">
										<input type="text" value="${source.course}" class="course monoCourse" name="course" maxlength="15" style="width: 135px;" aria-describedby="courseMaskStatus"
										onfocus="setVisibility('ta_sourcecourseHelp','inline')" onBlur="setVisibility('ta_sourcecourseHelp','none')">
										<span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;display:none;">
											<i class="fa fa-exclamation-triangle"></i>
										</span>
										<span class="sourceCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask. May be intentional - articulation still valid.</span>
									</div>
								</td>
					            <td class="aligncenter">
					            	<select class="pflg" name="pflg" style="width: 38px;" onfocus="setVisibility('ta_sourcepflgHelp','inline')" onBlur="setVisibility('ta_sourcepflgHelp','none')">
										<option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspDefault </option>
										<option value="P" <#if source.pflg?? && source.pflg == "P">selected="selected"</#if>>P &nbsp &nbsp Pseudo Course</option>
										<option value="R" <#if source.pflg?? && source.pflg == "R">selected="selected"</#if>>R &nbsp &nbsp Required</option>
										<option value=":" <#if source.pflg?? && source.pflg == ":">selected="selected"</#if>>: &nbsp &nbsp Course Range</option>
										<#list 1..9 as i>
										<option value="${i}" <#if source.pflg?? && source.pflg == i?string.number>selected="selected"</#if>>${i} &nbsp &nbsp ${i} Additional Match<#if i gt 1>es</#if></option>
										</#list>
									</select>
								</td>
								<td class="aligncenter"><input type="text" value="${source.ctitle!''}" class="ctitle" name="ctitle" maxlength="29" style="width: 235px;" onfocus="setVisibility('ta_sourcectitleHelp','inline')" onBlur="setVisibility('ta_sourcectitleHelp','none')"> </td>
								<td class="aligncenter"><input type="checkbox" <#if source.tflg?? && source.tflg == "-">checked</#if>  value="-" class="tflg" name="tflg" onfocus="setVisibility('ta_sourcetflgHelp','inline')" onBlur="setVisibility('ta_sourcetflgHelp','none')"></td>
								<td class="aligncenter"><input type="text" value="<#if source.limhrs?has_content>${source.limhrs?c}</#if>" class="limhrs" name="limhrs" maxlength="5" style="width: 42px;" onfocus="setVisibility('ta_sourcelimhrsHelp','inline')" onBlur="setVisibility('ta_sourcelimhrsHelp','none')"> </td>
								<td class="aligncenter"><input type="text" value="${source.ac!''}" class="ac" name="ac" maxlength="1" style="width: 25px;" onfocus="setVisibility('ta_sourceacHelp','inline')" onBlur="setVisibility('ta_sourceacHelp','none')"></td>
								<td class="aligncenter"><input type="text" value="${source.rc!''}" class="rc" name="rc" maxlength="1" style="width: 25px;" onfocus="setVisibility('ta_sourcercHelp','inline')" onBlur="setVisibility('ta_sourcercHelp','none')"></td>
								<#if source.effdte??>
									<#assign tempDate = source.effdte >
								<#else>
									<#assign tempDate ="" >
								</#if>
								<#assign effdate = tempDate?right_pad(12)>
								<td class="aligncenter"><input type="text" value="${effdate?substring(0,6)}" class="effdte" name="effdte" maxlength="6" style="width: 50px;" onfocus="setVisibility('ta_effdteHelp','inline')" onBlur="setVisibility('ta_effdteHelp','none')">&nbsp;-&nbsp;<input type="text" value="${effdate?substring(6)}" class="effdte2" name="effdte2" maxlength="6" style="width: 50px;" onfocus="setVisibility('ta_effdteHelp','inline')" onBlur="setVisibility('ta_effdteHelp','none')"></td>
								<td class="aligncenter">
									<a href="#" class="btn btn-default btn-xs" onclick="popSourceCourseModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a>
									
									<#if source.intSeqNo??><input type="hidden" class="intSeqNo" value="${source.intSeqNo?c}"/></#if>
									<input type="hidden" class="last_mod_date" name="last_mod_date" value="${source.lastModDate!''}"/>
									<input type="hidden" class="last_mod_user" name="last_mod_user" value="${source.lastModUser!''}"/>
								</td>
								<td class="aligncenter">
									<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
									<button type="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,'#sortableSource','#insertSource','sourceRow-')" title="Delete Course"><i class="fa fa-trash-o"></i></button>
									</@redauth.authorize>
								</td>
							</tr>
							</#list>
							<#else>
							<tr id="sourceRow-1" class="ui-state-default">
								<td class="move aligncenter"><i class="fa fa-bars"><span class="sr-only">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i></td>
								<td class="userSeqNo aligncenter">1</td>
								<td class="aligncenter">
									<div class="form-group has-feedback" style="margin-bottom: 0px;" title="">
										<input type="text" class="course monoCourse" name="course" maxlength="15" style="width: 135px;" onfocus="setVisibility('ta_sourcecourseHelp','inline')" onBlur="setVisibility('ta_sourcecourseHelp','none')">
										<span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;display:none;">
											<i class="fa fa-exclamation-triangle"></i>
										</span>
										<span class="sourceCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask. May be intentional - articulation still valid.</span>
									</div>
								</td>
					            <td class="aligncenter">
					            	<select class="pflg" name="pflg" style="width: 38px;" onfocus="setVisibility('ta_sourcepflgHelp','inline')" onBlur="setVisibility('ta_sourcepflgHelp','none')">
										<option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspDefault </option>
										<option value="P">P &nbsp &nbsp Pseudo Course</option>
										<option value="R">R &nbsp &nbsp Required</option>
										<option value=":">: &nbsp &nbsp Course Range</option>
										<#list 1..9 as i>
										<option value="${i}">${i} &nbsp &nbsp ${i} Additional Match<#if i gt 1>es</#if></option>
										</#list>
									</select>
								</td>
								<td class="aligncenter"><input type="text" class="ctitle" name="ctitle" maxlength="29" style="width: 235px;" onfocus="setVisibility('ta_sourcectitleHelp','inline')" onBlur="setVisibility('ta_sourcectitleHelp','none')"> </td>
								<td class="aligncenter"><input type="checkbox" value="-" class="tflg" name="tflg" onfocus="setVisibility('ta_sourcetflgHelp','inline')" onBlur="setVisibility('ta_sourcetflgHelp','none')"></td>
								<td class="aligncenter"><input type="text" class="limhrs" name="limhrs" maxlength="5" style="width: 42px;"onfocus="setVisibility('ta_sourcelimhrsHelp','inline')" onBlur="setVisibility('ta_sourcelimhrsHelp','none')"> </td>
								<td class="aligncenter"><input type="text" class="ac" name="ac" maxlength="1" style="width: 25px;" onfocus="setVisibility('ta_sourceacHelp','inline')" onBlur="setVisibility('ta_sourceacHelp','none')"></td>
								<td class="aligncenter"><input type="text" class="rc" name="rc" maxlength="1" style="width: 25px;" onfocus="setVisibility('ta_sourcercHelp','inline')" onBlur="setVisibility('ta_sourcercHelp','none')"></td>
								<td class="aligncenter"><input type="text" class="effdte" name="effdte" maxlength="6" style="width: 50px;" onfocus="setVisibility('ta_effdteHelp','inline')" onBlur="setVisibility('ta_effdteHelp','none')">&nbsp;-&nbsp;<input type="text" class="effdte2" name="effdte2" maxlength="6" style="width: 50px;" onfocus="setVisibility('ta_effdteHelp','inline')" onBlur="setVisibility('ta_effdteHelp','none')"></td>
								<td class="aligncenter">
									<a href="#" class="btn btn-default btn-xs" onclick="popSourceCourseModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a>
									
									<input type="hidden" class="last_mod_date" name="last_mod_date"/>
									<input type="hidden" class="last_mod_user" name="last_mod_user"/>	
								</td>
								<td class="aligncenter">
									<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
									<button type="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,'#sortableSource','#insertSource','sourceRow-')" title="Delete Course"><i class="fa fa-trash-o"></i></button>
									</@redauth.authorize>
								</td>
							</tr>
							</#if>
						</tbody>
						<tfoot>
							<tr>
								<td></td>
								<td></td>
								<td><span id="sourceCrsMsk" class="crsMsk">${sourceMask.crsmask!"No Mask Found"}</span></td>
								<td><input type="hidden" id="sourceCrsCase" value="${sourceMask.crscase!""}"/></td>
								<td></td>
					      		<td></td>
					      		<td></td>
					      		<td></td>
					      		<td></td>
					      		<td></td>
					      		<td></td>
					      		<td></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<#include 'modals/sourceCourseModal.ftl' />			
	<div class="ruleGroup">
		<div class="row">
			<div class="col-md-12">
				<div class="row ruleHeader">
					<div class="col-md-8">
						<h3 class="noMarginTop">
							<a href="#" type="button" data-toggle="collapse" data-target="#targetCourses, #addTarget" aria-expanded="true"  aria-controls="targetCourses, addTarget" onclick="rotateChevron('ruleChevron3'); return false;">
								<i id="ruleChevron3" class="fa fa-chevron-down" style="font-size: 14px;"></i> Home/Target Courses 
							</a>
						</h3>
					</div>
					<div class="col-md-4 collapse in" id="addTarget">
						<span class="pull-right">
							<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
							<#if selectedTargets?size  gt 0>
							 	<#assign targetCount = selectedTargets?size + 1 />
							<#else>
								<#assign targetCount = 2 />
							</#if>
							Add target course at line <input type="text" class="" id="insertTarget" value="${targetCount}" style="width: 30px;">
							<a accesskey="h" type="button" class="btn btn-success btn-xs" onclick="addTargetRow()" title="Add Row"><i class="fa fa-plus"></i> Add</a>
							</@redauth.authorize>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="collapse in" id="targetCourses">
			<div class="row">
				<div class="col-md-12 table-responsive">
					<table class="table table-bordered table-striped" id="targetList">
						<thead>
							<tr>
								<th><i class="fa fa-bars"></i></th>
								<th><i class="fa fa-bullseye fa-lg"><span class="sr-only">Home/Target Course</span></i></th>
								<th class="aligncenter">
									Course 
									<a href="#" type="button" data-toggle="popover" data-placement="top" data-container="body" data-content="Use the backslash '\' to automatically match the department begin/end when you save this rule."data-html="true" title="Course Help" onclick="return false;"><i class="fa fa-question"><span class="sr-only">Course Help</span></i></a>
								</th>
								<th class="aligncenter">P</th>
								<th class="aligncenter">Title</th>
								<th class="aligncenter">Hours</th>
								<th class="aligncenter">F</th>
								<th class="aligncenter">Hide</th>
								<th class="aligncenter">Alternate Courses</th>
								<th class="aligncenter">Course Flags</th>
								<th class="aligncenter">Details</th>
								<th class="aligncenter">Delete</th>
							</tr>
						</thead>
						<tbody id="sortableTarget">
							<#if selectedTargets?has_content>
							<#list selectedTargets as target>
								<tr id="targetRow-${target_index+1}" class="ui-state-default">
									<td class="move aligncenter"><i class="fa fa-bars"><span class="sr-only">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i></td>
									<td class="userSeqNo aligncenter">${target.userSeqNo}</td>
									<td class="aligncenter">
									<div class="form-group has-feedback" style="margin-bottom: 0px;">
										<input type="text" value="${target.course}" class="course monoCourse" name="course" maxlength="15" style="width: 135px;" onfocus="setVisibility('ta_targetcourseHelp','inline')" onBlur="setVisibility('ta_targetcourseHelp','none')">
										<span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;display:none;">
											<i class="fa fa-exclamation-triangle"></i>
										</span>
										<span class="targetCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask.</span>
									</div>
									</td>
									<td class="aligncenter">
										<select class="pflg" name="pflg" style="width: 38px;" onfocus="setVisibility('ta_targetpflgHelp','inline')" onBlur="setVisibility('ta_targetpflgHelp','none')">
											<option value=" " >&nbsp &nbsp &nbsp &nbspDefault </option>
											<option value="P" <#if target.pflg?? && target.pflg == "P">selected="selected"</#if>>P &nbsp &nbsp Pseudo Course</option>
											<option value="D" <#if target.pflg?? && target.pflg == "D">selected="selected"</#if>>D &nbsp &nbspDummy Course</option>
											<option value="X" <#if target.pflg?? && target.pflg == "X">selected="selected"</#if>>X &nbsp &nbsp Dummy Pseudo Course</option>
											<option value="Z" <#if target.pflg?? && target.pflg == "Z">selected="selected"</#if>>Z &nbsp &nbsp Eliminate residual credit/GPA</option>
										</select> 
									</td>
									<td class="aligncenter"><input type="text" value="${target.ctitle!''}" class="ctitle" name="ctitle" maxlength="29" style="width: 235px;" onfocus="setVisibility('ta_targetctitleHelp','inline')" onBlur="setVisibility('ta_targetctitleHelp','none')"></td>
									<td class="aligncenter"><input type="text" value="<#if target.limhrs?has_content>${target.limhrs?c}</#if>" class="limhrs" name="limhrs" maxlength="5" style="width: 42px;" onfocus="setVisibility('ta_targetlimhrsHelp','inline')" onBlur="setVisibility('ta_targetlimhrsHelp','none')"></td>
									<td class="aligncenter"><input type="checkbox" <#if target.forcehrs?? && target.forcehrs == "F">checked</#if> value="F" class="forcehrs" name="forcehrs" onfocus="setVisibility('ta_forcehrsHelp','inline')" onBlur="setVisibility('ta_forcehrsHelp','none')"></td>
									<td class="aligncenter">
										<input type="checkbox" <#if target.tastatus?? && target.tastatus == "H">checked</#if> value="H" class="tastatus" name="tastatus" onfocus="setVisibility('ta_tastatus3Help','inline')" onBlur="setVisibility('ta_tastatus3Help','none')">
									</td>

									<#assign  isPseudoIcon = "<i class='fa fa-check acourseCheck'><span class='sr-only'>This acourse is a pseudo course</span></i>",
											  notPseudoIcon = "<i class='fa fa-close acourseX'><span class='sr-only'>This acourse is not a pseudo course</span></i>",
											  isHiddenIcon =  "<i class='fa fa-check acourseCheck'><span class='sr-only'>This acourse is hidden</span></i>",
	 										  notHiddenIcon = "<i class='fa fa-close acourseX'><span class='sr-only'>This acourse is not hidden</span></i>" />

									<td class="aligncenter"><a href="#" class="targetAlt btn btn-xs btn-info" type="button" data-toggle="popover" data-placement="top" data-container="body"
									<#if !target.acourse1?has_content && !target.acourse2?has_content && !target.acourse3?has_content>
										disabled="disabled"
									</#if>
										data-content="
										<table><tr class='acourseTH'><th>Acourse</th><th>Pseudo</th><th>Hidden</th></tr>
										<tr><td><#if target.acourse1?has_content>${target.acourse1}</#if></td>
											<td class='acourse'><#if target.apflg1?? && target.apflg1 == "P">${isPseudoIcon}<#else>${notPseudoIcon}</#if></td>
											<td class='acourse'><#if target.hideAcourse1?? && target.hideAcourse1 == "P">${isHiddenIcon}<#else>${notHiddenIcon}</#if></td></tr>
										<tr><td><#if target.acourse2?has_content>${target.acourse2}</#if></td>
											<td class='acourse'><#if target.apflg2?? && target.apflg2 == "P">${isPseudoIcon}<#else>${notPseudoIcon}</#if></td>
											<td class='acourse'><#if target.hideAcourse2?? && target.hideAcourse2 == "P">${isHiddenIcon}<#else>${notHiddenIcon}</#if></td></td></tr>
										<tr><td><#if target.acourse3?has_content>${target.acourse3}</#if></td>
											<td class='acourse'><#if target.apflg3?? && target.apflg3 == "P">${isPseudoIcon}<#else>${notPseudoIcon}</#if></td>
											<td class='acourse'><#if target.hideAcourse3?? && target.hideAcourse3 == "P">${isHiddenIcon}<#else>${notHiddenIcon}</#if></td></td></tr></table>"
									data-html="true" title="Alternate Courses" onclick="return false;"><i class="fa fa-list-ol"></i></a>
									</td>
									<td class="aligncenter"><a href="#" class="targetFlag btn btn-xs btn-info" type="button" data-toggle="popover" data-placement="top" data-container="body"
									<#if !target.iflg1?has_content && !target.iflg2?has_content && !target.iflg3?has_content && !target.iflg4?has_content && !target.iflg5?has_content>
										disabled="disabled"
									</#if>
									data-content="
										<#if target.iflg1?has_content>
										${target.iflg1}
										</#if>
										<#if target.iflg2?has_content || target.iflg3?has_content || target.iflg4?has_content || target.iflg5?has_content>
										<br>
										</#if>
										<#if target.iflg2?has_content>
										${target.iflg2}
										</#if>
										<#if target.iflg3?has_content || target.iflg4?has_content || target.iflg5?has_content>
										<br>
										</#if>
										<#if target.iflg3?has_content>
										${target.iflg3}
										</#if>
										<#if target.iflg4?has_content || target.iflg5?has_content>
										<br>
										</#if>
										<#if target.iflg4?has_content>
										${target.iflg4}
										</#if>
										<#if target.iflg5?has_content>
										<br>
										</#if>
										<#if target.iflg5?has_content>
										${target.iflg5}
										</#if>
										<#if target.hideIflgs?? && target.hideIflgs == "P">
											<br><b>All Flags Hidden</b>
										</#if>""
									data-html="true" title="Flags" onclick="return false;"><i class="fa fa-flag"></i></a>
									</td>
									<td class="aligncenter">
										<a href="#" class="btn btn-default btn-xs" type="button" onclick="popTargetCourseModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a>
										
										<span style="display:none;"><input type="checkbox" class="apflg1" name="apflg1" value="P" <#if target.apflg1?? && target.apflg1 == "P">checked</#if>/></span>
										<span style="display:none;"><input type="checkbox" class="apflg2" name="apflg1" value="P" <#if target.apflg2?? && target.apflg2 == "P">checked</#if>/></span>
										<span style="display:none;"><input type="checkbox" class="apflg3" name="apflg1" value="P" <#if target.apflg3?? && target.apflg3 == "P">checked</#if>/></span>
										<span style="display:none;"><input type="checkbox" class="hide_acourse1" name="hide_acourse1" value="P" <#if target.hideAcourse1?? && target.hideAcourse1 == "P">checked</#if>/></span>
										<span style="display:none;"><input type="checkbox" class="hide_acourse2" name="hide_acourse2" value="P" <#if target.hideAcourse2?? && target.hideAcourse2 == "P">checked</#if>/></span>
										<span style="display:none;"><input type="checkbox" class="hide_acourse3" name="hide_acourse3" value="P" <#if target.hideAcourse3?? && target.hideAcourse3 == "P">checked</#if>/></span>
										<span style="display:none;"><input type="checkbox" class="hideIflgs" name="hideIflgs" value="P" <#if target.hideIflgs?? && target.hideIflgs == "P">checked</#if>/></span>
										<#if target.intSeqNo??><input type="hidden" class="intSeqNo" value="${target.intSeqNo?c}"/></#if>
										<input type="hidden" class="cond" name="cond" value="${target.cond!''}" maxlength="1">
										<input type="hidden" class="iflg1" name="iflg1" value="${target.iflg1!''}" maxlength="3"/>
										<input type="hidden" class="iflg2" name="iflg2" value="${target.iflg2!''}" maxlength="3"/>
										<input type="hidden" class="iflg3" name="iflg3" value="${target.iflg3!''}" maxlength="3"/>
										<input type="hidden" class="iflg4" name="iflg4" value="${target.iflg4!''}" maxlength="3"/>
										<input type="hidden" class="iflg5" name="iflg5" value="${target.iflg5!''}" maxlength="3"/>
										<input type="hidden" class="acourse1" name="acourse1" value="${target.acourse1!''}" maxlength="15"/>
										<input type="hidden" class="acourse2" name="acourse2" value="${target.acourse2!''}" maxlength="15"/>
										<input type="hidden" class="acourse3" name="acourse3" value="${target.acourse3!''}" maxlength="15"/>
										<input type="hidden" class="last_mod_date" name="last_mod_date" value="${target.lastModDate!''}"/>
										<input type="hidden" class="last_mod_user" name="last_mod_user" value="${target.lastModUser!''}"/>
									</td>
									<td class="aligncenter">
										<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
										<button type="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,'#sortableTarget','#insertTarget','targetRow-')" title="Delete Course"><i class="fa fa-trash-o"></i></button>
										</@redauth.authorize>
									</td>
								</tr>
							</#list>
							<#else><#-- EMPTY DEFAULT ROW -->
								<tr id="targetRow-1" class="ui-state-default">
									<td class="move aligncenter"><i class="fa fa-bars"><span class="sr-only">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i></td>
									<td class="userSeqNo aligncenter">1</td>
									<td class="aligncenter">
										<div class="form-group has-feedback" style="margin-bottom: 0px;">
											<input type="text" class="course monoCourse" name="course" maxlength="15" style="width: 135px;" onfocus="setVisibility('ta_targetcourseHelp','inline')" onBlur="setVisibility('ta_targetcourseHelp','none')">
											<span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;display:none;">
												<i class="fa fa-exclamation-triangle"></i>
											</span>
											<span class="targetCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask.</span>
										</div>
									</td>
									<td class="aligncenter">
										<select class="pflg" name="pflg" style="width: 38px;" onfocus="setVisibility('ta_targetpflgHelp','inline')" onBlur="setVisibility('ta_targetpflgHelp','none')">
											<option value=" " >&nbsp &nbsp &nbsp &nbspDefault </option>
											<option value="P">P &nbsp &nbsp Pseudo Course</option>
											<option value="D">D &nbsp &nbspDummy Course</option>
											<option value="X">X &nbsp &nbsp Dummy Pseudo Course</option>
											<option value="Z">Z &nbsp &nbsp Eliminate residual credit/GPA</option>
										</select> 
									</td>
									<td class="aligncenter"><input type="text" class="ctitle" name="ctitle" maxlength="29" style="width: 235px;" onfocus="setVisibility('ta_targetctitleHelp','inline')" onBlur="setVisibility('ta_targetctitleHelp','none')"></td>
									<td class="aligncenter"><input type="text" class="limhrs" name="limhrs" maxlength="5" style="width: 42px;" onfocus="setVisibility('ta_targetlimhrsHelp','inline')" onBlur="setVisibility('ta_targetlimhrsHelp','none')"></td>
									<td class="aligncenter"><input type="checkbox" value="F" class="forcehrs" name="forcehrs" onfocus="setVisibility('ta_forcehrsHelp','inline')" onBlur="setVisibility('ta_forcehrsHelp','none')"></td>
									<td class="aligncenter">
										<input type="checkbox" value="H" class="tastatus" name="tastatus" onfocus="setVisibility('ta_tastatusHelp','inline')" onBlur="setVisibility('ta_tastatusHelp','none')">
									</td>
									<td class="aligncenter"><a href="#" class="targetAlt btn btn-xs btn-info" type="button" data-placement="top" data-container="body" data-toggle="popover" data-html="true" title="Alternate Courses" disabled="disabled" onclick="return false;"><i class="fa fa-list-ol"></i></a></td>
									<td class="aligncenter"><a href="#" class="targetFlag btn btn-xs btn-info" type="button" data-placement="top" data-container="body" data-toggle="popover" data-html="true" title="Flags" disabled="disabled" onclick="return false;"><i class="fa fa-flag"></i></a></td>
									<td class="aligncenter">
										<a href="#" class="btn btn-default btn-xs" type="button" onclick="popTargetCourseModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a>
									
										<span style="display:none;"><input type="checkbox" class="apflg1" name="apflg1" value="P" /></span>
										<span style="display:none;"><input type="checkbox" class="apflg2" name="apflg1" value="P" /></span>
										<span style="display:none;"><input type="checkbox" class="apflg3" name="apflg1" value="P" /></span>
										<span style="display:none;"><input type="checkbox" class="hide_acourse1" name="hide_acourse1" value="P"/></span>
										<span style="display:none;"><input type="checkbox" class="hide_acourse2" name="hide_acourse2" value="P"/></span>
										<span style="display:none;"><input type="checkbox" class="hide_acourse3" name="hide_acourse3" value="P"/></span>
										<span style="display:none;"><input type="checkbox" class="hideIflgs" name="hideIflgs" value="P" /></span>
										<input type="hidden" class="cond" name="cond" maxlength="5">
										<input type="hidden" class="iflg1" name="iflg1" maxlength="3"/>
										<input type="hidden" class="iflg2" name="iflg2" maxlength="3"/>
										<input type="hidden" class="iflg3" name="iflg3" maxlength="3"/>
										<input type="hidden" class="iflg4" name="iflg4" maxlength="3"/>
										<input type="hidden" class="iflg5" name="iflg5" maxlength="3"/>
										<input type="hidden" class="acourse1" name="acourse1" maxlength="15"/>
										<input type="hidden" class="acourse2" name="acourse2" maxlength="15"/>
										<input type="hidden" class="acourse3" name="acourse3" maxlength="15"/>
										<input type="hidden" class="last_mod_date" name="last_mod_date"/>
										<input type="hidden" class="last_mod_user" name="last_mod_user"/>
									</td>
									<td class="aligncenter">
										<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
										<button type="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,'#sortableTarget','#insertTarget','targetRow-')" title="Delete Course"><i class="fa fa-trash-o"></i></button>
										</@redauth.authorize>
									</td>
								</tr>
							</#if>
						</tbody>
						<tfoot>
							<tr>
								<td></td>
								<td></td>
								<td><span id="targetCrsMsk"class="crsMsk">${targetMask.crsmask!"No Mask Found"}</span></td>
								<td><input type="hidden" id="targetCrsCase" value="${targetMask.crscase!""}"/></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<#include 'modals/targetCourseModal.ftl' />
</div>
</div>


