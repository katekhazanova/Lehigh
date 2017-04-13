<div class="row" style="overflow: scroll; height: 75vh;">
     	<div class="col-md-12">
     		<table class="table table-bordered table-striped" id="ta-rules">
		     	<thead>
		        <tr>
		        	<th class="aligncenter vAlignMid"><i class="fa fa-bars"></i></th>
		        	<th class="">
		        		Rule for ${selectedRule.tseg}    		
					</th>
		        </tr>
		        </thead>
		        <tbody id="sortableRules">
		        <#assign selectedRuleAdded = false/>
		        
		        <#list tcaRules as tcaRule>
				<#if tcaRule.tseg == selectedRule.tseg>
						
					<#if tcaRule.intSeqNo != selectedRule.intSeqNo && addRuleNum?? && tcaRule.userSeqNo == addRuleNum>
						<@displayRule selectedRule selectedRule/> 
						<#assign selectedRuleAdded = true/>
					<#elseif tcaRule.intSeqNo == selectedRule.intSeqNo>
						<#assign selectedRuleAdded = true/>
					</#if>

					<@displayRule tcaRule selectedRule/>

				</#if>
				</#list>

				<#if !selectedRuleAdded>
					<@displayRule selectedRule selectedRule/> 
				</#if>
		        </tbody>
	        </table>
	    </div>
	</div>

<#macro displayRule tcaRule selectedRule>

	<#if tcaRule.intSeqNo != selectedRule.intSeqNo && addRuleNum?? && tcaRule.userSeqNo gte addRuleNum>
		<#assign userSeqNo = tcaRule.userSeqNo + 1/>
	<#else>
		<#assign userSeqNo = tcaRule.userSeqNo/>
	</#if>

	<tr id="ruleRow-${userSeqNo?c}" class="ui-state-default ">
  		<td class="move aligncenter vAlignMid <#if tcaRule.intSeqNo == selectedRule.intSeqNo>selectedRule</#if>"><i class="fa fa-bars"><span class="sr-only">Hit spacebar and then use the up and down arrow keys to reorder this row. When done, hit spacebar again to drop the row.</span></i>
  		</td>
		<td class="vAlignMid <#if tcaRule.intSeqNo == selectedRule.intSeqNo>selectedRule</#if>">
			<div class="ruleLabel">
				<span class="pull-left" >
        			Rule <span class="userSeqNo">${userSeqNo?c}</span>
    			</span>
    			<#if tcaRule.intSeqNo != selectedRule.intSeqNo>
    			<span class="pull-right" style=" font-size: 15px;">
    				<a href="#" onclick="editRule('${tcaRule.intSeqNo?c}');return false;" style="color: #398E6B;"> 
						<i class="fa fa-edit"></i>
					</a>
					<@redauth.authorize ifAllGranted="SS_ENCODING_TA_RULE=u">
					<a href="#" onclick="delTaRow(event,'#sortableRules','#insertRule','ruleRow-');return false;" style="color: #ac2222;"> 
						<i class="fa fa-trash"></i>
					</a>
					</@redauth.authorize>
				</span>
				</#if>
			</div>
			<div class="ruleCourses">
			<#list tcaRule.tcaSources as tcaSource>
    			<span class="fa-stack smallStack sourceCourse" title="Transfer/Source Course">
					<i class="fa fa-long-arrow-right fa-stack-1x fa-rotate-45" style="margin-top: 3px; margin-left: 2px;">
						<span class="sr-only">Transfer/Source Course</span>
					</i>
					<i class="fa fa-angle-double-right fa-stack-1x fa-rotate-45" aria-hidden="true"></i>
				</span>
    			${tcaSource.course}<br>
			</#list>
			
			<#list tcaRule.tcaTargets as tcaTarget>
		 		<i class="fa fa-bullseye targetCourse" title="Home/Target Course"><span class="sr-only">Home/Target Course</span></i>
				${tcaTarget.course}<br>
			</#list>
			</div>
			<input type="hidden" class="intSeqNo" value="${tcaRule.intSeqNo?c}"/>
			
			<#if tcaRule.intSeqNo == selectedRule.intSeqNo><div class="selectedRuleText">*Selected Rule</div></#if>
		</td>
	</tr>
</#macro>
