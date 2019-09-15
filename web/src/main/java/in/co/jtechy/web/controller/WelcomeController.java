package in.co.jtechy.web.controller;

import in.co.jtechy.domain.model.User;
import in.co.jtechy.persistance.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

@Controller
public class WelcomeController {
	
	@Autowired 
	private UserRepository userRepository;

	@GetMapping(path = "/add") 
	public @ResponseBody String addNewUser(@RequestParam String name, @RequestParam String password) {
		User n = new User();
		n.setUserName(name);
		n.setPassword(password);
		userRepository.save(n);
		return "Saved";
	}

	@GetMapping(path = "/all")
	public @ResponseBody Iterable<User> getAllUsers() {
		return userRepository.findAll();
	}

	// inject via application.properties
	@Value("${welcome.message:test}")
	private String message = "Hello World";

	@RequestMapping("/")
	public String welcome(Map<String, Object> model) {
		model.put("message", this.message);
		return "welcome";
	}

}