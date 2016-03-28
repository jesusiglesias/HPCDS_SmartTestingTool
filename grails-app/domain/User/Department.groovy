package User

/**
 * It represents the general department information.
 */
class Department {

    UUID id
    // Attributes
    String name
    Integer userCount = 0

    static transients = ['userCount']

    // Relation
    static hasMany = [users:User]

    // It obtains the number of users that contains the department
    Integer getBookCount () {
        users?.size () ?: 0
    }

    void beforeUpdate () {
        userCount = getBookCount ()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        name blank: false, unique: true, maxSize: 50
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}