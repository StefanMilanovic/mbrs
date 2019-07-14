package myplugin.generator.fmmodel;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;


public class FMClass extends FMType {	
	
	private String visibility;
	

	//Class properties
	private List<FMProperty> FMProperties = new ArrayList<FMProperty>();
	private List<FMProperty> FMPropertiesNoId = new ArrayList<FMProperty>();
	private List<FMProperty> FMPropertiesStrings = new ArrayList<FMProperty>();
	
	//list of packages (for import declarations) 
	private List<String> importedPackages = new ArrayList<String>();
	
	/** @ToDo: add list of methods */
	
	
	public FMClass(String name, String classPackage, String visibility) {
		super(name, classPackage);		
		this.visibility = visibility;
	}	
	
	public List<FMProperty> getProperties(){
		return FMProperties;
	}
	
	public List<FMProperty> getPropertiesNoId(){		
		
		for(FMProperty fm : FMProperties){
			FMPropertiesNoId.add(fm);
		}
		
		for(int i = 0; i < FMPropertiesNoId.size(); i++){
			if(FMPropertiesNoId.get(i).getName().equals("id") || !FMPropertiesNoId.get(i).getType().equals("String") ){
				FMPropertiesNoId.remove(i);
			}
		}		
		return FMPropertiesNoId;
	}
	
	public List<FMProperty> getPropertiesStrings(){		
		
		for(FMProperty fm : FMProperties){
			FMPropertiesStrings.add(fm);
		}
		
		for(int i = 0; i < FMPropertiesStrings.size(); i++){
			if(!FMPropertiesStrings.get(i).getType().contains("String") ){
				FMPropertiesStrings.remove(i);
			}
		}		
		return FMPropertiesStrings;
	}
	
	
	public Iterator<FMProperty> getPropertyIterator(){
		return FMProperties.iterator();
	}
	
	public void addProperty(FMProperty property){
		FMProperties.add(property);		
	}
	
	public int getPropertyCount(){
		return FMProperties.size();
	}
	
	public List<String> getImportedPackages(){
		return importedPackages;
	}

	public Iterator<String> getImportedIterator(){
		return importedPackages.iterator();
	}
	
	public void addImportedPackage(String importedPackage){
		importedPackages.add(importedPackage);		
	}
	
	public int getImportedCount(){
		return FMProperties.size();
	}
	
	public String getVisibility() {
		return visibility;
	}

	public void setVisibility(String visibility) {
		this.visibility = visibility;
	}	

	
}
