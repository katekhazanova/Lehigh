<@layout.head title="${pageContext.page.label}">
	<#if autoPoll>
		<meta http-equiv="refresh" content="${batchConfig.batchPollingRate}">
	</#if>
</@layout.head>
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
	<h1>Batch</h1>
	<@t.setSelectedTab tab='batch/list' />
	<@t.printBatchTabs />
	<h2><@s.message 'uachieve.selfservice.batch.definition.list.header' /></h2>
	
	<p class="alert alert-danger" role="alert" tabindex="0"${isHidden}>${alertMessage}</p>
	
    <!-- Search Row -->
    	<div class="row">
	    	<div class="col-md-5">
	    		<form role="form">
			    <div class="form-group">
			      <input type="text" class="form-control" id="batchSearch" placeholder="Filter Batch Results (Minimum 3 Characters)">
		      </div> 
		      </form>
	      	</div>
	      	<div class="col-md-7">
	      	</div>
	   </div>
    <!-- /Search Row -->
	
	<@p.masterView ctx=pageContext addButton="Add Batch"/>

	<input type="hidden" id="contextPath" value="${springMacroRequestContext.getContextPath()}" />
	

	<div class="modal fade" id="runBatchModal" tabindex="-1" role="dialog" aria-labelledby="runBatchLabel" aria-hidden="true">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="runBatchLabel">Clone or Replace Batch</h4>
      </div>
      <div class="modal-body">
      
      <div id="student-warning" class="alert alert-info" role="alert"></div>
      
      <div class="row">
      	<div class="form-group col-md-12">
      		<div class="btn-group" data-toggle="buttons">
			  <label class="btn btn-default">
			    <input type="radio" id="clone-batch" name="clone-batch" value="true"> Clone
			  </label>
			  <label class="btn btn-default active">
			    <input type="radio" id="replace-batch" name="clone-batch" value="false" checked="checked"> Replace
			  </label>
			</div>
      	</div>
      </div>
      
      
      
      <input type="hidden" id="run-batchId" />
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <a href="#" type="button" class="btn btn-primary" onclick="submitRunBatchAndClone();return false;">Submit</a>
      </div>
    </div>
  </div>
</div>

</@layout.body>

