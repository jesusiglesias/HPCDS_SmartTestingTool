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

    // Relations
    static hasMany = [answers:Answer, catalogs:Catalog]
    static belongsTo = Catalog

    // Restrictions on the attributes of the entity
    static constraints = {
        description blank: false, maxSize: 800
        difficultyLevel blank: false, inList: [DifficultyLevel.EASY, DifficultyLevel.MEDIUM, DifficultyLevel.DIFFICULT]
        titleQuestionKey blank: false, unique: true, maxSize: 25
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}