<!DOCTYPE html>
	<html>
	
		<head>
			<meta charset="UTF-8">
			<title>MBRS</title>
			<script src="scripts/jquery-3.2.1.min.js"></script>
			<link href="bootstrapB/css/bootstrap.css" rel="stylesheet"
				type="text/css" />
			<script src="bootstrapB/js/bootstrap.js" type="text/javascript"></script>
		</head>
		<body>
				<div class="row">
					<div class="col-lg-12 col-lg-9"></div>
		  			<div class="col-lg-6 col-lg-3">
					    <div class="form-group">
					    	<form action="index.html" class="form-horizontal">
						        <div class="col-lg-4">
						            <input class="btn btn-link" type="submit" value="Pocetna">
						        </div>
					        </form>
					    </div>
		  			</div>
				</div>
			
		
				
					<div class="form-group col-lg-8" style="padding-right:65px" id="tabDesno">
						<h5><b><span id="prazno" class="row"></span></b></h5>
						<table id="tabela" class="table table-hover table-bordered" style="background-color: snow"></table>
						
					</div>
			
				
				<script>
				
				$(document).ready(function(){ 
					var url = window.location.href;
					var deo = url.substring(url.lastIndexOf('?') + 1);
					var nazivKlase = deo.split(':')[0];
					var id = deo.split(':')[1];
					$.ajax({
						url: "/${class.name?uncap_first}/get${class.name?cap_first}U" + nazivKlase + "/" + id,
						type: "GET",
						contentType: "application/json",
						datatype: 'json',
						success: function(data){
							if(data){
								if(data.length == 0){
									red = "Lista je prazna.";
									$("#prazno").append(red);
								}else{
									$("#prazno").empty();
									red = "Dostupni entiteti:";
									$("#prazno").append(red);
									$("#prazno").show();
									$("#tabela").empty();
									$("#tabela").append("<thead><tr><#list properties as p><#if p.type =='String'><th scope=\"col\" class=\"text-center\">${p.name?cap_first}</th></#if></#list></th></th></tr></thead><tbody>");
									
									for(i = 0; i < data.length; i++) {
										noviRed = "<tr>"<#list properties as p><#if p.type =='String'>+"<td>"+data[i].${p.name?uncap_first} + "</td>"</#if></#list>+"</tr>"
										
										$("#tabela").append(noviRed);
									}
									$("#tabela").append("</tbody>");
								}
							}
						}
					});
				
				});
				</script>
				
		</body>
</html>