package in.co.jtechy.web.controller;

import in.co.jtechy.domain.model.Course;
import in.co.jtechy.persistance.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.PostConstruct;

@Controller
@RequestMapping(value="/course")
public class CourseController extends AbstractController<Course>{

    @Autowired
    private CourseRepository courseRepository;

    @PostConstruct
    public void initialize() {
        classType = Course.class;
        crudRepository = courseRepository;
    }
}
