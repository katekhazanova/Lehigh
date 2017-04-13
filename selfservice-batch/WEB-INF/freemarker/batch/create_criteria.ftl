<@layout.head title="Create Criteria" />
<#import "_batch_macros.ftl" as batch>

<@layout.body>
	<input type="hidden" id="pageGroup" value="batch"/>
		<h1><@s.message 'uachieve.selfservice.batch.criteria.edit.header' /></h1>
	<@batch.batchTabs step=2 />
	

	
	<form id="createCriteria" class="focusable" action="<@h.url href="/batch/create_criteria.html" />" method="post">		<table class="verticalListing">
	
					<tbody><tr>
						<th>And/Or</th>
						<td class="content">
									<select class="form-control" name="andor" id="andor"  >
											<option value="" <#if editAndOr?? && editAndOr == "">selected</#if>></option>
											<option value="and" <#if editAndOr?? && editAndOr == "and">selected</#if>>and</option>
											<option value="or" <#if editAndOr?? && editAndOr == "or">selected</#if>>or</option>
									</select>
						</td>
						<td>
								&nbsp;
						</td>
						<td>
						</td>
					</tr>
	
					<tr>
						<th>(</th>
						<td class="content">
									<select class="form-control" name="openparen" id="openparen"  >
											<option value="" <#if editOpenParen??  && editOpenParen == "">selected</#if>></option>
											<option value="(" <#if editOpenParen?? && editOpenParen== "(">selected</#if>>(</option>
									</select>
						</td>
						<td>
								&nbsp;
						</td>
						<td>
						</td>
					</tr>
	
					<tr>
						<th>Operand</th>
						<td class="content">
									<select class="form-control" name="operand" id="operand"  >
											<#list operandOps?keys as key>  
  												<option  value="${key}" <#if selectedOp?? && key == selectedOp>selected</#if>>
  													${operandOps[key]}
  												</option>
											</#list>
									</select>
									<span id="operand_spinner">&nbsp;</span>
						</td>
						
						<td>
						
						</td>
						<td>
						</td>
					</tr>
	
					<tr>
						<th>Operator</th>
						<td class="content">
									<select class="form-control" name="operator" id="operator"  >
											<#list operatorOps?keys as key>  
  												<option  value="${key}" <#if editOperator?? && key == editOperator>selected</#if>>
  													${operatorOps[key]}
  												</option>
											</#list>
									</select>
						</td>
						<td>
								&nbsp;
						</td>
						<td>
						</td>
					</tr>
	
					<tr>
						<th>Value</th>
						<td class="content">
									<input type="radio" id="valueRadio" name="valueRadio" value="dropDown" checked/>
									<select class="form-control" name="value" id="value"  >
											<#list valueOps?keys as key>  
  												<option  value="${key}">${valueOps[key]}</option>
											</#list>
									</select>
									<br/>
									<br/>
									<strong>OR</strong>
									<br/>
									<br/>
									<input type="radio" id="valueTextRadio"name="valueRadio" value="text"/>
									<input type="text" class="form-control" name="valueText" id="valueText" <#if editValueText??>value="${editValueText}"</#if>/>
						</td>
						<td>
								&nbsp;
						</td>
						<td>
						</td>
					</tr>
	
					<tr>
						<th>)</th>
						<td class="content">
									<select class="form-control" name="closeparen" id="closeparen"  >
											<option value="" <#if editCloseParen?? && editCloseParen == "">selected</#if>></option>
											<option value=")" <#if editCloseParen?? && editCloseParen == ")">selected</#if>>)</option>
									</select>
						</td>
						<td>
								&nbsp;
						</td>
						<td>
						</td>
					</tr>
			
				<tr>
					<td class="pages-savebar">&nbsp;</td>
					<td colspan="3">
					<input class="btn btn-primary" type="submit" value="Save">
					<a class="btn btn-default" href="<@h.url href='/batch/criteria.html' />" role="button">Cancel</a>
						
					</td>
				</tr>
		</tbody></table>
		
		<input type="hidden" name="pageRefresh" id="pageRefresh" value="false">
</form>

	

<#-- following script refreshes the page when certain dropdowns change -->
<script>

	Event.observe(window, 'load', function() {
		<#-- hide the refresh buttons if the browser supports javascript -->
		var i, refreshers = $$('input.refresher');
		for(i = 0; i < refreshers.length; i++) {
			refreshers[i].hide();
		}

		function refreshOnChange(theId) {
			if($(theId)) {
				Event.observe(theId, 'change', function () {
					
					// signal that this is a page refresh, not an audit request
					$('pageRefresh').value = true;
					// refresh...
					$(theId + '_spinner').innerHTML = '<@h.img src="/images/small_loading.gif" title="Refreshing..." />';
					$('createCriteria').submit();
				});
			}
		}
		
		refreshOnChange('operand');

	});
</script>

</@layout.body>
