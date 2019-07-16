package mbrs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import mbrs.aop.AOPService;
<#list classes as c>
	<#list properties as property>
		<#if property.upper == 1 >
import mbrs.model.${c.name?cap_first};	
import mbrs.service.${c.name?cap_first}Service;	
			<#break>
		</#if>
	</#list>
</#list>

@RestController
@RequestMapping(value = "/${class.name?uncap_first}")
public class  ${class.name?cap_first}Controller {

<#list classes as c>
	<#list properties as property>
		<#if property.upper == 1>
	@Autowired
	${c.name?cap_first}Service ${c.name?uncap_first}Service;
				<#break>
		</#if>
	</#list>
</#list>

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<${class.name?cap_first}> get${class.name?cap_first}(@PathVariable Integer id) {
		${class.name?cap_first} ${class.name?uncap_first} = ${class.name?uncap_first}Service.findById(id);
				
		if (${class.name?uncap_first} == null) {
			return new ResponseEntity<${class.name?cap_first}>(${class.name?uncap_first}, HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<${class.name?cap_first}>(${class.name?uncap_first}, HttpStatus.OK);
	}
	
	@RequestMapping(value="/get${class.name?cap_first}s", method = RequestMethod.GET)
	public ResponseEntity<List<${class.name?cap_first}>> get${class.name?cap_first}s() {
		List<${class.name?cap_first}> ${class.name?uncap_first}s =${class.name?uncap_first}Service.findAll();
		
		if(${class.name?uncap_first}s.equals(null)) {
			return new ResponseEntity<List<${class.name?cap_first}>>(${class.name?uncap_first}s, HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<List<${class.name?cap_first}>>(${class.name?uncap_first}s, HttpStatus.OK);
	}
	
	@RequestMapping(value="/izbrisi/{id}", method = RequestMethod.DELETE)
	public String izbrisi(@PathVariable Integer id) {
		${class.name?cap_first} ${class.name?uncap_first} = ${class.name?uncap_first}Service.findById(id);	
		
		<#list properties as p><#if p.upper != 1 >
		if(!${class.name?uncap_first}.get${p.name?cap_first}s().isEmpty()) {
		
			
			System.out.println("\n\n\t\t ${class.name?cap_first}  se ne sme obrisati.");
			return "${class.name?cap_first}  se ne sme obrisati.";
		}
		 </#if>
		 </#list>
		
		${class.name?uncap_first}Service.delete(${class.name?uncap_first}.getId());
		return "Uspesno brisanje";
	}
	
	@RequestMapping(value = "/dodaj<#list properties as property><#if property.upper == 1 && property.type !='String' && property.type !='Integer'>/{id${property.name?cap_first}}</#if></#list>", method = RequestMethod.POST)
	public ResponseEntity<${class.name?cap_first}> dodaj(<#list properties as property><#if property.upper == 1 && property.type !='String' && property.type !='Integer'>@PathVariable Integer id${property.name?cap_first}, </#if></#list>@RequestBody ${class.name?cap_first} request) {			
			ApplicationContext appContext = new ClassPathXmlApplicationContext("aopConfig.xml");	
			AOPService aopSI = (AOPService) appContext.getBean("aopSI");
			aopSI.printMessage();
			
			${class.name?cap_first} ${class.name?uncap_first} = new ${class.name?cap_first}();
			
			<#list properties as property><#if property.type =='String'>${class.name?uncap_first}.set${property.name?cap_first}(request.get${property.name?cap_first}());
			</#if></#list>
			
			<#list properties as property><#if property.upper == 1 && property.type !='String' && property.type !='Integer'>
			${class.name?uncap_first}.set${property.name?cap_first}(${property.name?uncap_first}Service.findById(id${property.name?cap_first}));			
			</#if></#list>
			
			${class.name?uncap_first}Service.save(${class.name?uncap_first});
			return new ResponseEntity<${class.name?cap_first}>(${class.name?uncap_first}, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/azuriraj/{id}<#list properties as property><#if property.upper == 1 && property.type !='String' && property.type !='Integer'>/{id${property.name?cap_first}}</#if></#list>", method = RequestMethod.PUT)
	public ResponseEntity<${class.name?cap_first}> azuriraj(@PathVariable Integer id,
	<#list properties as property><#if property.upper == 1 && property.type !='String' && property.type !='Integer'>@PathVariable Integer id${property.name?cap_first}, </#if></#list>@RequestBody ${class.name?cap_first} request) {			

		${class.name?cap_first} ${class.name?uncap_first} = ${class.name?uncap_first}Service.findById(id);
			
		if(${class.name?uncap_first} != null) {
		
		<#list  properties as property><#if property.name !='id'  && property.type =='String'>
			${class.name?uncap_first}.set${property.name?cap_first}(request.get${property.name?cap_first}());
		</#if>
		</#list>
		
		<#list properties as property><#if property.upper == 1 && property.type !='String' && property.type !='Integer'>
			${class.name?uncap_first}.set${property.name?cap_first}(${property.name?uncap_first}Service.findById(id${property.name?cap_first}));
		</#if>	
		</#list>
		
			${class.name?uncap_first}Service.save(${class.name?uncap_first});
			return new ResponseEntity<${class.name?cap_first}>(${class.name?uncap_first}, HttpStatus.OK);
		}
		
		return new ResponseEntity<${class.name?cap_first}>(${class.name?uncap_first}, HttpStatus.NOT_FOUND);
	}
	
	
	
	<#list properties as property>
		<#if property.upper == 1 &&  property.type != 'String'  && property.name != 'id' >
	@RequestMapping(value="/get${class.name?cap_first}U${property.name?cap_first}/{id${property.name?cap_first}}", method = RequestMethod.GET)
	public ResponseEntity<List<${class.name?cap_first}>> get${class.name?cap_first}U${property.name?cap_first}(@PathVariable Integer id${property.name?cap_first}) {
		List<${class.name?cap_first}> lista = ${class.name?uncap_first}Service.findBy${property.name?cap_first}Id(id${property.name?cap_first});
		
		if(lista.equals(null)) {
			return new ResponseEntity<List<${class.name?cap_first}>>(lista, HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<List<${class.name?cap_first}>>(lista, HttpStatus.OK);
	}
	</#if>
	</#list>
	
	
	
}