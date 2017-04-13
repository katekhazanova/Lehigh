<#-- Clines -->
<#if showExcLines && (appliedExceptionText?size > 0) >
    <#if showPretext><#assign pretext = subreqPretext?right_pad(8)><#else><#assign pretext = ""?right_pad(8)/></#if>
    <#list appliedExceptionText as exceptionText>    
        <#if rmodstub>
<#rt>${pretext}${""?right_pad(2)}${exceptionText?right_pad(55)}
        <#else>
<#rt>${pretext}${""?right_pad(8)}${exceptionText?right_pad(49)}
        </#if>
    <#assign pretext = ""?right_pad(8)/>        
    </#list>
</#if>