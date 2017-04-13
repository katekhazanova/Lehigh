
<input type="hidden" id="pageGroup" value="tools"/>
<title>Audit Comparison Home</title>
	<h1 id="pagetitle">Audit Comparison</h1>



    <ul class="nav nav-tabs" id="myTab">

	  <li  class="active"><a href="#runAudits" data-toggle="tab">Run Audits</a></li>
 	  <li><a href="#compare" data-toggle="tab">Compare Previous</a></li>
	</ul>

	<div class="tab-content">





	  <div class="tab-pane active" id="runAudits">
	  <h2 class="sr-only">Run Audits</h2>
	  <p class="help">
	    		The settings that will be used when requesting audits for comparison. Changes are stored locally and will revert to their default values when you log out.
	    	</p>


	        <form name="studentListSearch"  role="form" method="get" action="updateRunOptions.html">
	        	<div class="row">
		           	<div class="form-group col-md-4">
						<label for="comkey">Com Key: </label>
						<input type="text" class="form-control" name="comKey" id="comkey" maxlength="5" value="${comKey!''}" onblur="updateRunConfigs()"/>
					</div>
					<div class="form-group col-md-4">
						<label for="evalsw">Run Type: </label>
						<select class="form-control" name="evalsw" id="evalsw" onchange="updateRunConfigs()">
							<option value="D" <#if evalsw = "D">selected</#if>>D-Degree Audit</option>
							<option value="S" <#if evalsw = "S">selected</#if>>S-Audit w/Course Sort</option>
							<option value="A" <#if evalsw = "A">selected</#if>>A-Audit and Evaluation</option>
						</select>
					</div>
		           	<div class="form-group col-md-4">
						<label for="startLine">Comparison Start Line: </label>
						<input type="text" class="form-control" name="startLine" id="startLine" value="${startLine!'0'}" onblur="updateRunConfigs()"/>
					</div>
				</div>
				<div class="row">
		           	<div class="form-group col-md-4">
						<label for="serverName1">Server 1: </label>
						<input type="text" class="form-control" name="serverName1" id="serverName1" maxlength="10" value="${serverName1!''}" onblur="updateRunConfigs()"/>
					</div>
		       	    <div class="form-group col-md-4">
						<label for="serverName2">Server 2: </label>
						<input type="text" class="form-control" name="serverName2" id="serverName2" maxlength="10" value="${serverName2!''}" onblur="updateRunConfigs()"/>
					</div>
					<div class="form-group col-md-4">

						<#if soprids?size gt 1>
							<label for="soprid">Soprid: </label>
							<select class="form-control" name="soprid" id="soprid" onchange="updateRunConfigs()">
								<#list soprids as sop>
									<option value="${sop}" <#if sop == soprid>selected</#if>>${sop}</option>
								</#list>
							</select>
						<#else>
							<input type="hidden" id="soprid" value="${soprid}"/>
						</#if>
					</div>
				</div>
	        </form>
	        <br>



	    	<p class="help">
	    		Enter a comma separated list of students you wish to run audits for. You can also search for students by name or Student ID to add the list.
	    		This list is stored locally until you edit the list or log out.
	    	</p>



        <form id="studentListSearch" name="studentListSearch" role="form" method="get" action="submitAudits.html">
    		<div class="row">
        	<div class="form-group col-md-12">
            	<label for="stunos">Student List: </label>
                <textarea id="stunos" name="stunos" class="form-control" name="stunos" maxlength="2000" onchange="updateStunoList('update')" placeholder="Student ID, Student ID, Student ID...">${stunos!''}</textarea>
            	<font size="1">(Maximum characters: 2000)</font>
            </div>
            </div>
            <div class="row">
				<div class="col-md-12">
				<span class="pull-right">
	            	<a  href="#" class="btn btn-default" onclick="updateStunoList('clear'); return false;">Clear List</a>
	            	<button type="submit"  id="stunos-button" class="btn btn-primary" >Run Audits</button>
	            	</span>
	            </div>
            </div>
        </form>
        <br>


		<div class="row">
			<form method="get" action="listStudentsByName.html">
				<div class="col-md-4">
					<label for="stuname">Search Student by Name:</label>
					<div class="input-group">
						<input type="text" id="stuname" name="stuname" class="form-control searchinput" placeholder="Student Name (Minimum 3 Characters)" onkeyup="checkSearch('stuname')">
						<span class="input-group-btn">
							<button class="btn btn-primary" id="stuname-button" type="submit" disabled="disabled"><i class="fa fa-search"></i></button>
						</span>
					</div>
				</div>
			</form>

			<form method="get" action="listStudents.html">
				<div class="col-md-4">
					<label for="partialStuno">Search Student by Student ID:</label>
					<div class="input-group">
						<input type="text" id="partialStuno" name="partialStuno" class="form-control searchinput" placeholder="STUDENT ID (Minimum 3 Characters)" onkeyup="checkSearch('partialStuno')">
						<span class="input-group-btn">
							<button class="btn btn-primary" id="partialStuno-button" type="submit" disabled="disabled"><i class="fa fa-search"></i></button>
						</span>
					</div>
				</div>
            </form>
        </div>
	  </div>

	  <div class="tab-pane" id="compare">
	  	<h2 class="sr-only">Compare Previous</h2>



        	<p class="help">
	    		To compare two audits for an individual student that were previously requested, enter their Student ID below.
	    	</p>


            <!--
			<form method="get" action="listAudits.html">
                <input type="text" id="stuno" name="stuno" class="form-control searchinput" placeholder="Student Number">
                <button type="submit" class="btn btn-primary btnAlign btnTopMargin" >Search</button>
            </form>
			-->
			<form method="get" action="listAudits.html">
				<div class="row">
					<div class="col-lg-12">
						<label for="stuno">Previously requested audits for Student ID:</label>
						<div class="input-group">
							<input type="text" id="stuno" name="stuno" class="form-control searchinput" placeholder="STUDENT ID (enter full Student ID)" onkeyup="checkSearch('stuno')">
							<span class="input-group-btn">
								<button type="submit" id="stuno-button" class="btn btn-primary"><i class="fa fa-search"></i></button>
							</span>
						</div>
					</div>
				</div>
            </form>

	  </div>


	  <div class="tab-pane" id="batchSearch">
        <h2 class="sr-only">Batch Search</h2>

	    	<p class="help">
	    		Help goes here
	    	</p>

	    	<br>

        <ul>
        	<li>
            	<br>
                <p>Enter a Batch ID:</p>
                <!--
				<form method="get" action="listBatchIds.html">
                    <input type="text" id="batchid" name="batchid" class="form-control searchinput" placeholder="Batch ID">
                    <button type="submit" class="btn btn-primary btnAlign btnTopMargin">Search</button>
                </form>
				-->
			<form method="get" action="listBatchIds.html">
				<div class="row">
					<div class="col-lg-12">
						<div class="input-group">
							<input type="text" id="batchid" name="batchid" class="form-control searchinput" placeholder="Batch ID">
							<span class="input-group-btn">
								<button type="submit" class="btn btn-primary" ><i class="fa fa-search"></i></button>
							</span>
						</div>
					</div>
				</div>
            </form>
        	</li>
        </ul>
	  </div>
	</div>

	<script>
			// Javascript to enable link to tab
			var hash = document.location.hash;
			var prefix = "tab_";
			if (hash) {
			    $('.nav-tabs a[href='+hash.replace(prefix,"")+']').tab('show');
			}

			// Change hash for page-reload
			$('.nav-tabs a').on('shown', function (e) {
			    window.location.hash = e.target.hash.replace("#", "#" + prefix);
			});
		</script>
