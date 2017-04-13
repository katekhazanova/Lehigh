<#macro batchTabs step>
		
			<#if (step != 0)>
				<ul class="nav nav-tabs">
					<li <#if (step == 1)>class="active"</#if>>
						<a href="<@h.url href='/batch/batch_redirect.html' />">
							1. Description <#if (step == 1)><span class="sr-only">tab selected</span></#if>
						</a>
					</li>
					<li <#if (step == 2)>class="active"</#if>> 
						<a href="<@h.url href='/batch/criteria.html' />">
							2. Criteria <#if (step == 2)><span class="sr-only">tab selected</span></#if>
						</a>
					</li>
					<li <#if (step == 3)>class="active"</#if>>
						<a href="#" onclick="checkBatch()">
							3. Schedule <#if (step == 3)><span class="sr-only">tab selected</span></#if>
						</a>
					</li>
					<li <#if (step == 4)>class="active"</#if>>
						<a href="<@h.url href='/batch/share.html' />">
							4. Share <#if (step == 4)><span class="sr-only">tab selected</span></#if>
						</a>
					</li>
				</ul>
			
			
		 
				<br/>
			</#if>
		
		
		<input type="hidden" id="contextPath" value="${springMacroRequestContext.getContextPath()}" />
</#macro>