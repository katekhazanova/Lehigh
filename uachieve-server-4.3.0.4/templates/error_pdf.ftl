<#ftl ns_prefixes={"h":"http://www.w3.org/1999/xhtml"}>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Audit Report</title>
<style type="text/css">

@page {size: 8.5in 11.0in;margin: 0.25in;
@bottom-center { color: gray; content: "Page " counter(page) " of " counter(pages)}
border: thin solid black; padding: 1em;}

hr {clear:both;}


/* ===== HEADER / FOOTER ===== */
#audit{width:714px; font:12pt; font-weight: normal;}
#auditHeader, #auditFooter {width:100%; float:left; clear:both; margin:0px; padding:0px; }
#auditHeader .headerRule, #auditFooter .headerRule {width:100%; margin-top:5px;margin-bottom:5px;border:none; border-top:2px double; font-size:1px; color:black; }
#auditHeader #testMessageHeader {font-weight: bold; text-align:left; margin-top: 0px; margin-bottom: 0px; }
#auditFooter #endText {text-align:center;}
        
/* linetype: 01 */  #audit          .horizontalSeparator    { /* 2 column audit only */ }
/* linetype: 02 */  #auditHeader    .columnHeader           { /* 2 column audit only */ }
/* linetype: 03 */  #includeTopText                         {text-align:left; margin: 0em; font-weight: normal; float:left; clear:both; white-space:pre; width:100%; font-family:monospace; letter-spacing: 0.2em;}
/* linetype: 04 */  #includeBottomText                      {text-align:left; margin: 0em; font-weight: normal; float:left; clear:both; white-space:pre; width:100%; font-family:monospace; letter-spacing: 0.2em;}

/* linetype: 06 */  #auditHeader    .completionText         { color: black; }
/* linetype: 08 */  #auditHeader    .errorText              { color: #c27079; }
/* linetype: 09 */  #audit          .blankLine              { }

/* Reference articulation header*/ #auditHeader #refArtHeaderText { font-style: italic;}
/* cmess header */ .cmessHeader { font-weight: bold; align:left; float:left; clear:both;}

/* ===== COMPLETION TEXT =====*/
#auditHeader .completionTextNO  { text-align:center; color: red;}
#auditHeader .completionTextYES { text-align:center; color: green;}
#auditHeader #leftHeader {width:50%; float:left; text-align:left;}
#auditHeader #rightHeader {width:50%; float:right; text-align:right;}
#auditHeader #rightHeader #degreeDateReplace {padding-left:2.0em;float:left; text-align:left; }
#auditHeader #rightHeader #catalogYearReplace {padding-left:1.6em;float:left; text-align:left; }
#auditHeader #headerTitle{ clear:both;}
#auditHeader #headerTitle #demo { float:left; text-align:left; }
#auditHeader #headerTitle #demoAppend {padding-left:7.5em;float:left;}
#auditHeader #dpTitle {width:100%; float:left; text-align:center; clear:both}
#auditHeader #refArtHeaderText { float:left; text-align:center; clear:both}

/* ===== REQUIREMENT ===== */
#auditRequirements { }
#auditRequirements .reqBotRule { width:100%; float:left; clear:both; border:0px; height:1px; color:gray; background-color:gray; margin-top:5px;margin-bottom:5px;}
#auditRequirements .requirement { clear: both; margin-top: 6px; }

/* ===== REQUIREMENTS LISTALL HEADER ===== */
#auditRequirements .listAll {float:left; clear:both; margin-left: 5em; float:left: clear:right; }
#auditRequirements .listAll .catlyt {float:left; width:9em; text-align:left; }
#auditRequirements .listAll .reqName {float:left; width:13em; text-align:left; }
#auditRequirements .listAll .pseudoName {float:left; width:13em; text-align:left; }
#auditRequirements .listAll .yearTermRange {float:left; width:16em; text-align:left; }
#auditRequirements .listAll .instCode {float:left; width:9em; text-align:left; }

/* ===== REQUIREMENTS ===== */
#auditRequirements {width:100%; }
#auditRequirements .reqText {float:left; clear:both; width:100%; }
#auditRequirements .reqText .statusOK { height: 18px; width: 1.8em; float:left; color: green; }
#auditRequirements .reqText .statusNO { height: 18px; width: 1.38em; float:left; color: red; }
#auditRequirements .reqText .statusPL { height: 18px; width: 1.38em; float:left; color: #FF8C00; }
#auditRequirements .reqText .statusIP { height: 18px; width: 1.38em; float:left; color: blue; }
#auditRequirements .reqText .statusNONE { height: 18px; width: 1.38em; float:left; color: black; }
#auditRequirements .reqText .reqNumber { height: 18px; float:left; text-align:right; width:2.2em; }
#auditRequirements .reqText .reqGroups { height: 18px; float:left; text-align:center; width:1.8em; }
#auditRequirements .reqText .reqTitle { float:left; text-align:left; }

#auditRequirements .requirement .reqBody {width:100%; border-top: 1px solid lightgray;}
#auditRequirements .requirement .reqBody .exceptionText {width:100%; float:left; clear:both; text-align:center; }   
#auditRequirements .requirement .reqBody .requirementTotals {float:left; clear:both; margin-left: 0.0em;}
#auditRequirements .requirement .reqBody .requirementTotals .warnInd {width:1.4em; font-weight:bold;}
#auditRequirements .requirement .reqBody .requirementTotals .rowlabel {width:7.6em; text-align:left;font-weight:bold;}
#auditRequirements .requirement .reqBody .requirementTotals .hourslabel {width:4.6em; text-align:left; font-style: italic;}
#auditRequirements .requirement .reqBody .requirementTotals .courseslabel {width:6.4em; text-align:left; font-style: italic;}
#auditRequirements .requirement .reqBody .requirementTotals .subreqslabel {width:7.6em; text-align:left; font-style: italic;}
#auditRequirements .requirement .reqBody .requirementTotals .gpalabel {width:3.0em; text-align:left; font-style: italic;}
#auditRequirements .requirement .reqBody .requirementTotals .rightalign {width:3.8em; text-align:right; font-style:italic;}
#auditRequirements .requirement .reqBody .requirementTotals .count {width:1.2em; text-align:right; font-style:italic;}
#auditRequirements .requirement .reqBody .requirementTotals .gpa {width:3.0em; text-align:right; font-style:italic;}

#auditRequirements .requirement .reqBody .detailGpaLine {float:left; clear:both; margin-left: 0.0em;}
#auditRequirements .requirement .reqBody .detailGpaLine .warnInd {width:9em;}
#auditRequirements .requirement .reqBody .detailGpaLine .gpaHoursLabel {width:10em; text-align:left; font-style: italic;}
#auditRequirements .requirement .reqBody .detailGpaLine .gpaPointsLabel {width:7.6em; text-align:left; font-style: italic;}
#auditRequirements .requirement .reqBody .detailGpaLine .gpaLabel {width:3.0em; text-align:left; font-style: italic;}
#auditRequirements .requirement .reqBody .detailGpaLine .rightalign {width:3.8em; text-align:right; font-style:italic;}
#auditRequirements .requirement .reqBody .detailGpaLine .gpa {width:3.0em; text-align:right; font-style:italic;}

/* ===== SUBREQUIREMENTS ===== */
#auditRequirements .auditSubrequirements { padding-top:1px; }
#auditRequirements .auditSubrequirements .subrequirement { margin-top:6px;}
                
/* ===== SUBREQUIREMENT ===== */
#auditRequirements .auditSubrequirements {clear:both; position:relative; vertical-align:top; }
#auditRequirements .auditSubrequirements .subrequirement {page-break-inside:avoid; margin-bottom:6px;}    
#auditRequirements .auditSubrequirements .subrequirement .status { margin-left: 50px; margin-top: 1px; background-position: left center;  }
#auditRequirements .auditSubrequirements .subrequirement .subreqSeqErr {text-align:center; width:22px; padding:0em;}
#auditRequirements .auditSubrequirements .subrequirement .subreqSeqErrBorder {border-width:1px; border-style:solid;}
#auditRequirements .auditSubrequirements .subrequirement .subreqStatus {text-align:center; width:9px;}
#auditRequirements .auditSubrequirements .subrequirement .subreqRequired {text-align:center; vertical-align:center; width:12px; padding:1px; font-size:90%;}
#auditRequirements .auditSubrequirements .subrequirement .subreqRequiredBorder {border-width:1px; border-style:solid;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNumber {text-align:right; width:33px;}
#auditRequirements .auditSubrequirements .subrequirement .subreqTitle {float:left; clear:both; width:100%; }
#auditRequirements .auditSubrequirements .subrequirement .substatusOK {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .substatusNO {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .substatusPL {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .substatusIP {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .exceptionText {float:left; clear:both; text-align:center; width:100%}
#auditRequirements .auditSubrequirements .subrequirement .subreqDetail {clear:both}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals {float:left; clear:both; page-break-inside: avoid;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .rightalign {width:4.4em; text-align:right;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .rowlabel {width:6.0em; text-align:left;font-weight:bold;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .hourslabel {width:8.4em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .iphourslabel {width:4.8em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .courseslabel {width:9.8em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .gpalabel {width:5.8em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .count {width:1.8em; text-align:right;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .takenlabel { width:10em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .gpa {width:3.2em; text-align:right;}

#auditRequirements .auditSubrequirements .subrequirement .gpaDetailLine {float:left; clear:both; page-break-inside: avoid;}
#auditRequirements .auditSubrequirements .subrequirement .gpaDetailLine .hourslabel {width:10em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .gpaDetailLine .pointslabel {width:5.4em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .gpaDetailLine .gpalabel {width:5.8em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .gpaDetailLine .rightalign {width:4.4em; text-align:right;}
#auditRequirements .auditSubrequirements .subrequirement .gpaDetailLine .count {width:1.8em; text-align:right;}
#auditRequirements .auditSubrequirements .subrequirement .gpaDetailLine .gpa {width:3.4em; text-align:right;}

#auditRequirements .auditSubrequirements .subrequirement .subrequirementTotals .subreqBody .subreqCline {padding-left:25px; float: none; margin-left: 50px; }
#auditRequirements .auditSubrequirements .subrequirement .pretext {width: 5em; float:left; }

#auditRequirements .auditSubrequirements .subrequirement .completedCourses {border:0px; width:100%; clear:both; float:left; font-family:monospace; white-space:pre; padding-right:5px; font:9pt;}
#auditRequirements .auditSubrequirements .subrequirement .completedCourses th {padding: 2px 4px 2px 4px; font-size:90%; background:#eee; text-align:left; color:gray;}

#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses {float:left;}
#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses .term {width:3.2em; text-align:left; vertical-align:top; }
#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses .course {width:10.2em; text-align:left; vertical-align:top; }
#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses .credit {width:3.2em; text-align:right; vertical-align:top; }
#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses .grade  {width:2.1em; text-align:left; vertical-align:top; padding-left:6px}
#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses .ccode {width:1.6em; text-align:left; vertical-align:top; }
#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses .descLines {width:18.2em;padding: 0px; postion:relative; border-collapse:collapse; white-space:pre; border:0em; }
#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses #descText {text-align:left; vertical-align:top; }

#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds {float:left;clear:both; }
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .needslabel {width:5.6em; text-align:left;font-weight:bold;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .hourslabel {width:5.6em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .courseslabel {width:6.8em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .gpalabel {width:2.4em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .rightalign {width:3em; text-align:right; font-style: italic;}
	
#auditRequirements .auditSubrequirements .subrequirement .fromCourses {float:left; clear:both; margin-left:92px;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .selectRow {text-align:left;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .selectText {text-align:left; vertical-align:top; width:139px; font-weight:bold;padding-right:5px;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .selectCourses {white-space:pre; font-family:monospace; font-size: 9pt;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .noRefFoundMsg{font-style:italic; }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .refCourses { font-style:italic; }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses a { color: black; text-decoration: underline; }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses a:hover { color: #6f3d05; }                    
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .course a { color: #0067D3; text-decoration: underline; }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses a:visited { color: #6F3D05; }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses { padding-right:2px;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .department { }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .course .number { }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .transferCourse { color: #1b7403; }
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .description { margin-left: 44px; padding: 4px 10px; border: 1px solid #efefef; }
</style>
</head>
<#-- </#noparse> -->
<body>
<div id="audit">
<div id="auditHeader"> 
	<div id="leftHeader">
		<span id="reportDate">
			<em>${preparedDateText?xml}</em>&nbsp;${preparedDate?xml}<br />
		</span>
		<span id="studentName">
			<em>${studentNameText?xml}</em>${studentName?xml}<br />
		</span>
		<span id="degreeProgram">
			<em>${degreeProgramCodeText?xml}</em>&nbsp;${degreeProgramCode?xml}
		</span>
	</div> <!-- leftHeader -->

<#if replaceFullDemo>	
	<div id="rightHeader">	
		<span id="studentNumber">
			<em>${studentNumberText?xml}</em>&nbsp;${studentNumber?xml}<br />
		</span>
		<span id="degreeDateReplace">
			${gradDateReplace?xml}<br />
		</span>
		<span id="catalogYearReplace">
			${catalogYearReplace?xml}
		</span>
	</div><!-- rightHeader -->
<#else>
    <div id="rightHeader">  
        <span id="studentNumber">
            <em>${studentNumberText?xml}</em>&nbsp;${studentNumber?xml}<br />
        </span>
        <span id="degreeDate">
            <em>${degreeDateText?xml}</em>&nbsp;${degreeDate?xml}<br />
        </span>
        <span id="catalogYear">
            <em>${catalogYearTermText?xml}</em>&nbsp;${catalogYearTerm?xml}
        </span>
    </div><!-- rightHeader -->
</#if>	
	<div id="headerTitle">
	    <div>
		<span id="demo">
		<#if demoNotBlank>
			${demo?xml}<br />
		</#if>
		</span>
		<span id="demoAppend">
        <#if demoAppendNotBlank>
            ${demoAppend?xml}<br />
        </#if>
        </span>
		</div>
		<div id="dpTitle">
            <#if showDpTitle1>${dpTitle1?xml}<br /></#if>
            <#if showDpTitle2>${dpTitle2?xml}<br /></#if>
		</div>
		
		<#if showTestMessage>
			<div id="testMessageHeader">
				<hr class="headerRule"/>
				${testMessage?xml}
			</div>
		</#if>
          <#if showIncludeTopText>      
			<hr class="headerRule" />
			<#list includeTopText as topTextLine>
			     <div id="includeTopText">${topTextLine}<#if topTextLine_has_next><br /></#if></div>     			
            </#list>
		</#if>	
		<#if showRefArtHeader>
			<div id="refArtHeaderText">
				<hr class="headerRule"/>
				${refArtHeaderTextLine1?xml}<br />
				${refArtHeaderTextLine2?xml}<br />
			</div>
		</#if>
		
		<div id="completionText">
			<hr class="headerRule"/>			
			<#if auditStatus = 0>
				<div class="completionTextYES">${auditStatusMessage?xml}</div>
            <#else>
				<div class="completionTextNO">${auditStatusMessage?xml}</div>
			</#if>
		</div><!-- completionText end -->
	</div> <!-- headerTitle -->
	<hr class="headerRule"/>
	<#if showError>
	 	<div class="error">
	 		<br />
	 		${umess?xml} <br />
	 		${errorMessage?xml}
	 	</div>
	 </#if>
</div> <!-- auditHeader -->
	 	
 </div> <!-- audit -->
 

</body></html>