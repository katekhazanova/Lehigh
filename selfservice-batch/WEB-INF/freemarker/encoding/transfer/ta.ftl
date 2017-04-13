<@layout.head title="Transfer Articulation Table - ${tcaMaster.iname!''}" />
<#assign security=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<@layout.body autoScroll=true>

	<!-- School Info Rows -->
	    	
	    <h1 class="sr-only">Transfer Articulation Table</h1>
		<div class="row">
	    	<div class="col-md-5">
	    		<span style="font-size: 14px; font-weight: 500;">
	    			Transfer Articulation Table
	    			<a href="#" type="button" data-toggle="modal" data-target="#helpModal" >
					  <i class="fa fa-question-circle"><span class="sr-only">Help</span></i>
					</a>
	    		</span>
				<br>
		    		<span style="font-size: 14px; font-weight: 500;" id="inameHeader" >${tcaMaster.iname!''}</span> 
	    		</div>
	    		<div class="col-md-3">
		      		<span style="font-size: 12px; font-weight: 500; color: gray;margin-right: 3px;">Source ID:
		      		<span style="color: black;" id="ta-sourceId">${tcaMaster.comp_id.sourceId}</span></span>
		      		<span style="font-size: 12px; font-weight: 500; color: gray;margin-right: 3px;">CD:
		      		<span style="color: black;" id="ta-sourceCd">${tcaMaster.comp_id.sourceCd}</span></span>
		      		<br>
		      		<span style="font-size: 12x; font-weight: 500; color: gray;margin-right: 3px;">FYT:
		      		<span style="color: black;" id="ta-fyt">${tcaMaster.comp_id.fyt}</span></span>
		      		<span style="font-size: 12px; font-weight: 500; color: gray;margin-right: 3px;">DPMask:
		      		<span style="color: black;" id="ta-dpmask">${tcaMaster.comp_id.dpmask}</span></span>
		    	</div>
	    		<div class="col-md-4">
	    			<span class="pull-right">
    				<a href="#" type="button" class="btn btn-microHelp btn-sm" data-toggle="collapse" data-target="#help, .microhelp" aria-expanded="true" aria-controls="help" id="showMicroHelp" title="Microhelp">
    					<i class="fa fa-lightbulb-o"><span class="sr-only">Click to view microhelp</span></i>
					</a>
					<a href="<@s.url "/encoding/transfer/ta.html?sourceCd=${tcaMaster.comp_id.sourceCd?url}&fyt=${tcaMaster.comp_id.fyt?url}&dpmask=${tcaMaster.comp_id.dpmask?url}&refresh=true" />" type="button" id="ta-refresh" class="btn btn-default btn-sm"><i class="fa fa-undo"></i> Restore</a>
					<#if clone=="false">
						<@security.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
						<a href="#" type="button" id="ta-save" onclick="saveTa()" class="btn btn-primary btn-sm" accesskey="s" <#if !unsavedChanges>disabled</#if>><i class="fa fa-save"></i> Save</a>
						</@security.authorize>
					<#else>
						<@security.authorize ifAllGranted="SS_ENCODING_TA_RULE=c">
						<a href="#" type="button" id="ta-save" onclick="cloneTa()" class="btn btn-primary btn-sm" accesskey="s" <#if !unsavedChanges>disabled</#if>><i class="fa fa-copy"></i> Clone</a>
    					</@security.authorize>
					</#if>
					<input type="hidden" id="unsavedChanges" value="${unsavedChanges?string("true","false")}" /> 
    				<a href="<@s.url "/encoding/transfer/institution.html" />" id="ta-exit"  type="button" class="btn btn-default btn-sm" accesskey="x"><i class="fa fa-arrow-left"></i> Exit Table</a>
						<@security.authorize ifNoneGranted="SS_ENCODING_TA_RULE=u,SS_ENCODING_TA_RULE=c">
							<input type="hidden" id="disableTAInputs"value="true" />
						</@security.authorize>
					</span>
		    	</div>
	    	</div>
      	
	    <!-- /School Info Rows -->
	    <hr class="smallTopMargin">
	    <!-- Body -->
	  	<div class="row">
			<div id="savingTAMessage" class="col-md-offset-3 col-md-6 alert alert-info" style="display:none;" >
				<center><i class="fa fa-spinner fa-spin" aria-hidden="true"></i> <strong>Saving...</strong> We are currently saving data do not leave the page.</center>
			</div>
		</div>
	   <div id="help" class="row collapse " style="margin: 5px;" aria-live="polite" aria-atomic="true" aria-relevant="all">
			<div  id="includedHelp">
				<#include "../micro_help/ta_micro_help.ftl" />
			</div>
		</div>
	    <div>
			<ul class="nav nav-tabs" role="tablist" id="myTab" style="margin: 0px;">
			  <li <#if segment??><#else>class="active"</#if>><a href="#ta-general" role="tab" data-toggle="tab">General</a></li>
			  <li><a href="#ta-default" role="tab" data-toggle="tab">Default Tables</a></li>
			  <li><a href="#segment" role="tab" data-toggle="tab">Segments</a></li>
			  <li <#if segment??>class="active"</#if>><a href="#rules" role="tab" data-toggle="tab">Edit Rules</a></li>
			  <!-- <li class=""><a href="#search" role="tab" data-toggle="tab">Search Rules</a></li> -->
			</ul>
          </div>
	    
	     <div id="ta-form" class="tab-content">
		    	<div class="tab-pane fade <#if segment??><#else> active in</#if>" id="ta-general">
		    		<div class="row" style="padding: 15px 0px;">
					    <form role="form">
					    	<div class="col-md-8 col-sm-12 col-xs-12"> 
							  <div class="form-group">
							    <label for="INAME">School Name</label>
							   <input class="form-control input-sm" id="INAME" type="text" value="${tcaMaster.iname!''}" maxlength="60" onfocus="setVisibility('ta_inameHelp','inline')" onBlur="setVisibility('ta_inameHelp','none')">
							  </div>
						  	</div>
						  	<div class="col-md-2 col-sm-3 col-xs-6">
						  	<div class="form-group">
							    <label for="TASTATUS">Hide from Transferology <br>& Reference Audits</label>
							    <span class="microhelp btn-microHelp" style="padding: 2px 3px 2px 5px; border-radius: 3px;" onfocus="setVisibility('ta_tastatus1Help','inline')" onBlur="setVisibility('ta_tastatus1Help','none')" tabindex="0">
									<i class="fa fa-lightbulb-o" ><span class="sr-only">click for microhelp</span></i>
								</span>
								<br>
							    <input type="checkbox" id="TASTATUS" value="H" <#if tcaMaster.tastatus?? && tcaMaster.tastatus == 'H'>checked</#if> style="margin-left: 0px;margin-top:0px;float: none;">
							  </div>
							 	
							  </div>
					  	</form>
					  	
				  	</div>
				  	<form role="form">
				  	<div class="row">
						  	<div class="col-md-2 col-sm-3 col-xs-6">
							  <div class="form-group">
							    <label for="SOURCE_ID">Source ID</label>
							   <input class="form-control input-sm" id="SOURCE_ID" type="text" value="${tcaMaster.comp_id.sourceId}"   
							  maxlength="8" onfocus="setVisibility('ta_sourceidHelp','inline')" onBlur="setVisibility('ta_sourceidHelp','none')"  <#if clone=="false">disabled="disabled"</#if>>
							  </div>
						  	</div>
						  	<div class="col-md-2 col-sm-3 col-xs-6">
							  <div class="form-group">
							    <label for="SOURCE_CD">Source CD</label>
							   <input class="form-control input-sm" id="SOURCE_CD" type="text" value="${tcaMaster.comp_id.sourceCd}" 
							   maxlength="3" onfocus="setVisibility('ta_sourcecdHelp','inline')" onBlur="setVisibility('ta_sourcecdHelp','none')" <#if clone=="false">disabled="disabled"</#if>>
							  </div>
							</div>
							<div class="col-md-2 col-sm-3 col-xs-6">
							  <div class="form-group">
							    <label for="DPMASK">DP Mask</label>
							   <input class="form-control input-sm" id="DPMASK" type="text" value="${tcaMaster.comp_id.dpmask}" 
							    maxlength="15" onfocus="setVisibility('ta_dpmaskHelp','inline')" onBlur="setVisibility('ta_dpmaskHelp','none')" <#if clone=="false">disabled="disabled"</#if>>
							  </div>
							</div>
							<div class="col-md-2 col-sm-3 col-xs-6">
							  <div class="form-group">
							  	 <div class="form-group">
							        <label for="UNIVDPMASK">Universal DP Mask </label>
							          <span class="microhelp btn-microHelp" style="padding: 2px 3px 2px 5px; border-radius: 3px;" onfocus="setVisibility('ta_univdpmaskHelp','inline')" onBlur="setVisibility('ta_univdpmaskHelp','none')" tabindex="0">
										  <i class="fa fa-lightbulb-o" ><span class="sr-only">click for microhelp</span></i>
									  </span>
							          <br>
							          <input type="checkbox" style="margin-left: 0px;float: none;" id="UNIVDPMASK" value="Y" <#if tcaMaster.univDpmask?? && tcaMaster.univDpmask ="Y">checked="true"</#if>>
							        
							       </div>
							  </div>
							  </div>
							<div class="col-md-2 col-sm-3 col-xs-6">
							  <div class="form-group">
							    <label for="FYT">First Year Term</label>
							   <input class="form-control input-sm" id="FYT" type="text" value="${tcaMaster.comp_id.fyt}" 
							    maxlength="6" onfocus="setVisibility('ta_fytHelp','inline')" onBlur="setVisibility('ta_fytHelp','none')" <#if clone=="false">disabled="disabled"</#if>>
							  </div>
						  	</div>
						  	<div class="col-md-2 col-sm-3 col-xs-6"> 
							  <div class="form-group">
							    <label for="LYT">Last Year Term</label>
							   <input class="form-control input-sm" id="LYT" type="text" value="${tcaMaster.lyt}"
							    maxlength="6" onfocus="setVisibility('ta_lytHelp','inline')" onBlur="setVisibility('ta_lytHelp','none')">
							  </div>
						  	</div>
				  	</div>
				  	<div class="row">
						<div class="col-md-12">
						  <div class="form-group">
						    <label for="MEMO">Memo</label>
						   <textarea class="form-control input-sm" id="MEMO" rows="3"
						    maxlength="255" onfocus="setVisibility('ta_memoHelp','inline')" onBlur="setVisibility('ta_memoHelp','none')">${tcaMaster.memo!''}</textarea>
						  </div>
						</div>
				  	</div>
				  	<div class="row">
				  		<div class="col-md-3">
							  <div class="form-group" style="padding-left: 5px;"><br>
							  	 <div>
							        <label for="last_mod_date">Last modified:</label>
							    	<span id="ta_last_mod_date" class="last_mod small">${tcaMaster.lastModDate!''}</span>  
							    </div>
							  </div>
						  </div>
						  <div class="col-md-3">
							  <div class="form-group" style="padding-left: 5px;"><br>
								 <div>
							        <label for="last_mod_user">By:</label>
									<span id="ta_last_mod_user" class="last_mod small">${tcaMaster.lastModUser!''}</span>
							     </div>
							  </div>
						  </div>
				  	</div>
				</form>
	    	</div> <!-- tab-pane -->
	    	<div class="tab-pane fade" id="ta-default">
	    		<form role="form">
					<h3>Default TA Table</h3>
					<span class="help-block">(Use the rules from the school set in the Default TA Table <i>after</i> the rules set on this table.)</span>
					<div class="row">
						<div class="col-md-2 col-sm-3 col-xs-6">
						  <div class="form-group">
						    <label for="dinstid">Default InstID</label>
						   <input class="form-control input-sm" id="dinstid" type="text" value="${tcaMaster.dinstid!''}" 
						    maxlength="8" onfocus="setVisibility('ta_dinstidHelp','inline')" onBlur="setVisibility('ta_dinstidHelp','none')">
						  </div>
						</div>
						<div class="col-md-2 col-sm-3 col-xs-6">
						  <div class="form-group">
						    <label for="dinstcd">Default InstCD</label>
						   <input class="form-control input-sm" id="dinstcd" type="text" value="${tcaMaster.dinstcd!''}" 
						    maxlength="3" onfocus="setVisibility('ta_dinstcdHelp','inline')" onBlur="setVisibility('ta_dinstcdHelp','none')">
						  </div>
						</div>
					</div>
				</form>		
	        </div>
	    	<div class="tab-pane fade" id="segment">
	    		<div class="row" style="padding-top: 15px;">
			        <div class="col-sm-12 col-md-12">
			        	<div class="row" style="padding-bottom: 5px;">
							<div class="col-md-4 col-md-offset-8">
								<span class="pull-right">
									<@security.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
									<button accesskey="n" type="button" class="btn btn-success btn-xs" onclick="popNewSegmentModal()" title="Add Row"><i class="fa fa-plus"></i> Add Row</button>
									</@security.authorize>
								</span>
							</div>
						</div>
						<table class="table table-bordered table-striped" id="segmentList">
							<thead>
								<tr class="ui-state-default">
									<th class="aligncenter" style="width: 40px;">#</th>
									<th class="aligncenter" style="width: 100px;">Segment Name</th>
									<th class="">Segment Hint</th>
									<th class="aligncenter" style="width: 40px;">Description</th>
									<th class="aligncenter" style="width: 40px;">Details</th>
									<th class="aligncenter" style="width: 40px;">Edit</th>
									
									<th class="aligncenter" style="width: 40px;">Delete</th>
								</tr>
							</thead>
							<tbody id="sortableSegment">						
								<#list segList as segment>
								<tr id="segmentRow-${segment_index+1}" class="ui-state-default">
									<td class="userSeqNo aligncenter vAlignMid <#if segment.tseg == selectedRule.tseg>selectedSegment</#if>">${segment_index + 1}</td>
									<td class="tsegName <#if segment.tseg == selectedRule.tseg>selectedSegment</#if>">${segment.tseg}</td>
									<td class="tsegHint <#if segment.tseg == selectedRule.tseg>selectedSegment</#if>">${segment.hint!''}</td>
									<td class="aligncenter vAlignMid <#if segment.tseg == selectedRule.tseg>selectedSegment</#if>"> 
										<a href="#" tabindex="0" class="segmentDescButton btn btn-info btn-xs" role="button" data-placement="top" data-container="body"  data-toggle="popover"  title="Memo" data-content="${segment.description!''}" onclick="return false;"
											<#if !segment.description?has_content>
										disabled="disabled"
									</#if>>
											<i class="fa fa-file-text-o"></i>
										</a>
									</td>
									<td class="aligncenter vAlignMid <#if segment.tseg == selectedRule.tseg>selectedSegment</#if>"> 
										<a href="#" class="btn btn-default btn-xs" type="button" onclick="popSegmentModal(${segment_index});return false;">
											<i class="fa fa-ellipsis-h"></i>
										</a> 
									</td>
									<td class="aligncenter vAlignMid <#if segment.tseg == selectedRule.tseg>selectedSegment</#if>"> 
										<a href="#" class="btn btn-default btn-xs" type="button" onclick="editSegment(event);return false;">
											<i class="fa fa-edit"></i>
										</a> 
									</td>
									<td class="aligncenter vAlignMid <#if segment.tseg == selectedRule.tseg>selectedSegment</#if>">
										<@security.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
										<button type="button" class="btn btn-danger btn-xs" onclick="delTaRow(event,'#sortableSegment','none')" title="Delete Segment"
											<#if segment.tseg == selectedRule.tseg>disabled="disabled"</#if>><i class="fa fa-trash-o"></i></button>
										</@security.authorize>
									</td>
									<#if segment.intSeqNo??><input type="hidden" class="intSeqNo" value="${segment.intSeqNo?c}" /></#if>
									<input type="hidden" class="tsegDesc" value="${segment.description!''}" />
									<input type="hidden" value="${segment.lastModDate!''}" class="last_mod_date" />
									<input type="hidden" value="${segment.lastModUser!''}" class="last_mod_user" />
								</tr>
								</#list>
							</tbody>
						</table>
						<!-- Modal -->
						<#include 'modals/segmentModal.ftl' />
						
					</div>
				</div>
			</div>
	    	<div class="tab-pane fade <#if segment??> active in</#if>" id="rules">
	    		<#if selectedRule??>
			    	<#include "ta_editrule.ftl" />
				<#else>
					<br/>
					<br/>
					<br/>
					<br/>
					<div class=" alert alert-info">
						Please create a Segment and set a Segment name before adding rules.
					</div>
				</#if>
	        </div>
	        
	  <!--      <div class="tab-pane fade" id="search">
				Search stuff goes here
	        </div> -->
	    	
	 	</div> <!-- tab-content -->
	 	
	 	
		<!-- Help Modal -->
		<#include 'modals/taHelpModal.ftl' />
	 	
	 	
	 	
	 	
	 	
	    <!-- /Body -->
		
</@layout.body>



