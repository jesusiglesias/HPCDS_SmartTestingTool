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

    <!-- Authentication -->
    <div class="content">
        <!-- Forgot password form -->
        <g:form class="forget-form" controller="customTasksUser" action="sendEmail" method="post">

            <div class="form-title">
                <span class="form-title"><g:message code="views.login.auth.forgotPassword.title" default="Forgot password?"/></span>
                <p>
                    <span class="form-subtitle"><g:message code="views.login.auth.forgotPassword.subtitle" default="Enter your e-mail to reset it."/></span>
                </p>
            </div>

            <g:if test="${errors}">
                <ul class="errors" role="alert">
                    <g:each in="${errors}" var="error">
                        <li class="error">
                            <g:message code="${error}" default="Error al procesar los datos"/>
                        </li>
                    </g:each>
                </ul>
            </g:if>

            <div class="form-group form-md-line-input form-md-floating-label has-success">
                <div class="input-icon right">
                    <g:field type="email" class="form-control" id="email" name="email" autocomplete="off"/>
                    <label for="email"><g:message code="views.login.auth.forgotPassword.email" default="Email"/></label>
                    <span class="help-block"><g:message code="views.login.auth.forgotPassword.email.help" default="Enter a valid email"/></span>
                    <i class="fa fa-envelope"></i>
                </div>
            </div>

            <div class="form-actions">
                <g:link type="button" uri="/" id="back-btn" class="btn green-dark back-button"><g:message code="views.login.auth.forgotPassword.back" default="Back"/></g:link>
                <g:submitButton name="${g.message(code:'views.login.auth.forgotPassword.submit', default:'Submit')}" id="submit" class="btn green-dark pull-right"/>
            </div>
        </g:form> <!-- /. Forgot password form -->
    </div> <!-- /.Authentication -->

</body>
</html>