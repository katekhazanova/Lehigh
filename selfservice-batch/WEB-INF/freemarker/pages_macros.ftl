<#assign form=JspTaglibs["/WEB-INF/tld/spring-form.tld"] />

<#macro detailView ctx includeFormTag=true saveButton="" cancelText="Cancel">
	${_detailViewBeforeHeader!""}
	<#if ctx.displayPageHeader>
		<#if ctx.readOnly>
			<h1>${ctx.label} Details</h1>
		<#elseif ctx.editing>
			<h1>Edit ${ctx.label}</h1>
		<#else>
			<h1>Add ${ctx.label}</h1>
		</#if>
	</#if>

	<#if validationErrors?? && validationErrors>
		<p class="alert alert-danger" role="alert" tabindex="0">There were errors - please fix them and try again.</p>
		<!--<#if errors??>${errors}</#if>-->
	</#if>
	
	${_detailViewBeforeForm!""}
	<#if includeFormTag>
		<@form.form commandName="row" cssClass="focusable">
			<@printFormContents ctx includeFormTag saveButton cancelText />
			${_detailViewInsideForm!""}
		</@form.form>
	<#else>
		<@printFormContents ctx includeFormTag saveButton cancelText />
	</#if>
	${_detailViewAfterForm!""}
</#macro>

<#macro detailViewWithHeaderClass ctx includeFormTag=true headerClass="" saveButton="" cancelText="Cancel">
	${_detailViewBeforeHeader!""}
	<#if ctx.displayPageHeader>
		<#if ctx.readOnly>
			<span class="${headerClass}">${ctx.label} Details</span>
		<#elseif ctx.editing>
			<span class="${headerClass}">Edit ${ctx.label}</span>
		<#else>
			<span class="${headerClass}">Add ${ctx.label}</span>
		</#if>
	</#if>

	<#if validationErrors?? && validationErrors>
		<p class="alert alert-danger" role="alert" tabindex="0">There were errors - please fix them and try again.</p>
		<!--<#if errors??>${errors}</#if>-->
	</#if>
	
	${_detailViewBeforeForm!""}
	<#if includeFormTag>
		<@form.form commandName="row" cssClass="focusable">
			<@printFormContents ctx includeFormTag saveButton cancelText />
			${_detailViewInsideForm!""}
		</@form.form>
	<#else>
		<@printFormContents ctx includeFormTag saveButton cancelText />
	</#if>
	${_detailViewAfterForm!""}
</#macro>

<#--assign saveButton="/images/bt_save.gif" /-->
<#-- prints out a form containing a row -->
<#macro printFormContents ctx includeFormTag saveButton cancelText>
		<table class="verticalListing">
			<#list ctx.page.columns as column>
				<@printColumn column ctx />
			</#list>
			${_detailViewBeforeButtons!""}
			<#if includeFormTag>
				<tr>
					<td class="pages-savebar">&nbsp;</td>
					<td colspan="3">
						<#if ctx.readOnly>
							<a class="btn btn-default" role="button" alt="Done" title="Done" href="<@h.url href=ctx.listUrl />"> Done </a>
							<#if ctx.canEdit(ctx.page, ctx.row)>
								<span class="subtle">|</span>
								
								<a class="btn btn-primary" role="button" alt="Update" title="Update" href="<@h.url href=ctx.editUrl />?id=${ctx.getId(ctx.row)}"> Update </a>
							</#if>
						<#else>
							${_detailViewBeforeSaveButton!""}
							<#if saveButton != "">
								<input class="btn btn-primary" type="submit" alt="${saveButton}" title="${saveButton}" value="${saveButton}" />
							<#else>
								<input class="btn btn-primary" type="submit" alt="Save ${ctx.label}" title="Save ${ctx.label}" value="Save ${ctx.label}" />
							</#if>
							<#if ctx.displayCancel>
								<a class="btn btn-default" role="button" alt="${cancelText}" title="${cancelText}" href="<@h.url href=ctx.cancelUrl />"> ${cancelText} </a>
								
							</#if>
						</#if>
					</td>
				</tr>
			</#if>
		</table>
		
		<#-- only show id parameter if editing an existing row -->
		<#if ctx.editing>
			<input type="hidden" name="id" value="${ctx.getId(ctx.row)}" />
		</#if>
</#macro>

<#-- prints an input field for an individual column from a row -->
<#-- TODO all of these if thens should be in a column renderer or two -->
<#macro printColumn column, ctx>
	<#local columnEditable = false />
	<#if ctx.editing && ctx.canEdit(column.columnDetailView, column)>
		<#local columnEditable = true />
	<#elseif (!ctx.editing && !ctx.readOnly) && ctx.canCreate(column.columnDetailView, column) >
		<#local columnEditable = true />
	</#if>
	
				<#if ctx.canRead(column.columnDetailView)>
					<tr <#if column.columnDetailView.inputType == "hidden">class="hidden"</#if>>
						<th>${column.label}</th>
						<td class="content">
							<#if column.derived>
								${ctx.render(ctx.row, column)}
							<#--elseif ctx.canEdit(column.columnDetailView, column) && !ctx.readOnly-->
							<#elseif columnEditable>
								<#if column.columnDetailView.inputType == "text">
									<input class="form-control" <#if column.columnDetailView.maxLength gt 0>maxlength="${column.columnDetailView.maxLength}"</#if> type="text" name="${column.name}" id="${column.name}" value="${ctx.renderPlain(ctx.row, column)}" />
								<#elseif column.columnDetailView.inputType == "textarea">
									<textarea class="form-control" name="${column.name}" id="${column.name}">${ctx.renderPlain(ctx.row, column)}</textarea>
								<#elseif column.columnDetailView.inputType == "menu">
									<select class="form-control" name="${column.name}" id="${column.name}" >
										<#list ctx.getOptions(column.columnDetailView.options) as option>
											<option value="${option.name}" <#if ctx.renderPlain(ctx.row, column) == option.name>selected="selected"</#if>>${option.label}</option>
										</#list>
									</select>
								<#elseif column.columnDetailView.inputType == "checkbox">
									<#local trueValue = ctx.getCheckboxMapping(column.columnDetailView.checkboxMapping).trueValue />
									<#local falseValue = ctx.getCheckboxMapping(column.columnDetailView.checkboxMapping).falseValue />
									<input type="checkbox" name="${column.name}" id="${column.name}" <#if ctx.renderPlain(ctx.row, column) == trueValue>checked="true" </#if> value="${trueValue}" />
									<input type="hidden" name="${column.name}" id="${column.name}" <#if ctx.renderPlain(ctx.row, column) != trueValue>value="${falseValue}"</#if> />
								<#elseif column.columnDetailView.inputType == "hidden">
									<input type="hidden" name="${column.name}" id="${column.name}" value="${ctx.renderPlain(ctx.row, column)}" />
								</#if>
							<#else>
								${ctx.render(ctx.row, column)}
							</#if>
						</td>
						<td>
							<#if column.description??>
								<@help.tooltip topic=column.name text=column.description />
							<#else>
								&nbsp;
							</#if>
						</td>
						<td>
							<@form.errors path=column.name element="div" cssClass="alert alert-danger" />
						</td>
					</tr>
				</#if>
</#macro>

<#macro masterView ctx plural="" deleteButton="" deleteHeader="" addButton="">
	<#local pluralLabel = plural>
	<#if pluralLabel?length == 0>
		<#local pluralLabel>${ctx.label?lower_case}s</#local>
	</#if>

	<#-- ========== STATUS MESSAGES ============== -->
	<#if flash["${ctx.page.name}.rowsDeleted"]??>
	
		<#if ctx.page.name != "ScheduledJob">
			<p class="alert alert-success"><strong>${flash["${ctx.page.name}.rowsDeleted"]}</strong> ${ctx.label?lower_case}<#if flash["${ctx.page.name}.rowsDeleted"] != 1>s were<#else> was</#if> deleted.</p>
		<#else>
			<p class="alert alert-success"><strong>${flash["${ctx.page.name}.rowsDeleted"]}</strong> ${ctx.label?lower_case}<#if flash["${ctx.page.name}.rowsDeleted"] != 1>s were<#else> was</#if> unscheduled.</p>
		</#if>
	</#if>

	<#if flash["${ctx.page.name}.rowsAdded"]??>
		<p class="alert alert-success"><strong>${flash["${ctx.page.name}.rowsAdded"]}</strong> ${ctx.label?lower_case}<#if flash["${ctx.page.name}.rowsAdded"] != 1>s were<#else> was</#if> added.</p>
	</#if>

	<#if flash["${ctx.page.name}.rowsEdited"]??>
		<p class="alert alert-success"><strong>${flash["${ctx.page.name}.rowsEdited"]}</strong> ${ctx.label?lower_case}<#if flash["${ctx.page.name}.rowsEdited"] != 1>s were<#else> was</#if> updated.</p>
	</#if>


	<#if ctx.displayMenuOptions>

		<form method="get" action="">
	
			<#-- ========== HIDDEN SORT OPTIONS ============== -->
			<input type="hidden" name="sort.propertyName" value="${ctx.currentlySortingOn()}" />
			<input type="hidden" name="sort.asc" value="${ctx.isAscendingSort()?string}" />
			
			<#-- ========== HIDDEN EXTRA QUERY PARAMS ============== -->
			<#assign originalQueryParamsNames = ctx.originalQueryParams?keys />
			<#list originalQueryParamsNames as name>
				<input type="hidden" name="${name}" value="${ctx.originalQueryParams[name]}" />
			</#list>
	
			<#-- ========== ADD BUTTONS ============== -->
			<div class="floatleft onequarter">
				<p>
					${_masterViewBeforeAddButton!""}
					<#if ctx.canCreate(ctx.page)>
						<#if addButton != "">
							<@h.buttonAsLink 
								src="" 
								href="${ctx.createUrl}" 
								title="${addButton}" 
								class=""
								onclick=""
								id="pageAddButton"
							/>
						<#else>
							<@h.buttonAsLink 
								src="" 
								href="${ctx.createUrl}" 
								title="Add ${ctx.label}" 
								class=""
								onclick=""
								id="pageAddButton"
							/>
						</#if>
					<#else>
						&nbsp;
					</#if>
					${_masterViewAfterAddButton!""}
				</p>
			</div>
	
			<#-- ========== PAGER CONTROLS ============ -->
			<#--
			<div class="floatleft onequarter aligncenter">
				<p>pager control</p>
				
				// paging
			        int currentPage = ServletRequestUtils.getIntParameter(req, "currentPage", 1);
			        mav.addObject("currentPage", currentPage);
			        mav.addObject("pages", getPageCount(courses));
			        // actually page the results now...
				
				    /** Returns the number of pages based on course count. */
			    public int getPageCount(List courses) {
			        if (courses.isEmpty()) {
			            return 1;
			        }
			
			        return (int) Math.ceil((double) courses.size() / defaultPageSize);
			    }
				
				
						<p>
							Page: ${currentPage} of
							<select name="currentPage" id="currentPage" size="1">
								<#list 1..pages as i>
									<option value="${i}" <#if ! i_has_next>selected="selected"</#if>>${i}</option>
								</#list>
							</select>
							<input class="image" type="image" src="<@h.url href="/images/arrow_next.gif" />" alt="Go" />
						</p>
				
			</div>
			-->
	
			<#-- ========== FILTER CONTROLS ============ -->
			<div class="inline onehalf aligncenter">
				<span>
					<#if ctx.hasFilters()>
						Filter by:
	
						<#list ctx.filters as filter>
							<select class="filter" name="filter.${filter.on}" id="filter.${filter.on}" size="1">
								<option value="">${filter.label}</option>
								<#list ctx.getFilterRecords(filter) as filterRecord>
									<option value="${filterRecord.key}" <#if ctx.getFilterValueFor(filter.on) == filterRecord.key>selected="selected"</#if>>(${filterRecord.count}) ${filterRecord.display}</option>
								</#list>
							</select>
						</#list>
						<button class="btn btn-primary btn-xs" type="submit" alt="Go" title="Go" style="padding: 0px; height: 18px; margin-bottom: 3px;" >
							<i class="fa fa-caret-right fa-fw"><span class="sr-only">Submit filter</span></i>
						</button>
					</#if>
				</span>
			</div>
	
	
		</form>

	</#if><#-- endif ctx.displayMenuOptions -->


	<#-- ================ DELETE BUTTON & FORM ============= -->
	<#if ctx.displayMenuOptions>
		<#if ctx.canDelete(ctx.page) || (ctx.page.subPage?? && ctx.canDelete(ctx.page.subPage))>
			<form action="<@h.url href=ctx.deleteUrl />" method="post" id="pageMasterViewDeleteForm">
				
				<#-- ========== HIDDEN SORT OPTIONS ============== -->
				<input type="hidden" name="sort.propertyName" value="${ctx.currentlySortingOn()}" />
				<input type="hidden" name="sort.asc" value="${ctx.isAscendingSort()?string}" />
			
				<div class="floatright onequarter alignright">
					<p>
						${_masterViewBeforeDeleteButton!""}
							<#if deleteButton != "">
								<@h.submit src='' title='${deleteButton}' />
							<#else>
								<@h.submit src='' title='Delete' />
							</#if>
						<br>
                        <span id="delete-select-all">select all/select none</span>
					</p>
				</div>
		</#if>
		${_masterViewAfterDeleteButton!""}
	</#if>
	
	<#-- ============= MASTER LIST START ============== -->

	<#-- determine if group headers should be displayed -->
	<#if ctx.hasGroupBy()>
		<#assign useGroupByHeaders = true />
	<#else>
		<#assign useGroupByHeaders = false />
	</#if>
	<div class="cleared tableContainer">
	<table class="table table-striped table-bordered table-hover cleared resultList">
		<tr>
			<#-- ============= COLUMN HEADERS ============== -->
			
			<#--if useGroupByHeaders>
				<th style="width:3%;">&nbsp;</th>
			</#if-->
			
			<#list ctx.page.columns as column>
				<#if ctx.canRead(column.columnMasterView)>
					<#local width = "" />
					<#if column.percentWidth??>
						<#local width = "width:" + column.percentWidth + "%;" />
					</#if>
					
					<th role="columnheader" style="text-align: ${column.align};${width}">
						<#-- ============= SORTING ============== -->
						<#if ctx.isSortable(column)>
							<#if ctx.isSortingOn(column)>
								<i class="fa fa-caret-${ctx.isAscendingSort()?string('up', 'down')}" aria-sort="${ctx.isAscendingSort()?string('ascending', 'descending')}" aria-hidden="true" ></i>
								<a href="?${ctx.getFiltersQuery()}&sort.propertyName=${column.name}&sort.asc=${(!ctx.isAscendingSort())?string}${ctx.originalQuery}" title="sorted ${ctx.isAscendingSort()?string('ascending', 'descending')}">${column.label}</a>
							<#else>
								<a href="?${ctx.getFiltersQuery()}&sort.propertyName=${column.name}${ctx.originalQuery}" title="Click to sort">${column.label}</a>
							</#if>
						<#else>
							${column.label}
						</#if>
					</th>
				</#if>
	    	</#list>
	    	<#if ctx.canEdit(ctx.page)>
	    		<th class="pages-op">Edit</th>
	    	</#if>
	    	<#if ctx.canDelete(ctx.page)>
	    		<#if deleteHeader != "">
	    			<th class="pages-op">${deleteHeader}</th>
	    		<#else>
	    			<th class="pages-op">Delete</th>
	    		</#if>
	    	</#if>
	    	
	    	<#-- ============= SUB PAGE COLUMN HEADERS ============= -->
	    	<#if ctx.page.subPage??>
		    	<#list ctx.page.subPage.columns as column>
					<#if ctx.canRead(column.columnMasterView)>
						<#local width = "" />
						<#if column.percentWidth??>
							<#local width = "width:" + column.percentWidth + "%;" />
						</#if>
						<th style="text-align: ${column.align};${width}">
							${column.label}
						</th>
					</#if>
		    	</#list>
		    	<#if ctx.canEdit(ctx.page.subPage)>
		    		<th class="pages-op">Edit</th>
		    	</#if>
		    	<#if ctx.canDelete(ctx.page.subPage)>
		    		<th class="pages-op">Del</th>
		    	</#if>
	    	</#if>
	    </tr>
	    
		<#-- ============= GROUPS/ROWS ============== -->
		
		<#list ctx.groups as group>
		<#assign isFirstRow = (group_index == 0) />
			<#if useGroupByHeaders>
				<tr class="groupByHeader">
					<td class="title" colspan="${ctx.getTotalColumnCount(ctx.page) + 1}">
						<@h.fa class="rowGroupToggleImage fa fa-caret-square-o-down fa-lg" id="${group.commonValue}RowGroupToggleImageOpen" title="" />
						<script>
						document.write('<@h.fa class="rowGroupToggleImage fa fa-caret-square-o-right fa-lg" id="${group.commonValue}RowGroupToggleImageClose" title="" />');
						</script>
						${ctx.renderRowGroupHeader(group)}
					</td>
				</tr>
				
			</#if>
			<#if useGroupByHeaders>
<tbody id="${group.commonValue}RowGroup" class="rowGroup">
</#if>
			<#list group.rows as row>
			    
		    	<#-- a LIST of subrows - must contain at least one item so that the main parent row can be rendered -->
				<#assign subRows = [false] />
				<#-- does this row have any subrows -->
				<#assign hasSubRows = false />
				
				<#-- does this page have a sub page AND does the subpage have any rows -->
				<#if ctx.page.subPage?? && row[ctx.page.subPage.property]?? && row[ctx.page.subPage.property]?size gt 0>
		    		<#assign subRows = row[ctx.page.subPage.property] />
		    		<#assign hasSubRows = true />
		    	</#if>
		    	
		    	<#-- loop through every subrow - will either be the default sequence [false] or the actual subrows if there are any -->
		    	<#list subRows as subRow>
		    	
		    		
					<#assign isFirstSubRow = (subRow_index == 0) />
	    		
	    			<#-- for zebra striping -->
	    			<#if row_index % 2 == 0>	<#assign zebra = 'even' />
	    			<#else>						<#assign zebra = 'odd' />
					</#if>
	    		    
			    	<tr class="${zebra}">
						<#-- ============= COLUMN VALUES ============== -->
						<#--if useGroupByHeaders>
							<td>&nbsp;</td>
						</#if-->
			    		<#list ctx.page.columns as column>
		    				<#if ctx.canRead(column.columnMasterView)>
			    				<td style="text-align: ${column.align};">
			    					<#if ctx.canRead(row,column)>
				    					<#if isFirstSubRow>
					    					<#if column.linkable><a href="<@h.url href="${ctx.readUrl}?id=${ctx.getId(row)}" />"></#if>
					    					${ctx.render(row, column)}
					    					<#if column.linkable></a></#if>
					    				<#else>
					    					&nbsp;
					    				</#if>
				    				</#if>
				    			</td>
			    			</#if>
			    		</#list>
			    		<#if ctx.canEdit(ctx.page)>
			    			<td>
			    				${ctx.renderEdit(ctx.page, row)}
							</td>
						</#if>
						<#if ctx.canDelete(ctx.page)>
			    			<td>
			    				${ctx.renderDelete(ctx.page, row)}
				    		</td>
			    		</#if>
						
						
						<#-- ============= SUB PAGE COLUMN VALUES ============= -->
			    		<#if ctx.page.subPage??>
			    			
			    			
	
			    			
			    			<#if !hasSubRows>
								<td colspan="${ctx.getColumnCount(ctx.page.subPage.page)}" style="text-align: left">
							    	<#if ctx.canCreate(ctx.page.subPage.page, row)>
										<a href="<@h.url href="${ctx.subPageCreateUrl}"/>?parentId=${ctx.getId(row)}">Add ${ctx.page.subPage.page.label}</a>
									<#else>
										&nbsp;
									</#if>
								</td>
							<#else>
			    				<#list ctx.page.subPage.columns as subColumn>
			    					<#if ctx.canRead(subColumn.columnMasterView)>
			    						<td style="text-align: ${subColumn.align};">
			    							<#if ctx.canRead(subRow,subColumn)>
						    					<#if subColumn.linkable><a href="<@h.url href="${ctx.readUrl}?id=${ctx.getId(subRow)}" />"></#if>
						    					${ctx.render(subRow, subColumn)}
						    					<#if subColumn.linkable></a></#if>
					    					</#if>
						    			</td>
					    			 </#if>
					    		</#list>
					    		
					    		
					    			<#if ctx.canEdit(ctx.page.subPage)>
					    			<td>
					    			    <#if ctx.canEdit(ctx.page.subPage, subRow)>
										<a href="<@h.url href="${ctx.editUrl}?id=${ctx.getId(subRow)}" />">
											<i class="fa fa-edit" title="Edit"></i>
										</a>
										<#else>
											&nbsp;
							    		</#if>
									</td>
					    			</#if>
					    		
					    		
									<#if ctx.canDelete(ctx.page.subPage)>
									<td>
					    				<#if ctx.canDelete(ctx.page.subPage, subRow)>
				    						<input type="checkbox" name="delete_id" value="${ctx.getId(subRow)}" />
				    					<#else>
				    						&nbsp;
				    					</#if>
				    				</td>
									</#if>
								
			    			</#if>
	
	
						</#if>
						
					</tr>
				</#list>
	
				<#-- ===== ADD NEW SUBROW BUTTON ===== -->
				<#if hasSubRows>
					<tr class="${zebra}">
						<#if useGroupByHeaders>
							<td>&nbsp;</td>
						</#if>
						<#if ctx.page.subPage.page.label=="Target Course">
							<td colspan="${ctx.getColumnCount(ctx.page)+2}">&nbsp;</td>
						<#else>
							<td colspan="${ctx.getColumnCount(ctx.page)}">&nbsp;</td>
						</#if>
						<#if ctx.page.subPage.page.label=="Target Course">
							<td colspan="${ctx.getColumnCount(ctx.page.subPage.page)-2}" style="text-align: left">
						<#else>
							<td colspan="${ctx.getColumnCount(ctx.page.subPage.page)}" style="text-align: left">
						</#if>
					    	<#if ctx.canCreate(ctx.page.subPage.page, row)>
								<a href="<@h.url href="${ctx.subPageCreateUrl}"/>?parentId=${ctx.getId(row)}">Add ${ctx.page.subPage.page.label}</a>
							<#else>
								&nbsp;
							</#if>
						</td>
					</tr>
				</#if>
	
			</#list> <#-- end list group.rows -->
			<#if useGroupByHeaders>
</tbody>
</#if>
		</#list> <#-- end list groups -->
	    
		${_masterViewOnTableEnd!""}
	    
	</table>
	</div>
	
	
	<#-- ============= NO DATA FOUND ============== -->
	<#if ctx.groups?size == 0 || (ctx.groups?size == 1 && ctx.groups[0].rows?size == 0)>
		<p class="alert alert-warning">No ${pluralLabel} found</p>
	</#if>

	<#if ctx.displayMenuOptions>
		<#if ctx.canDelete(ctx.page)>
			</form>
		</#if>
	</#if>
	
	
	<#-- ============= TOGGLE GROUPS ============== -->
	<#-- 
	<#if useGroupByHeaders>
		<script type="text/javascript">
			selfservice.pages.enableGroupByTogglers();
		</script>
	</#if>
	-->
	
</#macro>

<#-- run this macro before calling <@p.masterView pageContext /> and anything 
	inside this macro will be included right before the add button at the top of the master list
	
	here's an example of using it:
	
	<@p.masterViewBeforeAddButton>
		You'll see this to the left of the Add button
	</@p.masterViewBeforeAddButton>

 -->
<#macro masterViewBeforeAddButton>
	<#assign _masterViewBeforeAddButton><#nested /></#assign>
</#macro>

<#macro masterViewAfterAddButton>
	<#assign _masterViewAfterAddButton><#nested /></#assign>
</#macro>
<#-- run this macro before calling <@p.masterView pageContext /> and anything 
	inside this macro will be included right before the delete button at the top of the master list
	
	here's an example of using it:
	
	<@p.masterViewBeforeDeleteButton>
		<input class="image" type="image" name="pages.editAll" src="<@h.url href="/images/bt_save.gif" />" alt="Save Changes" />
	</@p.masterViewBeforeDeleteButton>

 -->
<#macro masterViewBeforeDeleteButton>
	<#assign _masterViewBeforeDeleteButton><#nested /></#assign>
</#macro>

<#-- run this macro before calling <@p.masterView pageContext /> and anything 
	inside this macro will be included before the end of the table in the master list
	
	here's an example of using it:
	
	<@p.masterViewOnTableEnd>
		<tr>
			<td colspan="${pageContext.getColumnCount(pageContext.page)}">
				<input name="defaultDegreeProgram" type="radio" value="__ALL__" id="defaultDegreeProgram_ALL" checked="true" /> <label for="defaultDegreeProgram_ALL">All</label>
			</td>
		</tr>
	</@p.masterViewOnTableEnd>

 -->
<#macro masterViewOnTableEnd>
	<#assign _masterViewOnTableEnd><#nested /></#assign>
</#macro>

<#macro detailViewBeforeButtons>
	<#assign _detailViewBeforeButtons><#nested /></#assign>
</#macro>

<#macro detailViewBeforeForm>
	<#assign _detailViewBeforeForm><#nested /></#assign>
</#macro>

<#macro detailViewBeforeHeader>
	<#assign _detailViewBeforeHeader><#nested /></#assign>
</#macro>

<#macro masterViewAfterDeleteButton>
	<#assign _masterViewAfterDeleteButton><#nested /></#assign>
</#macro>

<#macro detailViewBeforeSaveButton>
	<#assign _detailViewBeforeSaveButton><#nested /></#assign>
</#macro>

<#macro detailViewAfterForm>
	<#assign _detailViewAfterForm><#nested /></#assign>
</#macro>

<#macro detailViewInsideForm>
	<#assign _detailViewInsideForm><#nested /></#assign>
</#macro>