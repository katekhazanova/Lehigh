<#-- adds a help tooltip to a page.  the tooltip will display an inline popup of the help file when moused over, and will open a new browser window 
containing the help topic when clicked.  the entire topic is also printed out inline in the page but is hidden using css, but users without css
(like a screenreader) will see the help topic inline in the page. -->
<#macro tooltip text="" topic="">
	<div class="help">
		<#assign title = "Help" />
		
		<#if topic = "auditresults">
			<a href="#" data-toggle="modal" data-target="#auditresultsModal" aria-haspopup="true" title = "Help for audit results">
		<#elseif topic != "">
			<#assign title = "Help for ${getTopicName(topic)}" />
			<a href="#" data-toggle="modal" data-target="#${getTopicName(topic)}Modal" aria-haspopup="true" title = "Help for ${getTopicName(topic)}">
		</#if>
			
			<span class="sr-only">View Help Modal</span>
			<i class="fa fa-question-circle fa-lg"></i>

		<#if topic != ""></a></#if>
		
	</div>
	
	<div class="modal fade" id="${getTopicName(topic)}Modal" tabindex="-1" role="dialog" aria-labelledby="${getTopicName(topic)}ModalLabel" aria-hidden="true" data-backdrop="static">
  		<div class="modal-dialog" role="document">
    		<div class="modal-content">
      			<div class="modal-body">
        			<#include "/general/topics/${topic}-help.ftl" />
      			</div>
      			<div class="modal-footer">
			    	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        </div>
    		</div><!-- /.modal-content -->
  		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
</#macro>

<#function getTopicName topic>
	<#if topic?index_of('comp_id.') == 0>
		<#return topic?substring(8)/>
	<#else>
		<#return topic?substring(0)/>
	</#if>
</#function>