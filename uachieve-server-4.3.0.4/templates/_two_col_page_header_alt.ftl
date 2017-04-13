<#import "_text_macros.ftl" as text>
<#import "_two_column_macros.ftl" as twocol>
<#assign institution = "SAN DIEGO STATE UNIVERSITY                          ENROLLMENT SERVICES       "/>
<#rt>${auditRun.getPreparedDateText()?right_pad(10)}${auditRun.getPreparedDate()?right_pad(16)}${""?right_pad(28)}${institution?right_pad(78)}
<#rt>RAND #:${auditRun.getClients()?left_pad(14)}${""?right_pad(12)}${auditRun.getDpTitle1()?right_pad(71)}DEGREE PROGRAM:  ${auditRun.getDegreeProgramCode()?trim?right_pad(11)}
<#rt>${auditRun.getDegreeDateText()?right_pad(16)}${""?right_pad(1)}${auditRun.getDegreeDate()?right_pad(8)}${""?right_pad(7)}${auditRun.getDpTitle2()?right_pad(71)}G.E.  CATALOG YEAR:  ${auditRun.getAltCatalogYear1()?right_pad(7)}
<#if auditRun.showStudentNumber><#assign stuNum = auditRun.getStudentNumber()?right_pad(13)><#else><#assign stuNum = ""?right_pad(13)/></#if>
<#rt>${stuNum}${auditRun.getStudentName()?right_pad(30)}${""?right_pad(61)}MAJOR CATALOG YEAR:${auditRun.getCatalogYearTerm()?right_pad(8)}
<@text.printBlankString length=132 />


