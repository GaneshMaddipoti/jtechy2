package in.co.jtechy.persistance.repository;

import java.util.List;

import in.co.jtechy.domain.model.User;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Integer> {
	
	List<User> findByUserName(String userName);

}
