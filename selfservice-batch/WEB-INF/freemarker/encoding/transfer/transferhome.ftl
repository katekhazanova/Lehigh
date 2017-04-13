<@layout.head title="Transfer Articulation" />
<#assign security=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<@layout.body>
	<div class="row"><div id="content" class="col-md-12">
  		<!-- Title Row -->
	    		<h1>Transfer Articulation </h1>
	    <!-- /Title Row -->
	    
	    <!-- Search Row -->
	    	<div class="row">
		    	<div class="col-md-9">
		    		<form role="form">
				    <div class="form-group">
				      <input type="text" class="form-control" id="transferInstSearch" placeholder="Search by School Name or Source ID (Minimum 3 Characters case-sensitive)">
			      </div> 
			      </form>
		      	</div>
		      	<div class="col-md-3">
		      		<span class="pull-right">
		      		<@security.authorize ifAllGranted="SS_ENCODING_TA_IREF=c">	
		    		<a href="#createSchoolModal" data-toggle="modal" type="button" class="btn btn-success" style="margin-right: 5px;"><i class="fa fa-plus" aria-hidden="true"></i> Add New School</a>
		    	  	</@security.authorize>
		    	  	</span>
		    	  </div>
	      	</div>
	    <!-- /Search Row -->

		<#assign recentInstsSize = recentInsts?size/>


	    <div  id="searchMessage"class="row" >
	    	<div class="col-md-12">
			<#if recentInstsSize == 0>
				<span style="font-weight: bold; font-size: 14px;">${transferInsts?size} schools available.</span> Enter a partial School Name or Source ID to search.
			<#else>
				<h1>Recently Viewed Schools</h1>
				<input type="hidden" id="recentInsts" value="true"/>
			</#if>

	     		
			</div>
	    </div>
	    <!-- Body Row -->
    	<div class="row" style="min-height: 300px;">
				
     			<div class="col-md-12">
    			<table id="transferInstTable" class="table  table-bordered table-striped" <#if recentInstsSize == 0> style="display:none;"</#if>>
    				<thead>
	    				<tr>
		    				<th>School Name</th>
		    				<th class="aligncenter">Source ID</th>
		    				<th class="aligncenter">IREF</th>
		    				<th class="aligncenter">Transfer</th>
		    				<th class="aligncenter">View</th>
		    				<!-- <th>Clone</th> -->
		    				<th class="aligncenter">Delete</th>
	    				</tr>
    				</thead>
    				<tbody id="trasferInstBody" >
    				<#list transferInsts as transferInst>
	    				<tr id="transferInst-${transferInst.comp_id.sourceId}" 
						<#assign flag = recentInsts?seq_contains(transferInst.comp_id.sourceId)?string("yes", "no") />
						<#if flag == "no">
							
							style="display:none;"
						<#else>
							class="recentInstsRow"
						</#if>
						>
	    					<td><span class="instName" id="instName-${transferInst.comp_id.sourceId}">${transferInst.instName!''}</span>
	    						<@security.authorize ifAllGranted="SS_ENCODING_TA_IREF=u">
								 <a href="#" class="pull-right btn btn-xs btn-default"  onclick="loadEditTransferModal('${transferInst.comp_id.sourceId}'); return false;">Rename</a>
								</@security.authorize>
							</td>
	    					<td class="aligncenter">${transferInst.comp_id.sourceId}</td>
	    					<td class="aligncenter">${transferInst.mastrefCount}</td>
	    					<td class="aligncenter">${transferInst.tcaMasterCount}</td>
	    					<td class="aligncenter"><a id="instLink-${transferInst.comp_id.sourceId}"class="btn btn-default btn-xs" href="<@s.url "/encoding/transfer/institution.html?sourceId=${transferInst.comp_id.sourceId}" />"><i class="fa fa-folder-open"></i></a></td>
	    					<td class="aligncenter"><a class="btn btn-danger btn-xs" href="#"  
								<#if transferInst.mastrefCount gt 0 ||transferInst.tcaMasterCount gt 0>
									disabled="disabled"
								<#else>
									onclick="deleteTransferInst('${transferInst.comp_id.sourceId}'); return false;"
								</#if>><i class="fa fa-trash-o"></i></a></td>
	    				</tr>
					</#list>
    				</tbody>
    			</table>
    			
    			<div id="noSchools" class="alert alert-warning" role="alert" style="display:none">No schools found matching searched School Name or Source ID.</div>
    		</div>

    	</div>
	    <!-- /Body Row -->
  	</div></div>
  	
  	
  	
  	<!-- createSchool Modal -->
		<div class="modal" id="createSchoolModal" tabindex="-1" role="dialog" aria-labelledby="createSchoolModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">Add New School</h4>
		        </div>
		        <div class="modal-body">
			       <div id="createError" class="error" style="display: none;">
				     	An Transfer Institution Record already exists for the chosen Source ID.
				    </div>
				 	<div class="row">
				    	<div class="col-lg-9">
						    <input type="text" value="" class="form-control" id="schoolName" placeholder="Enter school name" maxlength="60"/>
				      	</div>
				      	<div class="col-md-3">
				      		<input type="text" value="" class="form-control" id="schoolID" placeholder="Source ID" maxlength="8"/>
				    	</div>
			    	</div>
				</div><!-- /.modal-body -->
				
		    	<div class="modal-footer" style="margin-top: 5px;">
					<a href="#" type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</a>
					<a href="#" type="button" class="btn btn-success" onclick="createTransferInst()">Add School</a>
					</div>
			  	</div>	<!-- /.modal-footer -->	
		      </div><!-- /.modal-content -->
		    </div><!-- /.modal-dialog -->
		  </div><!-- /.modal -->
		
	<!-- /createSchool Modal -->

  	<!-- editSchool Modal -->
		<div class="modal" id="editSchoolModal" tabindex="-1" role="dialog" aria-labelledby="editSchoolModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">Change School Name</h4>
		        </div>
		        <div class="modal-body">
				 	<div class="row">
				    	<div class="col-lg-9">
						    <input type="text" class="form-control" id="edit-schoolName"  maxlength="60"/>
						    <input type="hidden"  id="edit-sourceId" />
				      	</div>
			    	</div>
				</div><!-- /.modal-body -->
				
		    	<div class="modal-footer" style="margin-top: 5px;">
					<a href="#" type="button" class="btn btn-default" data-dismiss="modal" aria-hidden="true">Cancel</a>
					<a href="#" type="button" class="btn btn-primary" onclick="editTransferInst()">Change Name</a>
					</div>
			  	</div>	<!-- /.modal-footer -->	
		      </div><!-- /.modal-content -->
		    </div><!-- /.modal-dialog -->
		  </div><!-- /.modal -->
		
	<!-- /editSchool Modal -->
  	
		
</@layout.body>