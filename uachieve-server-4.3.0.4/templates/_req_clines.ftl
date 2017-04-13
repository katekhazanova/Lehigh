<#-- Clines -->
<#if showExcLines>
    <#list appliedExceptionText as exceptionText>    
        <#if rmodstub>
<#rt>${""?right_pad(10)}${exceptionText?right_pad(55)}
        <#else>
<#rt>${""?right_pad(16)}${exceptionText?right_pad(49)}
        </#if>
    </#list>
</#if>