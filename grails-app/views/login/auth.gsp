<!-------------------------------------------------------------------------------------------*
 *                                    AUTHENTICATION PAGE                                    *
 *------------------------------------------------------------------------------------------->

<html>
<!-- HEAD -->
<head>

    <meta name="layout" content="main_login"/>
    <title><g:message code="views.login.auth.head.title" default="Smart testing tool"/></title>

</head> <!-- /.HEAD -->

<!-- BODY -->
<body>

    <!-- Notifications TODO-->
    <!-- Error and invalid session notification -->
  <%--  <g:if test='${flash.errorLoginSession}'>
        <script>
            swal({
                title: 'Error',
                text: '${flash.errorLoginSession}',
                type: 'error',
                timer: 2000,
                confirmButtonText: 'Cool'
            });
        </script>
    </g:if> --%>

    <!-- Authentication -->
    <div class="content">

        <div class="form-title">
            <span class="form-title"><g:message code="views.login.auth.form.title" default="Welcome."/></span>
            <span class="form-subtitle"><g:message code="views.login.auth.form.subtitle" default="Please login."/></span>
        </div>

        <!-- Not user notification -->
        <g:if test='${flash.errorLoginUser}'>
            <div class="alert alert-danger alert-danger-custom alert-dismissable alert-notuser-reauth-invalidsession fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
                <span> ${raw(flash.errorLoginUser)} </span>
            </div>
        </g:if>

        <!-- Reauthenticate notification -->
        <g:if test='${flash.reauthenticate}'>
            <div class="alert alert-block alert-warning alert-warning-custom alert-dismissable alert-notuser-reauth-invalidsession fade in">
                <button type="button" class="close" data-dismiss="alert"></button>
                <h5 class="alert-heading alert-reauthentication">${raw(g.message(code:'views.login.auth.warning.title', default:'<strong>Warning!</strong>'))} </h5>
                <p> ${flash.reauthenticate} </p>
            </div>
        </g:if>

        <!-- Invalid session notification, authentication service exception -->
        <g:if test='${flash.errorInvalidSessionAuthenticationException}'>
            <div class="alert alert-block alert-danger alert-danger-custom alert-dismissable alert-notuser-reauth-invalidsession fade in">
                <button type="button" class="close" data-dismiss="alert"></button>
                <h5 class="alert-heading alert-reauthentication">${raw(g.message(code:'views.login.auth.error.title', default:'<strong>Error!</strong>'))} </h5>
                <p> ${flash.errorInvalidSessionAuthenticationException} </p>
            </div>
        </g:if>

        <!-- Login form -->
        <form action='${postUrl}' method='POST' class="login-form" autocomplete="on">

            <!-- Username/email Field -->
            <div class="form-group form-md-line-input form-md-floating-label has-success">
                <div class="input-icon right">
                    <g:textField class="form-control" id="username" name='stt_hp_username' value="${session['SPRING_SECURITY_LAST_USERNAME']}" autocomplete="on" />
                    <label for="username"><g:message code="views.login.auth.form.username/email" default="Username/Email"/></label>
                    <span class="help-block"><g:message code="views.login.auth.form.username/email.help" default="Enter a valid username or email"/></span>
                    <i class="icon-user"></i>
                </div>
            </div>

            <%-- TODO
            <!-- ie8, ie9 does not support html5 placeholder, so it just shows field title for that-->
                <label class="control-label visible-ie8 visible-ie9" for="username"><g:message code="views.login.auth.form.username/email" default="Username/Email"/></label>
                <g:field type="text" class="form-control form-control-solid placeholder-no-fix" id="username" name='stt_hp_username' placeholder='${message(code:"views.login.auth.form.username/email", default:"Username or email")}'
                         value="${session['SPRING_SECURITY_LAST_USERNAME']}" autocomplete="off"/>
            </div>--%>

            <!-- Password Field -->
            <div class="form-group form-md-line-input form-md-floating-label has-success">
                <div class="input-icon right">
                    <g:passwordField class="form-control" id="password" name='stt_hp_password' autocomplete="off" />
                    <label for="password"><g:message code="views.login.auth.form.password" default="Password"/></label>
                    <span class="help-block"><g:message code="views.login.auth.form.password.help" default="Enter your password"/></span>
                    <i class="fa fa-key"></i>
                </div>
            </div>

            <%--
            <div class="form-group">
                <!-- TODO -->
                <label class="control-label visible-ie8 visible-ie9" for="password"><g:message code="views.login.auth.form.password" default="Password"/></label>
                <g:field type="password" class="form-control form-control-solid placeholder-no-fix" id="password" name='stt_hp_password' placeholder='${message(code:"views.login.auth.form.password", default:"Password")}'
                          autocomplete="off"/>
            </div>--%>

            <!-- Remember me and password -->
            <div class="form-actions action-remember-password">
                <div class="pull-left">
                    <div class="md-checkbox rememberme">
                        <input type="checkbox" name='${rememberMeParameter}' id='remember_me' class="md-check" <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                        <label for="remember_me" class="">
                            <span></span>
                            <span class="check"></span>
                            <span class="box"></span>
                            <g:message code="views.login.auth.form.rememberme" default="Remember me"/>
                        </label>
                    </div>
                </div>

                <!-- Only it shows when is root path. In reauthentication path does not show -->
                <g:if test='${!flash.reauthenticate}'>
                    <!-- Forgot password -->
                    <div class="pull-right forget-password-block">
                        <g:link uri="/forgotPassword" id="forget-password" class="forget-password"><g:message code="views.login.auth.form.forgotPassword" default="Forgot Password?"/></g:link>
                    </div>
                </g:if>
            </div>

            <!-- Log in -->
            <div class="form-actions">
                <g:submitButton  name="${message(code: "views.login.auth.form.login.button", default: "Log in")}" id="login-button" class="btn green-dark btn-block"/>
            </div>
        </form> <!-- /.Authentication form -->

        <!-- Only it shows when is root path. In reauthentication path does not show -->
        <g:if test='${!flash.reauthenticate}'>
            <!-- Line -->
            <div class="login-options"></div>

            <!-- Create account button -->
            <div class="create-account">
                <p>
                    <a href="javascript:;" class="btn grey-steel signup-button" id="register-btn"><g:message code="views.login.auth.form.createAccount" default="Create an account"/></a>
                </p>
            </div>
         </g:if>
    </div> <!-- /.Authentication -->

    <!-- Only it shows when is root path. In reauthentication path is not displayed -->
    <g:if test='${!flash.reauthenticate}'>
        <div class="copyright"> 2016 © <g:link uri="http://es.linkedin.com/in/jesusgiglesias" class="author-link"> Jesús Iglesias García </g:link></div>
        <div class="logoHP">
            <g:link uri="https://www.hpcds.com/es/">
                <asset:image src="logo/logo_hp.png" alt="HP CDS"/>
            </g:link>
        </div>
    </g:if>

</body>
</html>