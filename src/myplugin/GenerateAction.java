package myplugin;

import java.awt.event.ActionEvent;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import com.nomagic.magicdraw.actions.MDAction;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import myplugin.analyzer.AnalyzeException;
import myplugin.analyzer.ModelAnalyzer;
import myplugin.generator.EJBGenerator;
import myplugin.generator.SpringGenerator;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

/** Action that activate code generation */
@SuppressWarnings("serial")
class GenerateAction extends MDAction{
	
	
	public GenerateAction(String name) {			
		super("", name, null, null);		
	}

	public void actionPerformed(ActionEvent evt) {
		
		if (Application.getInstance().getProject() == null) return;
		Package root = Application.getInstance().getProject().getPrimaryModel();
		
		if (root == null) return;
	
		ModelAnalyzer analyzer = new ModelAnalyzer(root, "ejb");
		ModelAnalyzer analyzer1 = new ModelAnalyzer(root, "controller");
		ModelAnalyzer analyzer2 = new ModelAnalyzer(root, "repository");
		ModelAnalyzer analyzer3 = new ModelAnalyzer(root, "service");
		ModelAnalyzer analyzer4 = new ModelAnalyzer(root, "serviceImpl");
		ModelAnalyzer analyzer5 = new ModelAnalyzer(root, "front");
		ModelAnalyzer analyzer6 = new ModelAnalyzer(root, "index");
		ModelAnalyzer analyzer7 = new ModelAnalyzer(root, "filter");
		
		
		
		try {
			analyzer.prepareModel();	
			GeneratorOptions go = ProjectOptions.getProjectOptions().getGeneratorOptions().get("EJBGenerator");			
			EJBGenerator generator = new EJBGenerator(go);
		    generator.generate();
		   
		    
		    //controller
			analyzer1.prepareModel();	
			GeneratorOptions go1 = ProjectOptions.getProjectOptions().getGeneratorOptions().get("SpringGeneratorController");			
			SpringGenerator generator1 = new SpringGenerator(go1);
			generator1.generate();
			
			
			//repository
			analyzer2.prepareModel();	
			GeneratorOptions go2 = ProjectOptions.getProjectOptions().getGeneratorOptions().get("SpringGenerator");			
			SpringGenerator generator2 = new SpringGenerator(go2);
			generator2.generate();
			
			
			//service
			analyzer3.prepareModel();	
			GeneratorOptions go3 = ProjectOptions.getProjectOptions().getGeneratorOptions().get("SpringGeneratorService");			
			SpringGenerator generator3 = new SpringGenerator(go3);
			generator3.generate();
		
			
			//serviceImpl
			analyzer4.prepareModel();	
			GeneratorOptions go4 = ProjectOptions.getProjectOptions().getGeneratorOptions().get("SpringGeneratorServiceImpl");			
			SpringGenerator generator4 = new SpringGenerator(go4);
			generator4.generate();
			
			//front
			analyzer5.prepareModel();	
			GeneratorOptions go5 = ProjectOptions.getProjectOptions().getGeneratorOptions().get("FrontGenerator");			
			SpringGenerator generator5 = new SpringGenerator(go5);
			generator5.generate();
			
			analyzer6.prepareModel();	
			GeneratorOptions go6 = ProjectOptions.getProjectOptions().getGeneratorOptions().get("IndexGenerator");			
			SpringGenerator generator6 = new SpringGenerator(go6);
			generator6.generate();
			
			analyzer7.prepareModel();	
			GeneratorOptions go7 = ProjectOptions.getProjectOptions().getGeneratorOptions().get("FilterGenerator");			
			SpringGenerator generator7 = new SpringGenerator(go7);
			generator7.generate();
			
			
			/**  @ToDo: Also call other generators */ 
			JOptionPane.showMessageDialog(null, "Code is successfully generated! Generated code is in folder: " + go.getOutputPath() 
					         );
			exportToXml();
		} catch (AnalyzeException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		} 			
	}
	
	private void exportToXml() {
		if (JOptionPane.showConfirmDialog(null, "Do you want to save FM Model?") == 
			JOptionPane.OK_OPTION)
		{	
			JFileChooser jfc = new JFileChooser();
			if (jfc.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
				String fileName = jfc.getSelectedFile().getAbsolutePath();
			
				XStream xstream = new XStream(new DomDriver());
				BufferedWriter out;		
				try {
					out = new BufferedWriter(new OutputStreamWriter(
							new FileOutputStream(fileName), "UTF8"));					
					xstream.toXML(FMModel.getInstance().getClasses(), out);
					xstream.toXML(FMModel.getInstance().getEnumerations(), out);
					
				} catch (UnsupportedEncodingException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				} catch (FileNotFoundException e) {
					JOptionPane.showMessageDialog(null, e.getMessage());				
				}		             
			}
		}	
	}	  

}