<#-- needs summary -->
<#if showNeedsSummary>
<#if showNeedsHours><#assign subreqNeedsHours = needsHours?left_pad(6) + ' ' + needsHoursText?right_pad(7) + ' '/><#else><#assign subreqNeedsHours = ""?right_pad(15)/></#if>
<#if showNeedsCount><#assign subreqNeedsCount = needsCount?left_pad(2) + ' ' + needsCountText?right_pad(9) + ' '/><#else><#assign subreqNeedsCount = ""?right_pad(13)/></#if>
<#if showNeedsGpa><#assign subreqNeedsGpa = needsGpa?left_pad(6) + ' ' + needsGpaText?right_pad(5)/><#else><#assign subreqNeedsGpa = ""?right_pad(12)/></#if>
    <#if showPretext>
<#rt>${subreqPretext?right_pad(9)}${needsText?right_pad(7)}${subreqNeedsHours}${subreqNeedsCount}${subreqNeedsGpa}
    <#else>
<#rt>${""?right_pad(9)}${needsText?right_pad(7)}${subreqNeedsHours}${subreqNeedsCount}${subreqNeedsGpa}
    </#if>
</#if>