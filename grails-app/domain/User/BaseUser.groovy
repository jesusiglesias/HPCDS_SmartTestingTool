package User

/**
 * It represents the minimum user information
 */
class BaseUser {

    String email
    UUID idUser
    String name
    String password
    String surname

    static constraints = {
    }
}
