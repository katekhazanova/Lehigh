<#-- Generates the drildown url for the Transcript graph. -->
<#function transcriptResetUrl auditViewRequest >
<#return "/audit/listcourses.html?id=${Compressor.compress(AuditViewRequest.getDrillDownTranscriptRequest(auditViewRequest, 'null'))}" />
</#function>