<#if showWarnInd><#assign reqWarnInd = warnInd?left_pad(2)/><#else><#assign reqWarnInd = ""?left_pad(2)/></#if>
<#-- got summary -->
<#if showGotSummary>
<#if showGotHours><#assign reqGotHours = gotHours?left_pad(6) + ' ' + gotHoursText?right_pad(7) + ' '/><#else><#assign reqGotHours = ""?right_pad(15)/></#if>
<#if showGotCount><#assign reqGotCount = gotCount?left_pad(2) + ' ' + gotCountText?right_pad(7) + ' '/><#else><#assign reqGotCount = ""?right_pad(11)/></#if>
<#if showGotSubreqs><#assign reqGotSubreqs = gotSubreqs?left_pad(2) + ' ' + gotSubreqsText?right_pad(13)/><#else><#assign reqGotSubreqs = ""?right_pad(16)/></#if>
<#if showGotGpa><#assign reqGotGpa = gotGpa?left_pad(6) + ' ' + gotGpaText?right_pad(5)/><#else><#assign reqGotGpa = ""?right_pad(12)/></#if>
<#rt> ${reqWarnInd?right_pad(2)} ${earnedText?left_pad(6)}${reqGotHours}${reqGotCount}${reqGotSubreqs}${reqGotGpa}
</#if>
<#-- detail GPA -->
<#if showDetailGpaLine>
<#if showDetailGpa><#assign reqDetailGotGpa = gotGpa?left_pad(8) + ' ' + gotGpaText?right_pad(5)/><#else><#assign reqDetailGotGpa = ""?right_pad(14)/></#if>
<#if showGotSummary>
<#rt>${""?right_pad(11)}${gotGpaHours?left_pad(6)} ${gotGpaHoursText?right_pad(17)} ${gotGpaPoints?left_pad(7)} ${gotGpaPointsText?right_pad(6)} ${reqDetailGotGpa}
<#else>
<#rt> ${reqWarnInd?right_pad(2)}${""?right_pad(8)}${gotGpaHours?left_pad(6)} ${gotGpaHoursText?right_pad(17)} ${gotGpaPoints?left_pad(7)} ${gotGpaPointsText?right_pad(6)} ${reqDetailGotGpa}
</#if>
</#if>
<#-- in-progress summary -->
<#if showInProgressHours>
<#rt>${ipStub?right_pad(11)}${ipHours?left_pad(6)} ${ipHoursText?right_pad(7)}${""?right_pad(40)}
</#if>
<#if showPlannedHours>
<#rt>${wifStub?right_pad(11)}${wifHours?left_pad(6)} ${wifHoursText?right_pad(7)}${""?right_pad(40)}
</#if>