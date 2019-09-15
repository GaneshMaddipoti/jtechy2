package in.co.jtechy.persistance.repository;

import in.co.jtechy.domain.model.Blog;
import org.springframework.data.repository.CrudRepository;

public interface BlogRepository extends CrudRepository<Blog, Integer> {

}
