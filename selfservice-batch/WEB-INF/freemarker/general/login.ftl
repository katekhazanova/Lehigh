<@layout.head "Log In" />

<@layout.body>
	<div class="row">
		<h1>Welcome to ${selfServiceConfig.applicationName}</h1>
		
		<div class="col-md-6">
		
			<form action="<@h.url href="/general/logincheck.html" />" method="POST" name="loginForm" class="focusable">
					 
		
					<#if RequestParameters['src']?? >
						<#if RequestParameters['src'] == "error">
							<p class="alert alert-danger" role="alert" tabindex="0">Your login attempt was not successful, try again.</p>
				      	<#elseif RequestParameters['src'] == "logout">
							<p class="alert alert-success">Logout complete.</p>
				      	</#if>
					</#if>
					
					
					
					  <div class="form-group">
					    <label for="userName">User Name</label>
					    <input type="text" class="form-control high-contrast-border" id="userName" placeholder="Enter username" name="${generalConfig.usernameParameter}" value="" />
					  </div>
					  <div class="form-group">
					    <label for="password">Password</label>
					    <input type="password" class="form-control high-contrast-border" id="password" placeholder="Password" name="${generalConfig.passwordParameter}" value="" autocomplete="off" /> 
					  </div>
					 	
					  <@h.submit src='' title='Log in' />
					  
					  

				
			</form>
		</div> <#-- /col-md-6 -->
	</div> <#-- /row -->
	
</@layout.body>