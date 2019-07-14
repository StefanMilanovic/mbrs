package mbrs.service;

import java.util.List;

import org.springframework.stereotype.Service;
import mbrs.model.${class.name?cap_first};

<#list classes as c>
	<#list properties as property>
		<#if property.upper == 1 &&  property.type != 'String'  && property.name != 'id' >
import mbrs.model.${c.name?cap_first};	
			<#break>
		</#if>
	</#list>
</#list>

@Service
public interface ${class.name?cap_first}Service {

	${class.name?cap_first} findOne(Integer id);
	List<${class.name?cap_first}> findAll();
	
	${class.name?cap_first} save(${class.name?cap_first} ${class.name?uncap_first});	
	
	${class.name?cap_first} delete(Integer id);	

	
	
	<#list properties as property>
	<#if property.upper == 1 && property.name != 'id' && property.type != 'String'>
	List<${class.name?cap_first}>  findBy${property.name?cap_first}Id(Integer id);
	</#if >
	</#list>
}