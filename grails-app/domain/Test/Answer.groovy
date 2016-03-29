package Test

/**
 * It represents the general answer information.
 */
class Answer {

    UUID id
    // Attributes
    boolean correct
    String description
    Integer score
    Integer questionAnswerCount = 0

    static transients = ['questionAnswerCount']

    // Relations
    static hasMany = [questionsAnswer:Question]
    static belongsTo = Question

    // It obtains the number of questions that contains the answer
    Integer getQuestionsAnswerCount () {
        questionsAnswer?.size () ?: 0
    }

    void beforeUpdate () {
        questionAnswerCount = getQuestionsAnswerCount ()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        description blank: false, maxSize: 300
        score blank: false // TODO
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}