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
	     An Institutional Reference Record already exists for the chosen first year term and Source CD.
	    </div>

	    <div class="row">
	    	<div class="col-md-12">
			    <div class="row">
		    		<div class="col-md-10">	
			    		 <h4>New IREF Wizard</h4>
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
    			
		<!--<h5 style="margin-bottom: 0px;">Select the elements you would like to import <span style="color: gray;">(optional)</span></h5>
		<div class="help" style="margin-bottom: 10px;">All values can be edited after import</div>-->
		
		 <div class="row">
    		<div class="col-md-12">				    
			    
			   <!-- <a href="#">Select All/None</a>
				    <ul class="list-unstyled">
				    	<li>
				    		<div class="checkbox checkboxText">
							    <label>
							      <input type="checkbox" > 
							      <span class="checklist">Address &nbsp; </span> 
							    </label>
							    <span class="checklistLink"> 
							      	<a href="#addressModal" data-toggle="modal">
							      	Preview
							      	</a>
							      </span>
							</div>
						</li>
						<li>
				    		<div class="checkbox checkboxText">
							    <label>
							      <input type="checkbox" > 
							      <span class="checklist">Grades &nbsp; </span> 
							    </label>
							    <span class="checklistLink"> 
							      	<a href="#gradesModal" data-toggle="modal">
							      	Preview
							      	</a>
							      </span>
							</div>
						</li>
				    	<li>
				    		<div class="checkbox checkboxText">
							    <label>
							      <input type="checkbox" > 
							      <span class="checklist">Course Mask &nbsp; </span> 
							    </label>
							    <span class="checklistLink"> 
							      	<a href="#maskModal" data-toggle="modal">
							      	Preview
							      	</a>
							      </span>
							</div>
						</li>
						<li>
				    		<div class="checkbox checkboxText">
							    <label>
							      <input type="checkbox" > 
							      <span class="checklist">Credit Type &nbsp; </span> 
							    </label>
							    <span class="checklistLink"> 
							      	<a href="#creditModal" data-toggle="modal">
							      	Preview
							      	</a>
							      </span>
							</div>
						</li>
				    </ul>-->
				    <button  onclick="createIref()" class="btn btn-default">Create IREF</button>
				    <a href="<@s.url "/encoding/transfer/institution.html" />" type="button" class="btn btn-default " style="margin-left: 5px;">Cancel</a>
			    
			</div>
		</div>
			    
			 </div>	    
    	</div>
	    <!-- /Body -->
	    
	<!--  Address Preview Modal -->
		<div class="modal" id="addressModal" tabindex="-1" role="dialog" aria-labelledby="addressModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">Address Preview</h4>
		        </div>
			        <div class="modal-body">
				        
				      	<table class="table table-bordered">
				        	<tbody>
				        		<tr>
				        			<th>Address Line 1:</th>
				        			<td>3800 Victory Parkway</td>
				        		</tr>
				        		<tr>
				        			<th>Address Line 2:</th>
				        			<td> </td>
				        		</tr>
				        		<tr>
				        			<th>City:</th>
				        			<td>Cincinnati</td>
				        		</tr>
				        		<tr>
				        			<th>State:</th>
				        			<td>OH</td>
				        		</tr>
				        		<tr>
				        			<th>Zip:</th>
				        			<td>45207</td>
				        		</tr>
				        		<tr>
				        			<th>Country:</th>
				        			<td> </td>
				        		</tr>
				        	</tbody>
				        </table>

					</div>





		        </div>
		      </div> <!-- /.modal-content -->
		    </div> <!-- /.modal-dialog -->
		</div> <!-- /.modal -->
	<!-- /Address Preview Modal -->  
	
	<!--  Grades Preview Modal -->
		<div class="modal" id="gradesModal" tabindex="-1" role="dialog" aria-labelledby="gradesModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">Grades Preview</h4>
		        </div>
		        <div class="modal-body">
			        <table class="table table-bordered">
			        	<thead>
			        		<th>Grade</th>
			        		<th>GPA</th>
			        	</thead>
			        	<tbody>
			        		<tr>
			        			<td>A</td>
			        			<td>4.00</td>
			        		</tr>
			        		<tr>
			        			<td>A-</td>
			        			<td>3.67</td>
			        		</tr>
			        		<tr>
			        			<td>B+</td>
			        			<td>3.33</td>
			        		</tr>
			        		<tr>
			        			<td>B</td>
			        			<td>3.00</td>
			        		</tr>
			        		<tr>
			        			<td>B-</td>
			        			<td>2.67</td>
			        		</tr>
			        		<tr>
			        			<td>C+</td>
			        			<td>2.33</td>
			        		</tr>
			        		<tr>
			        			<td>C</td>
			        			<td>2.00</td>
			        		</tr>
			        		<tr>
			        			<td>C-</td>
			        			<td>1.67</td>
			        		</tr>
			        		<tr>
			        			<td>D+</td>
			        			<td>1.33</td>
			        		</tr>
			        		<tr>
			        			<td>D</td>
			        			<td>1.00</td>
			        		</tr>
			        		<tr>
			        			<td>D-</td>
			        			<td>0.67</td>
			        		</tr>
			        		<tr>
			        			<td>F</td>
			        			<td>0.00</td>
			        		</tr>
			        		<tr>
			        			<td>P</td>
			        			<td>0.00</td>
			        		</tr>
			        		<tr>
			        			<td>W</td>
			        			<td>0.00</td>
			        		</tr>
			        		<tr>
			        			<td>I</td>
			        			<td>0.00</td>
			        		</tr>
			        		<tr>
			        			<td>RG</td>
			        			<td>0.00</td>
			        		</tr>
			        	</tbody>
			        </table>





		        </div>
		      </div> <!-- /.modal-content -->
		    </div> <!-- /.modal-dialog -->
		</div> <!-- /.modal -->
	<!-- /Grades Preview Modal --> 
	
	<!--  Mask Preview Modal -->
		<div class="modal" id="maskModal" tabindex="-1" role="dialog" aria-labelledby="maskModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">Course Mask Preview</h4>
		        </div>
		        <div class="modal-body">
			        <table class="table table-bordered">
			        	<tbody>
			        		<tr>
			        			<th>Mask:</th>
			        			<td>AAAA9999</td>
			        		</tr>
			        		<tr>
			        			<th>Department Begin:</th>
			        			<td>1</td>
			        		</tr>
			        		<tr>
			        			<th>Department End:</th>
			        			<td>4</td>
			        		</tr>
			        		<tr>
			        			<th>Course Begin:</th>
			        			<td>5</td>
			        		</tr>
			        		<tr>
			        			<th>Course End:</th>
			        			<td>8</td>
			        		</tr>
			        	</tbody>
			        </table>
			        </div>
		      </div> <!-- /.modal-content -->
		    </div> <!-- /.modal-dialog -->
		</div> <!-- /.modal -->
	<!-- /Mask Preview Modal --> 
	
	<!--  Credit Type Preview Modal -->
		<div class="modal" id="creditModal" tabindex="-1" role="dialog" aria-labelledby="creditModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		          <h4 class="modal-title">Credit Type Preview</h4>
		        </div>
		        <div class="modal-body">
			        <table class="table table-bordered">
			        	<tbody>
			        		<tr>
			        			<th>Credit Type:</th>
			        			<td>Semester Credit</td>
			        		</tr>
			        		<tr>
			        			<th>Unit Scale:</th>
			        			<td> </td>
			        		</tr>
			        	</tbody>
			        </table>
			        </div>
		      </div> <!-- /.modal-content -->
		    </div> <!-- /.modal-dialog -->
		</div> <!-- /.modal -->
	<!-- /Credit Type Preview Modal --> 
		
</@layout.body>