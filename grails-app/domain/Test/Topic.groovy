package Test

/**
 * It represents the general topic information.
 */
class Topic {

    UUID id
    // Attributes
    String description
    String name
    boolean visibility = true
    Integer testCount = 0

    static transients = ['testCount']

    // Relation
    static hasMany = [tests:Test]

    // It obtains the number of test that contains the topic
    Integer getTestsCount () {
        tests?.size () ?: 0
    }

    void beforeUpdate () {
        testCount = getTestsCount ()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        description blank: false, nullable: true, maxSize: 500
        name blank: false, unique: true, maxSize: 50
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}










