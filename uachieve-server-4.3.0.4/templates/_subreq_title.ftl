<#-- Title - for the purposes of reporting in conjunction with the NOLIST setting includes got summary, detail GPA, and in-progress courses -->
<#if showTitle>
<#if titleLines?size !=0>
	<#list titleLines as line>
		<#if line_index == 0>
<#rt>${subreqPretext} ${line?right_pad(57)}
		<#else>
<#rt>${""?right_pad(8)}${line?right_pad(57)}
		</#if>
	</#list>
</#if>
</#if>