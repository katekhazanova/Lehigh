<#-- Got summary -->
<#if showGotSummary>
    <#if showGotHours><#assign subreqGotHours = gotHoursOpenDecoration?right_pad(1) + gotHours?left_pad(6) + ' ' + gotHoursText?right_pad(13) + gotHoursCloseDecoration?right_pad(1)/><#else><#assign subreqGotHours = ""?right_pad(22)/></#if>
    <#if showGotCount><#assign subreqGotCount = gotCount?left_pad(2) + ' ' + gotCountText?right_pad(16)/><#else><#assign subreqGotCount = ""?right_pad(19)/></#if>
    <#if showGotGpa><#assign subreqGotGpa = gotGpa?left_pad(6) + ' ' + gotGpaText?right_pad(9)/><#else><#assign subreqGotGpa = ""?right_pad(15)/></#if>
    <#if showPretext>
<#rt>${subreqPretext} ${subreqGotHours}${subreqGotCount}${subreqGotGpa}
    <#else>
<#rt>${""?right_pad(8)}${subreqGotHours}${subreqGotCount}${subreqGotGpa}
    </#if>
</#if>