<#-- Taken courses -->
<#if showTakenCourses >
<#list courseList as course>
    <#if course_index == 0>
      <#if showPretext>
<#rt>${shortSubreqPretext?right_pad(6)}${course?right_pad(59)}
      <#else>
<#rt>${""?right_pad(6)}${course?right_pad(59)}
      </#if>
   <#else>
<#rt>${""?right_pad(6)}${course?right_pad(59)}
   </#if>
</#list>
</#if>