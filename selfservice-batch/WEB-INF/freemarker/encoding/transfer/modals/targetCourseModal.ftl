<div class="modal fade" id="targetCourseModal" tabindex="-1" role="dialog" aria-labelledby="targetCourseModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="targetCourseModalLabel">Home/Target Course Details</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class=" form-group has-feedback col-md-4" title="">
						<label for="modal_target_course">Home/Target Course</label>
						<input type="text" id="modal_target_course" name="target_course" class="form-control input-sm monoCourse" maxlength="15">
						<span class="form-control-feedback" aria-hidden="true" style="color: red; line-height: 24px!important;margin-right: 15px;display:none;">
							<i class="fa fa-exclamation-triangle"></i>
						</span>
						<span id="modal_target_crsMsk" class="help-block crsMsk2"></span>
						<span class="targetCrsMskStatus crsMskError sr-only" style="display:none;">Course does not match the course mask. May be intentional - articulation still valid.</span>
					</div>
					<div class=" form-group col-md-4">
						<label for="modal_target_pflg">Pseudo Flag</label><br>
						<select id="modal_target_pflg" class="form-control input-sm" name="pflg" >
							<option value="P">P &nbsp &nbsp Pseudo Course</option>
							<option value="D">D &nbsp &nbspDummy Course</option>
							<option value="X">X &nbsp &nbsp Dummy Pseudo Course</option>
							<option value="Z">Z &nbsp &nbsp Eliminate residual credit/GPA</option>
							<option value=" " selected="selected">&nbsp &nbsp &nbsp &nbspDefault </option>
						</select> 
					</div>
					<div class="form-group col-md-4">
						<label for="modal_target_ctitle">Title</label>
						<input type="text" class="form-control input-sm" id="modal_target_ctitle" name="ctitle" maxlength="29">
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-2">
						<label for="modal_target_limhrs">Hours</label>
						<input type="text" class="form-control input-sm" id="modal_target_limhrs" name="limhrs" maxlength="5">
					</div>
					<div class="col-md-2">
						<div class="form-group">
							<label for="modal_target_forcehrs">Force Hours</label>
							<br>
							<input type="checkbox" id="modal_target_forcehrs" name="forcehrs" style="margin-left: 0px;margin-top:0px;float: none;">
						</div>
					</div>
					<div class="col-md-5">
						<div class="form-group">
							<label for="modal_target_tastatus">Hide from Transferology & Reference Audits </label>
							<br>
							<input type="checkbox" id="modal_target_tastatus" onfocus="setVisibility('tastatusHelp','block')"; onBlur="setVisibility('tastatusHelp','none')"; style="margin-left: 0px;margin-top:0px;float: none;">
						</div>
					</div>
					<div class="form-group col-md-3">
						<label for="modal_target_cond">Condition Code</label>
						<input type="text" class="form-control input-sm" id="modal_target_cond" maxlength="1">
					</div>
				</div>
				<div class="row">
					<div class="col-md-5">
						<table class="table table-bordered table-striped" id="altCrs">
							<thead>
								<tr>
									<th class="aligncenter">#</th>
									<th>Alternate Course</th>
									<th class="aligncenter">Pseudo</th>
									<th class="aligncenter">Hide</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="aligncenter">1</td>
									<td><input type="text" class="form-control input-sm" id="modal_target_acourse1" name="acourse1" maxlength="15"></td>
									<td class="aligncenter"><input type="checkbox" value="" id="modal_target_apflg1" name="apflg1" ></td>
									<td class="aligncenter"><input type="checkbox" value="" id="modal_target_hide_acourse1" name="hide_acourse1"></td>
								</tr>
								<tr>
									<td class="aligncenter">2</td>
									<td><input type="text" class="form-control input-sm" id="modal_target_acourse2" name="acourse2" maxlength="15"></td>
									<td class="aligncenter"><input type="checkbox" value="" id="modal_target_apflg2" name="apflg2" ></td>
									<td class="aligncenter"><input type="checkbox" value="" id="modal_target_hide_acourse2" name="hide_acourse2"></td>
								</tr>
								<tr>
									<td class="aligncenter">3</td>
									<td><input type="text" class="form-control input-sm" id="modal_target_acourse3" name="acourse3" maxlength="15"></td>
									<td class="aligncenter"><input type="checkbox" value="" id="modal_target_apflg3" name="apflg3" ></td>
									<td class="aligncenter"><input type="checkbox" value="" id="modal_target_hide_acourse3" name="hide_acourse3"></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td></td>
									<td><span class="crsMsk">${targetMask.crsmask!""}</span></td>
									<td></td>
									<td></td>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="col-md-7">
						<div class="row">
						<div class="form-group col-md-4">
							<label for="modal_target_iflg1">Iflag1</label>
							<input type="text" class="form-control input-sm" id="modal_target_iflg1" maxlength="3">
						</div>
						<div class="form-group col-md-4">
							<label for="modal_target_iflg2">Iflag2</label>
							<input type="text" class="form-control input-sm" id="modal_target_iflg2" maxlength="3">
						</div>
						<div class="form-group col-md-4">
							<label for="modal_target_iflg3">Iflag3</label>
							<input type="text" class="form-control input-sm" id="modal_target_iflg3" maxlength="3">
						</div>
						</div>
						<div class="row">
						<div class="form-group col-md-4">
							<label for="modal_target_iflg4">Iflag4</label>
							<input type="text" class="form-control input-sm" id="modal_target_iflg4" maxlength="3">
						</div>
						<div class="form-group col-md-4">
							<label for="modal_target_iflg5">Iflag5</label>
							<input type="text" class="form-control input-sm" id="modal_target_iflg5" maxlength="3">
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="modal_target_hideIflgs">Hide All Iflags</label>
								<br>
								<input type="checkbox" id="modal_target_hideIflgs" style="margin-left: 0px;margin-top:0px;float: none;">
							</div>
						</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<div class="form-group"><br>
							<div>
								<label for="modal_target_last_mod_date">Last modified:</label>
								<span id="modal_target_last_mod_date" class="last_mod small"><#--11/24/14 10:54:00--></span>  
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group"><br>
							<div>
								<label for="modal_target_last_mod_user">By:</label>
								<span id="modal_target_last_mod_user" class="last_mod small"><#--brooksm--></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="target_close" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" id="target_save" class="btn btn-primary" onclick="applyTargetCourseModal();return false;">Apply changes</button>
			</div>
		</div>
	</div>
</div>