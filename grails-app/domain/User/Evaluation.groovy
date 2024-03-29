package User

/**
 * It represents the general evaluation information.
 */
class Evaluation {

    UUID id
    // Attributes
    Integer attemptNumber
    Date completenessDate
    Date initDate
    Integer failedQuestions
    Integer maxAttempt
    Integer maxPossibleScore
    Integer questionsUnanswered
    Integer rightQuestions
    String testName
    Float testScore
    String userName

    // Restrictions on the attributes of the entity
    static constraints = {
        attemptNumber blank:false, min: 1, max: 5
        completenessDate nullable: true, blank: false
        initDate nullable: true, blank: false
        failedQuestions nullable: true, blank: false, min: 0
        maxAttempt blank:false, min: 1, max: 5
        maxPossibleScore nullable: true, blank: false, min: 0
        questionsUnanswered nullable: true, blank: false, min: 0
        rightQuestions nullable: true, blank: false, min: 0
        testName blank: false, maxSize: 60
        testScore nullable: true, blank: false, scale: 2, min: 0.00 as Float, max: 10.00 as Float
        userName blank: false, unique: ['testName'], maxSize: 30
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
