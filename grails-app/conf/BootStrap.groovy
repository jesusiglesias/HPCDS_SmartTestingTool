/*-------------------------------------------------------------------------------------------*
 *                                         BOOTSTRAP                                         *
 *-------------------------------------------------------------------------------------------*/

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.SecurityFilterPosition
import grails.util.Environment
import Security.*

/**
 * Configuration during application startup and destruction.
 */
class BootStrap {

    def authenticationManager
    def concurrentSessionController
    def securityContextPersistenceFilter
    def authenticationProcessingFilter
    def concurrentSessionControlStrategy

    /**
     * Initial operations when application start.
     */
    def init = { servletContext ->

        // It establishes the sessionAuthenticationStrategy, hence, it is enforced at authentication time various rules about concurrent sessions
        // The filter calls the SessionRegistry for the given session id. If there is a session information and it is marked as expired, it forces a redirect to the provided 'expiredUrl'
        SpringSecurityUtils.clientRegisterFilter('concurrencyFilter', SecurityFilterPosition.CONCURRENT_SESSION_FILTER)
        authenticationProcessingFilter.sessionAuthenticationStrategy = concurrentSessionControlStrategy

        // Database populating depending on the environment
        switch (Environment.current) {
            case Environment.DEVELOPMENT:
                createInitialUsersDevTest()
                break;
            case Environment.TEST:
                createInitialUsersDevTest()
                break;
            case Environment.PRODUCTION:
                createInitialUsersProd()
                break;
        }
    }

    /**
     * Final operations when application finishes.
     */
    def destroy = {
    }

    /**
     * Populating the database in development or test environments.
     */
    void createInitialUsersDevTest() {
        log.debug("BootStrap:init():createInitialUsersDevTest")

        // It checks data existence
        if (!SecUser.count() && !SecRole.count()) {

            // Creating roles
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Creating new users
            def newAdmin = SecUser.findByUsername('admin_stt') ?: new SecUser( // Admin
                    username: 'admin_stt',
                    password: 'sttadmintfg',
                    email: 'admin_stt@stt.com')

            def newAdminUser = SecUser.findByUsername('admin_switch') ?: new SecUser( // Normal user to switch
                    username: 'admin_switch',
                    password: 'switchadmintfg',
                    email: 'admin_switch@stt.com')

            def newUser = SecUser.findByUsername('user_stt') ?: new SecUser( // Normal user
                    username: 'user_stt',
                    password: 'sttusertfg',
                    email: 'user_stt@stt.com')

            // Validation of new users
            def validAdmin = newAdmin.validate()
            def validAdminUser = newAdminUser.validate()
            def validUser = newUser.validate()

            if (validAdmin & validUser & validAdminUser) {
                // Saving roles
                adminRole.save(flush: true, failOnError: true)
                userRole.save(flush: true, failOnError: true)

                // Saving new users
                newAdmin.save(flush: true, failOnError: true)
                newUser.save(flush: true, failOnError: true)
                newAdminUser.save(flush: true, failOnError: true)

                // Assign user to role
                if (!newAdmin.authorities.contains(adminRole)) { // Admin
                    SecUserSecRole.create newAdmin, adminRole, true
                }
                if (!newAdminUser.authorities.contains(userRole)) { // Normal user to switch
                    SecUserSecRole.create newAdminUser, userRole, true
                }
                if (!newUser.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUser, userRole, true
                }

                log.debug("BootStrap:init():Base users have been created")
                log.info("Special config create for development or test: admin_stt/sttadmintfg, admin_switch/switchadmintfg and user_stt/sttusertfg")
            } else {
                log.error("BootStrap:init():Base users have not been created")
            }
        } else {
            log.warn("BooStrap:init():Existing user or role data")
        }
    }

    /**
     * Populating the database in production environment.
     */
    void createInitialUsersProd() {

        // It checks data existence
        if (!SecUser.count() && !SecRole.count()) {

            // Creating roles
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Creating new users
            def newAdmin = SecUser.findByUsername('admin_stt') ?: new SecUser( // Admin
                    username: 'admin_stt',
                    password: 'sttadminprod',
                    email: 'admin_stt_prod@stt.com')

            def newAdminUser = SecUser.findByUsername('admin_switch') ?: new SecUser( // Normal user to switch
                    username: 'admin_switch',
                    password: 'switchadminprod',
                    email: 'admin_switch_prod@stt.com')

            //----------TEST TODO
            def newUser = SecUser.findByUsername('user_stt') ?: new SecUser( // Normal user
                    username: 'user_stt',
                    password: 'sttuserprod',
                    email: 'user_stt_prod@stt.com')

            // Validation of new user
            def validAdmin = newAdmin.validate()
            def validAdminUser = newAdminUser.validate()
            // TODO
            def validUser = newUser.validate()
            // TODO
            if (validAdmin & validAdminUser & validUser) {
                // Saving roles
                adminRole.save(flush: true, failOnError: true)
                userRole.save(flush: true, failOnError: true)

                // Saving new users
                newAdmin.save(flush: true, failOnError: true)
                newAdminUser.save(flush: true, failOnError: true)

                //----------TEST TODO
                newUser.save(flush: true, failOnError: true)

                // Assign user to role
                if (!newAdmin.authorities.contains(adminRole)) { // Admin
                    SecUserSecRole.create newAdmin, adminRole, true
                }
                if (!newAdminUser.authorities.contains(userRole)) { // Normal user to switch
                    SecUserSecRole.create newAdminUser, userRole, true
                }

                //----------TEST TODO
                if (!newUser.authorities.contains(userRole)) { // Normal user
                    SecUserSecRole.create newUser, userRole, true
                }

            } else {
                log.error("BootStrap:init():Admin users have not been created")
            }
        } else {
            log.error("BooStrap:init():Existing admin or role data. Initial data were not created")
        }
    }

}