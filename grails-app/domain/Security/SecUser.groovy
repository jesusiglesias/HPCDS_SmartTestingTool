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

	// Attributes
	String username
	String password
	// Email field
	String email
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

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

	static transients = ['springSecurityService']

	// Restrictions on the attributes of the entity
	static constraints = {
		username blank: false, unique: true
		password blank: false
		email blank: false, unique: true, email: true
	}

	// It modifies the name of the password column in database
	static mapping = {
		password column: '`password`'
	}
}
