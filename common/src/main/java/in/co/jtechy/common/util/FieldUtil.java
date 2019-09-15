package in.co.jtechy.common.util;

import in.co.jtechy.common.model.Field;

import java.util.ArrayList;
import java.util.List;

public class FieldUtil {
	
	public static List<Field> filterFields(List<Field> fields) {
		List<Field> resultList = new ArrayList<Field>();
		if (fields != null) {
			for (Field field : fields) {
				if (!StringUtil.isEmpty(field.getFieldName())) {
					resultList.add(field);
				}
			}
		}
		return resultList;
	}

}
