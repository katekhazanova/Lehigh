<#import "_text_macros.ftl" as text>

<#assign two_col_width = 131 />

<#macro printThreeCols col1 col2 col3 >
<#local totalTextLength = col1?length + col2?length + col3?length />
<#local dividerLength = (two_col_width - totalTextLength) / 2 />
<#rt>${col1}<@text.printBlankString length=dividerLength />${col2}<@text.printBlankString length=dividerLength />${col3}
</#macro>
