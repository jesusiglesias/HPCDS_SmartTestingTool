<!-------------------------------------------------------------------------------------------*
 *                                     RESTORE PASSWORD                                      *
 *------------------------------------------------------------------------------------------->

<html>
<!-- HEAD -->
<head>

    <meta name="layout" content="main_login"/>
    <title><g:message code="views.login.auth.forgotPassword.head.title" default="STT | Restore password"/></title>

</head> <!-- /.HEAD -->

<!-- BODY -->
<body>

    <script type="text/javascript">
        var _forgotPassword = '${g.message(code:'views.login.auth.forgotPassword.email.help', default:'Enter a valid email')}'
    </script>

    <!-- Authentication -->
    <div class="content">
        <!-- Forgot password form -->
        <g:form class="forget-form" controller="customTasksUser" action="sendEmail" method="post" autocomplete="on">

            <div class="form-title">
                <span class="form-title"><g:message code="views.login.auth.forgotPassword.title" default="Forgot password?"/></span>
                <p>
                    <span class="form-subtitle"><g:message code="views.login.auth.forgotPassword.subtitle" default="Enter your e-mail to reset it."/></span>
                </p>
            </div>

            <!-- Success alert -->
            <g:if test='${flash.successRestorePassword}'>
                <div class="alert alert-block alert-success alert-success-custom alert-dismissable alert-restorePassword fade in">
                    <button type="button" class="close" data-dismiss="alert"></button>
                    <p> ${raw(flash.successRestorePassword)} </p>
                </div>
            </g:if>

            <!-- Failure alert -->
            <g:if test='${flash.errorRestorePassword}'>
                <div class="alert alert-block alert-danger alert-danger-custom alert-dismissable alert-restorePassword fade in">
                    <button type="button" class="close" data-dismiss="alert"></button>
                    <h5 class="alert-heading alert-reauthentication">${raw(g.message(code:'views.login.auth.error.title', default:'<strong>Error!</strong>'))} </h5>
                    <p> ${raw(flash.errorRestorePassword)} </p>
                </div>
            </g:if>

            <div class="form-group form-md-line-input form-md-floating-label has-success">
                <div class="input-icon right">
                    <g:field type="email" class="form-control" id="email" name="email" autocomplete="on"/>
                    <label for="email"><g:message code="views.login.auth.forgotPassword.email" default="Email"/></label>
                    <span class="help-block"><g:message code="views.login.auth.forgotPassword.email.help" default="Enter a valid email"/></span>
                    <i class="fa fa-envelope"></i>
                </div>
            </div>

            <div class="form-actions">
                <g:link type="button" uri="/" id="back-btn" class="btn green-dark back-button"><g:message code="views.login.auth.forgotPassword.back" default="Back"/></g:link>
                <g:submitButton name="${g.message(code:'views.login.auth.forgotPassword.submit', default:'Submit')}" id="restore-button" class="btn green-dark pull-right"/>
            </div>
        </g:form> <!-- /. Forgot password form -->
    </div> <!-- /.Authentication -->

    <g:javascript src="authentication/resetPassword.js"/>

</body>
</html>