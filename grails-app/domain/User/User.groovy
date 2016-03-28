package User

import Enumerations.Sex
import Security.SecUser

/**
 * It represents the general user information.
 */
class User extends SecUser{

    UUID id
    // Attributes
    String address
    Date birthDate
    String city
    String country
    String name
    String phone
    Sex sex
    String surname
    Integer zipCode

    // Relations between entities
    //static belongsTo = [secUser: SecUser]
    static belongsTo = [department:Department]
    static hasMany = [evaluations:Evaluation]


    // Restrictions on the attributes of the entity
   /* static constraints = {
        address blank: false, maxSize: 50
        avatar  nullable: true, blank: false
        city    blank: true
        country nullable: true, blank: false
        name    nullable: true, blank: true  name blank: false, unique: true, maxSize: 50
        phone
        sex
        surname
        zipCode         zipCode(blank: false, size: 5..5, validator: {val, obj -> val?.isNumber()})
    }*/

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
