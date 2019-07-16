package mbrs.serviceImpl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mbrs.model.${class.name?cap_first};
import mbrs.repository.${class.name?cap_first}Repository;
import mbrs.service.${class.name?cap_first}Service;

@Transactional
@Service
public class ${class.name?cap_first}ServiceImpl implements ${class.name?cap_first}Service {

	@Autowired
	private ${class.name?cap_first}Repository ${class.name?uncap_first}Repository;
	
	@Override
	public ${class.name?cap_first} findById(Integer id) {
		return ${class.name?uncap_first}Repository.findById(id).get();
	}

	@Override
	public List<${class.name?cap_first}> findAll() {
		return ${class.name?uncap_first}Repository.findAll();
	}

	@Override
	public ${class.name?cap_first} save(${class.name?cap_first} ${class.name?uncap_first}) {
		return ${class.name?uncap_first}Repository.save(${class.name?uncap_first});
	}

	@Override
	public ${class.name?cap_first} delete(Integer id) {
		${class.name?cap_first} ${class.name?uncap_first} = ${class.name?uncap_first}Repository.findById(id).get();
		if(${class.name?uncap_first} == null){
			throw new IllegalArgumentException("Pokusaj brisanja nepostojeceg entiteta.");
		}
		${class.name?uncap_first}Repository.delete(${class.name?uncap_first});
		return ${class.name?uncap_first};
	}
	
	<#list properties as property>
	<#if property.upper == 1 && property.name != 'id' && property.type != 'String'>
	
	@Override
	public List<${class.name?cap_first}>  findBy${property.name?cap_first}Id(Integer id){
		return ${class.name?uncap_first}Repository.findBy${property.name?cap_first}Id(id);
	}
	</#if >
	</#list>

}