package Test

/**
 * It represents the general answer information.
 */
class Answer {

    UUID id
    // Attributes
    boolean correct
    String description
    Integer questionAnswerCount = 0
    Integer score
    String titleAnswerKey

    // Relations
    static hasMany = [questionsAnswer:Question]
    static belongsTo = Question

    // It obtains the number of questions that contains the answer
    Integer getQuestionsAnswerCount () {
        questionsAnswer?.size () ?: 0
    }

    def beforeInsert() {
        this.beforeUpdate()
    }

    void beforeUpdate () {
        questionAnswerCount = getQuestionsAnswerCount ()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        description blank: false, maxSize: 400
        score blank: false, min: 0, max: 5
        titleAnswerKey blank: false, unique: true, maxSize: 50
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
