<#assign security=JspTaglibs["/WEB-INF/tlds/red-auth.tld"]>


<#macro cancelButton>
	<#assign admin_cancel_url><@spring.url relativeUrl="/admin/admin_menu.html"/></#assign>
	<a href="${admin_cancel_url}" class="btn btn-default">Cancel</a>
</#macro>

<#macro displayErrorsAsList errorList headerText="" container="td" properties="">
	<#if errorList?? && errorList?size gt 0>
		<${container} ${properties} class="ui-state-error ui-corner-all">
			<#if headerText?length gt 0>
				<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<b>${headerText}</b>
				<br/>
			</#if>
			<ul style="margin-left:30px;">
				<#list errorList as error>
					<li>${error}</li>
				</#list>
			</ul>
		</${container}>
	</#if>
</#macro>

<#macro inputRow name label max value="" tooltip=false >
	<div class="form-group">
		<span class="col-sm-3 control-label">${label}
		<#if tooltip>
			<#assign tooltip_img_url><@spring.url relativeUrl="/images/tooltip.gif"/></#assign>
			<br /><a href="http://clients.collegesource.com/home/display/SB/SIS+Course+Formatting"><img src="${tooltip_img_url}" title="CollegeSource Help" alt="CollegeSource help"/></a></td>
		</#if>
		</span>
		<div class="col-sm-9">
			<input type="text" class="form-control"  name="${name}" id="${name}" 
			onKeyDown="limitText(this.form.${name}, ${max});"
			onKeyUp="limitText(this.form.${name}, ${max});" value="${value}"/>
			<font size="1">(Maximum characters: ${max})</font>
		</div>
	</div>
</#macro>

<#macro inputRowAdminCheck name label max value="" tooltip=false >
		<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
	<div class="form-group">
		<span class="col-sm-3 control-label">${label}
		<#if tooltip>
			<#assign tooltip_img_url><@spring.url relativeUrl="/images/tooltip.gif"/></#assign>
			<br /><a href="http://clients.collegesource.com/home/display/SB/SIS+Course+Formatting"><img src="${tooltip_img_url}" title="CollegeSource Help" alt="CollegeSource help"/></a></td>
		</#if>
		</span>
		<div class="col-sm-9">
			<input type="text" class="form-control"  name="${name}" id="${name}" 
			onKeyDown="limitText(this.form.${name}, ${max});"
			onKeyUp="limitText(this.form.${name}, ${max});" value="${value}"/>
			<font size="1">(Maximum characters: ${max})</font>
		</div>
	</div>
	</@security.authorize>
		<@security.authorize ifNoneGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<div class="form-group">
		<span class="col-sm-3 control-label">${label}
		<#if tooltip>
			<#assign tooltip_img_url><@spring.url relativeUrl="/images/tooltip.gif"/></#assign>
			<br /><a href="http://clients.collegesource.com/home/display/SB/SIS+Course+Formatting"><img src="${tooltip_img_url}" title="CollegeSource Help" alt="CollegeSource help"/></a></td>
		</#if>
		</span>
		<div class="col-sm-9">
			<input type="text" class="form-control" disabled   name="${name}" id="${name}" 
			onKeyDown="limitText(this.form.${name}, ${max});"
			onKeyUp="limitText(this.form.${name}, ${max});" value="${value}"/>
			<font size="1">(Maximum characters: ${max})</font>
		</div>
	</div>
	</@security.authorize>
</#macro>

<#macro numericalInputRow name label min max value="" tooltip=false >
	<div class="form-group">
		<span class="col-sm-3 control-label">${label}
		<#if tooltip>
			<#assign tooltip_img_url><@spring.url relativeUrl="/images/tooltip.gif"/></#assign>
			<br /><a href="http://clients.collegesource.com/home/display/SB/SIS+Course+Formatting"><img src="${tooltip_img_url}" title="CollegeSource Help" alt="CollegeSource help"/></a></td>
		</#if>
		</span>
		<div class="col-sm-9">
			<input type="text" class="form-control"  name="${name}" id="${name}" 
			onKeyDown="limitText(this.form.${name}, ${max});"
			onKeyUp="limitText(this.form.${name}, ${max});" value="${value}"/>
			<font size="1">(Choose a number between ${min} and ${max})</font>
		</div>
	</div>
</#macro>

<#macro numericalInputRowAdminCheck name label min max value="" tooltip=false >
		<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
	<div class="form-group">
		<span class="col-sm-3 control-label">${label}
		<#if tooltip>
			<#assign tooltip_img_url><@spring.url relativeUrl="/images/tooltip.gif"/></#assign>
			<br /><a href="http://clients.collegesource.com/home/display/SB/SIS+Course+Formatting"><img src="${tooltip_img_url}" title="CollegeSource Help" alt="CollegeSource help"/></a></td>
		</#if>
		</span>
		<div class="col-sm-9">
			<input type="text" class="form-control" name="${name}" id="${name}" 
			onKeyDown="limitText(this.form.${name}, ${max});"
			onKeyUp="limitText(this.form.${name}, ${max});" value="${value}"/>
			<font size="1">(Choose a number between ${min} and ${max})</font>
		</div>
	</div>
	</@security.authorize>
		<@security.authorize ifNoneGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<div class="form-group">
		<span class="col-sm-3 control-label">${label}
		<#if tooltip>
			<#assign tooltip_img_url><@spring.url relativeUrl="/images/tooltip.gif"/></#assign>
			<br /><a href="http://clients.collegesource.com/home/display/SB/SIS+Course+Formatting"><img src="${tooltip_img_url}" title="CollegeSource Help" alt="CollegeSource help"/></a></td>
		</#if>
		</span>
		<div class="col-sm-9">
			<input type="text" class="form-control"  name="${name}"disabled  id="${name}" 
			onKeyDown="limitText(this.form.${name}, ${max});"
			onKeyUp="limitText(this.form.${name}, ${max});" value="${value}"/>
			<font size="1">(Choose a number between ${min} and ${max})</font>
		</div>
	</div>
	</@security.authorize>
</#macro>

<#macro textareaRow name label max value="" >
	<div class="form-group">
		<span class="col-sm-3 control-label">${label}</span>
		<div class="col-sm-9">
		<textarea class="form-control"  name="${name}" 
		onKeyDown="limitText(this.form.${name}, ${max});"
		onKeyUp="limitText(this.form.${name}, ${max});">${value}</textarea>
		<font size="1">(Maximum characters: ${max})</font>
		</div>
	</div>
</#macro>

<#macro textareaRowAdminCheck name label max value="" >
		<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
	<div class="form-group">
		<span class="col-sm-3 control-label">${label}</span>
		<div class="col-sm-9">
		<textarea class="form-control"  name="${name}" 
		onKeyDown="limitText(this.form.${name}, ${max});"
		onKeyUp="limitText(this.form.${name}, ${max});">${value}</textarea>
		<font size="1">(Maximum characters: ${max})</font>
		</div>
	</div>
	</@security.authorize>
		<@security.authorize ifNoneGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
	<div class="form-group">
		<span class="col-sm-3 control-label">${label}</span>
		<div class="col-sm-9">
		<textarea class="form-control" disabled name="${name}" 
		onKeyDown="limitText(this.form.${name}, ${max});"
		onKeyUp="limitText(this.form.${name}, ${max});">${value}</textarea>
		<font size="1">(Maximum characters: ${max})</font>
		</div>
	</div>
	</@security.authorize>
	
</#macro>

<#macro booleanRadioRow name label value="" >
		<div class="form-group">
				<span class="col-sm-3 control-label">${label}</span>
			<div class="col-sm-9">
				<input type="radio" name="${name}"   value="T" <#if value == "T"> checked</#if>/>T
		    	<input type="radio" name="${name}" value="F" <#if value == "F"> checked</#if> />F 
		    </div>
		</div>
</#macro>

<#macro booleanRadioRowAdminCheck name label value="" >
		<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<div class="form-group">
				<span class="col-sm-3 control-label">${label}</span>
			<div class="col-sm-9">
				<input type="radio" name="${name}"   value="T" <#if value == "T"> checked</#if>/>T
		    	<input type="radio" name="${name}" value="F" <#if value == "F"> checked</#if> />F 
		    </div>
		</div>
	</@security.authorize>
		<@security.authorize ifNoneGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<div class="form-group">
				<span class="col-sm-3 control-label">${label}</span>
			<div class="col-sm-9">
				<input type="radio" name="${name}"   value="T"  disabled <#if value == "T"> checked</#if>/>T
		    	<input type="radio" name="${name}" value="F"  disabled <#if value == "F"> checked</#if> />F 
		    </div>
		</div>
	</@security.authorize>

</#macro>

<#macro checkBox name label value="" checked=false >
		<div class="form-group">
				<span class="col-sm-3 control-label">${label}</span>
			<div class="col-sm-9">
				<input type="checkbox" name="${name}"  value="${value}" <#if checked == "true"> checked</#if>/>
		    </div>
		</div>
</#macro>

<#macro checkBoxAdminCheck name label value="" checked=false >
		<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<div class="form-group">
				<span class="col-sm-3 control-label">${label}</span>
			<div class="col-sm-9">
				<input type="checkbox" name="${name}"  value="${value}" <#if checked == "true"> checked</#if>/>
		    </div>
		</div>
	</@security.authorize>
		<@security.authorize ifNoneGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
			<div class="form-group">
				<span class="col-sm-3 control-label">${label}</span>
			<div class="col-sm-9">
				<input type="checkbox" name="${name}" disabled  value="${value}" <#if checked == "true"> checked</#if>/>
		    </div>
		</div>
	</@security.authorize>
</#macro>

<#macro submitButtons >
	<div class="form-group">	
		<div class="col-sm-offset-1 col-sm-10">
		<button type="submit" class="btn btn-primary">Save changes</button>
		<@d.cancelButton />
		</div>
	</div>
</#macro>

<#macro ctlcdConfigsRows action ruflag pseudo force delig id label ctlcd="" note="" memo="" >
	
	<h3>${label}</h3>
	<p> <span style="font-style:italic;">We recommend that you enter your control code that matches the following settings: </span>
	<br>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Action: ${action}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">RU Flag: ${ruflag}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Pseudo: ${pseudo}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Force: ${force}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Delig: ${delig}</span>
	</p>
	
	
	
	<@d.inputRow name="${id}Ctlcd" label="Ctlcd" max="2" value=ctlcd />
	<@d.inputRow name="${id}Note" label="Note" max="27" value=note />
	<@d.textareaRow name="${id}Memo" label="Memo" max="255" value=memo />
</#macro>

<#macro ctlcdConfigsRows action ruflag pseudo force delig id label ctlcd="" note="" memo="" >
	
	<h3>${label}</h3>
	<p> <span style="font-style:italic;">We recommend that you enter your control code that matches the following settings: </span>
	<br>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Action: ${action}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">RU Flag: ${ruflag}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Pseudo: ${pseudo}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Force: ${force}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Delig: ${delig}</span>
	</p>
	
	
	
	<@d.inputRow name="${id}Ctlcd" label="Ctlcd" max="2" value=ctlcd />
	<@d.inputRow name="${id}Note" label="Note" max="27" value=note />
	<@d.textareaRow name="${id}Memo" label="Memo" max="255" value=memo />
</#macro>

<#macro ctlcdConfigsRowsAdminCheck action ruflag pseudo force delig id label ctlcd="" note="" memo="" >
	
	<h3>${label}</h3>
	<p> <span style="font-style:italic;">We recommend that you enter your control code that matches the following settings: </span>
	<br>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Action: ${action}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">RU Flag: ${ruflag}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Pseudo: ${pseudo}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Force: ${force}</span>
	<span class="label label-default" style="font-size:85%;background-color: #595959;">Delig: ${delig}</span>
	</p>
	
	
	<@security.authorize ifAnyGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<@d.inputRow name="${id}Ctlcd" label="Ctlcd" max="2" value=ctlcd />
		<@d.inputRow name="${id}Note" label="Note" max="27" value=note />
		<@d.textareaRow name="${id}Memo" label="Memo" max="255" value=memo />
	</@security.authorize>
	<@security.authorize ifNoneGranted="SS_AREA_ADMIN=u, SB_ADMIN_EDIT=u, UDIR_Admin=u  ">
		<@d.inputRowAdminCheck name="${id}Ctlcd" label="Ctlcd" max="2" value=ctlcd />
		<@d.inputRowAdminCheck name="${id}Note" label="Note" max="27" value=note />
		<@d.textareaRowAdminCheck name="${id}Memo" label="Memo" max="255" value=memo />
	</@security.authorize>
	
</#macro>
<#macro cronTable>
<div id="cronHelp">
Values should be used in order separated by a space.  
Click <a href="https://clients.collegesource.com/home/display/SB/Course+Search">CollegeSource's documentation</a> for more help.
<br /><br />
<table class="admin-table cronHelp">
<thead>
<tr>
<th width="100px"> Name </th>
<th width="100px" > Mandatory </th>
<th > Allowed values </th>
<th > Special Chars </th>
</tr>
</thead>
<tbody>
<tr>
<td> Seconds </td>
<td> YES </td>
<td> 0-59 </td>
<td> , - * / </td>
</tr>
<tr>
<td> Minutes </td>
<td> YES </td>
<td> 0-59 </td>
<td> , - * / </td>
</tr>
<tr>
<td> Hours </td>
<td> YES </td>
<td> 0-23 </td>
<td> , - * / </td>
</tr>
<tr>
<td> Day of month </td>
<td> YES </td>
<td> 1-31 </td>
<td> , - * ? / L W </td>
</tr>
<tr>
<td> Month </td>
<td> YES </td>
<td> 1-12 or JAN-DEC </td>
<td> , - * / </td>
</tr>
<tr>
<td> Day of week </td>
<td> YES </td>
<td> 1-7 or SUN-SAT </td>
<td> , - * ? / L # </td>
</tr>
<tr>
<td> Year </td>
<td> NO </td>
<td> empty, 1970-2099 </td>
<td> , - * / </td>
</tr>
</tbody></table>
</div>

</#macro>

<#macro showIndexBuilt status>

	<#if status="true">
		<font color="00B836">Yes</font>
	<#else>
		No
	</#if>

</#macro>

<#macro showIndexStatus status>

	<#if status="Building...">
		<font color="D4A145">${status}</font>
	<#elseif status="Failed">
		<font color="9F1313">${status}</font>
	<#else>
		${status}
	</#if>

</#macro>