package in.co.jtechy.web.controller;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import in.co.jtechy.common.model.Field;
import in.co.jtechy.common.util.FieldUtil;
import in.co.jtechy.domain.model.Concept;
import in.co.jtechy.persistance.repository.ConceptRepository;
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
import java.util.List;

@Controller
@RequestMapping(value="/concept")
public class ConceptController extends AbstractController{
	
	@Autowired 
	private ConceptRepository conceptRepository;
	
	//create
	@RequestMapping(method = RequestMethod.GET, value = "/createconcept")
	public ModelAndView createConcept() throws NoSuchMethodException, SecurityException, InstantiationException,
			IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		return new ModelAndView("addconcept", "concept", new Concept());
	}
	
	//read
	@RequestMapping(method = RequestMethod.GET, value = "/readconcept/{conceptName}/{depth}")
	public ModelAndView readConcept(@PathVariable String conceptName, @PathVariable Integer depth) 
			throws InterruptedException, JsonParseException, JsonMappingException, IOException {
		ModelAndView model = new ModelAndView();
		List<Concept> concepts = conceptRepository.findByName(conceptName);
		if(!concepts.isEmpty()) {
			model.addObject("concept", concepts.get(0));
			List<Field> fields = mapper.readValue(concepts.get(0).getDetails(), new TypeReference<List<Field>>() {});
			concepts.get(0).setFields(fields);
		}
		model.addObject("depth", depth);
		model.setViewName("viewconcept");
		return model;
	}
	
	//update
	@RequestMapping(value = "/updateconcept/{id}", method = RequestMethod.GET)
	public ModelAndView updateConcept(@PathVariable Integer id)
			throws JsonParseException, JsonMappingException, IOException {
		Concept concept = conceptRepository.findById(id).orElse(new Concept());
		List<Field> fields = mapper.readValue(concept.getDetails(), new TypeReference<List<Field>>() {
		});
		concept.setFields(fields);
		return new ModelAndView("addconcept", "concept", concept); 
	}
	
	//save
	@RequestMapping(method = RequestMethod.POST, value = "/saveconcept")
	public ModelAndView saveConcept(@ModelAttribute Concept t, BindingResult result, ModelMap modelMap)
			throws JsonParseException, JsonMappingException, IOException, InterruptedException {
		String jsonStr = mapper.writeValueAsString(t);
		Concept concept = mapper.readValue(jsonStr, Concept.class);
		concept.setDetails(mapper.writeValueAsString(FieldUtil.filterFields(concept.getFields())));
		
		conceptRepository.save(concept);
		return readConcept(concept.getName(), 0); 
	}
	
	//delete
	@RequestMapping(method = RequestMethod.POST, value = "/deleteconcept")
	public ModelAndView deleteConcept(@ModelAttribute("id") Integer id) {
		conceptRepository.deleteById(id);
		ModelAndView model = new ModelAndView();
		model.addObject("list", conceptRepository.findAll());
		model.setViewName("listconcept");
		return model;
	}

}
