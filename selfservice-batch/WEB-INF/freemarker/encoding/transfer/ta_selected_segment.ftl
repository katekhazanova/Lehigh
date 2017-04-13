<div class="row" style="padding-top: 10px;border-bottom: 1px solid #55ccdd;margin-left: 1px;margin-right: 1px;">
	<div class="col-md-2" style="align: middle;">
		<h4>Selected Segment:</h4>
	</div>
	<div class="col-md-4">
		<select class="form-control input-sm" id="segmentList">
			<#list segList as segment>
			<option value="${segment.tseg}">${segment.tseg} - ${segment.hint}</option>
			</#list>	
		</select>
	</div>
	<div class="col-md-6">
		<span class="pull-right">
			Add new rule to this segment at line <input type="text" class="" id="insertRule" value="4" style="width: 30px;">
			<a href="#" class="btn btn-success btn-xs"><i class="fa fa-plus"></i> Add</a>
		</span>
	</div> 
</div>