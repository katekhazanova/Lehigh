<#-- list all header -->
<#if showListAllHeader>
<#rt>${""?right_pad(5)}${catlyt?right_pad(16)} ${reqName?right_pad(19)}${pseudoName?right_pad(24)}
<#rt>${""?right_pad(22)}${yearTermRange?right_pad(29)}${instCode?right_pad(14)}
</#if>
<#-- header lines -->
<#list headerLines as headerLine>
<#rt>${headerLine?right_pad(65)}
</#list>