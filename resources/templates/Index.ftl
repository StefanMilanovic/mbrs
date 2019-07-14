<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>MBRS</title>
		<script src="scripts/jquery-3.2.1.min.js"></script>
		<link href="bootstrapB/css/bootstrap.css" rel="stylesheet" type="text/css"/>
		<script src="bootstrapB/js/bootstrap.js" type="text/javascript"></script>
	</head>
	
	<body>
			<div class="container">
	   			<div style="margin-top:100px;" class="mainbox col-lg-6 col-lg-offset-3 col-lg-8 col-lg-offset-7"> 
	        		<div class="panel panel-primary" >
	            		<div class="panel-heading">
	                		<div class="panel-title text-center">MBRS</div>
	            		</div>
	            		  
	            		<div class="panel-body" style="padding-top:30px">
	            			<div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
	                		
	                		
							<#list classes as c>
	                		<div class="row">
							  	<form action="${c.name?uncap_first}.html" class="form-horizontal">
							        <div class="col-lg-7">
							            <input class="btn btn-link" style="float:right"  type="submit" value="${c.name?cap_first}">
							        </div>
							  	</form>
						  	</div>
						  	</#list>
	            		</div>                     
	        		</div>  
	    		</div>
			</div>
	</body>

</html>
