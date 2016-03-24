package User

/**
 * It represents the general department information.
 */
class Department {

    UUID id
    // Attributes
    String name

    // Relation
    static hasMany = [users:User]

    // Restrictions on the attributes of the entity
    static constraints = {
        name blank: false, maxSize: 30
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
