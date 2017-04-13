<#import "_text_macros.ftl" as text>
<#rt><#if showOneColHeaderLine1>${oneColHeaderLine1}</#if>
<#rt><#if showOneColHeaderLine2>${oneColHeaderLine2}</#if>
<#rt><#if showOneColHeaderLine3>${oneColHeaderLine3}</#if>
<#rt><#if demoNotBlank>${oneColHeaderLine4}</#if>
<#if showError>
<#rt>${hsep?right_pad(65,hsep)}
<#rt>${errorType?right_pad(65,"?")}
<#rt>-->ERROR: ${errorMessage?right_pad(55)}
</#if>
<#rt><#if showDpTitle1>${dpTitle1}</#if>
<#rt><#if showDpTitle2>${dpTitle2}</#if>