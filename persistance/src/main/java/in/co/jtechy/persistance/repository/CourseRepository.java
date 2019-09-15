package in.co.jtechy.persistance.repository;

import in.co.jtechy.domain.model.Course;
import org.springframework.data.repository.CrudRepository;

public interface CourseRepository extends CrudRepository<Course, Integer> {

}
