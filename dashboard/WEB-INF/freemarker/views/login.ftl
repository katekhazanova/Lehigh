<html>
 
<head>
	<title>Dashboard</title>
</head>
	
<div class="row">
	<h1>Welcome to Dashboard</h1>
	
			
	<div class="col-md-6">

		<form class="focusable" name="loginForm" method="post" action="j_spring_security_check">

			<div class="form-group">
			    <label for="userName">User Name</label>
			    <input type="text" class="form-control" id="userName" placeholder="Enter username" name="j_username" value="" />
			  </div>
			  <div class="form-group">
			    <label for="password">Password</label>
			    <input type="password" class="form-control" id="password" placeholder="Password" name="j_password" value="" autocomplete="off" /> 
			  </div>
			 
			 	<input type="submit" name="submit" value="Log In" class="btn btn-primary" />	
			 
		  </form>



		
	</div>
</div>

</body>
</html>