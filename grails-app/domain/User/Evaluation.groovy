package User

import Test.Test

/**
 * It represents the general evaluation information.
 */
class Evaluation {

    UUID id
    // Attributes
    Integer attemptNumber
    String testName
    Integer testScore
    String usernameEval

    // Relations
    static belongsTo = [user:User, test:Test]

    // Restrictions on the attributes of the entity
    static constraints = {
        attemptNumber blank:false, min: 0, max: 5
        testName blank: false, maxSize: 60
        testScore blank: false, min: 0, max: 10
        usernameEval blank: false, unique: ['testName'], maxSize: 30
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
