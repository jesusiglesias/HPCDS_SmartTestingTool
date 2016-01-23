/*-------------------------------------------------------------------------------------------*
 *                                         BOOTSTRAP                                         *
 *-------------------------------------------------------------------------------------------*/

import Security.*

/**
 * Configuration during application startup and destruction
 */
class BootStrap {

    /**
     * Initial operations when application start
     */
    def init = { servletContext ->

        // Populating the database
        if (!SecUser.count() && !SecRole.count()) {

            // Creating roles
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Creating new users
            def newAdmin = SecUser.findByUsername('admin_stt') ?: new SecUser(
                    username: 'admin_stt',
                    password: 'sttadmintfg',
                    email: 'admin_stt@stt.com')
            def newUser = SecUser.findByUsername('user_stt') ?: new SecUser(
                    username: 'user_stt',
                    password: 'sttusertfg',
                    email: 'user_stt@stt.com')

            // Validation of new users
            def validAdmin = newAdmin.validate()
            def validUser = newUser.validate()

            if (validAdmin & validUser) {
                // Saving roles
                adminRole.save(flush: true, failOnError: true)
                userRole.save(flush: true, failOnError: true)

                // Saving new users
                newAdmin.save(flush: true, failOnError: true)
                newUser.save(flush: true, failOnError: true)

                // Assign user to role
                if (!newAdmin.authorities.contains(adminRole)) {
                    SecUserSecRole.create newAdmin, adminRole, true
                }
                if (!newUser.authorities.contains(userRole)) {
                    SecUserSecRole.create newUser, userRole, true
                }

                log.debug("BootStrap:init():Base users have been created")
            } else {
                log.error("BootStrap:init():Base users have not been created")
            }
        } else {
            log.debug("BooStrap:init():Existing user or role data")
        }
    }

    /**
     * Final operations when application finishes
     */
    def destroy = {
    }
}
