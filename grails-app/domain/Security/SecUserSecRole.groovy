package Security

import grails.gorm.DetachedCriteria
import groovy.transform.ToString
import org.apache.commons.lang.builder.HashCodeBuilder

/**
 * It represents the association between users and roles.
 */
@ToString(cache=true, includeNames=true, includePackage=false)
class SecUserSecRole implements Serializable {

	private static final long serialVersionUID = 1

	// Attributes
	SecUser secUser
	SecRole secRole

	/**
	 * It establishes the user and authority of an entity.
	 *
	 * @param u Its represents the user.
	 * @param r Its represents the role.
	 */
	SecUserSecRole(SecUser u, SecRole r) {
		this()
		secUser = u
		secRole = r
	}

	/**
	 * It checks if the objects are equal (the same SecUserId and SecRoleId), hence, representing the same relation.
	 *
	 * @param other Its represents another entity.
	 * @return false Returns false if the supplied object is not a SecUserSecRole instance with the same ids value.
     */
	@Override
	boolean equals(other) {
		if (!(other instanceof SecUserSecRole)) {
			return false
		}

		other.secUser?.id == secUser?.id && other.secRole?.id == secRole?.id
	}

	/**
	 * It establishes the hashCode.
	 *
	 * @return hashCode Hashcode of the SecUserSecRole pair.
     */
	@Override
	int hashCode() {
		def builder = new HashCodeBuilder()
		if (secUser) builder.append(secUser.id)
		if (secRole) builder.append(secRole.id)
		builder.toHashCode()
	}

	/**
	 * It obtains the pair of ids of the SecUser and SecRole.
	 *
	 * @param secUserId Id that represents to the SecUser.
	 * @param secRoleId Id that represents to the SecRole.
     * @return SecUserSecRole Data of the SecUser and SecRole got.
     */
	static SecUserSecRole get(UUID secUserId, long secRoleId) {
		criteriaFor(secUserId, secRoleId).get()
	}

	/**
	 * It checks if a couple of SecUser and SecRole entities exist.
	 *
	 * @param secUserId Id that represents to the SecUser.
	 * @param secRoleId Id that represents to the SecRole.
     * @return True If the SecUser and SecRole pair exists.
     */
	static boolean exists(UUID secUserId, long secRoleId) {
		criteriaFor(secUserId, secRoleId).count()
	}

	/**
	 * It searches the SecUser and SecRole in the database.
	 *
	 * @param secUserId Id that represents to the SecUser.
	 * @param secRoleId Id that represents to the SecRole.
     * @return DetachedCriteria Query that can be executed outside the scope of a session.
     */
	private static DetachedCriteria criteriaFor(UUID secUserId, long secRoleId) {
		SecUserSecRole.where {
			secUser == SecUser.load(secUserId) &&
			secRole == SecRole.load(secRoleId)
		}
	}

	/**
	 * It creates the new SecUserSecRole.
	 *
	 * @param secUser It represents to the user.
	 * @param secRole It represents to the role.
	 * @param flush It permits to indicate if the storage should be immediate.
     * @return instance SecUserSecRole instance.
     */
	static SecUserSecRole create(SecUser secUser, SecRole secRole, boolean flush = false) {
		def instance = new SecUserSecRole(secUser: secUser, secRole: secRole)
		instance.save(flush: flush, insert: true)
		instance
	}

	/**
	 * It removes a SecUserSecRole entity.
	 *
	 * @param u It represents to the user.
	 * @param r It represents to the role.
	 * @param flush It permits to indicate if the storage should be immediate.
     * @return rowCount Number of row that was removed.
     */
	static boolean remove(SecUser u, SecRole r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = SecUserSecRole.where { secUser == u && secRole == r }.deleteAll()

		if (flush) { SecUserSecRole.withSession { it.flush() } }

		rowCount
	}

	/**
	 * It removes all entries of a SecUser entity.
	 *
	 * @param u It represents to the user.
	 * @param flush It permits to indicate if the storage should be immediate.
     */
	static void removeAll(SecUser u, boolean flush = false) {
		if (u == null) return

		SecUserSecRole.where { secUser == u }.deleteAll()

		if (flush) { SecUserSecRole.withSession { it.flush() } }
	}

	/**
	 * It removes all entries of a SecRole entity.
	 *
	 * @param r It represents to the role.
	 * @param flush It permits to indicate if the storage should be immediate.
     */
	static void removeAll(SecRole r, boolean flush = false) {
		if (r == null) return

		SecUserSecRole.where { secRole == r }.deleteAll()

		if (flush) { SecUserSecRole.withSession { it.flush() } }
	}

	// Restrictions in the entity
	static constraints = {
		secRole validator: { SecRole r, SecUserSecRole ur ->
			if (ur.secUser == null || ur.secUser.id == null) return
			boolean existing = false
			SecUserSecRole.withNewSession {
				existing = SecUserSecRole.exists(ur.secUser.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	// It activates an id composite for the id of the SecUser entity and the id of the SecRole entity
	static mapping = {
		id composite: ['secUser', 'secRole']
		version false
	}
}
