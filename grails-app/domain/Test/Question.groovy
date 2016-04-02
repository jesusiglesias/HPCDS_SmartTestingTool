package Test

import Enumerations.DifficultyLevel

/**
 * It represents the general question information.
 */
class Question {

    UUID id
    // Attributes
    Integer answerCount = 0
    Integer catalogCount = 0
    String description
    DifficultyLevel difficultyLevel
    String titleQuestionKey

    // Relations
    static hasMany = [answers:Answer, catalogs:Catalog]
    static belongsTo = Catalog

    // It obtains the number of answers that contains the question
    Integer getAnswersCount () {
        answers?.size () ?: 0
    }

    // It obtains the number of catalogs that contains the question
    Integer getCatalogsCount () {
        catalogs?.size () ?: 0
    }

    def beforeInsert() {
        this.beforeUpdate()
    }

    void beforeUpdate () {
        answerCount = getAnswersCount ()
        catalogCount = getCatalogsCount ()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        description blank: false, maxSize: 800
        difficultyLevel blank: false, inList: [DifficultyLevel.EASY, DifficultyLevel.MEDIUM, DifficultyLevel.DIFFICULT]
        titleQuestionKey blank: false, unique: true, maxSize: 50
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}