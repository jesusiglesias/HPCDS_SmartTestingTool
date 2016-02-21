<!-------------------------------------------------------------------------------------------*
 *                                       AUTHENTICATION                                      *
 *------------------------------------------------------------------------------------------->

<!DOCTYPE html>
  <!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
  <!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
  <!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
  <!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
  <!--[if (gt IE 9)|!(IE)]><!-->
    <html lang="en" class="no-js">
  <!--<![endif]-->

<!-- HEAD -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><g:message code="views.login.auth.head.title" default="Smart testing tool"/></title>

    <meta name="description" content="Smart Testing Tool is a HP CDS solution for online evaluation of different subjects through testing that
    it intended as a tool for internal qualification of personnel."/>
    <meta name="author" content="Jesús Iglesias García"/>
    <meta name="keywords" content="HP CDS, Smart Testing Tool, online test, evaluation test, english testing tool, test online, evaluacion online, Jesus Iglesias, TFG, Universidad de Valladolid, UVa"/>

    <!-- FAVICON -->
    <link rel="shortcut icon" href="${assetPath(src: 'favicon/favicon.ico')}" type="image/x-icon">
    <link rel="icon" href="${assetPath(src: 'favicon/favicon.ico')}" type="image/x-icon">

    <!-- HUMANS.TXT -->
    <link type="text/plain" rel="author" href="${createLink(uri: '/humans.txt')}"/>

    <!-- GLOBAL MANDATORY STYLES -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.2.3/css/simple-line-icons.css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'uniform.default.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'custom.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/notification', file: 'sweetalert2.css')}" type="text/css"/>


        <!-- PAGE LEVEL PLUGINS -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2-bootstrap.min.css')}" type="text/css"/>

    <!-- THEME GLOBAL STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'components-md.css')}" type="text/css" id="style_components"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'plugins-md.css')}" type="text/css"/>

    <!-- PAGE LEVEL STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css/authentication', file: 'authentication.css')}" type="text/css"/>

    <!-- LOAD JS -->
    <asset:javascript src="application.js"/>
    <!-- Notification -->
    <g:javascript src="notification/sweetalert2.min.js"/>

    <!-- HTML5 SHIV, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
		<script src="/js/html5shiv.min.js" type="text/javascript"></script>
    <![endif]-->

</head> <!-- /.HEAD -->

<!-- BODY -->
<body class=" login">

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

    <!-- Logo -->
    <div class="logo">
        <g:link uri="/">
            <asset:image src="logo/logo_auth.png" alt="SMART TESTING TOOL"/>
        </g:link>
    </div>

    <!-- Authentication -->
    <div class="content">
        <!-- Section to hide -->
        <div class="auth-section">
            <div class="form-title">
                <span class="form-title"><g:message code="views.login.auth.form.title" default="Welcome."/></span>
                <span class="form-subtitle"><g:message code="views.login.auth.form.subtitle" default="Please login."/></span>
            </div>

            <!-- Not user notification  -->
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

            <!-- Invalid session notification -->
            <g:if test='${flash.errorLoginSession}'>
                <div class="alert alert-block alert-danger alert-danger-custom alert-dismissable alert-notuser-reauth-invalidsession fade in">
                    <button type="button" class="close" data-dismiss="alert"></button>
                    <h5 class="alert-heading alert-reauthentication">${raw(g.message(code:'views.login.auth.error.title', default:'<strong>Error!</strong>'))} </h5>
                    <p> ${flash.errorLoginSession} </p>
                </div>
            </g:if>
        </div>

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
                        <a href="javascript:;" id="forget-password" class="forget-password"><g:message code="views.login.auth.form.forgotPassword" default="Forgot Password?"/></a>
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
            <!-- Section to hide -->
            <div class="auth-section">
                <!-- Line -->
                <div class="login-options"></div>

                <!-- Create account button -->
                <div class="create-account">
                    <p>
                        <a href="javascript:;" class="btn grey-steel" id="register-btn"><g:message code="views.login.auth.form.createAccount" default="Create an account"/></a>
                    </p>
                </div>
            </div>
         </g:if>

        <!-- Forgot password form -->
        <form class="forget-form" action="" method="post">
            <div class="form-title">
                <span class="form-title"><g:message code="views.login.auth.forgotPassword.title" default="Forgot password?"/></span>
                <p>
                    <span class="form-subtitle"><g:message code="views.login.auth.forgotPassword.subtitle" default="Enter your e-mail to reset it."/></span>
                </p>
            </div>
            <div class="form-group form-md-line-input form-md-floating-label has-success">
                <div class="input-icon right">
                    <g:field type="email" class="form-control" id="email" name="email" autocomplete="off" />
                    <label for="email"><g:message code="views.login.auth.forgotPassword.email" default="Email"/></label>
                    <span class="help-block"><g:message code="views.login.auth.forgotPassword.email.help" default="Enter a valid email"/></span>
                    <i class="fa fa-envelope"></i>
                </div>
            </div>
            <div class="form-actions">
                <button type="button" id="back-btn" class="btn green-dark"><g:message code="views.login.auth.forgotPassword.back" default="Back"/></button>
                <g:submitButton name="${g.message(code:'views.login.auth.forgotPassword.submit', default:'Submit')}" id="submit" class="btn green-dark pull-right"/>
            </div>
        </form> <!-- /. Forgot password form -->
    </div> <!-- /.Authentication -->

    <!-- Only it shows when is root path. In reauthentication path does not show -->
    <g:if test='${!flash.reauthenticate}'>
        <!-- Section to hide -->
        <div class="auth-section">
            <div class="copyright"> 2016 © <g:link uri="http://es.linkedin.com/in/jesusgiglesias"> Jesús Iglesias García </g:link></div>
            <div class="logoHP">
                <g:link uri="https://www.hpcds.com/es/">
                    <asset:image src="logo/logo_hp.png" alt="HP CDS"/>
                </g:link>
            </div>
         </div>
    </g:if>

    <!-- Back to top -->
    <g:link href="#" class="back-to-top"><g:message code="views.general.backtotop" default="Top"/></g:link>

    <!-- LOAD JAVASCRIPT -->
    <!-- Enable responsive CSS code on browsers that don't support it -->
    <!--[if lt IE 9]>
    <script src="../js/respond.min.js"></script>
    <![endif]-->

    <!-- CORE PLUGINS -->
    <!-- TODO -->
    <g:javascript src="bootstrap.min.js"/>
    <g:javascript src="js.cookie.min.js"/>
    <g:javascript src="bootstrap-hover-dropdown.min.js"/>
    <g:javascript src="jquery.slimscroll.min.js"/>
    <g:javascript src="jquery.blockui.min.js"/>
    <g:javascript src="jquery.uniform.min.js"/>
    <g:javascript src="custom.js"/>

    <!-- THEME GLOBAL SCRIPT -->
    <g:javascript src="app.js"/>

    <!-- PAGE LEVEL SCRIPTS -->
    <g:javascript src="authentication/authentication.js"/>
    <g:javascript src="authentication/jquery.validate.min.js"/>
    <g:javascript src="authentication/additional-methods.min.js"/>
    <g:javascript src="authentication/select2.full.min.js"/>

</body>
</html>