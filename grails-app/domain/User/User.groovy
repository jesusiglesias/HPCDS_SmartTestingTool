package User

import Enumerations.Sex

/**
 * It represents the general user information.
 */
class User {

    // Attributes
    String address
    String avatar
    Date birthDate
    String city
    String country
    String name
    String phone
    Sex sex
    String surname
    Integer zipCode

    // Restrictions on the attributes of the entity
    static constraints = {
    }
}
