package Test

import User.Evaluation

/**
 * It represents the general test information.
 */
class Test {

    UUID id
    // Attributes
    boolean active = true
    String description
    Date endDate
    Date initDate
    Integer lockTime = 0
    Integer maxAttempts
    String name
    Integer numberOfQuestions

    // Relations
    static hasMany = [evaluationsTest: Evaluation]
    static belongsTo = [topic: Topic, catalog: Catalog]

    // Restrictions on the attributes of the entity
    static constraints = {
        active blank: false
        description blank: false, maxSize: 800
        endDate blank: false, validator: { val, obj ->
                if (!val?.after(obj.initDate)) return ['endDateFail']
            }
        initDate blank: false, min: new Date()
        lockTime blank:false
        maxAttempts blank:false, min: 0, max: 5
        name blank: false, unique: true, maxSize: 60
        numberOfQuestions blank: false, validator: { val, obj ->
            if (val > obj.catalog.questions.size()) return ['numberOfQuestionsFail']
        }
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}