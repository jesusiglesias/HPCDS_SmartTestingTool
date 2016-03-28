package Security

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

/**
 * It represents the security information of a user.
 */
@EqualsAndHashCode(includes='username')
@ToString(includes='username', includeNames=true, includePackage=false)
class SecUser implements Serializable {

	private static final long serialVersionUID = 1

	transient springSecurityService

	UUID id
	// Attributes
	String username
	String password
	String confirmPassword // Plain text, not stored
	// Email field
	String email
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
	byte[] avatar
	String avatarType

	// Transient attributes
	static transients = ['springSecurityService', 'confirmPassword']

	/**
	 * It establishes the username and password of a user.
	 *
	 * @param username String that represents the username.
	 * @param password String that represents the password.
     */
	SecUser(String username, String password) {
		this()
		this.username = username
		this.password = password
	}

	/**
	 * It obtains the roles of the entity.
	 *
	 * @return roles Role/s of the user.
     */
	Set<SecRole> getAuthorities() {
		SecUserSecRole.findAllBySecUser(this)*.secRole
	}

	/**
	 * It encrypts password before inserting the entity.
	 */
	def beforeInsert() {
		encodePassword()
	}

	/**
	 * It encrypts password before updating the entity.
	 */
	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	/**
	 * It encrypts the user's password.
	 */
	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}

	// Restrictions on the attributes of the entity
	static constraints = {
		username blank: false, unique: true
		// Validator password
		password blank: false, matches: "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+\$).{8,}\$"
		email blank: false, unique: true, email: true
		confirmPassword bindable: true
		avatar nullable:true, maxSize: 1048576 /* 1MB */
		avatarType nullable:true, inList: ['image/png', 'image/jpeg', 'image/gif']
	}

	// It modifies the name of the password column in database
	static mapping = {
		id(generator: "uuid2", type: "uuid-binary", length: 16)
		password column: '`password`'
		// TODO
		tablePerHierarchy(false)
	}
}
