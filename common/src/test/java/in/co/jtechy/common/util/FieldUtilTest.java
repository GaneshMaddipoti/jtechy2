package in.co.jtechy.common.util;

import in.co.jtechy.common.model.Field;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertTrue;

public class FieldUtilTest {

    @org.junit.Test
    public void filterFields() {
        //Input
        List<Field> fields = new ArrayList<>();
        fields.add(new Field("type1", "name1", "desc1", "value1"));
        fields.add(new Field("type1", "", "desc1", "value1"));

        //test
        assertTrue(FieldUtil.filterFields(fields).size() == 1);
    }
}