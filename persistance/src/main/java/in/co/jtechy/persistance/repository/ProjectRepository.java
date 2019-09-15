package in.co.jtechy.persistance.repository;

import in.co.jtechy.domain.model.Project;
import org.springframework.data.repository.CrudRepository;

public interface ProjectRepository extends CrudRepository<Project, Integer> {

}
