<#-- In progress courses -->
<#if showInProgressHours || showInProgressCount>
<#rt>${ipSrStub?right_pad(9)}${ipHours?left_pad(6)} ${ipHoursText?right_pad(13)} ${ipCount?left_pad(2)} ${ipCountText?right_pad(16)}${""?right_pad(16)}
</#if>