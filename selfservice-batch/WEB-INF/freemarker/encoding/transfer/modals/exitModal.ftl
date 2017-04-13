<div class="modal fade" id="exitModal" tabindex="-1" role="dialog" aria-labelledby="exitModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="exitModalLabel">You have not saved your changes.</h4>
      </div>
      <div class="modal-body">
        Do you wish to do so now?
      </div>
      <div class="modal-footer">
      	<a href="#" type="button" id="modal_save" class="btn btn-primary"<#if clone=="true"> onclick="cloneIref()"<#else> onclick="saveIref();"</#if>>Save changes<span id="modal_save_action"></span></a>
      	<a href="#" type="button" id="modal_exit" class="btn btn-default"><span id="modal_action"></span> without saving</a>
        <a href="#" type="button" id="modal_cancel" class="btn btn-default" data-dismiss="modal">Cancel</a>
      </div>
    </div>
  </div>
</div>