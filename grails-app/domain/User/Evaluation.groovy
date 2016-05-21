package User

/**
 * It represents the general evaluation information.
 */
class Evaluation {

    UUID id
    // Attributes
    Integer attemptNumber
    Date completenessDate
    Integer maxAttempt
    String testName
    Float testScore

    // Relations
    static belongsTo = [user:User]

    // Restrictions on the attributes of the entity
    static constraints = {
        attemptNumber blank:false, min: 1, max: 5
        completenessDate nullable: true, blank: false
        maxAttempt blank:false, min: 1, max: 5
        testName blank: false, maxSize: 60
        testScore nullable: true, blank: false, scale: 2, min: 0.00 as Float, max: 10.00 as Float
        user blank: false, unique: ['testName'], maxSize: 30
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
