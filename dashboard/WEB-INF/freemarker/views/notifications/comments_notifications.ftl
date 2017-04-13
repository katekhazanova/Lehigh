<html>
<#assign authz=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>
<head>
	<title>Comments Notifications</title>	
	<META name="userName" content="${userFullName!''}">	

	<script type="text/javascript">
	//JQuery formatting of the Plan Comments
			$(document).ready(function(){
				loadTables();
				countTables();
             });
	</script>

</head>
<input type="hidden" id="pageGroup" value="notifications"/>
<body> 
	

	<h1>Notifications</h1>

	<div class="panel-group" id="accordion">
	
		<#if enableComments>
			<@authz.authorize ifAnyGranted="SS_AREA_COMMENTS=r, UDIR_Notes=r">	
			  <div class="panel panel-default">
			    <div class="panel-heading">
			      <h2 class="panel-title">
			        
			          <a data-parent="#accordion" href="#collapseComments">
							${commentLabel}s 

							<span class="badge-notifications" style="float: right; id="comment-table-count"> ${noteNotifications?size}  Total</span>


			      </h2>
			    </div>
			    <div id="collapseComments" class="panel-collapse in">
			      <div class="panel-body">
			      	<div class="allRoadmapsManagerTable">
						<div class="block">
						<table class="table table-striped table-bordered table-hover" id="comment-table"> 
						<#--<# id="comment-table"leView()>style="width: 40%"</#if> > -->
							<thead>
							<tr>
								<th>Student Name</th>
								<th>Declared ${planLabel}</th>
								<th># of New ${commentLabel}s</th>
								<th>View</th>
							</tr>
							</thead>
							<tbody>
							<#list noteNotifications as noteNotification>
							<tr>
							<td>${noteNotification.studentName}</td>
								<td>${noteNotification.declaredPlanName}</td>
								<td>${noteNotification.numberOfNewComments}</td>
								<#--<td><@h.link href="${selfserviceURL}/plan/manage/display-plans.html?student=${noteNotification.studentUserName}" title="View"/></td>-->
								<td>
									<a href="${selfserviceURL}/comment/list.html">View</a>
								</td>
							</tr>
							</#list>
							</tbody>
						</table>
						</div>
						</div>
			      </div>
			    </div>
			  </div>
		  </@authz.authorize> 
		</#if>
  
  		
</div>
	
</body>
</html>