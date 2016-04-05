package User

import Enumerations.Sex
import Security.SecUser
import org.grails.databinding.BindingFormat

/**
 * It represents the general user information.
 */
class User extends SecUser {

    UUID id
    // Attributes
    String address
    @BindingFormat('dd-MM-yyyy')
    Date birthDate
    String city
    String country
    Integer evaluationCount = 0
    String name
    String phone
    Sex sex
    String surname

    // Relations
    static belongsTo = [department:Department]
    static hasMany = [evaluations:Evaluation]

    // It obtains the number of evaluations that has the user
    Integer getEvaluationsCount () {
        evaluations?.size () ?: 0
    }

    def beforeInsert() {
        encodePassword()

        this.beforeUpdate()
    }

    def beforeUpdate () {
        evaluationCount = getEvaluationsCount ()

        if (isDirty('password')) {
            encodePassword()
        }
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        address nullable: true, blank: false, maxSize: 70
        birthDate blank:false, max: new Date()
        city nullable: true, blank: false, maxSize: 70
        country nullable: true, blank: false, maxSize: 70
        name blank: false, maxSize: 25
        phone nullable: true, blank: false, maxSize: 20
        sex blank: false, inList: [Sex.FEMALE, Sex.MALE]
        surname blank: false, maxSize: 40
    }

    // It modifies the id type
    static mapping = {
        id(generator: "uuid2", type: "uuid-binary", length: 16)
    }
}
