package in.co.jtechy.web.controller;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import in.co.jtechy.common.model.Field;
import in.co.jtechy.common.util.FieldUtil;
import in.co.jtechy.domain.model.Tool;
import in.co.jtechy.persistance.repository.ToolRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/tool")
public class ToolController extends AbstractController{	
	
	@Autowired 
	private ToolRepository toolRepository;
	
	@RequestMapping(method = RequestMethod.GET, value = "/listtool")
	public ModelAndView listTool() throws InterruptedException {
		ModelAndView model = new ModelAndView();
		Map<String, List<Tool>> resultMap = new HashMap<String, List<Tool>>();
		
		for (Tool tool : toolRepository.findAll()) {
			if (resultMap.get(tool.getCategory()) == null) {
				List<Tool> tools = new ArrayList<Tool>();
				tools.add(tool);
				resultMap.put(tool.getCategory(), tools);
			} else {
				List<Tool> tools = resultMap.get(tool.getCategory());
				tools.add(tool);
			}
		}
		model.addObject("resultMap", resultMap);
		model.setViewName("listtool");
		return model;
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/addtool")
	public ModelAndView addTool() throws NoSuchMethodException, SecurityException, InstantiationException,
			IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		ModelAndView model = new ModelAndView();
		model.addObject("tool", new Tool());
		model.setViewName("addtool");
		return model;
	}
	
	@RequestMapping(value = "/tooldetails/{toolId}", method = RequestMethod.GET)
	public ModelAndView toolDetails(@PathVariable Integer toolId)
			throws JsonParseException, JsonMappingException, IOException {
		Tool tool = toolRepository.findById(toolId).orElse(new Tool());
		List<Field> fields = mapper.readValue(tool.getDetails(), new TypeReference<List<Field>>() {
		});
		for (Field field : fields) {
			field.setFieldValue(field.getFieldValue().replaceAll("\r\n", "<br/>"));
		}
		tool.setFields(fields);
		return new ModelAndView("viewtool", "tool", tool);
	}
	
	@RequestMapping(value = "/modifytool/{id}", method = RequestMethod.GET)
	public ModelAndView tooldetail(@PathVariable Integer id)
			throws JsonParseException, JsonMappingException, IOException {
		Tool tool = toolRepository.findById(id).orElse(new Tool());
		List<Field> fields = mapper.readValue(tool.getDetails(), new TypeReference<List<Field>>() {
		});
		tool.setFields(fields);
		return new ModelAndView("addtool", "tool", tool);
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/savetool")
	public ModelAndView saveTool(@ModelAttribute Tool t, BindingResult result, ModelMap modelMap)
			throws JsonParseException, JsonMappingException, IOException, InterruptedException {
		String jsonStr = mapper.writeValueAsString(t);
		Tool tool = mapper.readValue(jsonStr, Tool.class);
		tool.setDetails(mapper.writeValueAsString(FieldUtil.filterFields(tool.getFields())));
		
		toolRepository.save(tool);
		return listTool(); 
	}
	
	@RequestMapping(method = RequestMethod.POST, value = "/deletetool")
	public ModelAndView deleteTool(@ModelAttribute("id") Integer id) {
		toolRepository.deleteById(id);
		ModelAndView model = new ModelAndView();
		model.addObject("list", toolRepository.findAll());
		model.setViewName("listtool");
		return model;
	}

}
