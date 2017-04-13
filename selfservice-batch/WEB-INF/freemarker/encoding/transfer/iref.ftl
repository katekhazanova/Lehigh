<@layout.head title="Institutional Reference Table - ${mastref.iname!''}" />
<#assign redauth=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<@layout.body>

	<h1 class="sr-only">Institutional Reference Table</h1>
	<div class="row" >
    	<div class="col-md-5">
    		<span style="font-size: 14px; font-weight: 500;">
    			IREF Table
    			<a href="#" type="button" data-toggle="modal" data-target="#helpModal" >
				  <i class="fa fa-question-circle"><span class="sr-only">Help</span></i>
				</a>
    		</span>
    		<br>
	    		<span style="font-size: 14px; font-weight: 500;" id="inameHeader" >${mastref.iname!''}</span> 
    		</div>
    		<div class="col-md-3">
	      		<span style="font-size: 12px; font-weight: 500; color: gray;margin-right: 3px;">Source ID: 
	      		<span style="color: black;">${mastref.comp_id.sourceId}</span></span>
	      		<span style="font-size: 12px; font-weight: 500; color: gray;margin-right: 3px;">CD: 
	      		<span style="color: black;">${mastref.comp_id.sourceCd}</span></span>
	      		<br>
	      		<span style="font-size: 12x; font-weight: 500; color: gray;margin-right: 3px;">FYT: 
	      		<span style="color: black;">${mastref.comp_id.mrfyt}</span></span>
	    	</div>
    		<div class="col-md-4">
    			<span class="pull-right">
    				<a href="#" type="button" class="btn btn-microHelp btn-sm" data-toggle="collapse" data-target="#help, .microhelp" aria-expanded="true" aria-controls="help" id="showMicroHelp" title="Microhelp">
    					<i class="fa fa-lightbulb-o"><span class="sr-only">Click to view microhelp</span></i>
					</a>
					<a href="iref.html?sourceCd=${mastref.comp_id.sourceCd?url}&fyt=${mastref.comp_id.mrfyt?url}<#if clone=="true">&clone=true</#if>" 
					type="button" id="iref-refresh" class="btn btn-default btn-sm"><i class="fa fa-undo"></i> Restore</a>
					<#if clone=="false">
						<@redauth.authorize ifAllGranted="SS_ENCODING_TA_IREF=u">
						<a href="#" type="button" id="iref-save" onclick="saveIref()" class="btn btn-primary btn-sm" accesskey="s" disabled><i class="fa fa-save"></i> Save</a>
						</@redauth.authorize>
					<#else>
						<@redauth.authorize ifAllGranted="SS_ENCODING_TA_IREF=c">
						<a href="#" type="button" id="iref-save" onclick="cloneIref()" class="btn btn-primary btn-sm" accesskey="s" disabled><i class="fa fa-copy"></i> Clone</a>
    					</@redauth.authorize>
					</#if> 
    				<a href="<@s.url "/encoding/transfer/institution.html" />" id="iref-exit" type="button" class="btn btn-default btn-sm" accesskey="x"><i class="fa fa-arrow-left"></i> Exit Table</a>
					<@redauth.authorize ifNoneGranted="SS_ENCODING_TA_IREF=u,SS_ENCODING_TA_IREF=c">
						<input type="hidden" id="disableIrefInputs"value="true" />
					</@redauth.authorize>
				</span>
	    	</div>
    	</div>
	    <hr class="smallTopMargin">
	    
	  	<div class="row">
			<div id="savingTAMessage" class="col-md-offset-3 col-md-6 alert alert-info" style="display:none;" >
				<center><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> <strong>Saving...</strong> We are currently saving data do not leave the page.</center>
			</div>
		</div>
		<div id="help" class="row collapse " style="margin: 5px;" aria-live="polite" aria-atomic="true" aria-relevant="all">
			<div  id="includedHelp">
				<#include "../micro_help/iref_micro_help.ftl" />
			</div>
		</div>
		
		<div role="tabpanel">
			<ul class="nav nav-tabs" role="tablist" id="myTab" style="margin: 0px;">
			  <li role="presentation"<#if (tabid?has_content && tabid == "general") || !tabid?has_content> class="active"</#if>><a href="#general" id="generalTab" role="tab" aria-controls="general" data-toggle="tab">General</a></li>
			  <li role="presentation"<#if tabid?has_content && tabid == "default"> class="active"</#if> class=""><a href="#default" id="defaultTab" role="tab" aria-controls="default" data-toggle="tab">Default Tables</a></li>
			  <li role="presentation"<#if tabid?has_content && tabid == "course"> class="active"</#if> class=""><a href="#course" id="courseTab" role="tab" aria-controls="course" data-toggle="tab">Course</a></li>
			  <li role="presentation"<#if tabid?has_content && tabid == "grade"> class="active"</#if> class=""><a href="#grade" id="gradeTab" role="tab" aria-controls="grade" data-toggle="tab">Grade Definition</a></li>
			  <#if homeIref>
				  <li role="presentation"<#if tabid?has_content && tabid == "credit"> class="active"</#if> class=""><a href="#credit" id="creditTab" role="tab" aria-controls="credit" data-toggle="tab">Credit</a></li>
				  <li role="presentation"<#if tabid?has_content && tabid == "gpa"> class="active"</#if> class=""><a href="#gpa" id="gpaTab" role="tab" aria-controls="gpa" data-toggle="tab">GPA</a></li>
			  <#else>
				  <li role="presentation"<#if tabid?has_content && tabid == "address"> class="active"</#if> class=""><a href="#address" id="addressTab" role="tab" aria-controls="address" data-toggle="tab">Address</a></li>	
			  </#if>
			  
			</ul>
   		</div>


		<div id="iref-form" class="tab-content">
	    	<div class="tab-pane fade<#if (tabid?has_content && tabid == "general") || !tabid?has_content> active in</#if>" id="general" role="tabpanel" aria-labelledby="generalTab">
	    		<form role="form">
					<div class="row" style="padding: 15px 0px;">
				    	<div class="col-md-8 col-sm-12 col-xs-12"> 
						  <div class="form-group">
						    <label for="INAME">School Name</label>
						   <input class="form-control input-sm" id="INAME" type="text" value="${mastref.iname!''}" maxlength="60" onfocus="setVisibility('iref_inameHelp','inline')" onBlur="setVisibility('iref_inameHelp','none')">
						  </div>
					  	</div>
					  	<div class="col-md-2 col-sm-3 col-xs-6">
					  		<div class="form-group">
						    	<label for="status">Hide from Transferology <br>& Reference Audits</label>
								<span class="microhelp btn-microHelp" style="padding: 2px 3px 2px 5px; border-radius: 3px;" onfocus="setVisibility('iref_statusHelp','inline')" onBlur="setVisibility('iref_statusHelp','none')" tabindex="0">
									<i class="fa fa-lightbulb-o" ><span class="sr-only">click for microhelp</span></i>
								</span>
						    	<br>
						    	<input type="checkbox" id="STATUS" value="H" <#if mastref.status?? && mastref.status == 'H'>checked</#if> style="margin-left: 0px;margin-top:0px;float: none;">
						 	</div>
					  	</div>
			  		</div>
			  		<div class="row">
				  		
					  	<div class="col-md-2 col-sm-3 col-xs-6">
						  <div class="form-group">
						    <label for="SOURCE_ID"><#if homeIref>Home<#else>Source</#if> InstID</label>
						   <input class="form-control input-sm" id="SOURCE_ID" type="text" placeholder=""  value="${mastref.comp_id.sourceId}" 
						   maxlength="8" onfocus="setVisibility('iref_sourceidHelp','inline')" onBlur="setVisibility('iref_sourceidHelp','none')" <#if clone=="false">disabled</#if>>
						  </div>
					  	</div>
						  <div class="col-md-2 col-sm-3 col-xs-6">
							  <div class="form-group">
							    <label for="SOURCE_CD"><#if homeIref>Home<#else>Source</#if> InstCD</label>
							   <input class="form-control input-sm" id="SOURCE_CD" type="text" placeholder=" " value="${mastref.comp_id.sourceCd}"
							    maxlength="3" onfocus="setVisibility('iref_sourcecdHelp','inline')" onBlur="setVisibility('iref_sourcecdHelp','none')" <#if clone=="false">disabled</#if>>
							  </div>
							</div>
						  
						  <div class="col-md-2 col-sm-3 col-xs-6">
							  <div class="form-group">
							    <label for="FYT">First Year Term</label>
							   <input class="form-control input-sm" id="FYT" type="text" placeholder="000000" value="${mastref.comp_id.mrfyt}"
							    maxlength="6" onfocus="setVisibility('iref_mrfytHelp','inline')" onBlur="setVisibility('iref_mrfytHelp','none')" <#if clone=="false">disabled</#if>>
							  </div>
						  	</div>
					  	<div class="col-md-2 col-sm-3 col-xs-6"> 
						  <div class="form-group">
						    <label for="LYT">Last Year Term</label>
						   <input class="form-control input-sm" id="LYT" type="text" value="${mastref.lyt}"
						    maxlength="6" onfocus="setVisibility('iref_lytHelp','inline')" onBlur="setVisibility('iref_lytHelp','none')">
						  </div>
					  	</div>
						
					  	<div class="col-md-2 col-sm-3 col-xs-6"> 
						  <div class="form-group">
						    <label for="sourceidq"><#if homeIref>Home<#else>Source</#if> InstIDQ</label>
						    
						    <select id="sourceidq" class="form-control input-sm" onfocus="setVisibility('iref_sourceidqHelp','block')" ;="" onblur="setVisibility('iref_sourceidqHelp','none')">
								<option value="71" <#if mastref.sourceidq?? && mastref.sourceidq = "71">selected="selected"</#if>>71 - IPEDS</option>
								<option value="72" <#if mastref.sourceidq?? && mastref.sourceidq = "72">selected="selected"</#if>>72 - ATP</option>
								<option value="73" <#if mastref.sourceidq?? && mastref.sourceidq = "73">selected="selected"</#if>>73 - FICE</option>
								<option value="74" <#if mastref.sourceidq?? && mastref.sourceidq = "74">selected="selected"</#if>>74 - ACT</option>
								<option value="77" <#if mastref.sourceidq?? && mastref.sourceidq = "77">selected="selected"</#if>>77 - NCES </option>
								<option value="78" <#if mastref.sourceidq?? && mastref.sourceidq = "78">selected="selected"</#if>>78 - ACT - Pre K-12 </option>
								<option value="CB" <#if mastref.sourceidq?? && mastref.sourceidq = "CB">selected="selected"</#if>>CB - Canada College Student Inst </option>
								<option value="CS" <#if mastref.sourceidq?? && mastref.sourceidq = "CS">selected="selected"</#if>>CS - Canada University SIS U Cds </option>
								<option value="ZZ" <#if mastref.sourceidq?? && mastref.sourceidq = "ZZ">selected="selected"</#if>>ZZ - Other </option>
								<option value=" "<#if mastref.sourceidq?? && mastref.sourceidq = "">selected="selected"</#if> >None</option>
							</select>
						  </div>
						</div>
			  		</div>

			  		<div class="row">
						<div class="col-md-2 col-sm-3 col-xs-6">
						  <div class="form-group">
						    <label for="RPINSTID">Report InstID</label>
						   <input class="form-control input-sm" id="RPINSTID" type="text" value="${mastref.rptinstid}"
						    maxlength="8" onfocus="setVisibility('iref_rpinstidHelp','inline')" onBlur="setVisibility('iref_rpinstidHelp','none')">
						  </div>
						</div>
			  			<div class="col-md-2 col-sm-3 col-xs-6 ">
						  <div class="form-group">
						    <label for="grdcase">Grade Case</label>
						   <select id="grdcase" class="form-control input-sm" onfocus="setVisibility('iref_grdcaseHelp','inline')" onBlur="setVisibility('iref_grdcaseHelp','none')">
								<option value="A" <#if mastref.grdcase = "A">selected="selected"</#if>>Any</option>
								<option value="U" <#if mastref.grdcase = "U">selected="selected"</#if>>Upper</option>
								<option value="L" <#if mastref.grdcase = "L">selected="selected"</#if>>Lower</option>
							</select>
						  </div>
					  	</div>
						<div class="col-md-2 col-sm-3 col-xs-6">
						  	<div class="form-group">
							    <label for="grdreq">Grade Required</label>
								<span class="microhelp btn-microHelp" style="padding: 2px 3px 2px 5px; border-radius: 3px;" onfocus="setVisibility('iref_grdreqHelp','inline')" onBlur="setVisibility('iref_grdreqHelp','none')" tabindex="0">
									<i class="fa fa-lightbulb-o"><span class="sr-only">click for microhelp</span></i>
								</span>
							    <br>
							    <input type="checkbox" id="grdreq" value="Y" <#if mastref.grdreq?? && mastref.grdreq = "Y">checked</#if> style="margin-left: 0px;float: none;" onfocus="setVisibility('iref_grdreqHelp','inline')" onBlur="setVisibility('iref_grdreqHelp','none')">
							</div>
						</div>
			  		</div>
				  	<div class="row">
				  		<div class="col-md-3">
							  <div class="form-group"><br>
							  	 <div>
							        <label for="last_mod_date">Last modified:</label>
							    	<span id="iref_last_mod_date" class="last_mod small">${mastref.lastModDate!''} </span>  
							    </div>
							  </div>
						  </div>
						  <div class="col-md-3">
							  <div class="form-group"><br>
								 <div>
							        <label for="last_mod_user">By:</label>
									<span id="iref_last_mod_user" class="last_mod small">${mastref.lastModUser!''} </span>
							     </div>
							  </div>
						  </div>
				  	</div>
				</form>		  		
	   		</div> <!-- tab-pane -->
	    		
	   		<div class="tab-pane fade<#if tabid?has_content && tabid == "default"> active in</#if>" id="default" role="tabpanel" aria-labelledby="defaultTab">
	    		<form role="form">
					<div class="form-group panel2" style="margin: 15px 0px;">
						<label for="refonly">Reference Record Only:</label> 
						<span class="microhelp btn-microHelp" style="padding: 2px 3px 2px 5px; border-radius: 3px;" onfocus="setVisibility('iref_refonlyHelp','inline')" onBlur="setVisibility('iref_refonlyHelp','none')" tabindex="0">
							<i class="fa fa-lightbulb-o"><span class="sr-only">click for microhelp</span></i>
						</span>
						<br>
						<input type="checkbox" id="refonly" value="Y"<#if mastref.refonly?? &&  mastref.refonly = "Y">checked</#if> style="margin-left: 0px;float: none;">
						<span class="help-block">(Checking this means all rules for this school are defined by the Default IREF Table.)</span>
					</div>	
					<div class="row">
						<div class="col-md-4">
							<div class="row">
								<div class="col-md-12">
									<h3>Default IREF Table</h3>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="dinstid">InstID</label>
										<input class="form-control input-sm" id="dinstid" type="text" value="${mastref.dinstid!''}" placeholder="" maxlength="8" onfocus="setVisibility('iref_dinstidHelp','inline')" onBlur="setVisibility('iref_dinstidHelp','none')">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="dinstcd">InstCD</label>
										<input class="form-control input-sm" id="dinstcd" type="text" value="${mastref.dinstcd!''}" placeholder="" maxlength="3" onfocus="setVisibility('iref_dinstcdHelp','inline')" onBlur="setVisibility('iref_dinstcdHelp','none')">
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 col-md-offset-2">
							<div class="row">
								<div class="col-md-12">
									<h3>Default TA Table</h3>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="tainstid">InstID</label>
										<input class="form-control input-sm" id="tainstid" type="text" value="${mastref.tainstid!''}"  placeholder="" maxlength="8" <#if mastref.refonly?? && mastref.refonly = "Y">disabled="disabled"</#if> onfocus="setVisibility('iref_tainstidHelp','inline')" onBlur="setVisibility('iref_tainstidHelp','none')">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="tainstcd">InstCD</label>
										<input class="form-control input-sm" id="tainstcd" type="text" value="${mastref.tainstcd!''}"  placeholder="" maxlength="3" <#if mastref.refonly?? && mastref.refonly = "Y">disabled="disabled"</#if> onfocus="setVisibility('iref_tainstcdHelp','inline')" onBlur="setVisibility('iref_tainstcdHelp','none')">
									</div>
								</div>
							</div>
						</div>	
					</div>
				</form>	
	        </div>
	    	
	    	<div class="tab-pane fade<#if tabid?has_content && tabid == "course"> active in</#if>" id="course" role="tabpanel" aria-labelledby="courseTab">
	    		<form role="form">
					<div class="row" style="padding: 15px 0px;">
						<div class="col-md-6">
						<h4>Display Format</h4>
							<div class="row">
								<div class="col-md-3">
									 <div class="form-group">
									 	<label for="crsmask">
									 		Mask 
									 		<a href="#" type="button" data-toggle="modal" data-target="#courseMaskHelp" >
											  <i class="fa fa-question"><span class="sr-only">Course Mask Help</span></i>
											</a>
									 	</label>
									 	<input class="form-control input-sm" id="crsmask" type="text" value="${mastref.crsmask}" maxlength="15" onfocus="setVisibility('iref_crsmaskHelp','inline')" onBlur="setVisibility('iref_crsmaskHelp','none')">
									 </div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										    <label for="crscase">Case</label>
										   <select id="crscase" class="form-control input-sm" onfocus="setVisibility('iref_crscaseHelp','inline')" onBlur="setVisibility('iref_crscaseHelp','none')">
												<option value="A" <#if mastref.crscase = "A">selected="selected"</#if>>Any</option>
												<option value="U" <#if mastref.crscase = "U">selected="selected"</#if>>Upper</option>
												<option value="L" <#if mastref.crscase = "L">selected="selected"</#if>>Lower</option>
											</select>
										  </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									 <div class="form-group">
									 	<label for="deptbgn">Department Begin</label>
									 	<input class="form-control input-sm" id="deptbgn" type="text" value="${mastref.deptbgn!''}" maxlength="2" onfocus="setVisibility('iref_deptbgnHelp','inline')" onBlur="setVisibility('iref_deptbgnHelp','none')">
									 </div>
								</div>
								<div class="col-md-3">
									 <div class="form-group">
									 	<label for="deptend">Department End</label>
									 	<input class="form-control input-sm" id="deptend" type="text" value="${mastref.deptend!''}" maxlength="2" onfocus="setVisibility('iref_deptendHelp','inline')" onBlur="setVisibility('iref_deptendHelp','none')">
									 </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									 <div class="form-group">
									 	<label for="crsbgn">Course Begin</label>
									 	<input class="form-control input-sm" id="crsbgn" type="text" value="${mastref.crsbgn!''}" maxlength="2" onfocus="setVisibility('iref_crsbgnHelp','inline')" onBlur="setVisibility('iref_crsbgnHelp','none')">
									 </div>
								</div>
								<div class="col-md-3">
									 <div class="form-group">
									 	<label for="crsend">Course End</label>
									 	<input class="form-control input-sm" id="crsend" type="text" value="${mastref.crsend!''}" maxlength="2" onfocus="setVisibility('iref_crsendHelp','inline')" onBlur="setVisibility('iref_crsendHelp','none')">
									 </div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<h4>Default Credit Type Values</h4>
							<div class="row">
								
								<div class="col-md-4">
									<div class="form-group">
										    <label for="actc">Credit Type</label>
										   <select id="actc" class="form-control input-sm" onfocus="setVisibility('iref_actcHelp','inline')" onBlur="setVisibility('iref_actcHelp','none')">
												<option value=" ">&nbsp;</option>
												<option value="Q" <#if mastref.actc?? && mastref.actc = "Q">selected="selected"</#if>>Q - Quarter Credit</option>
												<option value="S" <#if mastref.actc?? && mastref.actc = "S">selected="selected"</#if>>S - Semester Credit</option>
												<option value="U" <#if mastref.actc?? && mastref.actc = "U">selected="selected"</#if>>U - Unit Credit</option>
												<option value="C" <#if mastref.actc?? && mastref.actc = "C">selected="selected"</#if>>C - CEU Credit</option>
												<option value="N" <#if mastref.actc?? && mastref.actc = "N">selected="selected"</#if>>N - No Credit</option>
												<option value="A" <#if mastref.actc?? && mastref.actc = "A">selected="selected"</#if>>A - Adult</option>
												<option value="V" <#if mastref.actc?? && mastref.actc = "V">selected="selected"</#if>>V - Vocational</option>
												<option value="G" <#if mastref.actc?? && mastref.actc = "G">selected="selected"</#if>>G - Carnegie Units (Pre K-12)</option>
												<option value="X" <#if mastref.actc?? && mastref.actc = "X">selected="selected"</#if>>X - Other</option>
											</select>
										  </div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										    <label for="unitscale">Unit Scale</label>
										  <input class="form-control input-sm" id="unitscale" <#if mastref.actc?? && mastref.actc = "U"><#else>disabled="disabled"</#if> type="text" value="${mastref.unitscale?c}" maxlength="6" onfocus="setVisibility('iref_unitscaleHelp','inline')" onBlur="setVisibility('iref_unitscaleHelp','none')" >
										  </div>
								</div>
								<div class="col-md-4">
									<div class="form-group">
										    <label for="bacc">Academic Credit Code</label>
										   <select id="bacc" class="form-control input-sm" onfocus="setVisibility('iref_baccHelp','inline')" onBlur="setVisibility('iref_baccHelp','none')">
												<option value=" ">&nbsp;</option>
												<option value="A" <#if mastref.bacc?? && mastref.bacc = "A">selected="selected"</#if>>A - AP Program</option>
												<option value="B" <#if mastref.bacc?? && mastref.bacc = "B">selected="selected"</#if>>B - Credit by Exam</option>
												<option value="C" <#if mastref.bacc?? && mastref.bacc = "C">selected="selected"</#if>>C - CLEP</option>
												<option value="D" <#if mastref.bacc?? && mastref.bacc = "D">selected="selected"</#if>>D - DANTES Program</option>
												<option value="E" <#if mastref.bacc?? && mastref.bacc = "E">selected="selected"</#if>>E - Life Experience</option>
												<option value="F" <#if mastref.bacc?? && mastref.bacc = "F">selected="selected"</#if>>F - Study Abroad</option>
												<option value="G" <#if mastref.bacc?? && mastref.bacc = "G">selected="selected"</#if>>G - CEEB Credit</option>
												<option value="H" <#if mastref.bacc?? && mastref.bacc = "H">selected="selected"</#if>>H - Removal of Incomplete</option>
												<option value="I" <#if mastref.bacc?? && mastref.bacc = "I">selected="selected"</#if>>I - International Baccalaureate</option>
												<option value="M" <#if mastref.bacc?? && mastref.bacc = "M">selected="selected"</#if>>M - Military Credit</option>
												<option value="N" <#if mastref.bacc?? && mastref.bacc = "N">selected="selected"</#if>>N - Correspondence</option>
												<option value="R" <#if mastref.bacc?? && mastref.bacc = "R">selected="selected"</#if>>R - Regular Enrollment</option>
												<option value="T" <#if mastref.bacc?? && mastref.bacc = "T">selected="selected"</#if>>T - Credits Transferred In</option>
												<option value="V" <#if mastref.bacc?? && mastref.bacc = "V">selected="selected"</#if>>V - Audit or Visitor Status</option>
												<option value="W" <#if mastref.bacc?? && mastref.bacc = "W">selected="selected"</#if>>W - Work Experience</option>
												<option value="X" <#if mastref.bacc?? && mastref.bacc = "X">selected="selected"</#if>>X - Not Applicable</option>
												<option value="Z" <#if mastref.bacc?? && mastref.bacc = "Z">selected="selected"</#if>>Z - Other</option>
												<option value="2" <#if mastref.bacc?? && mastref.bacc = "2">selected="selected"</#if>>2 - 2nd Baccalaureate</option>
												<option value="J" <#if mastref.bacc?? && mastref.bacc = "J">selected="selected"</#if>>J - Abitur</option>
												<option value="P" <#if mastref.bacc?? && mastref.bacc = "P">selected="selected"</#if>>P - ACE Credit</option>
												<option value="O" <#if mastref.bacc?? && mastref.bacc = "O">selected="selected"</#if>>O - ADV Int Cam Program</option>
												<option value="L" <#if mastref.bacc?? && mastref.bacc = "L">selected="selected"</#if>>L - Defense Language Inst.</option>
												<option value="Q" <#if mastref.bacc?? && mastref.bacc = "Q">selected="selected"</#if>>Q - French Baccalaureate</option>
												<option value="S" <#if mastref.bacc?? && mastref.bacc = "S">selected="selected"</#if>>S - Graduate Level Course</option>
												<option value="K" <#if mastref.bacc?? && mastref.bacc = "K">selected="selected"</#if>>K - Italian Lyceium</option>
												<option value="U" <#if mastref.bacc?? && mastref.bacc = "U">selected="selected"</#if>>U - Undergrad Level Course</option>
												<option value="Y" <#if mastref.bacc?? && mastref.bacc = "Y">selected="selected"</#if>>Y - Writing Across the Curriculum</option>
											</select>
										  </div>
								</div>
							</div>
							
							<h4>Universal Condition Code Assignment</h4>
							<div class="row">
							
								<div class="col-md-4">
									 <div class="form-group">
									 	<label for="refucond1">RefUCond1</label>
									 	<input class="form-control input-sm" id="refucond1" type="text" value="${mastref.refucond1!''}" maxlength="3" onfocus="setVisibility('iref_refucond1Help','inline')" onBlur="setVisibility('iref_refucond1Help','none')">
									 </div>
								</div>
								<div class="col-md-4">
									 <div class="form-group">
									 	<label for="refucond2">RefUCond2</label>
									 	<input class="form-control input-sm" id="refucond2" type="text" value="${mastref.refucond2!''}" maxlength="3" onfocus="setVisibility('iref_refucond2Help','inline')" onBlur="setVisibility('iref_refucond2Help','none')">
									 </div>
								</div>
								
							</div>
							
						</div>
					</div>
					
				</form>
	        </div>
	        
	        <div class="tab-pane fade<#if tabid?has_content && tabid == "grade"> active in</#if>" id="grade" role="tabpanel" aria-labelledby="gradeTab">
				<div class="row" style="padding: 5px 0px;">
					<div class="col-md-8">
					</div>
					<div class="col-md-4">
						<span class="pull-right">
						<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
						Add row at line <input type="text" class="" id="insertGrade" value="${gradeDefs?size + 1}" style="width: 30px;">
						<a accesskey="g" type="button" id="addGrade" class="btn btn-success btn-xs" onclick="addRowGrade()" href="#" title="Add Row"><i class="fa fa-plus"></i> Add</a>
						</@redauth.authorize>
						</span>
					</div>
				</div>
				<div class="table-responsive">
				<table class="table table-bordered table-striped" id="gradeTable">
				      <thead>
				        <tr class="ui-state-default" <#if homeIref> style="font-size: 10px;"</#if> >
				          <th class="aligncenter"><i class="fa fa-bars"></i></th>
				          <th class="aligncenter">#</th>
				          <th class="aligncenter">Type</th>
				          <#if homeIref>
				          	<th class="aligncenter">IU</th>
				          </#if>
				          <th class="aligncenter">Grade</th>
				          <th class="aligncenter">AC</th>
				          <th class="aligncenter">RC</th>
						  <#if homeIref>
				          <th class="aligncenter">UI</th>
				          </#if>
				          <th class="aligncenter">Univ Grade</th>
				          <#if homeIref>
				          <th class="aligncenter">AC Univ</th>
				          <th class="aligncenter">RC Univ</th>
				          </#if>
				          <th class="aligncenter">GPA</th>
				          <th class="aligncenter">GPA Calc</th>
				          <th class="aligncenter">Add Credit</th>
				          <th class="aligncenter">Add Count</th>
				          <#if homeIref>
				          <th class="aligncenter">Assign C1</th>
				          <th class="aligncenter">Assign C2</th>
						  </#if>
				          <th class="aligncenter">Assign Univ C1</th>
				          <th class="aligncenter">Assign Univ C2</th>
				          <th class="aligncenter">Effective Year/Term Range</th>
				          <th class="aligncenter">Memo</th>
				          <th class="aligncenter">Details</th>
				          <th class="aligncenter">Delete</th>
				        </tr>
				      </thead>
				      <tbody id="gradeSortable" class="ui-sortable" style="">
				      		<#list gradeDefs as gradeDef>
					      	<tr id="gradeRow-${gradeDef_index+1}" class="ui-state-default">
					      		<td class="move aligncenter"><i class="fa fa-bars"></i></td>
					      		<td class="userSeqNo aligncenter">${gradeDef.userSeqNo}</td>
					      		<td class="aligncenter">
					      			<select class="ltype" name="ltype" onfocus="setVisibility('iref_ltypeHelp','inline')" onBlur="setVisibility('iref_ltypeHelp','none')">
					      				<option value="G" <#if gradeDef.ltype?? && gradeDef.ltype = "G">selected="selected"</#if>>Grade</option>
					      				<option value="C" <#if gradeDef.ltype?? && gradeDef.ltype = "C">selected="selected"</#if>>Condition</option>
					      				<option value="F" <#if gradeDef.ltype?? && gradeDef.ltype = "F">selected="selected"</#if>>Flag</option>
					      				<option value="A" <#if gradeDef.ltype?? && gradeDef.ltype = "A">selected="selected"</#if>>Average</option>
					      				<option value="S" <#if gradeDef.ltype?? && gradeDef.ltype = "S">selected="selected"</#if>>SPEEDE</option>
				      				</select>
				  				</td>
				  				<td class="aligncenter" <#if !homeIref> style="display: none"</#if>><input class="i2uflg" type="checkbox" style="margin-left: 0px;float: none;" value="Y" onfocus="setVisibility('iref_i2uflgHelp','inline')" onBlur="setVisibility('iref_i2uflgHelp','none')" <#if gradeDef.i2uflg??  && gradeDef.i2uflg = "Y">checked</#if>></td>
				  				<td class="aligncenter"><input type="text" value="${gradeDef.grade!''}" class="grade" name="grade" maxlength="4" style="width: 40px;" onfocus="setVisibility('iref_gradeHelp','inline')" onBlur="setVisibility('iref_gradeHelp','none')"></td>
				  				<td class="aligncenter"><input type="text" value="${gradeDef.ac!''}" class="ac" name="ac" maxlength="1" style="width: 25px;" onfocus="setVisibility('iref_acHelp','inline')" onBlur="setVisibility('iref_acHelp','none')"></td>
				  				<td class="aligncenter"><input type="text" value="${gradeDef.rc!''}" class="rc" name="rc" maxlength="1" style="width: 25px;" onfocus="setVisibility('iref_rcHelp','inline')" onBlur="setVisibility('iref_rcHelp','none')"></td>
				  				<td class="aligncenter" <#if !homeIref> style="display: none"</#if>><input class="u2iflg" type="checkbox" style="margin-left: 0px;float: none;" value="Y" onfocus="setVisibility('iref_u2iflgHelp','inline')" onBlur="setVisibility('iref_u2iflgHelp','none')"  <#if gradeDef.u2iflg??  &&  gradeDef.u2iflg = "Y">checked</#if>></td>
								<td class="aligncenter"><input class="ugrade" type="text" value="${gradeDef.ugrade!''}" name="ugrade" maxlength="4" style="width: 40px;" <#if homeIref>onfocus="setVisibility('iref_ugradeHomeHelp','inline')" onBlur="setVisibility('iref_ugradeHomeHelp','none')</#if> <#if !homeIref>onfocus="setVisibility('iref_ugradeSourceHelp','inline')" onBlur="setVisibility('iref_ugradeSourceHelp','none') </#if>"></td>
								<td class="aligncenter" <#if !homeIref> style="display: none"</#if>><input type="text" value="${gradeDef.acu!''}" class="acu" name="acu" maxlength="3" style="width: 30px;" onfocus="setVisibility('iref_acuHelp','inline')" onBlur="setVisibility('iref_acuHelp','none')"></td>
				  				<td class="aligncenter" <#if !homeIref> style="display: none"</#if>><input type="text" value="${gradeDef.rcu!''}" class="rcu" name="rcu" maxlength="3" style="width: 30px;" onfocus="setVisibility('iref_rcuHelp','inline')" onBlur="setVisibility('iref_rcuHelp','none')"></td>
				  				<td class="aligncenter"><input type="text" value="${gradeDef.gpapt?c}" class="gpapt" name="gpapt" maxlength="11" style="width: 42px;" onfocus="setVisibility('iref_gpaptHelp','inline')" onBlur="setVisibility('iref_gpaptHelp','none')"></td>
				  				<td class="aligncenter">
				  					<select class="gpacal" name="gpacal" style="width: 38px;" onfocus="setVisibility('iref_gpacalHelp','inline')" onBlur="setVisibility('iref_gpacalHelp','none')">
				  						<option value=" " >&nbsp; &nbsp; &nbsp; &nbsp;No Change </option>
				  						<option value="N" <#if gradeDef.gpacal?? && gradeDef.gpacal = "N">selected="selected"</#if>>N &nbsp; &nbsp; No</option>
				  						<option value="Y" <#if gradeDef.gpacal?? && gradeDef.gpacal = "Y">selected="selected"</#if>>Y &nbsp; &nbsp; Yes</option>
				  						<option value="V" <#if gradeDef.gpacal?? && gradeDef.gpacal = "V">selected="selected"</#if>>V &nbsp; &nbsp; &gt;=</option>
									</select>
								</td>
								<td class="aligncenter">
									<select class="addcr" name="addcr" style="width: 38px;" onfocus="setVisibility('iref_addcrHelp','inline')" onBlur="setVisibility('iref_addcrHelp','none')">
										<option value=" " >&nbsp; &nbsp; &nbsp; &nbsp;No Change </option>
										<option value="N" <#if gradeDef.addcr?? && gradeDef.addcr = "N">selected="selected"</#if>>N &nbsp; &nbsp; No</option>
										<option value="Y" <#if gradeDef.addcr?? && gradeDef.addcr = "Y">selected="selected"</#if>>Y &nbsp; &nbsp; Yes</option>
										<option value="I" <#if gradeDef.addcr?? && gradeDef.addcr = "I">selected="selected"</#if>>I &nbsp; &nbsp; &nbsp;Directly Input</option>
									</select>
								</td>
								<td class="aligncenter">
									<select class="addct" name="addct" style="width: 38px;" <#if homeIref>onfocus="setVisibility('iref_addctHomeHelp','inline')" onBlur="setVisibility('iref_addctHomeHelp','none')"</#if> <#if !homeIref>onfocus="setVisibility('iref_addctSourceHelp','inline')" onBlur="setVisibility('iref_addctSourceHelp','none')" </#if>>
										<option value="1" <#if gradeDef.addct = "1">selected="selected"</#if>>1 &nbsp; &nbsp; Acceptable</option>
										<option value="0" <#if gradeDef.addct = "0">selected="selected"</#if>>0 &nbsp; &nbsp; Not Acceptable</option>
										<option value="X" <#if gradeDef.addct = "X">selected="selected"</#if>>X &nbsp; &nbsp; Tentatively Acceptable</option>
									</select>
								</td>
								<td class="aligncenter"><input type="text" value="${gradeDef.cond1!''}" class="cond1" name="cond1" maxlength="1" style="width: 25px;" onfocus="setVisibility('iref_cond1Help','inline')" onBlur="setVisibility('iref_cond1Help','none')"></td>
								<td class="aligncenter"><input type="text" value="${gradeDef.cond2!''}" class="cond2" name="cond2" maxlength="1" style="width: 25px;" onfocus="setVisibility('iref_cond2Help','inline')" onBlur="setVisibility('iref_cond2Help','none')"></td>
								<td class="aligncenter" <#if !homeIref> style="display: none"</#if>><input type="text" value="${gradeDef.ucond1!''}" class="ucond1" name="ucond1" maxlength="3" style="width: 30px;" onfocus="setVisibility('iref_ucond1Help','inline')" onBlur="setVisibility('iref_ucond1Help','none')"></td>
								<td class="aligncenter" <#if !homeIref> style="display: none"</#if>><input type="text" value="${gradeDef.ucond2!''}" class="ucond2" name="ucond2" maxlength="3" style="width: 30px;" onfocus="setVisibility('iref_ucond2Help','inline')" onBlur="setVisibility('iref_ucond2Help','none')"></td>
								
								<#if gradeDef.effdte??>
									<#assign tempDate = gradeDef.effdte >
								<#else>
									<#assign tempDate ="" >
								</#if>
								<#assign effdate = tempDate?right_pad(12)>
								<td class="aligncenter"><input type="text" value="${effdate?substring(0,6)}" class="effdte" name="effdte" maxlength="6" style="width: 50px;" onfocus="setVisibility('iref_effdteHelp','inline')" onBlur="setVisibility('iref_effdteHelp','none')">&nbsp;-&nbsp;<input type="text" value="${effdate?substring(6)}" class="effdte2" name="effdte2" maxlength="6" style="width: 50px;" onfocus="setVisibility('iref_effdteHelp','inline')" onBlur="setVisibility('iref_effdteHelp','none')"></td>
								<td class="aligncenter">
									<a href="#" class="gradeMemoButton btn btn-info btn-xs" name="gradeMemoButton" type="button" data-placement="top" data-toggle="popover" title="Memo" data-content="${gradeDef.memo!''}" onclick="return false;"
									 <#if gradeDef.memo??><#else>disabled="disabled"</#if> >
										<i class="fa fa-file-text-o"></i>
									</a>
								</td>
								<td class="aligncenter"><a href="#" class="btn btn-default btn-xs" type="button" onclick="popGradeModal(event);return false;"><i class="fa fa-ellipsis-h"></i></a></td>
								<td class="aligncenter">
									<@redauth.authorize ifAnyGranted="SS_ENCODING_TA_IREF=u,SS_ENCODING_TA_IREF=c">
									<button type="button" class="btn btn-danger btn-xs deleteGrade" onclick="delRowGrade(event)" title="Delete Course"><i class="fa fa-trash-o"></i></button></td>
									</@redauth.authorize>
								<input type="hidden" value="${gradeDef.intSeqNo?c}" class="intSeqNo" />
								<input type="hidden" value="${gradeDef.memo!''}" class="grade_memo" />
								<input type="hidden" value="${gradeDef.lastModDate!''}" class="last_mod_date" />
								<input type="hidden" value="${gradeDef.lastModUser!''}" class="last_mod_user" />
							</tr>
							</#list>
						</tbody>
				    </table>
				    </div>
					<!-- Modal -->
					<#include 'modals/gradeModal.ftl' />
				</div>
			</div>
	    		
	        <#if homeIref>
	        <div class="tab-pane fade<#if tabid?has_content && tabid == "credit"> active in</#if>" id="credit" role="tabpanel" aria-labelledby="creditTab">
	    		<h4 style="padding: 15px 0px;">Transfer Credit Allocation Assignment</h4>
					<div class="row">
						<div class="col-md-3">
							<div class="row">
								<div class="col-md-8">
									<div class="form-group">
										    <label for="cscale">Credit Scale</label>
										   <select id="cscale" class="form-control input-sm" onfocus="setVisibility('iref_cscaleHelp','inline')" onBlur="setVisibility('iref_cscaleHelp','none')">
												<option value=" ">Default</option>
												<option value="0" <#if mastref.cscale?? && mastref.cscale = "0">selected="selected"</#if>>0</option>
												<option value="1" <#if mastref.cscale?? && mastref.cscale = "1">selected="selected"</#if>>0.0</option>
												<option value="2" <#if mastref.cscale?? && mastref.cscale = "2">selected="selected"</#if>>0.00</option>
												<option value="3" <#if mastref.cscale?? && mastref.cscale = "3">selected="selected"</#if>>0.000</option>
												<option value="4" <#if mastref.cscale?? && mastref.cscale = "4">selected="selected"</#if>>0.0000</option>
												<option value="5" <#if mastref.cscale?? && mastref.cscale = "5">selected="selected"</#if>>0.00000</option>
											</select>
										  </div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-8">
								<div class="form-group">
									    <label for="cassign">Assign</label>
									   <select id="cassign" class="form-control input-sm" onfocus="setVisibility('iref_cassignHelp','inline')" onBlur="setVisibility('iref_cassignHelp','none')">
											<option value=" ">' ' - No Change</option>
											<option value="E" <#if mastref.cassign?? && mastref.cassign = "E">selected="selected"</#if>>E - Exact to 5 decimal places</option>
											<option value="R" <#if mastref.cassign?? && mastref.cassign = "R">selected="selected"</#if>>R - Round to Credit Scale</option>
											<option value="T" <#if mastref.cassign?? && mastref.cassign = "T">selected="selected"</#if>>T - Truncate to Credit Scale</option>
											<option value="U" <#if mastref.cassign?? && mastref.cassign = "U">selected="selected"</#if>>U - Round up to Credit Scale</option>
										</select>
									  </div>
							</div>
							</div>
							<div class="row">
								<div class="col-md-8">
								<div class="form-group">
									    <label for="cexcess">Excess</label>
									   <select id="cexcess" class="form-control input-sm" onfocus="setVisibility('iref_cexcessHelp','inline')" onBlur="setVisibility('iref_cexcessHelp','none')">
											<option value=" " >' ' - No Change</option>
											<option value="Z" <#if mastref.cexcess?? && mastref.cexcess = "Z">selected="selected"</#if>>Z - Zero Out</option>
											<option value="F" <#if mastref.cexcess?? && mastref.cexcess = "F">selected="selected"</#if>>F - Carry Forward</option>
											<option value="A" <#if mastref.cexcess?? && mastref.cexcess = "A">selected="selected"</#if>>A - Accumulate to End</option>
										</select>
									  </div>
							</div>
							</div>
							<div class="row">
								<div class="col-md-8">
								<div class="form-group">
									    <label for="cfinal">Final</label>
									   <select id="cfinal" class="form-control input-sm" onfocus="setVisibility('iref_cfinalHelp','inline')" onBlur="setVisibility('iref_cfinalHelp','none')">
											<option value=" ">' ' - No Change</option>
											<option value="Z" <#if mastref.cfinal?? && mastref.cfinal = "Z">selected="selected"</#if>>Z - Zero Out</option>
											<option value="R" <#if mastref.cfinal?? && mastref.cfinal = "R">selected="selected"</#if>>R - Round</option>
											<option value="T" <#if mastref.cfinal?? && mastref.cfinal = "T">selected="selected"</#if>>T - Truncate</option>
											<option value="U" <#if mastref.cfinal?? && mastref.cfinal = "U">selected="selected"</#if>>U - Round Up</option>
											<option value="X" <#if mastref.cfinal?? && mastref.cfinal = "X">selected="selected"</#if>>X - Assign to Default</option>
										</select>
									  </div>
							</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-md-4">
									<div class="form-group">
									   <label for="dcourse">Default Course</label>
									   <input class="form-control input-sm" id="dcourse" type="text" value="${mastref.dcourse}" maxlength="15" onfocus="setVisibility('iref_dcourseHelp','inline')" onBlur="setVisibility('iref_dcourseHelp','none')">
									</div>
								</div>
								<div class="col-md-3">
									<div class="form-group">
									    <label for="dpflg">Pseudo</label>
									    <span class="microhelp btn-microHelp" style="padding: 2px 3px 2px 5px; border-radius: 3px;" onfocus="setVisibility('iref_dpflgHelp','inline')" onBlur="setVisibility('iref_dpflgHelp','none')" tabindex="0">
											<i class="fa fa-lightbulb-o"><span class="sr-only">click for microhelp</span></i>
										</span>
									    <br>
									    <input type="checkbox"  value="P" <#if mastref.dpflg?? && mastref.dpflg = "P">checked="true"</#if> style="margin-left: 0px;float: none;" id="dpflg">
								 	 </div>
								</div>
							</div>
						</div>
					</div>

	        </div>
	        
	        <div class="tab-pane fade<#if tabid?has_content && tabid == "gpa"> active in</#if>" id="gpa" role="tabpanel" aria-labelledby="gpaTab">
	    		<div class="row" style="padding: 15px 0px;">
					<div class="col-md-4">
						<div class="row">
							<div class="col-md-8">
								<div class="form-group">
								   <label for="gpascale">GPA Scale</label>
								   <select id="gpascale" class="form-control input-sm" onfocus="setVisibility('iref_gpascaleHelp','inline')" onBlur="setVisibility('iref_gpascaleHelp','none')">
										<option value=" " >'&nbsp;' - 0.000</option>
										<option value="W" <#if mastref.gpascale?? && mastref.gpascale = "W">selected="selected"</#if>>W - 00.00</option>
										<option value="Q" <#if mastref.gpascale?? && mastref.gpascale = "Q">selected="selected"</#if>>Q - 000.0</option>
									</select>
								  </div>
								  <div class="form-group">
								   <label for="gparule">Unalike GPA Assignment</label>
								   <select id="gparule" class="form-control input-sm" onfocus="setVisibility('iref_gparuleHelp','inline')" onBlur="setVisibility('iref_gparuleHelp','none')">
										<option value=" ">No Rule</option>
										<option value="R" <#if mastref.gparule?? && mastref.gparule = "R">selected="selected"</#if>>R - Retain within group</option>
										<option value="A" <#if mastref.gparule?? && mastref.gparule = "A">selected="selected"</#if>>A - Accumulate until final</option>
									</select>
								  </div>
								  
							  </div>
						  </div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
								   <label for="grule">Unalike Grade Assignment</label>
								   <select id="grule" class="form-control input-sm" onfocus="setVisibility('iref_gruleHelp','inline')" onBlur="setVisibility('iref_gruleHelp','none')">
										<option value=" " >No Rule</option>
										<option value="D" <#if mastref.grule?? && mastref.grule = "D">selected="selected"</#if>>D - DGrade</option>
										<option value="U" <#if mastref.grule?? && mastref.grule = "U">selected="selected"</#if>>U - Existing Grade</option>
									</select>
								  </div>
						
						<div class="form-group">
						   <label for="dgrade">Universal&nbsp;Passed Default Grade</label>
						   <input class="form-control input-sm" id="dgrade" type="text" value="${mastref.dgrade}" maxlength="4" onfocus="setVisibility('iref_dgradeHelp','inline')" onBlur="setVisibility('iref_dgradeHelp','none')" >
						</div>
						<div class="form-group">
						   <label for="d0grade">Universal Not Passed Default Grade</label>
						   <input class="form-control input-sm" id="d0grade" type="text" value="${mastref.d0grade}" maxlength="4" onfocus="setVisibility('iref_d0gradeHelp','inline')" onBlur="setVisibility('iref_d0gradeHelp','none')" >
						</div>
					</div>
				</div>
	        </div>
	        
			<#else>
	        <div class="tab-pane fade<#if tabid?has_content && tabid == "address"> active in</#if>" id="address" role="tabpanel" aria-labelledby="addressTab">
	    		 <form role="form">
						<div class="row" style="padding: 15px 0px;">
							<div class="col-md-6" style="padding-left: 0px;padding-right: 0px;">
								<div class="col-md-12"> 
								  <div class="form-group">
								    <label for="ADDRESS1">Address Line 1</label>
								   <input class="form-control input-sm" id="ADDRESS1" type="text" value="${mastrefAddress.address1!''}" maxlength="35" onfocus="setVisibility('iref_address1Help','inline')" onBlur="setVisibility('iref_address1Help','none')" >
								  </div>
							  	</div>
							  	<div class="col-md-12"> 
								  <div class="form-group">
								    <label for="ADDRESS2">Address Line 2</label>
								   <input class="form-control input-sm" id="ADDRESS2" type="text" value="${mastrefAddress.address2!''}" maxlength="35" onfocus="setVisibility('iref_address2Help','inline')" onBlur="setVisibility('iref_address2Help','none')" >
								  </div>
							  	</div>
							  	<div class="col-md-6">
								  <div class="form-group">
								    <label for="CITY">City</label>
								   <input class="form-control input-sm" id="CITY" type="text" value="${mastrefAddress.city!''}" maxlength="30" onfocus="setVisibility('iref_cityHelp','inline')" onBlur="setVisibility('iref_cityHelp','none')"  >
								  </div>
								</div>
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="STATE">State</label>
								   <input class="form-control input-sm" id="STATE" type="text" value="${mastrefAddress.state!''}" maxlength="2" onfocus="setVisibility('iref_stateHelp','inline')" onBlur="setVisibility('iref_stateHelp','none')"  >
								  </div>
								</div>
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="ZIP">Zip</label>
								   <input class="form-control input-sm" id="ZIP" type="text" value="${mastrefAddress.zip!''}" maxlength="10" onfocus="setVisibility('iref_zipHelp','inline')" onBlur="setVisibility('iref_zipHelp','none')"  >
								  </div>
								</div>
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="COUNTRY">Country</label>
								   <input class="form-control input-sm" id="COUNTRY" type="text" value="${mastrefAddress.country!''}" maxlength="3" onfocus="setVisibility('iref_countryHelp','inline')" onBlur="setVisibility('iref_countryHelp','none')"  >
								  </div>
								</div>
							</div>
							<div class="col-md-6" style="padding-left: 0px;padding-right: 0px;">
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="LOCATIONQ">Location Qualifier</label>
								   <select id="LOCATIONQ" class="form-control input-sm" onfocus="setVisibility('iref_locationqHelp','inline')" onBlur="setVisibility('iref_locationqHelp','none')">
								   		<option value=" " <#if mastrefAddress.locationq?? && mastrefAddress.locationq = ' '>selected="selected"</#if>>   No location</option>
									   	<option value="CC" <#if mastrefAddress.locationq?? && mastrefAddress.locationq = 'CC'>selected="selected"</#if>>CC Country</option>
									   	<option value="CY" <#if mastrefAddress.locationq?? && mastrefAddress.locationq = 'CY'>selected="selected"</#if>>CY County or Parish</option>
									   	<option value="SD" <#if mastrefAddress.locationq?? && mastrefAddress.locationq = 'SD'>selected="selected"</#if>>SD School District</option>
									   	<option value="SP" <#if mastrefAddress.locationq?? && mastrefAddress.locationq = 'SP'>selected="selected"</#if>>SP State or Province</option>
								   	</select>
								  </div>
								</div>
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="LOCATIONID">Location ID</label>
								   <input class="form-control input-sm" id="LOCATIONID" type="text" value="${mastrefAddress.locationid!''}" maxlength="25" onfocus="setVisibility('iref_locationidHelp','inline')" onBlur="setVisibility('iref_locationidHelp','none')"  >
								  </div>
								</div>
								
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="CONTACTCD">Contact Code</label>
								   <select id="CONTACTCD" class="form-control input-sm" onfocus="setVisibility('iref_contactcdHelp','inline')" onBlur="setVisibility('iref_contactcdHelp','none')">
									   	<option value=" " <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = ' '>selected="selected"</#if>>None</option>
									   	<option value="RG" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'RG'>selected="selected"</#if>>RG Registrar</option>
									   	<option value="UG" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'UG'>selected="selected"</#if>>UG Undergraduate Admissions Office</option>
									   	<option value="GR" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'GR'>selected="selected"</#if>>GR Graduate Admissions Office</option>
									   	<option value="LD" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'LD'>selected="selected"</#if>>LD Law School Admissions Office</option>
									   	<option value="OA" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'OA'>selected="selected"</#if>>OA Medical Admissions Office</option>
									   	<option value="DN" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'DN'>selected="selected"</#if>>DN Dental School Admissions Office</option>
									   	<option value="TC" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'TC'>selected="selected"</#if>>TC College of Education Admissions Office</option>
									   	<option value="TH" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'TH'>selected="selected"</#if>>TH School of Theology Admissions Office</option>
									   	<option value="VM" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'VM'>selected="selected"</#if>>VM School of Veterinary Medicine Admissions Office</option>
									   	<option value="FA" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'FA'>selected="selected"</#if>>FA Financial Aid Officer</option>
									   	<option value="SK" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'SK'>selected="selected"</#if>>SK School Clerk</option>
									   	<option value="SP" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'SP'>selected="selected"</#if>>SP Special Program Contact</option>
									   	<option value="PS" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'PS'>selected="selected"</#if>>PS Personnel Department</option>
									   	<option value="GC" <#if mastrefAddress.contactcd?? && mastrefAddress.contactcd = 'GC'>selected="selected"</#if>>GC Guidance Counselor</option>
								   </select>
								  </div>
								</div>
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="CONTACTNAME">Contact Name</label>
								   <input class="form-control input-sm" id="CONTACTNAME" type="text" value="${mastrefAddress.contactname!''}" maxlength="35" onfocus="setVisibility('iref_contactnameHelp','inline')" onBlur="setVisibility('iref_contactnameHelp','none')"  >
								  </div>
								</div>
								
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="COMMNOQ">Preferred Contact</label>
								   <select id="COMMNOQ" class="form-control input-sm" onfocus="setVisibility('iref_commnoqHelp','inline')" onBlur="setVisibility('iref_commnoqHelp','none')">
									   	<option value=" " <#if mastrefAddress.commnoq?? && mastrefAddress.commnoq == ' '>selected="selected"</#if>>None</option>
									   	<option value="EM" <#if mastrefAddress.commnoq?? && mastrefAddress.commnoq == 'EM'>selected="selected"</#if>>Email</option>
									   	<option value="FX" <#if mastrefAddress.commnoq?? && mastrefAddress.commnoq == 'FX'>selected="selected"</#if>>Fax</option>
									   	<option value="TE" <#if mastrefAddress.commnoq?? && mastrefAddress.commnoq == 'TE'>selected="selected"</#if>>Telephone</option>
								   </select>
								  </div>
								</div>
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="FAX">Fax</label>
								   <input class="form-control input-sm" id="FAX" type="text" value="${mastrefAddress.fax!''}" maxlength="25" onfocus="setVisibility('iref_faxHelp','inline')" onBlur="setVisibility('iref_faxHelp','none')"  >
								  </div>
								</div>
								<div class="col-md-6">
								  <div class="form-group">
								    <label for="PHONE">Phone</label>
								   <input class="form-control input-sm" id="PHONE" type="text" value="${mastrefAddress.phone!''}" maxlength="25" onfocus="setVisibility('iref_phoneHelp','inline')" onBlur="setVisibility('iref_phoneHelp','none')"  >
								  </div>
								</div>
								<div class="col-md-6"> 
								  <div class="form-group">
								    <label for="E_MAIL">Email</label>
								   <input class="form-control input-sm" id="E_MAIL" type="text" value="${mastrefAddress.email!''}" maxlength="80" onfocus="setVisibility('iref_emailHelp','inline')" onBlur="setVisibility('iref_emailHelp','none')" >
								  </div>
							  	</div>
							</div>
						</div>
						<div class="row">
						  	<div class="col-md-12"> 
							  <div class="form-group">
							    <label for="MEMO">Memo</label>
							   <textarea class="form-control" rows="3" id="ADDRESS_MEMO" maxlength="255" onfocus="setVisibility('iref_addressmemoHelp','inline')" onBlur="setVisibility('iref_addressmemoHelp','none')">${mastrefAddress.memo!''}</textarea>
							  </div>
						  	</div>
					  	</div>
					  	<input type="hidden" value="${mastrefAddress.lastModUser!''}" id="address_last_mod_user">
					  	<input type="hidden" value="${mastrefAddress.lastModDate!''}" id="address_last_mod_date">
					</form>
	        </div>
	        </#if>
 		</div> <!-- tab-content -->
 		<input type="hidden" value="${homeIref?string("true", "false")}" id="homeIref"/>

		<#if tabid?has_content>
		<script type="text/javascript">
			$j(document).ready(function() {
				$j('#iref-refresh').attr('href', refreshUrl + '&tabid=${tabid}');
			});
		</script>
		</#if>
		
		
				
		<!-- Help Modal -->
		<#include 'modals/irefHelpModal.ftl' />
		<#include 'modals/courseMaskHelpModal.ftl' />
		
		
</@layout.body>