package in.co.jtechy.web.strategy;

import in.co.jtechy.common.model.AbstractEntity;

import java.util.List;
import java.util.Map;

public interface EntitiesByCategoryStrategy<T extends AbstractEntity> {

    Map<String, List<T>> entitiesByCategory(Iterable<T> entities);

}
