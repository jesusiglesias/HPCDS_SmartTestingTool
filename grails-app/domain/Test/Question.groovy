package Test

import Enumerations.DifficultyLevel

/**
 * It represents the general question information.
 */
class Question {

    // Attributes
    String description
    DifficultyLevel difficultyLevel
    String title

    // Restrictions on the attributes of the entity
    static constraints = {
    }
}
