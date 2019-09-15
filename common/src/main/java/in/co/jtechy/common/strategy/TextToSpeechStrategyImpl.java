package in.co.jtechy.common.strategy;

import com.fasterxml.jackson.annotation.JsonIgnoreType;
import in.co.jtechy.common.model.AbstractEntity;
import in.co.jtechy.common.model.Field;

@JsonIgnoreType
public class TextToSpeechStrategyImpl implements TextToSpeechStrategy{

    @Override
    public void textToSpeech(AbstractEntity abstractEntity) {
        StringBuilder sb = new StringBuilder();
        for(Field field : abstractEntity.getFields()) {
            sb.append(field.getFieldName()).append("!");
            sb.append(field.getFieldValue().replaceAll("<br/>", "!")).append("! !");
        }
        String tempStr = sb.toString();

        boolean flag = false;
        do{
            if(tempStr.contains("<div")) {
                String firstPart = tempStr.substring(0, tempStr.indexOf("<div"));
                String otherPart = tempStr.substring(tempStr.indexOf("<div"), tempStr.length());
                String secondPart = otherPart.substring(otherPart.indexOf("</div>") + 6, otherPart.length());
                tempStr = firstPart + secondPart;
                flag = true;
            }else {
                flag = false;
            }
        } while(flag);

        do{
            if(tempStr.contains("<img")) {
                String firstPart = tempStr.substring(0, tempStr.indexOf("<img"));
                String otherPart = tempStr.substring(tempStr.indexOf("<img"), tempStr.length());
                String secondPart = otherPart.substring(otherPart.indexOf(">") + 1, otherPart.length());
                tempStr = firstPart + secondPart;
                flag = true;
            }else {
                flag = false;
            }
        } while(flag);
        abstractEntity.setTextToSpeech(tempStr);
    }
}
