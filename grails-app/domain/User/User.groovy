package User

import Enumerations.Sex
import Security.SecUser
import java.text.ParsePosition
import java.text.SimpleDateFormat

/**
 * It represents the general user information.
 */
class User extends SecUser {

    UUID id
    // Attributes
    String address
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
        this.beforeUpdate()
    }

    def beforeUpdate () {
        evaluationCount = getEvaluationsCount ()
    }

    // Restrictions on the attributes of the entity
    static constraints = {
        address nullable: true, blank: false, maxSize: 70
        birthDate blank:false, max: new Date(),
                validator: { v ->
                    def dateFormat = new SimpleDateFormat('dd-MMM-yyyy')
                    dateFormat.lenient = false
                    // Parse will return null if date was unparseable
                    return dateFormat.parse(v as String, new ParsePosition(0)) ? true : false
                }
        city nullable: true, blank: false, maxSize: 100
        country nullable: true, blank: false, maxSize: 100
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
