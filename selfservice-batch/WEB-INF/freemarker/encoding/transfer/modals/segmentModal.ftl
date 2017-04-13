<div class="modal fade" id="segmentModal" tabindex="-1" role="dialog" aria-labelledby="segmentModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="segmentModalLabel">Segment Details</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class=" form-group col-md-3">
						<label for="modal_tsegName">Segment Name</label>
						<input type="text" class="form-control input-sm" id="modal_tsegName" maxlength="7" onfocus="setVisibility('ta_tsegHelp','inline')" onBlur="setVisibility('ta_tsegHelp','none')">
					</div>
					<div class=" form-group col-md-9">
						<label for="modal_tsegHint">Segment Hint</label>
						<input type="text" class="form-control input-sm" id="modal_tsegHint" maxlength="25" onfocus="setVisibility('ta_tseghintHelp','inline')" onBlur="setVisibility('ta_tseghintHelp','none')">
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<label for="modal_tsegDesc">Segment Description</label>
						<textarea class="form-control input-sm" id="modal_tsegDesc" rows="5" maxlength="255" onfocus="setVisibility('ta_tsegdescHelp','inline')" onBlur="setVisibility('ta_tsegdescHelp','none')"></textarea>
					</div>
				</div>
				<div class="row" id="last_mod_seg">
					<div class="col-md-6">
						<div class="form-group"><br>
							<div>
								<label for="modal_last_mod_date">Last modified:</label>
								<span id="modal_last_mod_date" class="last_mod small"></span>  
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group"><br>
							<div>
								<label for="modal_last_mod_user">By:</label>
								<span id="modal_last_mod_user" class="last_mod small"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="segment_close" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" id="segment_save" class="btn btn-primary" onclick="applySegmentModal();return false;" disabled="disabled">Apply changes</button>
			</div>
		</div>
	</div>
</div>