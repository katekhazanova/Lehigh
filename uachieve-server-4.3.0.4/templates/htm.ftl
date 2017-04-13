<title>Audit Report</title>
<style type="text/css">
	<#include "./css/auditSpacing.css" parse=false>
	<#include "./css/audit.css" parse=false>
</style>
<div id="audit" com="${comkey?xml}" dprog="${degreeProgramCode?xml}" forceDprog="${forceDprog?c}" catlyt="${catlyt?xml}" forceCatlyt="${forceCatlyt?c}" dpmask="${dpmask?xml}" sinstid="${sinstid?xml}" sinstcd="${sinstcd?xml}" includeIP="${includeIP?c}" includePlanned="${includePlanned?c}" wifRead="${wifRead?xml}" wifDprog="${wifDprog?xml}" evalsw="${evalsw?xml}" soprid="${soprid?xml}" >
	<div id="auditHeader">
		<#if showTestMessage>
			<div id="testMessageHeader">
    			<hr class="headerRule"/>
    			${testMessage?xml}
    			<hr class="headerRule"/>
    			<br />
			</div>
		</#if>
		<div class="includeTopText preformatted"><#t>
      		<#list includeTopText as topTextLine>
        		${topTextLine}
     		</#list>
		</div>
		<#if showRefArtHeader>
    		<div id="refArtHeaderText">
        		${refArtHeaderTextLine1?xml}<br />
        		${refArtHeaderTextLine2?xml}<br />
    		</div>
		</#if>
		<#if auditStatus = 0>
			<div class="completionTextOK">${auditStatusMessage?xml}</div>
		<#elseif auditStatus = -1>
			<div class="completionTextNO">${auditStatusMessage?xml}</div>
		<#else>
			<div class="completionText">${auditStatusMessage?xml}</div>
		</#if>
		<#if showWifDegreeProgramMessage><div class="wifDpMessage">${wifDegreeProgramMessage?xml}</div></#if>
	</div>  <#-- auditHeader -->
	<#assign statusOk = false />
	<#assign showCMess = true />
	<#assign showNMess = true />
	<div id="auditRequirements">
		<#list auditReportReqs as auditReportReq>
			<#assign statusOk = auditReportReq.ok />
			<#assign satisfiedClass = "Status_NONE" />
			<#assign statusClass = "statusNONE" />
			<#assign statusDesc = "" />
			<#if auditReportReq.showStatus >
    			<#assign satisfiedClass = auditReportReq.satisfied?xml />
    			<#assign statusClass = auditReportReq.reqStatus?xml />
    			<#assign statusDesc = auditReportReq.reqStatusDescription?xml />
			</#if>
    		<#if cncflg>
        		<#if showCFirst>        
            		<#if showCMess && (! statusOk)>
                		<#assign showCMess = false />                        
                		<span class="cmessc">${cmess?xml}</span>
                		<hr class="headerRule"/>
            		</#if>
        		<#else>
            		<#if showNMess && (statusOk)>
                		<#assign showNMess = false />                        
                		<span class="cmessc">${ncmess?xml}</span>
                		<hr class="headerRule"/>
            		</#if>        
        		</#if>

        		<#if statusOk>
            		<#if showCMess>
                		<#assign showCMess = false />                        
                		<span class="cmessc">${cmess?xml}</span>
                		<hr class="headerRule"/>
            		</#if>
        		<#else>
            		<#if showNMess>
                		<#assign showNMess = false />                        
                		<span class="cmessc">${ncmess?xml}</span>
                		<hr class="headerRule"/>
            		</#if>        
        		</#if>                        
   			</#if>  <#-- cncflg -->
			<#if auditReportReq.showHeader>
				<#-- requirement header -->
				<#if auditReportReq.showListAllHeader>
    				<div class="listAll">
        				<table>
        					<tr>
        						<td>${auditReportReq.reqName}</td>
        						<td>${auditReportReq.instCode}</td>
        						<td>${auditReportReq.catlyt}</td>
        						<td>${auditReportReq.pseudoName}</td>
    							<td>${auditReportReq.yearTermRange}</td>
							</tr>
						</table>
    				</div>
				</#if>
			</#if>
			<div class="requirement ${satisfiedClass} ${auditReportReq.category?xml} ${auditReportReq.summaryGroupName?xml} ${auditReportReq.rname?xml} ${auditReportReq.rtabx?xml}" <#rt>
     			id="req-${auditReportReq.uuid?xml}" rname="${auditReportReq.plainRname?xml}" pseudo="${auditReportReq.plainPsname?xml}" <#t>
     			rqdSubreq="${auditReportReq.rqdSubreq?xml}" rqdCount="${auditReportReq.rqdCount?xml}" rqdGpa="${auditReportReq.rqdGpa?xml}" rqdHours="${auditReportReq.rqdHours?xml}" <#t>
     			maxHours="${auditReportReq.maxHours?xml}" authCode1="${auditReportReq.authCode1?xml}" authCode2="${auditReportReq.authCode2?xml}"> <#lt>
			<div class="reqHeaderTable">
				<h3 class="sr-only">Requirement: ${auditReportReq.label?xml}</h3>
				<div class="reqStatusGroup">
					<button class="toggler togglerExpanded hidden-print" title="Toggle Requirement Text"><i class="fa fa-togglerExpanded"><span class="sr-only hidden-print">Requirement expanded, click to collapse</span></i></button>
					<div class="status ${statusClass}"><span class="sr-only hidden-print">Requirement ${statusDesc}</span><i class="fa fa-${statusClass}" title="Requirement ${statusDesc}" aria-hidden="true"></i></div>
					<#if auditReportReq.showNumber>
						<div class="reqNumber">${auditReportReq.number?xml}</div>
					</#if>
					<#if auditReportReq.showGroups>
						<div class="reqGroups">${auditReportReq.groups?xml}</div>
					</#if>
				</div>  <#-- reqStatusGroup-->
				<#-- requirement text -->
				<div class="reqText"><#t>
					<div class="requirement-buttons"></div>
					<div class="reqHeader"><#t>
						<#list auditReportReq.headerLines as headerLine>${headerLine}<#if headerLine_has_next><br /></#if></#list><#t>
					</div>
					<#if auditReportReq.showTitle>
						<div class="reqTitle"><#t>
							<#list auditReportReq.titleLines as titleLine>${titleLine}<#if titleLine_has_next><br /></#if></#list><#t>
						</div>
					</#if>
				</div><#-- reqText end -->
			</div><#-- reqHeaderTable end -->
			<div class="reqBody">
                <table class="requirementTotals">
                    <#-- requirement earned/got -->
                    <#if auditReportReq.showGotSummary>
                        <tr class="reqEarned">
                        <td class="warnind"></td>
                        <td class="rowlabel"><span class="warnind"><#if auditReportReq.showWarnInd>${auditReportReq.warnInd?xml}</#if></span>${auditReportReq.earnedText?xml}</td>
                        <td class="hourscount bigcolumn">
                        	<span class="hours number"><#if auditReportReq.showGotHours>${auditReportReq.gotHours?xml}</#if></span>
                        	<span class="hourslabel smallfieldlabel"><#if auditReportReq.showGotHours>${auditReportReq.gotHoursText?xml}</#if></span>
                        	<span class="count number"><#if auditReportReq.showGotCount>${auditReportReq.gotCount?xml}</#if></span>
                        	<span class="countlabel smallfieldlabel"><#if auditReportReq.showGotCount>${auditReportReq.gotCountText?xml}</#if></span>
                        </td>
                        <td class="subreqs number"><#if auditReportReq.showGotSubreqs>${auditReportReq.gotSubreqs?xml}</#if></td>
                        <td class="subreqslabel fieldlabel"><#if auditReportReq.showGotSubreqs>${auditReportReq.gotSubreqsText?xml}</#if></td>
                        <td class="gpa number"><#if auditReportReq.showGotGpa>${auditReportReq.gotGpa?xml}</#if></td>
                        <td class="gpalabel"><#if auditReportReq.showGotGpa>${auditReportReq.gotGpaText?xml}</#if></td>
                        </tr><#-- reqEarned end --> 
                    </#if> <#-- showGotSummary -->
                    <#-- detailed gpa -->
                    <#if auditReportReq.showDetailGpaLine>
                    	<tr class="reqGpaDetail">
                    		<td class="reqStatusTd"></td>
                    		<td class="rowlabel"></td>
                    		<td class="hourscount bigcolumn">
                    			<span class="hours number">${auditReportReq.gotGpaHours?xml}</span>
                    			<span class="hourslabel fieldlabel">${auditReportReq.gotGpaHoursText?xml}</span>
                    		</td>
                    		<td class="points number">${auditReportReq.gotGpaPoints?xml}</td>
                    		<td class="pointslabel fieldlabel">${auditReportReq.gotGpaPointsText?xml}</td>
                    		<td class="gpa number"><#if auditReportReq.showDetailGpa>${auditReportReq.gotGpa?xml}</#if></td>
                    		<td class="gpalabel"><#if auditReportReq.showDetailGpa>${auditReportReq.gotGpaText?xml}</#if></td>
                    	</tr><#-- reqGpaDetail end -->
                    </#if>
                    <#-- in-progress hours -->
                    <#if auditReportReq.showInProgressHours>
                    	<tr class="reqIpDetail">
                        	<td class="reqStatusTd"></td>
                            <td class="rowlabel">${auditReportReq.ipStub?xml}</td>
                            <td class="hourscount bigcolumn">
                            	<span class="hours number">${auditReportReq.ipHours?xml}</span>
                               	<span class="hourslabel fieldlabel">${auditReportReq.ipHoursText?xml}</span>
                            </td>
                            <td class="number"></td><td class="fieldlabel"></td>
                            <td class="number"></td><td class="fieldlabel"></td>
                        </tr><#-- reqIpDetail end -->
                    </#if>
                    <#-- planned hours -->
                    <#if auditReportReq.showPlannedHours>
                    	<tr class="reqWhatIfDetail">
                            <td class="reqStatusTd"></td>
                            <td class="rowlabel">${auditReportReq.wifStub?xml}</td>
                            <td class="bigcolumn">
                             	<span class="hours number">${auditReportReq.wifHours?xml}</span>
                               	<span class="hourslabel fieldlabel">${auditReportReq.wifHoursText?xml}</span>
                            </td>
                            <td class="number"></td><td class="fieldlabel"></td>
                            <td class="number"></td><td class="fieldlabel"></td>
                        </tr><#-- reqWhatIfDetail end -->
                    </#if>
                    <#-- requirement Needs -->
                    <#if auditReportReq.showNeedsSummary>
                    	<tr class="reqNeeds">
                        	<td class="warnind"></td>
                        	<td class="rowlabel">${auditReportReq.needsText?xml}</td>
                        	<td class="hourscount bigcolumn">
                        		<span class="hours number"><#if auditReportReq.showNeedsHours>${auditReportReq.needsHours?xml}</#if></span>
                        		<span class="hourslabel smallfieldlabel"><#if auditReportReq.showNeedsHours>${auditReportReq.needsHoursText?xml}</#if></span>
                        		<span class="count number"><#if auditReportReq.showNeedsCount>${auditReportReq.needsCount?xml}</#if></span>
                        		<span class="countlabel smallfieldlabel"><#if auditReportReq.showNeedsCount>${auditReportReq.needsCountText?xml}</#if></span>
                        	</td>
                        	<td class="subreqs number"><#if auditReportReq.showNeedsSubreqs>${auditReportReq.needsSubreqs?xml}</#if></td>
                        	<td class="subreqslabel fieldlabel"><#if auditReportReq.showNeedsSubreqs>${auditReportReq.needsSubreqsText?xml}</#if></td>
                        	<td class="gpa number"><#if auditReportReq.showNeedsGpa>${auditReportReq.needsGpa?xml}</#if></td>
                        	<td class="gpalabel"><#if auditReportReq.showNeedsGpa>${auditReportReq.needsGpaText?xml}</#if></td>
                    	</tr><#-- reqNeeds end -->
                    </#if>
                </table><#-- requirementTotals end -->
				<#if auditReportReq.showExcLines>
					<div class="reqExceptions">
						<#list auditReportReq.appliedExceptionText as ex>
							<span class="reqCline">${ex?xml}<br /></span>
						</#list>
					</div>
				</#if>
				<div class="auditSubrequirements">
					<#list auditReportReq.auditReportSubreqs as auditReportSubreq>
						<div class="subrequirement" id="subreq-${auditReportSubreq.uuid}" <#rt>
    						pseudo="${auditReportSubreq.selectFromPseudo}" pseudoList='${auditReportSubreq.allPseudosAsAttribute?xml}' <#t>
    						rqdSubreq="${auditReportSubreq.rqdCount?xml}" rqdGpa="${auditReportSubreq.rqdGpa?xml}" <#t>
    						rqdHours="${auditReportSubreq.rqdHours?xml}" maxHours="${auditReportSubreq.maxHours?xml}"> <#lt>
							<div class="subreqPretext">
								<span class="subreqSeqErr"><#if auditReportSubreq.showSubreqStatus>${auditReportSubreq.seqErr?xml}</#if></span>
								<span class="subreqRequired"><#if auditReportSubreq.required><span class="subreqRequiredBorder">${auditReportSubreq.subreqRequired?xml}</span></#if></span>
								<#if auditReportSubreq.showSubreqStatus>
									<span class="status ${auditReportSubreq.status?xml}"><span class="sr-only hidden-print">Sub-Requirement ${auditReportSubreq.statusDescription?xml}</span><i class="fa fa-${auditReportSubreq.status?xml}" title="Sub-Requirement ${auditReportSubreq.statusDescription?xml}" aria-hidden="true"></i></span>
								<#else>
									<span class="status"></span>
								</#if>
								<span class="subreqNumber"><#if auditReportSubreq.showSubreqNumber>${auditReportSubreq.subreqNumber?xml}<#if auditReportSubreq.showParen>)</#if></#if></span>
							</div>
							<div class="subreqBody">
								<div class="subrequirement-buttons"></div>
								<#if auditReportSubreq.showTitle >
									<span class="subreqTitle srTitle_${auditReportSubreq.statusClassSR?xml}"><#list auditReportSubreq.titleLines as titleLine>${titleLine}<#if titleLine_has_next><br /></#if></#list></span>
								</#if>
								<#if auditReportSubreq.showExcLines><#list auditReportSubreq.appliedExceptionText as ex>
									<span class="subreqCline">${ex?xml}<br /></span></#list>
								</#if>
             					<#if auditReportSubreq.showGotSummary || auditReportSubreq.showDetailGpaLine || auditReportSubreq.showInProgressHours || auditReportSubreq.showPlannedHours >
 	           						<table class="subrequirementTotals">
                						<#if auditReportSubreq.showGotSummary >
                    						<tr class="subreqEarned">
                       							<td class="bigcolumn">
                    	   							<#if auditReportSubreq.showGotHours ><#t>
                    		  							<span class="hours number">${auditReportSubreq.gotHoursOpenDecoration}${auditReportSubreq.gotHours?xml}</span><#t>
		                      							<span class="hourslabel fieldlabel">${auditReportSubreq.gotHoursText?xml}${auditReportSubreq.gotHoursCloseDecoration}</span><#t>
                    	   							</#if>
                        						</td>
                        						<td class="count number">
                            						<#if auditReportSubreq.showGotCount>${auditReportSubreq.gotCount?xml}</#if>
                        						</td>
                        						<td class="countlabel fieldlabel">
                            						<#if auditReportSubreq.showGotCount >${auditReportSubreq.gotCountText?xml}</#if>
                        						</td>
                        						<td class="gpa number">
                            						<#if auditReportSubreq.showGotGpa >${auditReportSubreq.gotGpa?xml}</#if>
                       							</td>
                        						<td class="gpalabel smallfieldlabel">
                            						<#if auditReportSubreq.showGotGpa >${auditReportSubreq.gotGpaText?xml}</#if>
                        						</td>
                    						</tr>               
                						</#if> <#-- showGotSummary -->
                						<#if auditReportSubreq.showDetailGpaLine>
                    						<tr class="gpaDetail">
                    							<td class="bigcolumn">
                        							<span class="hours number">${auditReportSubreq.gotGpaHours?xml}</span><#t>
                        							<span class="hourslabel fieldlabel">${auditReportSubreq.gotGpaHoursText?xml}</span><#t>
                        						</td>
                        						<td class="points number">
                            						${auditReportSubreq.gotGpaPoints?xml}
                        						</td>
                        						<td class="pointslabel fieldlabel">
                            						${auditReportSubreq.gotGpaPointsText?xml}
                        						</td>
                        						<td class="gpa number">
                            						<#if auditReportSubreq.showDetailGpa>${auditReportSubreq.gotGpa?xml}</#if>
                        						</td>
                        						<td class="gpalabel smallfieldlabel">
                           							<#if auditReportSubreq.showDetailGpa>${auditReportSubreq.gotGpaText?xml}</#if>
                        						</td>
                    						</tr>
                						</#if> <#-- showDetailGpa -->
                						<#if auditReportSubreq.showInProgressHours || auditReportSubreq.showInProgressCount >
                    						<tr class="subreqIpHours">
                        						<td class="rowlabel">
                        							${auditReportSubreq.ipSrStub?xml}
                        						</td>
                        						<td class="hours number">
                        							<#if auditReportSubreq.showInProgressHours >${auditReportSubreq.ipHours?xml}</#if>
                        						</td>
                        						<td class="hourslabel fieldlabel">
                        							<#if auditReportSubreq.showInProgressHours >${auditReportSubreq.ipHoursText?xml}</#if>
                        						</td>
                        						<td class="count number">
                        							<#if auditReportSubreq.showInProgressCount >${auditReportSubreq.ipCount?xml}</#if>
                        						</td>
                        						<td class="countlabel fieldlabel">
                        							<#if auditReportSubreq.showInProgressCount >${auditReportSubreq.ipCountText?xml}</#if>
                        						</td>
                    						</tr>
                						</#if> <#-- showInProgressHours -->
                						<#if auditReportSubreq.showPlannedHours || auditReportSubreq.showPlannedCount > 
                    						<tr class="subreqWhatIfDetail">
                        						<td class="rowlabel">${auditReportSubreq.wifSrStub?xml}</td>
                        						<td class="hours number">
                           							<#if auditReportSubreq.showPlannedHours>${auditReportSubreq.plannedHours?xml}</#if>
                        						</td>
                        						<td class="hourslabel fieldlabel">
                            						<#if auditReportSubreq.showPlannedHours>${auditReportSubreq.plannedHoursText?xml}</#if>
                        						</td>
                        						<td class="count number">
                            						<#if auditReportSubreq.showPlannedCount>${auditReportSubreq.plannedCount?xml}</#if>
                        						</td>
                        						<td class="countlabel fieldlabel">
                            						<#if auditReportSubreq.showPlannedCount>${auditReportSubreq.plannedCountText?xml}</#if>
                        						</td>
                    						</tr><#-- subreqWhatIfDetail end -->
                						</#if> <#-- showWhatifDetail -->
            						</table><#-- subrequirementTotals end -->
            					</#if><#-- showGotSummary -->
								<#if auditReportSubreq.showTakenCourses>
									<table class="completedCourses" summary="complete course table">
										<#list auditReportSubreq.takenCourses as takenCourse>
											<tr class="takenCourse ${takenCourse.courseType}">
    											<#if takenCourse.showCline>
        											<td colspan="4" class="cline" aria-label="note">${takenCourse.yt?xml}</td>
    											<#else>
        											<td class="term"	aria-label="term">${takenCourse.yt?xml}</td>
        											<td class="course"	aria-label="course">${takenCourse.displayCourse?xml}</td>
											        <td class="credit"	aria-label="credit">${takenCourse.credit?xml}</td>
											        <td class="grade"	aria-label="grade">${takenCourse.grade?xml}</td>
    											</#if>      
    											<td class="ccode" aria-label="condition code">${takenCourse.condCode?xml}</td>
												<td class="description" aria-label="description">
													<table>
														<#list takenCourse.descriptiveLines as descriptiveLine>
															<tr>
																<td class="descLine">${descriptiveLine?xml}</td>
															</tr>
														</#list>
													</table>
												</td>
											</tr>
										</#list> <#-- takenCourses -->
									</table> <#-- completedCourses -->
								</#if>
								<#if auditReportSubreq.showNeedsSummary >
									<table class="subreqNeeds">
										<tr>
											<td class="rowlabel">${auditReportSubreq.needsText?xml}</td>
											<#if auditReportSubreq.showNeedsHours >
												<td class="hours number">${auditReportSubreq.needsHours?xml}</td>
												<td class="hourslabel smallfieldlabel">${auditReportSubreq.needsHoursText?xml}</td>
											</#if>
											<#if auditReportSubreq.showNeedsCount >
												<td class="count number">${auditReportSubreq.needsCount?xml}</td>
												<td class="countlabel fieldlabel">${auditReportSubreq.needsCountText?xml}</td>
											</#if>
											<#if auditReportSubreq.showNeedsGpa >
												<td class="gpa number">${auditReportSubreq.needsGpa?xml}</td>
												<td class="gpalabel smallfieldlabel">${auditReportSubreq.needsGpaText?xml}</td>
											</#if>
										</tr>
									</table>
								</#if> <#-- showNeedsSummary -->
								<#if auditReportSubreq.showSelectNotFrom>
									<table 	class="notcourses" id="notcourses-${auditReportSubreq.uuid}" pseudo="${auditReportSubreq.notFromPseudo}">
										<#if auditReportSubreq.showReject>
											<tr class="notfromcourses">
												<td class="fromlabel">${auditReportSubreq.notText?xml} <span class="notfrom-buttons"></span></td>
												<td class="fromcourselist">
													<table>
   														<#list auditReportSubreq.notFromHtmlCourses as course>
															<tr><td>${course}</td></tr>
    													</#list>
    												</table>
    											</td>
    										</tr>
										</#if>
    								</table>
    								<table 	class="selectcourses" id="selectcourses-${auditReportSubreq.uuid}" pseudo="${auditReportSubreq.selectFromPseudo}">
										<#if auditReportSubreq.showAccept>
											<tr class="selectfromcourses">
												<td class="fromlabel">${auditReportSubreq.selectText?xml} <span class="selectfrom-buttons"></span></td>
												<td class="fromcourselist">
													<table>
   														<#list auditReportSubreq.selectFromHtmlCourses as course>
															<tr><td>${course}</td></tr>
    													</#list>
    												</table>
    											</td>
    										</tr>
										</#if>
									</table>
									<#if auditReportSubreq.showNoRefCoursesFoundMessage>
									   <div class="refcoursemessage">                                                                        
                                            <#rt>${auditReportSubreq.noRefCourseFoundMessage?xml}
									   </div>
									</#if>
								</#if> <#-- showSelectNotFrom -->
							</div> <#-- subreqBody -->
						</div> <#-- subrequirement -->
					</#list> <#-- auditReportSubreqs -->
				</div> <#-- auditSubrequirements -->
				<hr/>
			</div> <#-- reqBody -->
			</div> <#-- requirement -->
		</#list> <#-- auditReportReqs -->
    	<#if cncflg>
        	<#if showCFirst>        
            	<#if showCMess>
                	<span class="cmessc">${cmess?xml}</span>
                	<hr class="headerRule"/>
            	</#if>
            	<#if showNMess>
                	<span class="cmessc">${ncmess?xml}</span>
                	<hr class="headerRule"/>
            	</#if>        
        	<#else>
            	<#if showNMess>
                	<span class="cmessc">${ncmess?xml}</span>
                	<hr class="headerRule"/>
            	</#if>        
            	<#if showCMess>
                	<span class="cmessc">${cmess?xml}</span>
                	<hr class="headerRule"/>
            	</#if>
        	</#if>
   		</#if>   
	</div> <#-- auditRequirements -->
	<#if showIncludeBottomText>
    	<div class="includeBottomText preformatted"><#t>
    		<#list includeBottomText as bottomTextLine>
        		${bottomTextLine}
    		</#list>
     		<hr class="headerRule" />
    	</div>
	</#if>                                                 
 	<div id="endText">
		${endText}
	</div><#-- endText -->                                                
</div> <#-- audit -->