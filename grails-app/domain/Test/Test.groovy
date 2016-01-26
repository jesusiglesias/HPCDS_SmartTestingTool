package Test

import Enumerations.DifficultyLevel

/**
 * It represents the general test information.
 */
class Test {

    // Attributes
    boolean active = true
    String description
    DifficultyLevel difficultyLevel
    Date endDate
    Date initDate
    Integer lockTime = 0
    Integer maxAttempts
    String name
    Integer numberOfQuestions

    // Restrictions on the attributes of the entity
    static constraints = {
    }
}
