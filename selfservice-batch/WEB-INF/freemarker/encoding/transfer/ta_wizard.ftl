<@layout.head title="Institutional Reference Table Wizard" />

<@layout.body>
		
		<!-- School Info Rows -->
	    	<div class="row">
	    	<div class="col-md-5">
	    		<span style="font-size: 14px; font-weight: 500;">Institutional Reference Table</span>
	    		<br>
		    		<span style="font-size: 14px; font-weight: 500;">${instName}</span> 
	    		</div>
	    		<div class="col-md-3">
		      		<span style="font-size: 12px; font-weight: 500; color: gray;margin-right: 3px;">Source ID:
		      		<span style="color: black;">${sourceId}</span></span>
		    	</div>
	    		<div class="col-md-4">
	    			<span class="pull-right">
				    	<a href="<@s.url "/encoding/transfer/institution.html" />" type="button" class="btn btn-default " style="margin-left: 5px;">Cancel</a>
    				</span>
		    	</div>
	    	</div>
	    	
      	
	    <!-- /School Info Rows -->
	    
	     <hr>
	    <!-- Body -->
	    
	    
	    <div id="createError" class="error" style="display: none;">
	     An TA Record already exists for the chosen first year term, Source CD, and DPMask.
	    </div>

	    <div class="row">
	    	<div class="col-md-12">
			    <div class="row">
		    		<div class="col-md-10">	
			    		 <h4>New TA Wizard</h4>
			    	</div>
			    </div>
    			
    			
    			<div class="row">
    				<div class="col-md-2">
						<div class="form-group">
					    	<label for="fyt">First Year Term <span style="color: gray;">(required)</label>
					   		<input class="form-control input-sm" id="fyt" name="fyt" type="text" value="000000" maxlength="6">
					  	</div>
    				</div>
    			</div>
    			
    			<div class="row">
    				<div class="col-md-2">
						<div class="form-group">
				    		<label for="sourceCd">Source CD <span style="color: gray;">(optional)</label>
					   		<input class="form-control input-sm" id="sourceCd" name="sourceCd" type="text" maxlength="3" value="">
					  	</div>
    				</div>
    			</div>
    			
    			<div class="row">
    				<div class="col-md-2">
						<div class="form-group">
				    		<label for="DPMask">DPMask <span style="color: gray;">(optional)</label>
					   		<input class="form-control input-sm" id="DPMask" name="DPMask" type="text"  maxlength="15" value="">
					  	</div>
    				</div>
    			</div>
    			
				 <div class="row">
		    		<div class="col-md-12">				    
					    
						    <button  onclick="createTA()" class="btn btn-default">Create TA </button>
						    <a href="<@s.url "/encoding/transfer/institution.html" />" type="button" class="btn btn-default " style="margin-left: 5px;">Cancel</a>
					</div>
				</div>
			    
			 </div>	    
    	</div>
	    <!-- /Body -->
		
</@layout.body>