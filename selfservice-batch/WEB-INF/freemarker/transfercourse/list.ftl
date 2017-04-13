<@layout.head title="${pageContext.page.label}s" />

<@layout.body>
	<input type="hidden" id="pageGroup" value="courses"/>
<input type="hidden" id="mobilePageGroup" value="transferCourses"/>
	<h1 class="cleared"><@s.message 'uachieve.selfservice.transfercourse.list.header'/></h1>
	<p><@s.message 'uachieve.selfservice.transfercourse.list.text'/></p>
	<@p.masterViewAfterAddButton>
		<br />
		<br />
		<#if canRunEval>
		<@h.buttonAsLink src="" 
			href="/transfereval/runarticulation.html?transferArticulation=true" 
			title="Run Transfer Evaluation" />
		</#if>
	</@p.masterViewAfterAddButton>
	
	<@p.masterView ctx=pageContext addButton="Add Transfer Course" />
</@layout.body>

