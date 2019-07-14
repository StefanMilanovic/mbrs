package mbrs.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import mbrs.model.${class.name?cap_first};


@Repository
public interface ${class.name?cap_first}Repository extends JpaRepository<${class.name?cap_first}, Integer> {

	<#list properties as property>
	<#if property.upper == 1 && property.name != 'id' && property.type != 'String'>
	List<${class.name?cap_first}>  findBy${property.name?cap_first}Id(Integer id);
	</#if >
	</#list>
}
