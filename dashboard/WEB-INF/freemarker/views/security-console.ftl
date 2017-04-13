
<html>
<head>
	<title>Security Console</title>
	
</head>
<input type="hidden" id="pageGroup" value="security"/>
<body>


		<h1>Security</h1>
		<p class="bd">  Here you can configure security for u.direct and
		u.achieve Self-Service.</p>
		
		<h2>Introduction</h2>
	
		<p class="bd">In designing your security, we suggest starting with Roles first and then define 
		the Groups for those Roles. After those two have been developed, you can assign 
		Domains to certain Groups, where applicable. However, Roles, Groups and Domains can 
		be created at any point in time.
		<br clear="all"></p>

			<ul class="nav nav-tabs" id="securityTabs">
				<li class="active"><a href="#roles" data-toggle="tab">Roles</a></li>
				<li><a href="#users" data-toggle="tab">Users</a></li>
				<li><a href="#groups" data-toggle="tab">Groups</a></li>
				<li><a href="#domains" data-toggle="tab">Domains</a></li>
			</ul>
			
			<div class="tab-content">
				<div id="roles" class="tab-pane active" >
					<h3>Roles</h3>
					
					<p>Roles in u.direct are a 'collection of permissions' with a label. They 
					are designed to define permission to what a user can read, update, create 
					or delete while in u.direct. Users can have multiple roles in u.direct. 
					These roles can be utilized to design the varying type of permissions 
					that you need to create for access to the application functions.</p>
	
					<p>The application functions are: Plans, Roadmaps, Publishers, Student 
					Search, and Admin.</p>
					
					<h4>To Create Roles:</h4>
					
					<ol>
						<li>Insert Role Name into the <b>Role Name</b> field</li>
						<li>Click <b>Add</b></li>
					
						<li>Determine which App Functions this Role will have permissions for <b>Read, Update, Create</b> and <b>Delete</b>
						<ol>
							<li>Click the drop down for each app function to set the status of permission</li>
						</ol>
						</li>
						<li>Click <b>Save</b><br>
					
					<em>*To add this new Role to a Group, use the Group Section</em></li>
					</ol>
				</div>
	
	<!-- ############################################################################### -->
	<!-- ####            USERS  TAB													#### -->
	<!-- ############################################################################### -->					
				<div id="users" class="tab-pane">
					<h3>Users</h3>
					
					<p>The users are granted permission to different aspects of u.direct. 
					Users can be created in the security screens, or added to the database 
					from the student system information.</p>
	
					<h4>To Create Users:</h4>
					
					<ol>
						<li>Click <b>New</b> at the bottom of the screen</li>
					
						<li>Fill in appropriate fields
						<ol>
							<li><b><em>username</em></b> and <b><em>SIS ID</em></b> are required</li>
						</ol>
						</li>
						<li>Click <b>Save</b><br>
					
					At this point, you can also assign this new user to a Group membership</li>
					</ol>
					
					
					<h4>To Add New Users to Groups:</h4>
					
					<ol>
						<li>Type the group name in the <b>Group Name</b> field</li>
						<li>Click <b>Add</b>
					
						<ol>
							<li>If the Group exists, the Group Domain will appear on the screen</li>
							<li>If the Group does not exist, the Group Name will be assigned 
							with no associated group definitions
							<ol>
								<li>Go to the Group section to create the necessary group</li>
							</ol>
							</li>
						</ol>
					
						</li>
					</ol>
					
					
					<h4>To add the New User to a Domain:</h4>
					
					<ol>
						<li>Type the Domain in the <b>Add Domain</b> fields</li>
						<li>Click <b>Add Domain</b></li>
					
					</ol>
					
					
					<h2>To Add Advisees to the User</h2>
					
					<ol>
						<li>Type the Last Name, First Name and SIS ID in the <b>Search</b> criteria</li>
						<li>Click <b>Search</b></li>
					
						<li>Select desired User</li>
						<li>Click <b>Add</b><br>
					<b>OR</b></li>
						<li>Type the username in <b>Username</b> field</li>
						<li>Click <b>Add</b><br>
					
					<b><em>OR</em></b></li>
						<li>Type SIS ID in <b>SIS ID</b> field</li>
						<li>Click <b>Add</b></li>
					</ol>
				</div>
	
	<!-- ############################################################################### -->
	<!-- ####            GROUPS  TAB												#### -->
	<!-- ############################################################################### -->
				<div id="groups" class="tab-pane ">
					<h3>Groups</h3>
					
					<p>A group contains a list of roles, and is used to map users to the 
					appropriate roles. This section allows for you to map application roles 
					to your institution's groups. First, select the application. You will 
					then see a list of roles associated with it. You can then make the 
					associations by selecting the roles and clicking on the appropriate 
					button.</p>
	
					<h4>To Create Groups:</h4>
					
					<ol>
						<li>Type new group name in <b>Group Name</b> field</li>
						<li>Click <b>Add</b></li>
					</ol>
					
					
					<h2>To Assign Roles to the Group:</h2>
					
					<ol>
						<li>Select the group from the <b>Groups</b> box at the top of the screen</li>
						<li>Select the <b>Permissions</b> tab</li>
					
						<li>Choose the Application from the <b>Applications</b> drop down</li>
						<li>Highlight the desired roles from the <b>Existing Roles</b> box on the right</li>
						<li>Click <b>Add</b>
						<ol>
					
							<li>Role will be added to the <b>Group Roles</b> box</li>
						</ol>
						</li>
					</ol>
					
					
					<h4>To Assign Users to the Group:</h4>
					
					<ol>
					
						<li>Select the group from the <b>Groups</b> box at the top of the screen</li>
						<li>Select the <b>Group Members</b> tab
						<ol>
							<li>A list of current members will display in the <b>Members</b> area</li>
					
						</ol>
						</li>
						<li>Type the Last Name, First Name and SIS ID in the <b>Search</b> criteria</li>
						<li>Click <b>Search</b></li>
						<li>Select desired User</li>
					
						<li>Click <b>Add</b><br>
					<b>OR</b></li>
						<li>Type the username in <b>Username</b> field</li>
						<li>Click <b>Add</b><br>
					<b><em>OR</em></b></li>
					
						<li>Type SIS ID in <b>SIS ID</b> field</li>
						<li>Click <b>Add</b></li>
					</ol>
					
					
					<h4>To Assign Domains to the Group:</h4>
					
					<ol>
					
						<li>Select the group from the <b>Groups</b> box at the top of the screen</li>
						<li>Select the <b>Domains</b> tab
						<ol>
							<li>A list of domains assigned to this group will appear under Group Domains</li>
						</ol>
					
						</li>
						<li>Type Domain hierarchy in the <b>Add Domain</b> boxes</li>
						<li>Click <b>Add Domain</b></li>
					</ol>
				</div>
				
	<!-- ############################################################################### -->
	<!-- ####            DOMAINS  TAB												#### -->
	<!-- ############################################################################### -->
				<div id="domains" class="tab-pane ">
					<h3>Domains</h3>
					
					<p>Domains define a more limited scope to the system than the higher 
					level app functions. A domain is a hierarchy (up to 6 levels) that 
					defines your institution and can be used to limit permissions. Domains 
					are defined and created using Views on the technical side; however they 
					can be assigned in the security application. Use asterisks (*)
					to indicate that the group has permissions for any of the values for that
					level. A user may have domain permissions directly applied to their user 
					account or inherited from groups they belong to.</p>
	
					<h4>To Assign a Domain to a Group:</h4>
					
					<ol>
						<li>Select <b>Groups</b> from the menu on the left</li>
						<li>Select the group from the <b>Groups</b> box at the top of the screen</li>
					
						<li>Select the <b>Domains</b> tab
						<ol>
							<li>A list of domains assigned to this group will appear under Group Domains</li>
						</ol>
						</li>
						<li>Type Domain hierarchy in the <b>Add Domain</b> boxes</li>
					
						<li>Click <b>Add Domain</b></li>
					</ol>
					
					
					<h4>To Assign a Domain to a User:</h4>
					
					<ol>
						<li>Select User from the menu on the left</li>
						<li>Search for a user OR Click New
						<ol>
							<li>Instructions are within the User section of this document</li>
						</ol>
						</li>
						<li>Type the Domain in the <b>Add Domain</b> fields</li>
						<li>Click *Add Domain*</li>
					</ol>
				</div>
			</div>
		</div>
</body>
</html>