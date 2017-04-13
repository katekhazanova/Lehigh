<div class="modal fade" id="sourceCourseModal" tabindex="-1" role="dialog" aria-labelledby="sourceCourseModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="sourceCourseModalLabel">Transfer/Source Course Details</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class=" form-group has-feedback col-md-6" title="">
						<label for="modal_source_course">Transfer/Source Course</label>
						<input type="text" id="modal_source_course" name="source_course" class="form-control input-sm monoCourse" maxlength="15">
						<span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;margin-right: 15px;display:none;">
							<i class="fa fa-exclamation-triangle"></i>
						</span>
						<span id="modal_source_crsMsk" class="help-block crsMsk2"></span>
						<span class="sourceCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask. May be intentional - articulation still valid.</span>
					</div>
					<div class=" form-group col-md-6">
						<label for="modal_pflg">Pseudo Flag</label><br>
						<select id="modal_source_pflg" name="pflg" class="form-control input-sm">
							<option value="P">P &nbsp &nbsp Pseudo Course</option>
							<option value="R">R &nbsp &nbsp Required</option>
							<option value=":">: &nbsp &nbsp Course Range</option>
							<#list 1..9 as i>
							<option value="${i}">${i} &nbsp &nbsp ${i} Additional Match<#if i gt 1>es</#if></option>
							</#list>
							<option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspDefault </option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-9">
						<label for="modal_ctitle">Title</label>
						<input type="text" class="form-control input-sm" id="modal_source_ctitle" name="ctitle" maxlength="29" >
					</div>
					<div class="col-md-3">
						<div class="form-group">
								<label for="modal_source_tflg">Title Check </label>
								<br>
								<input type="checkbox" id="modal_source_tflg" style="margin-left: 0px;margin-top:0px;float: none;">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-3">
						<label for="modal_limhrs">Hours</label>
						<input type="text" class="form-control input-sm" id="modal_source_limhrs" maxlength="5" >
					</div>
					<div class="form-group col-md-3">
						<label for="modal_ac">Accept Code</label>
						<input type="text" class="form-control input-sm" id="modal_source_ac" maxlength="1" >
					</div>
					<div class="form-group col-md-3">
						<label for="modal_rc">Reject Code</label>
						<input type="text" class="form-control input-sm" id="modal_source_rc" maxlength="1">
					</div>
				</div>
				<div class="row">
		       		<div class="form-group col-md-6">
		       			<label for="modal_effdte">Effective Year/Term Range</label>
		       			<div class="row form-inline" style="padding-left:15px;">
				    		<input class="form-control input-sm" type="text" id="modal_source_effdte" name="effdte" maxlength="6" style="width:40%;">&nbsp;-&nbsp;<input class="form-control input-sm" type="text" id="modal_source_effdte2" name="effdte2" maxlength="6" style="width:40%;">
				    	</div>
				  	</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<div class="form-group"><br>
							<div>
								<label for="modal_source_last_mod_date">Last modified:</label>
								<span id="modal_source_last_mod_date" class="last_mod small"></span>  
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group"><br>
							<div>
								<label for="modal_source_last_mod_user">By:</label>
								<span id="modal_source_last_mod_user" class="last_mod small"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="source_close" class="btn btn-default" data-dismiss="modal">Close</button>
	        	<button type="button" id="source_save" class="btn btn-primary" onclick="applySourceCourseModal();return false;">Apply changes</button>
			</div>
		</div>
	</div>
</div>