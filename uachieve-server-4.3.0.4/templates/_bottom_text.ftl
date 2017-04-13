<#if showIncludeBottomText>
<#list includeBottomText as bottomLine>
<#rt>${bottomLine?right_pad(65)}
</#list>
</#if>