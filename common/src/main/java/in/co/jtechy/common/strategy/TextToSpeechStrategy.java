package in.co.jtechy.common.strategy;

import com.fasterxml.jackson.annotation.JsonIgnoreType;
import in.co.jtechy.common.model.AbstractEntity;

@JsonIgnoreType
public interface TextToSpeechStrategy {

    void textToSpeech(AbstractEntity abstractEntity);
}
