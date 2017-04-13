<#-- status, number, groups, title -->
<#if showStatus><#assign reqStatus = status?right_pad(2)/><#else><#assign reqStatus = ""?right_pad(2)/></#if>
<#if showNumber><#assign reqNumber = number?left_pad(3)/><#else><#assign reqNumber = ""?right_pad(3)/></#if>
<#if showGroups><#assign reqGrps = groups?right_pad(2)/><#else><#assign reqGrps = ""?right_pad(2)/></#if>
<#rt>${reqStatus}${reqNumber}${reqGrps}
<#list titleLines as titleLine>
<#if titleLine_index = 0>
<#rt>${titleLine?right_pad(58)}
<#else>
<#rt>${""?left_pad(7)}${titleLine?right_pad(58)}
</#if>
</#list>