<#-- Detail GPA -->
<#if showDetailGpaLine>
<#if showDetailGpa><#assign subreqDetailGotGpa = gotGpa?left_pad(6) + ' ' + gotGpaText?right_pad(6)/><#else><#assign subreqDetailGotGpa = ""?right_pad(13)/></#if>
<#rt>${""?right_pad(8)}${gotGpaHours?left_pad(7)} ${gotGpaHoursText?right_pad(7)} ${gotGpaPoints?left_pad(9)} ${gotGpaPointsText?right_pad(6)} ${subreqDetailGotGpa}
</#if>