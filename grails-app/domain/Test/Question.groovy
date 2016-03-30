package Test

import Enumerations.DifficultyLevel

/**
 * It represents the general question information.
 */
class Question {

    UUID id
    // Attributes
    String description
    DifficultyLevel difficultyLevel
    String titleQuestionKey
    Integer answerCount = 0

    static transients = ['answerCount']

    // Relations
    static hasMany = [catalogs:Catalog, answers:Answer]
    static belongsTo = Catalog

    // It obtains the number of answers that contains the question
    Integer getAnswersCount () {
        answers?.size () ?: 0
    }

    void beforeUpdate () {
        answerCount = getAnswersCount ()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        titleQuestionKey blank: false, unique: true, maxSize: 50
        description blank: false, maxSize: 800
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}