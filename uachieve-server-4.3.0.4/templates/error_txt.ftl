<#import "_text_macros.ftl" as text>
${umess}${lineSeparator}
<#list errorMessage as errorLine>
	${errorLine}${lineSeparator}
</#list>