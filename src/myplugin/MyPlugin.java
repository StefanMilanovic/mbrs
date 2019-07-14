package myplugin;

import java.io.File;

import javax.swing.JOptionPane;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;


import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {
	
	String pluginDir = null; 
	
	public void init() {
		JOptionPane.showMessageDialog( null, "My Plugin init");
		
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		
		// Creating submenu in the MagicDraw main menu 	
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();		
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));
		
		/** @Todo: load project options (@see myplugin.generator.options.ProjectOptions) from 
		 * ProjectOptions.xml and take ejb generator options */
		
		//for test purpose only:
		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp", "ejbclass", "templates", "{0}.java", true, "ejb"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("EJBGenerator", ejbOptions);
				
		ejbOptions.setTemplateDir(pluginDir + File.separator + ejbOptions.getTemplateDir()); //apsolutna putanja*/
		
		
		GeneratorOptions springOptionsRepository = new GeneratorOptions("c:/temp", "Repository", "templates", "{0}.java", true, "repository"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("SpringGenerator", springOptionsRepository);
				
		springOptionsRepository.setTemplateDir(pluginDir + File.separator + springOptionsRepository.getTemplateDir()); //apsolutna putanja
	
		GeneratorOptions springOptionsService = new GeneratorOptions("c:/temp", "Service", "templates", "{0}.java", true, "service"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("SpringGeneratorService", springOptionsService);
				
		springOptionsService.setTemplateDir(pluginDir + File.separator + springOptionsService.getTemplateDir()); //apsolutna putanja
	

		GeneratorOptions springOptions = new GeneratorOptions("c:/temp", "Controller", "templates", "{0}.java", true, "controller"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("SpringGeneratorController", springOptions);
				
		springOptions.setTemplateDir(pluginDir + File.separator + springOptions.getTemplateDir()); //apsolutna putanja

		GeneratorOptions springOptionsServiceImpl = new GeneratorOptions("c:/temp", "ServiceImpl", "templates", "{0}.java", true, "serviceImpl"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("SpringGeneratorServiceImpl", springOptionsServiceImpl);
				
		springOptionsServiceImpl.setTemplateDir(pluginDir + File.separator + springOptionsServiceImpl.getTemplateDir()); //apsolutna putanja
		
		//front
		GeneratorOptions front = new GeneratorOptions("c:/temp", "FrontFTL", "templates", "{0}.html", true, "Front"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("FrontGenerator", front);
				
		front.setTemplateDir(pluginDir + File.separator + front.getTemplateDir()); //apsolutna putanja
	
		GeneratorOptions index = new GeneratorOptions("c:/temp", "Index", "templates", "{0}.html", true, "Index"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("IndexGenerator", index);
				
		index.setTemplateDir(pluginDir + File.separator + index.getTemplateDir()); //apsolutna putanja
	
		
		GeneratorOptions filter = new GeneratorOptions("c:/temp", "FrontFilter", "templates", "{0}.html", true, "Filter"); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put("FilterGenerator", filter);
				
		filter.setTemplateDir(pluginDir + File.separator + filter.getTemplateDir()); //apsolutna putanja
	
	}

	private NMAction[] getSubmenuActions()
	{
	   return new NMAction[]{
			new GenerateAction("Generate"),
	   };
	}
	
	public boolean close() {
		return true;
	}
	
	public boolean isSupported() {				
		return true;
	}
}


