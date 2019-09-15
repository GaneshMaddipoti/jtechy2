package in.co.jtechy.web.controller;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import in.co.jtechy.common.model.Field;
import in.co.jtechy.common.util.FieldUtil;
import in.co.jtechy.domain.model.Project;
import in.co.jtechy.persistance.repository.ProjectRepository;
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
@RequestMapping(value = "/project")
public class ProjectController extends AbstractController {

	@Autowired
	private ProjectRepository projectRepository;

    public ProjectController() {
        System.out.println("dfd");
        projectRepository = projectRepository;
    }

    @RequestMapping(method = RequestMethod.GET, value = "/listproject")
	public ModelAndView listProject() throws InterruptedException {
		ModelAndView model = new ModelAndView();
		Map<String, List<Project>> resultMap = new HashMap<String, List<Project>>();

		for (Project project : projectRepository.findAll()) {
			if (resultMap.get(project.getCategory()) == null) {
				List<Project> projects = new ArrayList<Project>();
				projects.add(project);
				resultMap.put(project.getCategory(), projects);
			} else {
				List<Project> projects = resultMap.get(project.getCategory());
				projects.add(project);
			}
		}
		model.addObject("resultMap", resultMap);
		model.setViewName("listproject");
		return model;

	}

	@RequestMapping(method = RequestMethod.GET, value = "/addproject")
	public ModelAndView addProject() throws NoSuchMethodException, SecurityException, InstantiationException,
			IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		ModelAndView model = new ModelAndView();
		model.addObject("project", new Project());
		model.setViewName("addproject");
		return model;
	}

	@RequestMapping(value = "/projectdetails/{id}", method = RequestMethod.GET)
	public ModelAndView projectDetails(@PathVariable Integer id)
			throws JsonParseException, JsonMappingException, IOException {
		Project project = projectRepository.findById(id).orElse(new Project());
		List<Field> fields = mapper.readValue(project.getDetails(), new TypeReference<List<Field>>() {
		});
		for (Field field : fields) {
			field.setFieldValue(field.getFieldValue().replaceAll("\r\n", "<br/>"));
		}
		project.setFields(fields);
		return new ModelAndView("viewproject", "project", project);
	}

	@RequestMapping(value = "/modifyproject/{id}", method = RequestMethod.GET)
	public ModelAndView projectdetail(@PathVariable Integer id)
			throws JsonParseException, JsonMappingException, IOException {
		Project project = projectRepository.findById(id).orElse(new Project());
		List<Field> fields = mapper.readValue(project.getDetails(), new TypeReference<List<Field>>() {
		});
		project.setFields(fields);
		return new ModelAndView("addproject", "project", project);
	}

	@RequestMapping(method = RequestMethod.POST, value = "/saveproject")
	public ModelAndView saveProject(@ModelAttribute Project t, BindingResult result, ModelMap modelMap)
			throws JsonParseException, JsonMappingException, IOException, InterruptedException {
		String jsonStr = mapper.writeValueAsString(t);
		Project project = mapper.readValue(jsonStr, Project.class);
		project.setDetails(mapper.writeValueAsString(FieldUtil.filterFields(project.getFields())));

		projectRepository.save(project);
		return listProject();
	}

	@RequestMapping(method = RequestMethod.POST, value = "/deleteproject")
	public ModelAndView deleteProject(@ModelAttribute("id") Integer id) {
		projectRepository.deleteById(id);
		ModelAndView model = new ModelAndView();
		model.addObject("list", projectRepository.findAll());
		model.setViewName("listproject");
		return model;
	}

}
