<div class="modal fade" id="gradeModal" tabindex="-1" role="dialog" aria-labelledby="gradeLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="gradeLabel">Grade Definition Details</h4>
      </div>
      <div class="modal-body">
        <div class="row">
       		<div class="form-group col-md-4">
		    	<label for="modal_ltype">Type</label>
		    	<select id="modal_ltype" name="ltype" class="ltype form-control input-sm">
					<option value="G">Grade</option>
					<option value="C">Condition</option>
					<option value="F">Flag</option>
					<option value="A">Average</option>
					<option value="S">SPEEDE</option>
				</select>
		  	</div>
		  	<div class="form-group col-md-4">
		    	<label for="modal_grade">Grade</label>
		    	<input class="form-control input-sm" type="text" value="" id="modal_grade" name="grade" maxlength="4">
		  	</div>
       		<div class="form-group col-md-4">
       			<label for="modal_effdte">Effective Year/Term Range</label>
       			<div class="row form-inline" style="padding-left:15px;">
		    		<input class="form-control input-sm" type="text" value="" id="modal_effdte" name="effdte" maxlength="6" style="width:40%;">&nbsp;-&nbsp;<input class="form-control input-sm" type="text" value="" id="modal_effdte2" name="effdte2" maxlength="6" style="width:40%;">
		    	</div>
		  	</div>
        </div>
        <div class="row">
        	<div class="form-group col-md-4">
			        <label for="modal_i2uflg">Institution to Universal</label>
			        <br>
			        <input  id="modal_i2uflg" type="checkbox" style="margin-left: 0px;margin-top:0px;float: none;">
		       
        	</div>
		  	<div class="form-group col-md-4">
		    	<label for="modal_ugrade">Universal Grade</label>
		    	<input class="form-control input-sm" type="text" value="" id="modal_ugrade" name="ugrade" maxlength="4">
		  	</div>
        	<div class="form-group col-md-4">
			        <label for="modal_u2iflg">Universal to Institution </label>
		        	<br>
			        	<#if homeIref>
			          		<input  id="modal_u2iflg" type="checkbox" style="margin-left: 0px;margin-top:0px;float: none;">
		          		<#else>
			          		<input  id="modal_u2iflg" type="checkbox" disabled style="margin-left: 0px;margin-top:0px;float: none;">
		          		</#if>
			        
        	</div>
      </div>
      <div class="row">
      	  <div class="form-group col-md-2">
      	  		<label for="ac"><br> Accept Code (AC)</label>
          		<input class="form-control input-sm" type="text" value="" id="modal_ac" name="ac" maxlength="1">
          </div>
          <div class="form-group col-md-2">
      	  		<label for="modal_rc"><br> Reject Code (RC)</label>
          		<input class="form-control input-sm" type="text" value="" id="modal_rc" name="rc" maxlength="1">
          </div>
          <div class="form-group col-md-2">
      	  		<label for="modal_acu">Universal <br> Accept Code (ACU)</label>
          		<input class="form-control input-sm" type="text" value="" id="modal_acu" name="acu" maxlength="1">
          </div>
          <div class="form-group col-md-2">
      	  		<label for="modal_rcu">Universal <br> Reject Code (RCU)</label>
          		<input class="form-control input-sm" type="text" value="" id="modal_rcu" name="rcu" maxlength="1">
          </div>
      	<div class="form-group col-md-2">
      	  		<label for="modal_gpapt"><br> GPA Points</label>
          		<input class="form-control input-sm" type="text" value="" id="modal_gpapt" name="gpapt" maxlength="11">
          </div>
      	<div class="form-group col-md-2">
   	  		<label for="modal_gpacal"><br> GPA Calculation</label><br>
       		<select class="form-control input-sm" id="modal_gpacal" name="gpacal">
				<option value="N">N &nbsp &nbsp No</option>
				<option value="Y">Y &nbsp &nbsp Yes</option>
				<option value="V">V &nbsp &nbsp >=</option>
				<option value=" " selected="selected">No Change </option>
			</select>
		</div>
      </div>
      <div class="row">
      	<div class="form-group col-md-2">
      		<label for="modal_addcr">Add Credit</label><br>
      		<select class="form-control input-sm" id="modal_addcr" name="addcr">
				<option value="N">N &nbsp &nbsp No</option>
				<option value="Y">Y &nbsp &nbsp Yes</option>
				<option value="I">I &nbsp &nbsp &nbspDirectly Input</option>
				<option value=" " selected="selected">No Change </option>
			</select>
      	</div>
      	<div class="form-group col-md-2">
      		<label for="modal_addct">Add Count</label><br>
      		<select class="form-control input-sm" id="modal_addct" name="addct">
				<option value="1">1 &nbsp Acceptable</option>
				<option value="0">0 &nbsp Not Acceptable</option>
				<option value="X">X &nbsp Tentatively Acceptable</option>
			</select>
      	</div>
  		<div class="form-group col-md-2">
  			<label for="modal_cond1">Cond 1</label>
      		<input class="form-control input-sm" type="text" value="" id="modal_cond1" name="cond1" maxlength="1">      			
  		</div>
  		<div class="form-group col-md-2">
  			<label for="modal_cond2">Cond 2</label>
      		<input class="form-control input-sm" type="text" value="" id="modal_cond2" name="cond2" maxlength="1">      		
  		</div>
  		<div class="form-group col-md-2">
  			<label for="modal_ucond1">Universal Cond 1</label>
      		<input class="form-control input-sm" type="text" value="" id="modal_ucond1" name="ucond1" maxlength="3">      		
  		</div>
  		<div class="form-group col-md-2">
  			<label for="ucond2">Universal Cond 2</label>
      		<input class="form-control input-sm" type="text" value="" id="modal_ucond2" name="ucond2" maxlength="3">      		
  		</div>
      </div>
      <div class="row">
      		<div class="form-group col-md-12">
		    	<label for="modal_grade_memo">Memo</label>
		    	<textarea class="form-control input-sm" id="modal_grade_memo" rows="3" maxlength="255"></textarea>
		  	</div>
      </div>
      <div class="row">
      		<div class="col-md-12">
				  <div class="form-group">
			        <label for="modal_last_mod_date">Last modified:</label>
			    	<span id="modal_last_mod_date" class="last_mod small"></span>  
				  </div>
			  </div>
			  <div class="col-md-6">
				  <div class="form-group">
			        <label for="modal_last_mod_user">By:</label>
					<span id="modal_last_mod_user" class="last_mod small"></span>
			      </div>
			  </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <a href="#" type="button" class="btn btn-primary" onclick="applyGradeModal();return false;">Apply changes</a>
      </div>
    </div>
  </div>
</div>