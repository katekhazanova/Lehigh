<@layout.head title="Transfer Articulation - ${instName!''}" />
<#assign security=JspTaglibs["/WEB-INF/tld/red-auth.tld"]>

<@layout.body>
		<!-- Title Row -->
	    		<h1 class="sr-only">Transfer Articulation</h1>
	    <!-- /Title Row -->
	    
  		
	    <!-- School Info Rows -->
	    
	    <div class="row">
	    	<div class="col-md-5">
	    		<span style="font-size: 14px; font-weight: 500;">Transfer Articulation</span>
	    		<br>
		    		<span style="font-size: 14px; font-weight: 500;">${instName!''}</span> 
	    		</div>
	    		<div class="col-md-3">
	    			<br>
		      		<span style="font-size: 12px; font-weight: 500; color: gray;margin-right: 3px;">Source ID:
		      		<span style="color: black;">${sourceId}</span>
		    	</div>
	    		<div class="col-md-4">
	    			<span class="pull-right">
	    				<a href="<@s.url "/encoding/transfer/transferhome.html" />" type="button" class="btn btn-default pull-right" style="width:118px;">Return to list</a>
    				</span>
		    	</div>
	    	</div>
	    	
      	
	    <!-- /School Info Rows -->
	    
	     <hr>
	    <!-- Body -->
	    <div class="row">
	    	<@security.authorize ifAllGranted="SS_ENCODING_TA_IREF=r">
	    	<div class="col-md-12">
	    		<div class="row">
		    		<div class="col-md-10">	
			    		 <h4>Institutional Reference Tables</h4>
			    	</div>
			    	
			    	<div class="col-md-2">

		    			<span class="pull-right">
							<@security.authorize ifAllGranted="SS_ENCODING_TA_IREF=c"> 
			    			<a href="<@s.url "/encoding/transfer/irefWizard.html" />" class="btn btn-success btn-sm" type="button" title="Add new IREF Table"><i class="fa fa-plus" aria-hidden="true"></i> Add IREF Table</a>
		    				</@security.authorize>
						</span>
	    			</div>
    			</div>
	    		
		    	<div class="table-responsive">
				    <table id="irefTable" class="table table-bordered table-striped">
				    	<colgroup>
					        <col class="col-xs-4">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					      </colgroup>
				      <thead>
				        <tr>
				          <th>Name</th>
				          <th>Source ID</th>
				          <th>Source CD</th>
				          <th>FYT</th>
				          <th>LYT</th>
				          <th class="aligncenter">Clone</th>
				          <th class="aligncenter">Edit</th>
				          <th class="aligncenter">Delete</th>
				        </tr>
				      </thead>
				      <tbody>
				      	<#list mastrefs as mastref>
				        <tr id="irefRow-${mastref_index}" >
				          <td>${mastref.iname!''}</td>
				          <td>${mastref.comp_id.sourceId}</td>
				          <td id="iref-sourceCd">${mastref.comp_id.sourceCd}</td>
				          <td id="iref-fyt">${mastref.comp_id.mrfyt}</td>
				          <td>${mastref.lyt}</td>
				          <td class="aligncenter">
				          	<@security.authorize ifAllGranted="SS_ENCODING_TA_IREF=c">
				          	<a class="btn btn-default btn-xs" href="iref.html?sourceCd=${mastref.comp_id.sourceCd?url}&fyt=${mastref.comp_id.mrfyt?url}&clone=true"><i class="fa fa-copy"></i></a>
						  	</@security.authorize>
						  </td>
				          <td class="aligncenter">
				          	<@security.authorize ifAnyGranted="SS_ENCODING_TA_IREF=r,SS_ENCODING_TA_IREF=u">
				          	<a class="btn btn-default btn-xs" href="iref.html?sourceCd=${mastref.comp_id.sourceCd?url}&fyt=${mastref.comp_id.mrfyt?url}"><i class="fa fa-edit"></i></a>
							</@security.authorize>				          	
							</td>
				          <td class="aligncenter">
				          	<@security.authorize ifAllGranted="SS_ENCODING_TA_IREF=d">	
							<a class="btn btn-danger btn-xs" href="#" onclick="deleteIref('irefRow-${mastref_index}');return false;" ><i class="fa fa-trash-o"></i></a>
						  	</@security.authorize>
						  </td>
				        </tr>
				        </#list>
				      </tbody>
				    </table>
				  </div>		
		    	
		    		
		    </div>
			</@security.authorize>	
		    <br>
		    <@security.authorize ifAllGranted="SS_ENCODING_TA_RULE=r">
		   	<div class="col-md-12"> 
		   		<div class="row">
		    		<div class="col-md-10">	
			    		 <h4>Transfer Articulation Table</h4>
			    	</div>
			    	
			    	<div class="col-md-2">
			    		<span class="pull-right"> 
							<@security.authorize ifAllGranted="SS_ENCODING_TA_IREF=c"> 
			    			<a href="<@s.url "/encoding/transfer/taWizard.html" />" type="button" class="btn btn-success btn-sm" title="Add new TA Table" style="width: 118px;"><i class="fa fa-plus" aria-hidden="true"></i> Add TA Table</a>
			    			</@security.authorize>
			    		</span>
	    			</div>
    			</div>
		   	
		    <div class="table-responsive">
				    <table id="taTable" class="table table-bordered table-striped">
				    	<colgroup>
					        <col class="col-xs-3">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					        <col class="col-xs-1">
					      </colgroup>
				      <thead>
				        <tr>
				          <th>Name</th>
				          <th>Source ID</th>
				          <th>Source CD</th>
				          <th>DPMask</th>
				          <th>FYT</th>
				          <th>LYT</th>
				          <th class="aligncenter">Clone</th>
				          <th class="aligncenter">Edit</th>
				          <th class="aligncenter">Delete</th>
				        </tr>
				      </thead>
				      <tbody>
				      	<#list tcaMasters as tcaMaster>
				        <tr id="taRow-${tcaMaster_index}">
				          <td>${tcaMaster.iname!''}</td>
				          <td>${tcaMaster.comp_id.sourceId}</td>
				          <td id="ta-sourceCd">${tcaMaster.comp_id.sourceCd}</td>
						  <td id="ta-dpmask">${tcaMaster.comp_id.dpmask}</td>
				          <td id="ta-fyt">${tcaMaster.comp_id.fyt}</td>
				          <td>${tcaMaster.lyt}</td>
				          <td class="aligncenter">
				          	<@security.authorize ifAllGranted="SS_ENCODING_TA_RULE=c">
				          	<a class="btn btn-default btn-xs" href="<@s.url "/encoding/transfer/ta.html?sourceCd=${tcaMaster.comp_id.sourceCd?url}&fyt=${tcaMaster.comp_id.fyt?url}&dpmask=${tcaMaster.comp_id.dpmask?url}&clone=true" />"><i class="fa fa-copy"></i></a>
                          	</@security.authorize>
						  </td>
				          <td class="aligncenter">
							<@security.authorize ifAnyGranted="SS_ENCODING_TA_RULE=r,SS_ENCODING_TA_RULE=u">
							<a class="btn btn-default btn-xs" href="<@s.url "/encoding/transfer/ta.html?sourceCd=${tcaMaster.comp_id.sourceCd?url}&fyt=${tcaMaster.comp_id.fyt?url}&dpmask=${tcaMaster.comp_id.dpmask?url}" />"><i class="fa fa-edit"></i></a>
	      				    </@security.authorize>
	      				  </td>
				          <td class="aligncenter">
				          	<@security.authorize ifAllGranted="SS_ENCODING_TA_RULE=d">
							<a class="btn btn-danger btn-xs" href="#" onclick="deleteTA('taRow-${tcaMaster_index}'); return false;" ><i class="fa fa-trash-o" ></i></a>
						  	</@security.authorize>
						  </td>
				        </tr>
				        </#list>
				      </tbody>
				    </table>
				  </div>		
    		
    		</div>
			</@security.authorize>
    	</div>
	    <!-- /Body -->
	    
</@layout.body>