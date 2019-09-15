package in.co.jtechy.common.model;

import in.co.jtechy.common.strategy.TextToSpeechStrategy;

import javax.persistence.*;
import java.util.List;

@MappedSuperclass
public abstract class AbstractEntity extends AuditEntity{

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "category")
    private String category;

    @Column(name = "rank")
    private Integer rank;

    @Column(name = "details")
    @Lob
    private String details;

    @Transient
    private List<Field> fields;

    @Transient
    private String textToSpeech;

    @Transient
    private TextToSpeechStrategy textToSpeechStrategy;

    public TextToSpeechStrategy getTextToSpeechStrategy() {
        return textToSpeechStrategy;
    }

    public void setTextToSpeechStrategy(TextToSpeechStrategy textToSpeechStrategy) {
        this.textToSpeechStrategy = textToSpeechStrategy;
    }

    public void textToSpeech(){
        textToSpeechStrategy.textToSpeech(this);
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public List<Field> getFields() {
        return fields;
    }

    public void setFields(List<Field> fields) {
        this.fields = fields;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public String getTextToSpeech() {
        return textToSpeech;
    }

    public void setTextToSpeech(String textToSpeech) {
        this.textToSpeech = textToSpeech;
    }

}
