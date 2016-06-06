package Test

import User.Evaluation
import User.User

/**
 * It represents the general test information.
 */
class Test {

    UUID id
    // Attributes
    boolean active = true
    String description
    Date endDate
    boolean incorrectDiscount = false
    Date initDate
    Integer lockTime = 0
    Integer maxAttempts = 1
    String name
    Integer numberOfQuestions
    Integer penalty = 10
    Topic topic
    Catalog catalog

    // Relations
    static hasMany = [evaluationsTest: Evaluation, allowedUsers: User]
    static belongsTo = [User, Topic, Catalog]

    // Restrictions on the attributes of the entity
    static constraints = {
        active blank: false
        description blank: false, maxSize: 800
        endDate blank: false, validator: { val, obj ->
                if (val?.compareTo(obj.initDate) < 0) return ['endDateFail']
            }
        incorrectDiscount blank: false
        initDate blank: false, min: new Date().clearTime()
        lockTime blank:false, min: 0
        maxAttempts blank:false, min: 1, max: 5
        name blank: false, unique: true, maxSize: 60
        numberOfQuestions blank: false, min: 0
        penalty blank:false, min:0, max: 100
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}