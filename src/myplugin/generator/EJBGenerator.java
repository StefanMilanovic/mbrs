package myplugin.generator;

import java.io.IOException;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;

/**
 * EJB generator that now generates incomplete ejb classes based on MagicDraw
 * class model
 * 
 * @ToDo: enhance resources/templates/ejbclass.ftl template and intermediate
 *        data structure (@see myplugin.generator.fmmodel) in order to generate
 *        complete ejb classes
 */

public class EJBGenerator extends BasicGenerator {

	public EJBGenerator(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}

	public void generate() {

		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}

		List<FMClass> classes = FMModel.getInstance().getClasses();
		List<FMClass> classes2 = FMModel.getInstance().getClasses();
		
		
		for (int i = 0; i < classes.size(); i++) {
			FMClass cl = classes.get(i);
			
			for (int i1 = 0; i1 < classes2.size(); i1++) {
				//cl.addClasses(new FMClasses(classes2.get(i).getName()));
			}
			Writer out;
			Map<String, Object> context = new HashMap<String, Object>();
			try {
				out = getWriter(cl.getName(), cl.getTypePackage());
				if (out != null) {
					context.clear();
				//	context.put("classes",cl.getClasses());
					context.put("classes", classes);
					context.put("class", cl);
					context.put("properties", cl.getProperties());
					context.put("noIds", cl.getPropertiesNoId());
					context.put("propertiesStrings", cl.getPropertiesStrings());
					context.put("importedPackages", cl.getImportedPackages());
					getTemplate().process(context, out);
					out.flush();
				}
			} catch (TemplateException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
			} catch (IOException e) {
				JOptionPane.showMessageDialog(null, e.getMessage());
			}
		}
	}
}
