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
			
				<div class="tabcontent" style="padding-top:20px">
					<div class="form-group col-lg-4" style="padding:65px" id="tabLevo">
		   				<form id="formaDodaj" class="form-horizontal" enctype="multipart/form-data" method="POST">
		                	<#list properties as p>
		                		<#if p.type == 'String'>
		                			<input type="text" class="form-control" id="${p.name}A" name="${p.name}" placeholder="${p.name}">		                	
		                		<#elseif p.upper == 1 && p.type !='Integer' >
			                		<label>${p.type}:</label> 
									<select class="form-control" id="${p.name}"></select>
		                		</#if>
		                	</#list>
		                	<input id="dugmeDodaj" type="button" class="btn btn-success" style="float:right" value="Dodaj">
		                	<input id="dugmeAzuriraj2" type="button" class="btn btn-warning" style="float:right" value="Azuriraj">	
		                </form>
		            </div>
				
					<div class="form-group col-lg-8" style="padding-right:65px" id="tabDesno">
						<h5><b><span id="prazno" class="row"></span></b></h5>
						<table id="tabela" class="table table-hover table-bordered" style="background-color: snow"></table>
						
						
					</div>
				</div>
				
				<script>
				<#list properties as property>
				<#if property.upper == 1 && property.type !='Integer' && property.type !='String' >
				$.ajax({
					type : 'GET',
					url : "/${property.name?uncap_first}/get${property.name?cap_first}s",
					contentType : 'application/json',
					dataType : "json",
					success : function(data) {
						$("#${property.name?uncap_first}").empty();
						var list = data == null ? [] : (data instanceof Array ? data : [ data ]);
						var ${property.name?uncap_first}s = $("#${property.name?uncap_first}");
						$.each(list, function(index) {
							var li = $('<option value="'+data[index].id+'">' + data[index].id + '</option>');
							$(${property.name?uncap_first}s).append(li);
						});
					}
				});
				</#if>
				</#list>
				
				
				
				
				
				$.ajax({
					url: "/${class.name?uncap_first}/get${class.name?cap_first}s",
					type: "GET",
					contentType: "application/json",
					datatype: 'json',
					success: function(data){
						if(data){
							if(data.length == 0){
								red = "Lista je prazna.";
								$("#prazno").append(red);
							}else{
								red = "Dostupni entiteti:";
								$("#prazno").append(red);
								$("#prazno").show();
								$("#tabela").append("<thead><tr><#list properties as pTable><#if pTable.type =='String'><th scope=\"col\" class=\"text-center\">${pTable.name?cap_first}</th><#elseif pTable.upper != 1 ><th scope=\"col\" class=\"text-center\"></#if></#list><th scope=\"col\" class=\"text-center\"><th scope=\"col\" class=\"text-center\"></th></th></tr></thead><tbody>");
								
								for(i = 0; i < data.length; i++) {					
								noviRed = "<tr>"<#list properties as pRow><#if pRow.type =='String' >+"<td>"+data[i].${pRow.name?uncap_first}+"</td>"</#if></#list>+<#list properties as pRowSec><#if pRowSec.upper != 1 >"<td><input id=\"dugme${pRowSec.name?cap_first}\" type=\"button\" class=\"btn btn-primary\" style=\"float:right\" value=\"${pRowSec.name?cap_first}\" onclick =\"${pRowSec.name?uncap_first}(" + data[i].id + ")\"></td>" + </#if></#list> "<td><input id=\"dugmeAzuriraj1\" type=\"button\" class=\"btn btn-warning\" style=\"float:right\" value=\"Azuriraj\" onclick =\"azuriraj(" + data[i].id + ")\">"+ "</td><td>" + "<input id=\"dugmeIzbrisi\" type=\"button\" class=\"btn btn-danger\" style=\"float:right\" value=\"Izbrisi\" onclick =\"izbrisi(" + data[i].id + ")\"></td>"+"</tr>"
								$("#tabela").append(noviRed);
								}
								$("#tabela").append("</tbody>");
							}
						}else
							alert("Greska prilikom pokusaja prikazivanja liste.");
					}
				});
				
				
				<#list properties as pPokupi>
				 <#if pPokupi.upper == 1 && pPokupi.type !='String' && pPokupi.type !='Integer'>
				 	var id${pPokupi.name?cap_first};
				 </#if>
				</#list>	
				function pokupiPodatke() {					
					var forma = $('form[id="formaDodaj"]');
					
					<#list properties as p>
					<#if p.type =='String' >
						var ${p.name?uncap_first} = forma.find('[name=${p.name?uncap_first}]').val();
					</#if>
					</#list>
					
					<#list properties as p>
					 <#if p.upper == 1 && p.type !='String' && p.type !='Integer'>
						id${p.name?cap_first} = $("#${p.name?uncap_first} option:selected").text();
					 </#if>
					</#list>	
																			
					formData = JSON.stringify({									
					<#list properties as p>
					<#if p.type =='String' >
						${p.name?uncap_first}:$("#formaDodaj [name='${p.name?uncap_first}']").val(),
					</#if>
					</#list>						
					});
				}		
				
				
				
				
				$("#dugmeDodaj").click(function(){
					pokupiPodatke();
						
					$.ajax({
						url: "/${class.name?uncap_first}/dodaj/"<#list properties as pPokupi><#if pPokupi.upper == 1 && pPokupi.type !='String' && pPokupi.type !='Integer'>+ id${pPokupi.name?cap_first} + "/"</#if></#list>,
						type: "POST",
						data: formData,
						contentType: "application/json",
						datatype: 'json',
						success: function(data){
							alert('Uspesno dodavanje.');
							location.href = "/${class.name?uncap_first}.html"
						}
					});
				});
				
					var idZaAzuriranje;
				function azuriraj(id) {
					idZaAzuriranje = id;
					
					$.ajax({
						url: "/${class.name?uncap_first}/" + id,
					}).then(function(${class.name?uncap_first}){
					
					<#list properties as p>
					<#if p.type =='String' >
						$("#${p.name?uncap_first}A").val(${class.name?uncap_first}.${p.name?uncap_first});
					</#if>
					</#list>	
					});
				}
				
				
				$("#dugmeAzuriraj2").click(function(){					
					pokupiPodatke();
						
					$.ajax({
					url: "/${class.name?uncap_first}/azuriraj/" + idZaAzuriranje<#list properties as pPokupi><#if pPokupi.upper == 1 && pPokupi.type !='String' && pPokupi.type !='Integer'> + "/" + id${pPokupi.name?cap_first}</#if></#list>,
						type: "PUT",
						data: formData,
						contentType: "application/json",
						datatype: 'json',
						success: function(data){
							if(data) {
								alert('Uspesno azuriranje.');
								location.href = "/${class.name?uncap_first}.html"
							}
						}
					});
				});
				
					function izbrisi(id) {
					$.ajax({
						url: "/${class.name?uncap_first}/izbrisi/" + id,
						type: "DELETE",
						success: function(){
							alert('Uspesno brisanje.');
							location.href = "/${class.name?uncap_first}.html"
						}
					});
				}
				
				<#list properties as property>
				<#if property.upper != 1 > 
					function ${property.name?uncap_first}(id) {
						location.href = "/${property.type?uncap_first}Filter.html?" + "${class.name?cap_first}" + ":"  + id
					}</#if></#list>
									
				</script>
				
		</body>
		
</html>