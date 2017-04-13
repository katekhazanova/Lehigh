<@layout.head title="Create ${pageContext.page.label}" />

<@layout.body>
<input type="hidden" id="pageGroup" value="students"/>
<input type="hidden" id="mobilePageGroup" value="addstudent"/>
	<div class="row">
		<div class="col-md-12">
			<@p.detailView pageContext />
		</div> <#-- /col-md-12 -->
	</div> <#-- /row -->

<#if uppercaseStuno>
	<input type="hidden" id="uppercaseStuno" value="true"/>
<#else>
	<input type="hidden" id="uppercaseStuno" value="false"/>
</#if>	
</@layout.body>