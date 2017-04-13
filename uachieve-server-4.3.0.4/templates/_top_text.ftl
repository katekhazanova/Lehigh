<#if showIncludeTopText>
<#list includeTopText as topLine>
<#rt>${topLine?right_pad(65)}
</#list>
</#if>