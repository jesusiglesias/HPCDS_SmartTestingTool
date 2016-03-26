/*-------------------------------------------------------------------------------------------*
 *                                         BOOTSTRAP                                         *
 *-------------------------------------------------------------------------------------------*/

import Test.Catalog
import Test.Topic
import User.Department
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.SecurityFilterPosition
import grails.util.Environment
import Security.*

/**
 * Configuration during application startup and destruction.
 */
class BootStrap {

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
        log.debug("BootStrap:init():createInitialDataDevTest")

        // It checks data existence
        if (!SecUser.count() && !SecRole.count()) {

            // Creating roles
            def adminRole = SecRole.findByAuthority('ROLE_ADMIN') ?: new SecRole(authority: 'ROLE_ADMIN')
            def userRole = SecRole.findByAuthority('ROLE_USER') ?: new SecRole(authority: 'ROLE_USER')

            // Creating new users
            def newAdmin = SecUser.findByUsername('admin_stt') ?: new SecUser( // Admin
                    username: 'admin_stt',
                    password: '7g4sOmmm',
                    email: 'info.smartestingtool@gmail.com')

            def newAdminUser = SecUser.findByUsername('admin_switch') ?: new SecUser( // Normal user to switch
                    username: 'admin_switch',
                    password: '7g4sOmmm',
                    email: 'admin_switch@stt.com')

            def newUser = SecUser.findByUsername('user_stt') ?: new SecUser( // Normal user
                    username: 'user_stt',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt.com')

            def newUser1 = SecUser.findByUsername('user_stt1') ?: new SecUser( // Normal user
                    username: 'user_stt1',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt1.com')

            def newUser2 = SecUser.findByUsername('user_stt2') ?: new SecUser( // Normal user
                    username: 'user_stt2',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt2.com')

            def newUser3 = SecUser.findByUsername('user_stt3') ?: new SecUser( // Normal user
                    username: 'user_stt3',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt3.com')

            def newUser4 = SecUser.findByUsername('user_stt4') ?: new SecUser( // Normal user
                    username: 'user_stt4',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt4.com')

            def newUser5 = SecUser.findByUsername('user_stt5') ?: new SecUser( // Normal user
                    username: 'user_stt5',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt5.com')

            def newUser6 = SecUser.findByUsername('user_stt6') ?: new SecUser( // Normal user
                    username: 'user_stt6',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt6.com')

            def newUser7 = SecUser.findByUsername('user_stt7') ?: new SecUser( // Normal user
                    username: 'user_stt7',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt7.com')

            def newUser8 = SecUser.findByUsername('user_stt8') ?: new SecUser( // Normal user
                    username: 'user_stt8',
                    password: '7g4sOmmm',
                    email: 'user_stt@stt8.com')

            // Creating new departments
            def iDDepartment = Department.findByName('Investigación + Desarrollo') ?: new Department(
                    name: 'Investigación + Desarrollo'
            )

            def securityDepartment = Department.findByName('Seguridad') ?: new Department(
                    name: 'Seguridad'
            )

            def productDepartment = Department.findByName('Ingeniería de producto') ?: new Department(
                    name: 'Ingeniería de producto'
            )

            def rrhhDepartment = Department.findByName('Recursos humanos') ?: new Department(
                    name: 'Recursos humanos'
            )

            def supportDepartment = Department.findByName('Soporte técnico') ?: new Department(
                    name: 'Soporte técnico'
            )

            // Creating new catalogs
            def iDcatalog = Catalog.findByName('Catálogo I+D') ?: new Catalog(
                    name: 'Catálogo I+D'
            )

            def securityCatalog = Catalog.findByName('Seguridad inicial') ?: new Catalog(
                    name: 'Seguridad inicial'
            )

            // Creating new topics
            def englishTopic = Topic.findByName('Inglés') ?: new Topic(
                    name: 'Inglés',
                    description: 'Descripción 1'
            )

            def arquitecturaComputadoresTopic = Topic.findByName('Arquitectura de computadores') ?: new Topic(
                    name: 'Arquitectura de computadores',
                    description: 'Descripción 2'
            )

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
                newUser1.save(flush: true, failOnError: true)
                newUser2.save(flush: true, failOnError: true)
                newUser3.save(flush: true, failOnError: true)
                newUser4.save(flush: true, failOnError: true)
                newUser5.save(flush: true, failOnError: true)
                newUser6.save(flush: true, failOnError: true)
                newUser7.save(flush: true, failOnError: true)
                newUser8.save(flush: true, failOnError: true)
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

                // Saving departments
                iDDepartment.save(flush: true, failOnError: true)
                securityDepartment.save(flush: true, failOnError: true)
                productDepartment.save(flush: true, failOnError: true)
                rrhhDepartment.save(flush: true, failOnError: true)
                supportDepartment.save(flush: true, failOnError: true)

                // Saving catalogs
                iDcatalog.save(flush: true, failOnError: true)
                securityCatalog.save(flush: true, failOnError: true)

                // Saving topics
                arquitecturaComputadoresTopic.save(flush: true, failOnError: true)
                englishTopic.save(flush: true, failOnError: true)

                log.debug("BootStrap:init():Initial data have been created")
                log.info("Special config create for development or test - Users: admin_stt/7g4sOmmm (Admin), admin_switch/7g4sOmmm (User) and user_stt/7g4sOmmm (User)")
            } else {
                log.error("BootStrap:init():Initial data have not been created. You verify that the initial data complies with the rules")
            }
        } else {
            log.warn("BooStrap:init():Initial data existing")
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
                    password: '7g4sOmmm',
                    email: 'info.smartestingtool@gmail.com')

            def newAdminUser = SecUser.findByUsername('admin_switch') ?: new SecUser( // Normal user to switch
                    username: 'admin_switch',
                    password: '7g4sOmmm',
                    email: 'admin_switch_prod@stt.com')

            //----------TEST TODO
            def newUser = SecUser.findByUsername('user_stt') ?: new SecUser( // Normal user
                    username: 'user_stt',
                    password: '7g4sOmmm',
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
                log.error("BootStrap:init():Admin users have not been created. You verify that the initial data complies with the rules")

            }
        } else {
            log.error("BooStrap:init():Existing admin or role data. Initial data were not created")
        }
    }

}