<#-- needs summary -->
<#if showNeedsSummary>
<#if showNeedsHours><#assign reqNeedsHours = needsHours?left_pad(6) + ' '+ needsHoursText?right_pad(7) + ' '/><#else><#assign reqNeedsHours = ""?right_pad(15)/></#if>
<#if showNeedsCount><#assign reqNeedsCount = needsCount?left_pad(2) + ' ' + needsCountText?right_pad(7) + ' '/><#else><#assign reqNeedsCount = ""?right_pad(11)/></#if>
<#if showNeedsSubreqs><#assign reqNeedsSubreqs = needsSubreqs?left_pad(2) + ' ' + needsSubreqsText?right_pad(13)/><#else><#assign reqNeedsSubreqs = ""?right_pad(16)/></#if>
<#if showNeedsGpa><#assign reqNeedsGpa = needsGpa?left_pad(6) + ' ' + needsGpaText?right_pad(5)/><#else><#assign reqNeedsGpa = ""?right_pad(12)/></#if>
<#rt>${arrowText?right_pad(4)}${needsText?right_pad(7)}${reqNeedsHours}${reqNeedsCount}${reqNeedsSubreqs}${reqNeedsGpa}
</#if>