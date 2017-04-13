<@layout.head title='Change Password'>
<style>
.paddedHeader{ padding: .8em; margin-bottom: 1em;}
</style>
</@layout.head>
<@layout.body>

		<input type="hidden" id="pageGroup" value="settings"/>
<h1><@s.message 'uachieve.selfservice.passwordChange.header' /></h1>

<#if passwordChanged??>
	<#if passwordChanged>
		<p class="alert alert-success" role="alert" tabindex="0"><@s.message 'uachieve.selfservice.passwordChange.success' /></p>
	<#else>
		<p class="alert alert-danger" role="alert" tabindex="0"><@s.message 'uachieve.selfservice.passwordChange.failure' /></p>
	</#if>
</#if>

<div class="row">
	<form method="POST" name="passwordForm" class="focusable form-horizontal" role="form">
		<div class="form-group">
			<label class="col-md-2 control-label" for="currentPassword">Current Password:</label>
			<div class="col-md-4">
				<@s.formPasswordInput path='passwordChange.currentPassword' attributes='autocomplete="off"' />
			</div>
			<div class="col-md-4">
				<@s.showErrors separator='' classOrStyle='alert alert-danger' />
			</div>
		</div>
		
		
		<div class="form-group">
			<label class="col-md-2 control-label" for="newPassword">New Password:</label>
			<div class="col-md-4">
				<@s.formPasswordInput path='passwordChange.newPassword' attributes='autocomplete="off"' />
			</div>
			<div class="col-md-4">
				<@s.showErrors separator='' classOrStyle='alert alert-danger' />
			</div>
		</div>
		
		
		<div class="form-group">
			<label class="col-md-2 control-label" for="confirmPassword">Confirm New Password:</label>
			<div class="col-md-4">
				<@s.formPasswordInput path='passwordChange.confirmPassword' attributes='autocomplete="off"' />
			</div>
			<div class="col-md-4">
				<@s.showErrors separator='' classOrStyle='alert alert-danger' />
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-md-offset-2 col-md-6">
				<@h.submit src='/images/bt_save.gif' title='Save' />
				<a class="btn btn-default" href="../general/changepassword.html" role="button">Cancel</a>
			</div>
		</div>
	</form>
</div>




</@layout.body>