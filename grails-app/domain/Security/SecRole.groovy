package Security

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

/**
 * It represents the authority of a user.
 */
@EqualsAndHashCode(includes='authority')
@ToString(includes='authority', includeNames=true, includePackage=false)
class SecRole implements Serializable {

	private static final long serialVersionUID = 1

	// Attribute
	String authority

	/**
	 * It establishes the authority/role of a user.
	 *
	 * @param authority String that represents the role.
	 */
	SecRole(String authority) {
		this()
		this.authority = authority
	}

	// Restrictions on the attribute of the entity
	static constraints = {
		authority blank: false, unique: true
	}

	// It activates the cache functionality
	static mapping = {
		cache true
	}
}
