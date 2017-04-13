<#if showPlannedHours>
<#rt>${wifSrStub?right_pad(9)}${plannedHours?left_pad(6)} ${plannedHoursText?right_pad(13)} ${plannedCount?left_pad(2)} ${plannedCountText?right_pad(16)}${""?right_pad(16)}
</#if>