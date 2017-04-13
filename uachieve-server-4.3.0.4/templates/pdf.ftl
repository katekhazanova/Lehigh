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
pre {display:inline; front-family:inherit;}

/* ===== HEADER / FOOTER ===== */
#audit{width:714px; font:12pt; font-weight: normal;}
#auditHeader, #auditFooter {width:100%; float:left; clear:both; margin:0px; padding:0px; }
#auditHeader .headerRule, #auditFooter .headerRule {width:100%; margin-top:5px; margin-bottom:5px; border:none; border-top:2px double; font-size:1px; color:black; }
#auditHeader #testMessageHeader {font-weight:bold; text-align:left; margin-top: 0px; margin-bottom: 0px; }
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
#auditRequirements .listAll .gpaName {float:left; width:13em; text-align:left; }
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
#auditRequirements .requirement .reqBody .exceptionText {width:100%; float:left; clear:both; margin-left:117px; text-align:left; }   
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
#auditRequirements .auditSubrequirements .subrequirement .break {float:left; clear:both;} 
#auditRequirements .auditSubrequirements .subrequirement .status { margin-left: 50px; margin-top: 1px; background-position: left center;  }
#auditRequirements .auditSubrequirements .subrequirement .subreqSeqErr {text-align:center; width:22px; padding:0em; font:12pt; vertical-align:top;}
#auditRequirements .auditSubrequirements .subrequirement .subreqSeqErrBorder {border-width:1px; border-style:solid;}
#auditRequirements .auditSubrequirements .subrequirement .subreqStatus {text-align:center; width:9px; font:12pt; vertical-align:top;}
#auditRequirements .auditSubrequirements .subrequirement .subreqRequired {text-align:center; width:12px; padding:1px; padding-top:4px; font-size:90%; vertical-align:top;}
#auditRequirements .auditSubrequirements .subrequirement .subreqRequiredBorder {border-width:1px; border-style:solid;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNumber {text-align:right; width:33px; font:12pt; vertical-align:top;}
#auditRequirements .auditSubrequirements .subrequirement .subreqTitle {float:left; clear:both; width:100%; }
#auditRequirements .auditSubrequirements .subrequirement .substatusOK {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .substatusNO {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .substatusPL {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .substatusIP {height: 18px; color:black; padding-top:0px;padding-bottom:0px;}
#auditRequirements .auditSubrequirements .subrequirement .exceptionText {float:left; clear:both; text-align:left; width:100%;}
#auditRequirements .auditSubrequirements .subrequirement .exceptionText .reqCline {width: 475px; padding-left:75px;}
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

div.completedCourses {width:100%; clear:both; float:left; font-family:monospace; padding-right:5px; font:9pt;}

table, tr, td, th { font-weight:none;}
table.courses {clear:both; border:0px; padding-right:5px; font:9pt; font-size:90%;}
tr.courses {padding: 2px 4px 2px 4px; font-size:90%; text-align:left; }
th, td {padding: 0px; border: none;}
th.term {text-align:left; vertical-align:top; background:#eee;}
th.course {text-align:left; vertical-align:top; background:#eee;}
th.credit {text-align:right; vertical-align:top; background:#eee;}
th.grade  {text-align:left; vertical-align:top; padding-left:6px; background:#eee;}
th.ccode {text-align:left; vertical-align:top; background:#eee;}
th.descLines {postion:relative; border-collapse:collapse; white-space:pre; border:0em; background:#eee;}

td.cline {white-space:pre; column-span: all; text-align:left; vertical-align:top; width:38.0em;}
td.term {width:3.2em; max-width:3.2em; text-align:left; vertical-align:top; }
td.course {width:10.2em; text-align:left; vertical-align:top; }
td.credit {width:4.2em; text-align:right; vertical-align:top; }
td.grade  {width:3.1em; text-align:left; vertical-align:top; padding-left:6px; }
td.ccode {width:1.8em; text-align:left; vertical-align:top; }
td.descLines {width:18.2em;padding: 0px; postion:relative; border-collapse:collapse; white-space:pre; border:0em; }

div.needsSummary {clear:both;}

#auditRequirements .auditSubrequirements .subrequirement .completedCourses .courses #descText {text-align:left; vertical-align:top; }
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds {float:left;clear:both;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .needslabel {width:5.6em; text-align:left;font-weight:bold;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .hourslabel {width:5.6em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .courseslabel {width:6.8em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .gpalabel {width:2.4em; text-align:left; font-style: italic;}
#auditRequirements .auditSubrequirements .subrequirement .subreqNeeds .rightalign {width:3em; text-align:right; font-style: italic;}
    
#auditRequirements .auditSubrequirements .subrequirement .fromCourses {float:left; clear:both;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .selectRow {text-align:left;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .selectText {text-align:left; vertical-align:top; width:139px; font-weight:bold;padding-right:5px;}
#auditRequirements .auditSubrequirements .subrequirement .fromCourses .selectCourses {white-space:pre; padding-top: 2px; font-family:monospace; font-size: 12pt;}
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
            <#if showOneColHeaderLine1><em>${preparedDateText?xml}</em>&nbsp;${preparedDate?xml}<br /></#if>
        </span>
        <span id="studentName">
            <#if showOneColHeaderLine2><em>${studentNameText?xml}</em>${studentName?xml}<br /></#if>
        </span>
        <span id="degreeProgram">
            <#if showOneColHeaderLine3><#if showProgramCode><em>${degreeProgramCodeText?xml}</em>&nbsp;${degreeProgramCode?xml}</#if></#if>
        </span>
    </div> <!-- leftHeader -->

<#if replaceFullDemo>   
    <div id="rightHeader">  
        <span id="studentNumber">
            <em>${studentNumberText?xml}</em>&nbsp;<#if showStudentNumber>${studentNumber?xml}</#if><br />
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
            <#if showOneColHeaderLine1><em>${studentNumberText?xml}</em>&nbsp;<#if showStudentNumber>${studentNumber?xml}</#if><br /></#if>
        </span>
        <span id="degreeDate">
            <#if showOneColHeaderLine2><em>${degreeDateText?xml}</em>&nbsp;${degreeDate?xml}<br /></#if>
        </span>
        <span id="catalogYear">
            <#if showOneColHeaderLine3><em>${catalogYearTermText?xml}</em>&nbsp;${catalogYearTerm?xml}</#if>
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
        <#if showWifDegreeProgramMessage><div class="wifDpMessage">${wifDegreeProgramMessage?xml}</div></#if>
    </div> <!-- headerTitle -->
    <hr class="headerRule"/>
</div> <!-- auditHeader -->

<#assign statusOk = false>
<#assign showCMess = true>
<#assign showNMess = true>

<div id="auditRequirements">
<#list auditReportReqs as auditReportReq>
    <#assign statusOk = auditReportReq.ok>
    <#assign satisfiedClass = "Status_NONE" />
    <#assign statusClass = "statusNONE" />
    <#if auditReportReq.showStatus >
        <#assign satisfiedClass = auditReportReq.satisfied?xml />
        <#assign statusClass = auditReportReq.reqStatus?xml />
    </#if>
    <#if cncflg>
        <#if showCFirst>        
            <#if showCMess && (! statusOk)>
                <#assign showCMess = false>                        
                <span class="cmessHeader">${cmess?xml}</span>
                <hr class="headerRule"/>
            </#if>
        <#else>
            <#if showNMess && (statusOk)>
                <#assign showNMess = false>                        
                <span class="cmessHeader">${ncmess?xml}</span>
                <hr class="headerRule"/>
            </#if>        
        </#if>

        <#if statusOk>
            <#if showCMess>
                <#assign showCMess = false>                        
                <span class="cmessHeader">${cmess?xml}</span>
                <hr class="headerRule"/>
            </#if>
        <#else>
            <#if showNMess>
                <#assign showNMess = false>                        
                <span class="cmessHeader">${ncmess?xml}</span>
                <hr class="headerRule"/>
            </#if>        
        </#if>                        
   </#if>
    <#if auditReportReq.showListAllHeader>
        <div class="listAll">
            <div><span class="catlyt">${auditReportReq.catlyt?xml}</span><span class="reqName">${auditReportReq.reqName?xml}</span><span class="pseudoName">${auditReportReq.pseudoName?xml}</span></div>
            <div><span class="gpaName"></span>${auditReportReq.gpaName?xml}<span class="yearTermRange">${auditReportReq.yearTermRange?xml}</span><span class="instCode">${auditReportReq.instCode?xml}</span></div>
        </div><!-- listAll -->
    </#if>
    <div class="requirement ${satisfiedClass?xml} ${auditReportReq.category?xml} ${auditReportReq.summaryGroupName?xml} ${auditReportReq.rname?xml} ${auditReportReq.rtabx?xml}">
    <#if auditReportReq.showHeader>
        <div>
            <#list auditReportReq.headerLines as headerLine>${headerLine}<#if headerLine_has_next><br /></#if></#list><#t>
        </div>    
    </#if>
    <div class="reqText">
        <div class="status ${statusClass}"><#if auditReportReq.showStatus>${auditReportReq.status?xml}</#if></div>
        <div class="reqNumber"><#if auditReportReq.showNumber>${auditReportReq.number?xml}</#if></div>
        <div class="reqGroups"><#if auditReportReq.showGroups>${auditReportReq.groups?xml}</#if></div>        
        <#if auditReportReq.showTitle><#t>
            <div class="reqTitle"><#t>
                <#list auditReportReq.titleLines as titleLine>${titleLine}<#if titleLine_has_next><br /></#if></#list><#t>
            </div>
        </#if>
    </div><!-- reaText -->
    <div class="reqBody">
        <table class="requirementTotals">
            <#if auditReportReq.showGotSummary>
                <tr class="reqEarned">
                        <td class="warnInd"><#if auditReportReq.showWarnInd>${auditReportReq.warnInd?xml}</#if></td>
                        <td class="rowlabel">${auditReportReq.earnedText?xml}</td>
                        <td class="rightalign"><#if auditReportReq.showGotHours>${auditReportReq.gotHours?xml}</#if></td>
                        <td class="hourslabel"><#if auditReportReq.showGotHours>${auditReportReq.gotHoursText?xml}</#if></td>
                        <td class="count"><#if auditReportReq.showGotCount>${auditReportReq.gotCount?xml}</#if></td>
                        <td class="courseslabel"><#if auditReportReq.showGotCount>${auditReportReq.gotCountText?xml}</#if></td>
                        <td class="count"><#if auditReportReq.showGotSubreqs>${auditReportReq.gotSubreqs?xml}</#if></td>
                        <td class="subreqslabel"><#if auditReportReq.showGotSubreqs>${auditReportReq.gotSubreqsText?xml}</#if></td>
                        <td class="gpa"><#if auditReportReq.showGotGpa>${auditReportReq.gotGpa?xml}</#if></td>
                        <td class="gpalabel"><#if auditReportReq.showGotGpa>${auditReportReq.gotGpaText?xml}</#if></td>
                    </tr><!-- reqEarned end --> 
            </#if>
        </table>        
        <table class="detailGpaLine">
            <#if auditReportReq.showDetailGpaLine>
                <tr class="reqGotGpaDetail">
                        <td class="warnInd"></td>
                        <td class="rowlabel"></td>
                        <td class="rightalign">${auditReportReq.gotGpaHours?xml}</td>
                        <td class="gpaHoursLabel">${auditReportReq.gotGpaHoursText?xml}</td>
                        <td class="rightalign">${auditReportReq.gotGpaPoints?xml}</td>
                        <td class="gpaPointsLabel">${auditReportReq.gotGpaPointsText?xml}</td>
                        <td class="gpa"><#if auditReportReq.showDetailGpa>${auditReportReq.gotGpa?xml}</#if></td>
                        <td class="gpaLabel"><#if auditReportReq.showDetailGpa>${auditReportReq.gotGpaText?xml}</#if></td>
                    </tr><!-- reqGotGpaDetail end -->
            </#if>
        </table>
        <table class="requirementTotals">
            <#if auditReportReq.showInProgressHours>
                <tr class="reqIpDetail">
                        <td class="warnInd"></td>
                        <td class="rowlabel">${auditReportReq.ipStub?xml}</td>
                        <td class="rightalign">${auditReportReq.ipHours?xml}</td>
                        <td class="hourslabel">${auditReportReq.ipHoursText?xml}</td>
                </tr>
            </#if>
            <#if auditReportReq.showPlannedHours>
                <tr class="reqWhatIfDetail">
                        <td class="warnInd"></td>
                        <td class="rowlabel">${auditReportReq.wifStub?xml}</td>
                        <td class="rightalign">${auditReportReq.wifHours?xml}</td>
                        <td class="hourslabel">${auditReportReq.wifHoursText?xml}</td>
                    </tr><!-- reqWhatIfDetail end -->
            </#if>
            <#if auditReportReq.showNeedsSummary>
                <tr class="reqNeeds">
                        <td class="warnInd"></td>
                        <td class="rowlabel">${auditReportReq.needsText?xml}</td>
                        <td class="rightalign"><#if auditReportReq.showNeedsHours>${auditReportReq.needsHours?xml}</#if></td>
                        <td class="hourslabel"><#if auditReportReq.showNeedsHours>${auditReportReq.needsHoursText?xml}</#if></td>
                        <td class="count"><#if auditReportReq.showNeedsCount>${auditReportReq.needsCount?xml}</#if></td>
                        <td class="courseslabel"><#if auditReportReq.showNeedsCount>${auditReportReq.needsCountText?xml}</#if></td>
                        <td class="count"><#if auditReportReq.showNeedsSubreqs>${auditReportReq.needsSubreqs?xml}</#if></td>
                        <td class="subreqslabel"><#if auditReportReq.showNeedsSubreqs>${auditReportReq.needsSubreqsText?xml}</#if></td>
                        <td class="gpa"><#if auditReportReq.showNeedsGpa>${auditReportReq.needsGpa?xml}</#if></td>
                        <td class="gpalabel"><#if auditReportReq.showNeedsGpa>${auditReportReq.needsGpaText?xml}</#if></td>
                    </tr><!-- reqNeeds end -->
            </#if>
        </table><!-- requirementTotals end -->
        <#if auditReportReq.showExcLines>
            <div class="exceptionText">
                <#list auditReportReq.appliedExceptionText as ex>
                    <span class="reqCline">${ex?xml}<br /></span>
                </#list>
            </div>  
        </#if><!-- exceptionText -->
    </div>
    <div class="auditSubrequirements">
    <#assign newHeader = true>
    <#list auditReportReq.auditReportSubreqs as auditReportSubreq>    
        <#if auditReportSubreq.showListAllLHeader>
        <div class="listAll"> <span class="gpaName">${auditReportSubreq.gpaName?xml}</span><span class="webTitle">${auditReportSubreq.webTitle?xml}</span></div><!-- listAll -->
        </#if>  
        <div class="subrequirement">
        <!-- THIS IS THE PART THAT INSERTS BLANK LINES BEFORE THE SUBREQUIREMENTS -->
        <#if auditReportSubreq.skipBct>
            <!-- Be careful here with the language switch, as ftl may count backwards. This list also acts as a "While ... OR EQUAL TO" condition. Hence, we count from zero to the number of desired lines minus one. (If desired lines is 0, boolean should be false and we should never execute this loop.) -->
            <#list 0..auditReportSubreq.skipBlankCount?number - 1 as i>
                <span class="break"><br /></span>
            </#list>
        </#if>
        <#assign showPretext = true>
        <#if auditReportSubreq.showTitle >
            <#assign newHeader = true>
            <table class="subreqTitle">
                <#list auditReportSubreq.titleLines as titleLine>
                <tr>
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
                    <td class="subreqTitleLine ${auditReportSubreq.statusClassSR?xml}">${titleLine}</td>
                </tr>    
                <#assign showPretext = false>             
                </#list>
            </table><!-- subreqTitle -->
        </#if>
        <#if auditReportSubreq.showExcLines>
            <#assign newHeader = true>                              
        <div class="exceptionText">
            <table class="exceptionList">
            <#list auditReportSubreq.appliedExceptionText as ex>
                <tr>
                <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
                <td class="reqCline">${ex?xml}<#if ex_has_next><br /></#if></td>
                </tr>
                <#if showPretext><#assign showPretext = false></#if>             
            </#list>
            </table><!-- exceptionList -->
        </div><!-- exceptionText -->    
        </#if>
         <#if auditReportSubreq.showGotSummary> 
            <#assign newHeader = true>                              
			<table class="subrequirementTotals">
				<tr class="subreqEarned">
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
					<td class="rightalign"><#if auditReportSubreq.showGotHours>${auditReportSubreq.gotHoursOpenDecoration?xml}${auditReportSubreq.gotHours?xml}</#if></td>
					<td class="hourslabel"><#if auditReportSubreq.showGotHours>${auditReportSubreq.gotHoursText?xml}${auditReportSubreq.gotHoursCloseDecoration?xml}</#if></td>
					<td class="count"><#if auditReportSubreq.showGotCount>${auditReportSubreq.gotCount?xml}</#if></td>
					<td class="courseslabel"><#if auditReportSubreq.showGotCount>${auditReportSubreq.gotCountText?xml}</#if></td>
					<td class="gpa"><#if auditReportSubreq.showGotGpa>${auditReportSubreq.gotGpa?xml}</#if></td>
					<td class="gpalabel"><#if auditReportSubreq.showGotGpa>${auditReportSubreq.gotGpaText?xml}</#if></td>
				</tr>				
                <#assign showPretext = false>             
            </table>
        </#if>    
		<#if auditReportSubreq.showDetailGpaLine>
            <#assign newHeader = true>                              
            <table class="gpaDetailLine">
				<tr class="gpaDetail">
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
                    <td class="rightalign">${auditReportSubreq.gotGpaHours?xml}</td>
                    <td class="hourslabel">${auditReportSubreq.gotGpaHoursText?xml}</td>
                    <td class="rightalign">${auditReportSubreq.gotGpaPoints?xml}</td>
                    <td class="pointslabel">${auditReportSubreq.gotGpaPointsText?xml}</td>
                    <td class="gpa"><#if auditReportSubreq.showDetailGpa>${auditReportSubreq.gotGpa?xml}</#if></td>
                    <td class="gpalabel"><#if auditReportSubreq.showDetailGpa>${auditReportSubreq.gotGpaText?xml}</#if></td>
				</tr>
            <#assign showPretext = false>             
            </table>
		</#if>
        <#if auditReportSubreq.showInProgressHours || auditReportSubreq.showInProgressCount || auditReportSubreq.showPlannedHours || auditReportSubreq.showPlannedCount>
            <#assign newHeader = true>                              
            <table class="subrequirementTotals">
			<#if auditReportSubreq.showInProgressHours || auditReportSubreq.showInProgressCount>
				<tr class="subreqIpHours">
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
					<td class="rowlabel"><#if auditReportSubreq.showInProgressHours || auditReportSubreq.showInProgressCount>${auditReportSubreq.ipSrStub?xml}</#if></td>
                    <td class="rightalign"><#if auditReportSubreq.showInProgressHours>${auditReportSubreq.ipHours?xml}</#if></td>
                    <td class="iphourslabel"><#if auditReportSubreq.showInProgressHours>${auditReportSubreq.ipHoursText?xml}</#if></td>
                    <td class="count"><#if auditReportSubreq.showInProgressCount>${auditReportSubreq.ipCount?xml}</#if></td>
                    <td class="takenlabel"><#if auditReportSubreq.showInProgressCount>${auditReportSubreq.ipCountText?xml}</#if></td>
				</tr>
                <#assign showPretext = false>             
			</#if>
			<#if auditReportSubreq.showPlannedHours || auditReportSubreq.showPlannedCount> 
				<tr class="subreqWhatIfDetail">
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
			 	    <td class="rowlabel"><#if  auditReportSubreq.showPlannedHours || auditReportSubreq.showPlannedCount>${auditReportSubreq.wifSrStub?xml}</#if></td>
					<td class="rightalign"><#if  auditReportSubreq.showPlannedHours>${auditReportSubreq.plannedHours?xml}</#if></td>
					<td class="iphourslabel"><#if  auditReportSubreq.showPlannedHours>${auditReportSubreq.plannedHoursText?xml}</#if></td>
					<td class="count"><#if  auditReportSubreq.showPlannedCount>${auditReportSubreq.plannedCount?xml}</#if></td>
					<td class="takenlabel"><#if  auditReportSubreq.showPlannedCount>${auditReportSubreq.plannedCountText?xml}</#if></td>
				</tr>
                <#assign showPretext = false>             
			</#if>
			</table><!-- subrequirementTotals -->
        </#if>
       <#if auditReportSubreq.showTakenCourses>
            <div class="completedCourses">
            <table class="courses">
                <#if newHeader && auditReportSubreq.showTakenCourseHeader>
                  <#assign newHeader = false>
            	  <tr>
                	<th class="subreqSeqErr"></th>
                	<th class="subreqStatus"></th>
                	<th class="subreqRequired"></th>
                	<th class="subreqNumber"></th>
                	<th class="term">Term</th>
                	<th class="course">Course</th>
                	<th class="credit">Credits</th>
                	<th class="grade">Grade</th>
                	<th class="ccode"></th>
                	<th class="descLines">Title</th>
                  </tr>
                </#if>
                <#list auditReportSubreq.takenCourses as takenCourse>
                    <tr>
                        <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                        <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                        <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                        <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
                        <#if takenCourse.showCline>
                            <td class="cline" colspan="4">${takenCourse.cline?xml}</td>
                            <td class="ccode">${takenCourse.condCode?xml}</td>
                            <td><table class="descLines"><#list takenCourse.descriptiveLines as descriptiveLine><tr><td id="descText">${descriptiveLine?xml}</td></tr></#list></table></td>
                        <#else>
                            <td class="term">${takenCourse.yt?xml}</td>
                            <td class="course">${takenCourse.displayCourse?xml}</td>
                            <td class="credit">${takenCourse.credit?xml}</td>
                            <td class="grade">${takenCourse.grade?xml}</td>
                            <td class="ccode">${takenCourse.condCode?xml}</td>
                            <td><table class="descLines"><#list takenCourse.descriptiveLines as descriptiveLine><tr><td id="descText">${descriptiveLine?xml}</td></tr></#list></table></td>
                        </#if>
                    </tr>
                </#list>
            </table><!-- courses -->
            </div><!-- completedCourses -->
            <#assign showPretext = false>
        </#if>
        <#if auditReportSubreq.showNeedsSummary>
            <div class="needsSummary">
            <#assign newHeader = true>                              
            <table class="subreqNeeds">     
                <tr>
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>
                    <td class="needslabel">${auditReportSubreq.needsText?xml}</td>
                    <td class="rightalign"><#if auditReportSubreq.showNeedsHours>${auditReportSubreq.needsHours?xml}</#if></td>
                    <td class="hourslabel"><#if auditReportSubreq.showNeedsHours>${auditReportSubreq.needsHoursText?xml}</#if></td>
                    <td class="rightalign"><#if auditReportSubreq.showNeedsCount>${auditReportSubreq.needsCount?xml}</#if></td>
                    <td class="courseslabel"><#if auditReportSubreq.showNeedsCount>${auditReportSubreq.needsCountText?xml}</#if></td>
                    <td class="rightalign"><#if auditReportSubreq.showNeedsGpa>${auditReportSubreq.needsGpa?xml}</#if></td>
                    <td class="gpalabel"><#if auditReportSubreq.showNeedsGpa>${auditReportSubreq.needsGpaText?xml}</#if></td>
                </tr>
            </table><!-- subreqNeeds -->
            <#assign showPretext = false>
            </div>             
        </#if>
        <#if auditReportSubreq.showSelectNotFrom>
          <#assign newHeader = true>                              
          <table class="fromCourses">
            <#if auditReportSubreq.showReject>
                <tr class="selectRow">
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>          
                    <td class="selectText">${auditReportSubreq.notText?xml}</td>
                    <td class="selectCourses rejectCourses"><#t>
                        <#list auditReportSubreq.notFromPDFCourses as course><#t>
                            ${course?xml}<#lt>
                        </#list><#t> 
                    </td><#t>
                </tr>
                <#assign showPretext = false>             
            </#if>
            <#if auditReportSubreq.showAccept>
                <tr class="selectRow">
                    <td class="subreqSeqErr"><#if showPretext><#if auditReportSubreq.hasSeqErr>${auditReportSubreq.seqErr?xml}</#if></#if></td>
                    <td class="subreqStatus"><#if showPretext><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.subreqStatus?xml}</#if></#if></td>
                    <td class="subreqRequired"><#if showPretext><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></#if></td>
                    <td class="subreqNumber"><#if showPretext><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></#if></td>          
                    <td class="selectText">${auditReportSubreq.selectText?xml}</td>
                    <td class="selectCourses acceptCourses"><#t>
                        <#list auditReportSubreq.selectFromPDFCourses as course><#t>
                            ${course?xml}<#lt>
                        </#list><#t> 
                    </td><#t>
                </tr>
                <#assign showPretext = false>             
            </#if>
            <#if auditReportSubreq.showNoRefCoursesFoundMessage>
                <tr class="selectRow">
                    <td class="selectText"></td>
                    <td class="selectCourses noRefFoundMsg">
                        ${auditReportSubreq.noRefCourseFoundMessage?xml}
                    </td>
                </tr>
            </#if>
          </table> <!-- fromCourses -->
        </#if> <!--showSelectNotFrom -->
    </div><!-- subrequirement -->
    </#list>
    </div><!-- auditSubrequirements -->
    </div><!-- requirement --> 
    <hr class="reqBotRule" />
</#list>
</div>
<#if cncflg>
<div>
    <#if showCFirst>        
        <#if showCMess>
            <span class="cmessHeader">${cmess?xml}</span>
            <hr class="headerRule"/>
        </#if>
        <#if showNMess>
            <span class="cmessHeader">${ncmess?xml}</span>
            <hr class="headerRule"/>
        </#if>        
    <#else>
        <#if showNMess>
            <span class="cmessHeader">${ncmess?xml}</span>
            <hr class="headerRule"/>
        </#if>        
        <#if showCMess>
            <span class="cmessHeader">${cmess?xml}</span>
            <hr class="headerRule"/>
        </#if>
   </#if>
</div>   
</#if>   
<div id="auditFooter">
<#if showIncludeBottomText>
    <#list includeBottomText as bottomTextLine>
       <div id="includeBottomText">${bottomTextLine}<#if bottomTextLine_has_next><br /></#if></div>                        
    </#list>
<hr class="headerRule" />
</#if>
<div id="endText">
${endText}
</div><!-- endText -->
</div>
</div>
</body>
</html>