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
        name blank: false, unique: true, maxSize: 50
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}