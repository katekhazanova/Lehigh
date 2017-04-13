<@layout.head title="Comments" />

<@layout.body>	
	<input type="hidden" id="pageGroup" value="comments"/>
	<div class="row">
		<div class="col-md-12">	
			<#if showError>
				<div class="alert alert-danger" role="alert" tabindex="0">Comments can only have a Maximum of 4,000 characters.</div>
			</#if>
			<div class="col-md-7" style="padding-left: 0px;">
				<#--p class="commentsHeader"--><h1><@s.message 'uachieve.selfservice.comment.label'/>s</h1><#--/p-->
		    	<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COMMENTS perm="C">
		    		<div class="col-md-12" style="min-height: 70px;">
				    	<div class="col-md-8" style="padding-left: 0px;">
				    	<#if noteList??>
				    		<p class="commentsText"><@s.message 'uachieve.selfservice.comment.list.text'/></p>
			    		</div>
			    		<div class="col-md-4" style="padding-right: 0px;">
			    			<a class="btn btn-primary pull-right" type="button" id="addNewComment" name="addNewComment" value="AddNewComment tabindex="-1" href="<@h.url href='${urlMap["LIST"]}?replyInd=false&mode=add' />">Add New <@s.message 'uachieve.selfservice.comment.label'/></a>
		    			</div>
		    		</div>	
		    			
			    	<div class="col-md-12">
	    				<a href="#" title="Expand All" onclick="expandAllComments(); return false">Expand All</a> / 
	   					<a href="#" title="Collapse All" onclick="collapseAllComments(); return false">Collapse All</a>	
	    			</div>
	
			    	<#else>
						Student must have a valid LogIn ID to Self-Service to add comments.
					</#if>
			    	</div>
		    	</@sec.hasAppFnPerm>	
			</div> <#-- /col-md-7 -->
			
			<div class="col-md-7" style="padding-left: 30px; padding-top: 10px; padding-right: 30px;">
				<table class="borderless-table commentsTable" style="width: 100%;">
					<#if showAdd>
				    	<td></td>
				    	<td>
							<div class="commentsBox">
								<@noteForm redirect=urlMap["CREATE"] note=addNote/>
							</div>
						</td>
					</#if>
				
					<#assign odd=true>
					<#assign odd2=true>
					<#if noteList??>
						<#list noteList as note>
							<tr>
								<td valign="top">
								
								<a href="#" onclick="collapseComment(${note.id?c});" alt="collapse" title="collapse"><i class="fa fa-minus-square-o"></i></a>
								</td>
							<td>
							<div id="historicalComment-${note.id?c}" class="historicalComment">
							<#if odd>
								<div class="altCommentsBox" >
								<#assign odd=false>
							<#else>
								<div class="commentsBox" >
								<#assign odd=true>
							</#if>
							<#if showEdit && editNote?? && note.id == editNote.id>
								<@noteForm redirect=urlMap["EDIT"] note=editNote/>
							<#else>
								<div id="topLine">
									<span id="commentFrom" class="commentSays" style="width:25%; float:left">From: ${note.authorFullName!' '} (${note.author!' '})</span>
							    	<span id="commentTo" style="width:25%; float:left"
							    		 <#if note.isToStudent()> class="commentToStudent" </#if>
							    		 <#if note.isToAdvisors()> class="commentToAdvisors" </#if>
							    		 <#if note.isToPublic()> class="commentToPublic" </#if>
							    		 <#if note.isToPrivate()> class="commentToPrivate"</#if>
							    		 >To ${note.viewableByDisplayText!' '}
							    	</span>
							    		 <table class="borderless-table" style="float:right; margin:0px 5px 0px 0px" >
							    		 <#if note.hasLastUpdateDate()>
							    		 <tr>
							    		 	<td class="commentDate"><i class="fa fa-clock-o"></i> Edited:&nbsp;</td>
							    		 	<td id="commentTimestamp" class="commentDate"><@h.formatDateTime "${note.lastUpdatedDate!' '}"/></td>
							    		 </tr>
							    		 <tr>
							    		 	<td class="commentDate"></td>
							    		 	<td class="commentDate"><@h.formatDateTime "${note.creationDate!' '}"/></td>
							    		 </tr>
							    		 <#else>
							    		  <tr>
							    		 	<td class="commentDate"></td>
							    		 	<td id="commentTimestamp" class="commentDate"><i class="fa fa-clock-o"></i> <@h.formatDateTime "${note.creationDate!' '}"/></td>
							    		 </tr>
							    		 </#if>
							    		 </table>
							  		  
							    </div> 
							    <div class="historicalCommentText">
							  	  <pre id="memo">${note.memo!' '}</pre>
							    </div>
							    		<div id="historicalCommentLink">
												<div id="commentActions">
													<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COMMENTS perm="C">
														<@h.replyComment  href="${urlMap['LIST']}?noteId=${note.id?c}&replyInd=true&mode=add"  title="Reply"  />
													</@sec.hasAppFnPerm>
													<#if note.canEditDelete>
														<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COMMENTS perm="U">
											    			<@h.editComment  href="${urlMap['LIST']}?mode=edit&noteId=${note.id?c}"  title="Edit"  />
														</@sec.hasAppFnPerm>
														<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COMMENTS perm="D">
															<@h.deleteComment  href="${urlMap['DELETE']}?noteId=${note.id?c}"  title="Delete"  />
														</@sec.hasAppFnPerm>
													</#if>
												</div>
								</div>
							</#if>
							</div>
							</div>
						</td>
						</tr>
						<tr class="hidden">
							<td valign="top">
							<a href="#" onclick="expandComment(${note.id?c});" alt="expand" title="expand"><i class="fa fa-plus-square-o"></i></a>
							</td>
						<td>
						<div id="closed-historicalComment-${note.id?c}" class="closed-historicalComment">
							<#if odd2>
								<div class="altCommentsBox" >
								<#assign odd2=false>
							<#else>
								<div class="commentsBox" >
								<#assign odd2=true>
							</#if>
							<div id="topLine">
								<span id="commentFrom" class="commentSays" style="width:25%; float:left">From: ${note.authorFullName!' '} (${note.author!' '})</span>
						   		<span id="memo" style="width:35%; float:left"><pre>${note.memoSummary!' '}</pre></span>
						   		<span class="commentDate" style="float:right">
						   		  <#if note.hasLastUpdateDate()>
						  			  <span class="commentDate"><@h.formatDateTime "${note.lastUpdatedDate!' '}"/></span>
						    	<#else>
						    		  <span class="commentDate"><@h.formatDateTime "${note.creationDate!' '}"/></span>
						   		 </#if>
						   		 </span>
						    </div>
						    <div id="historicalCommentLink">
								<span id="planLink" style="width:40%"><#-- Link with Plan: ${note.assocPlanName!'None'} --></span>
								<span id="commentTo" style="width:40%"
						    		 <#if note.isToStudent()> class="commentToStudent" </#if>
						    		 <#if note.isToAdvisors()> class="commentToAdvisors" </#if>
						    		 <#if note.isToPublic()> class="commentToPublic" </#if>
						    		 <#if note.isToPrivate()> class="commentToPrivate"</#if>
						    		 >To ${note.viewableByDisplayText!' '}
						    	</span>
								<div id="commentActions">
									<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COMMENTS perm="C">
										<@h.replyComment  href="${urlMap['LIST']}?noteId=${note.id?c}&replyInd=true&mode=add"  title="Reply"  />
									</@sec.hasAppFnPerm>
									<#if note.canEditDelete>
										<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COMMENTS perm="U">
							    			<@h.editComment  href="${urlMap['LIST']}?mode=edit&noteId=${note.id?c}"  title="Edit"  />
										</@sec.hasAppFnPerm>
										<@sec.hasAppFnPerm appFn=AppFuncRole.SS_AREA_COMMENTS perm="D">
											<@h.deleteComment  href="${urlMap['DELETE']}?noteId=${note.id?c}"  title="Delete"  />
										</@sec.hasAppFnPerm>
									</#if>
								</div>
							</div>
						</div>
						</td></tr>
						</#list>
					</#if>
				</table>
			</div> <#-- /col-md-7 -->
		</div> <#-- /col-md-12 -->
	</div> <#-- /row -->





	

</@layout.body>


<#macro noteForm redirect note>
	<form method="post" action="<@h.url href="${redirect}"/>">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td>From: Me</td>
			</tr>
			<tr>
				<td class="commentOptions">
					<#if currentUser.isAdvisor()>
						<input id="newCommentOptionPrivate"  type="radio" name="newCommentOptionShare" value="PRIVATE" <#if note.isToPrivate()> checked </#if> aria-labelledby="privateLabel"><span id="privateLabel">Private </span>
						<input id="newCommentOptionShare" type="radio" name="newCommentOptionShare" value="SHARE" <#if note.isToPublic() || !note.isToPrivate() || note.isToAdvisors() > checked </#if>  aria-labelledby="shareWithLabel"><span id="shareWithLabel">Share with: </span>
						<input id="newCommentOptionStudent"  type="checkbox" name="newCommentOptionStudent" value="STUDENT" <#if note.isToStudent() || note.isToPublic() > checked </#if> aria-labelledby="toStudentLabel"><span id="toStudentLabel">To: Student </span>
						<input id="newCommentOptionAdvisors" type="checkbox" name="newCommentOptionAdvisors" value="ADVISORS" <#if note.isToAdvisors() || note.isToPublic() > checked </#if> aria-labelledby="toOtherAdvisorsLabel"><span id="toOtherAdvisorsLabel">To: Other Advisors</span>
					<#else>
						<input id="newCommentOptionPrivate" type="radio" name="newCommentOptionShare" value="PRIVATE" <#if note.isToPrivate()> checked </#if>>Private
						<input id="newCommentOptionAdvisors"  type="radio" name="newCommentOptionShare" value="ADVISORS" <#if note.isToAdvisors() || note.isToPublic() > checked </#if>>To: Advisors
					</#if>
				</td>
			</tr>
			<tr>
				<td> &nbsp;</td>
			</tr>
			<tr>
				<td>
					<textarea id="newCommentTextArea" class="form-control" maxlength="500" name="memo" rows="5" cols="100">${note.memo}</textarea>
				</td>
			</tr>
			<tr>
				<td> &nbsp;</td>
			</tr>
			<tr>
				<td align="right" style="padding:3px 5px;"> 
					<#if note.id??>
						<input type="hidden" name="noteId" id="noteId" value="${note.id?c}" />
					</#if>
					<input class="btn btn-primary" type="submit" value="Save">
					&nbsp;
					<a class="btn btn-default" href="<@h.url href='${urlMap["LIST"]}' />">Cancel</a>
				</td>
			</tr>
		</table>
		</form>
</#macro>