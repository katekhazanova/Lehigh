<html>
<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
<head>
	<title>Reports Console</title>	
	<META name="userName" content="${userFullName!''}">	
</head>
<input type="hidden" id="pageGroup" value="reports"/>
<body > 

	<h1>Reports</h1>
	<br/>
	
	<div class="row">
		<#if daversion != "peoplesoft">
		<div class="col-md-6">
				<h2>Batch Based </h2>
				<ul>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=CompletionCheckReport" />" title="Audit Completion Check" alt="Audit Completion Check">
						Audit Completion Check
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=BatchReqCompletion" />" title="Requirement Completion Grid" alt="Requirement Completion Grid">
						Requirement Completion Grid
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=CountAcceptCourse" />" title="Accepted Course Count" alt="Accepted Course Count">
						Accept Course Count
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=MajorReqPercentComplete" />" title="Requirement Percent Complete" alt="Requirement Percent Complete">
						Requirement Percent Complete
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=MostUsedDprogs" />" title="Most Used Degree Programs" alt="Most Used Degree Programs">
						Most Used Degree Programs
						</a>
					</li>
				</ul>
		</div>
		</#if>
		<#if udirectURL != "">
		<div class="col-md-6">
				<h2>Course Demand </h2>
				<ul>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=CourseDemandOverview" />" title="Course Demand Overview" alt="Course Demand Overview">
						Course Demand Overview
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=PlannedCoursesByTerm" />" title="Planned Courses by Term" alt="Planned Courses by Term">
						Planned Courses by Term
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=PlannedCoursesByCourse" />" title="Planned Courses by Course" alt="Planned Courses by Course">
						Planned Courses by Course
						</a>
					</li>

					<#if scheduleBuilderURL??>
					<li><a href="${scheduleBuilderURL}/admin/admin_course_demand?crossApp=${crossApp}" title="Scheduled Courses by Term" alt="Scheduled Courses by Term">
						Scheduled Courses by Term
						</a>
					</li>
					</#if>
				</ul>
		</div>
		</#if>
	</div>
	<#if daversion != "peoplesoft">
	<div class="row">
		<div class="col-md-6">
				<h2>Encoding </h2>
				<ul>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=NumRulesBySchool" />" title="Number of Rules by TA School" alt="Number of Rules by TA School">
						Number of Rules by TA School
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=StudentTABySchool" />" title="Number of Student Courses by TA School" alt="Number of Student Courses by TA School">
						Number of Student Courses by TA School
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=NumStudentPerTASchool" />" title="Number of Students by TA School" alt="Number of Students by TA School">
						Number of Students by TA School
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=MostUsedRequirements" />" title="Most Used Requirements" alt="Most Used Requirements">
						Most Used Requirements
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=AllRPTINSTID" />" title="All Master Reference by RPTINSTID" alt="All Master Reference by RPTINSTID">
						All Master Reference by RPTINSTID
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=DupRPTINSTID" />" title="Duplicate RPTINSTIDs" alt="Duplicate RPTINSTIDs">
						Duplicate RPTINSTIDs
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=CourseSearch" />" title="Course Search" alt="Course  Search">
						Course Search
						</a>
					</li>
				</ul>
		</div>
		<div class="col-md-6">
				<h2>Exceptions </h2>
				<ul>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=MostUsedEXByType" />" title="Number of Exceptions by Type" alt="Number of Exceptions by Type">
						Number of Exceptions by Type
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=WhoUsesExceptions" />" title="Number of Exceptions by LastModUser" alt="Number of Exceptions by LastModUser">
						Number of Exceptions by LastModUser
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=WhoUsesExceptions_AuthId" />" title="Number of Exceptions by AuthId" alt="Number of Exceptions by AuthId">
						Number of Exceptions by AuthId
						</a>
					</li>
					<li><a href="<@spring.url relativeUrl="/reports/report-options.html?report=NumberOfExByStudent" />" title="Number of Exceptions by Student" alt="Number of Exceptions by Student">
						Number of Exceptions by Student
						</a>
					</li>
				</ul>
		</div>
	</div>
	</#if>

</body>
</html>