// Place your Spring DSL code here
beans = {

    // Register custom authentication bean
    userDetailsService(Security.CustomSecUserDetailsService)
}
