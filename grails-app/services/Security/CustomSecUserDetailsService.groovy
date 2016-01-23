package Security

import grails.transaction.Transactional
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.userdetails.GrailsUser
import grails.plugin.springsecurity.userdetails.GrailsUserDetailsService
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException

/**
 * It implements authentication by email or username
 */
@Transactional
class CustomSecUserDetailsService implements GrailsUserDetailsService {

    // Some Spring Security classes (e.g. RoleHierarchyVoter) expect at least * one role, so we give a user with
    // no granted roles this one which gets * past that restriction but doesn't grant anything.
    static final List NO_ROLES = [new SimpleGrantedAuthority(SpringSecurityUtils.NO_ROLE)]

    /**
     * Locates the user based on the username.
     *
     * @param username The username identifying the user whose data is required.
     * @param loadRoles Whether to load roles at the same time as loading the user.
     *
     * @return A fully populated user record (never <code>null</code>)
     *
     * @throws UsernameNotFoundException If the user could not be found
     */
    UserDetails loadUserByUsername(String username, boolean loadRoles) throws UsernameNotFoundException {
        return loadUserByUsername(username)
    }

    /**
     * Locates the user based on the email or username.
     *
     * @param username The username identifying the user whose data is required.
     *
     * @return A fully populated user record (never <code>null</code>)
     *
     * @throws UsernameNotFoundException If the user could not be found
     */
    UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        SecUser.withTransaction { status ->

            // It searches the user by email or username introduced
            SecUser user = SecUser.findByUsernameOrEmail(username, username)

            // User doesn't exist
            if (!user) throw new UsernameNotFoundException('User not found', username)

            def authorities = user.authorities.collect {new SimpleGrantedAuthority(it.authority)}

            return new GrailsUser(user.username, user.password, user.enabled, !user.accountExpired,
                    !user.passwordExpired, !user.accountLocked,
                    authorities ?: NO_ROLES, user.id)
        }
    }
}






