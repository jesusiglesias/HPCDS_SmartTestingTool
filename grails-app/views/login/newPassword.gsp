<!-------------------------------------------------------------------------------------------*
 *                                       NEW PASSWORD                                        *
 *------------------------------------------------------------------------------------------->

<html>
<!-- HEAD -->
<head>

    <meta name="layout" content="main_login"/>
    <title><g:message code="views.login.auth.newPassword.head.title" default="STT | New password"/></title>

</head> <!-- /.HEAD -->

<!-- BODY -->
<body>

<!-- Authentication -->
<div class="content">
    <!-- Forgot password form -->
    <g:form class="forget-form" controller="customTasksUser" action="updatePass" method="post" autocomplete="off">

        <div class="form-title newPassword-form">
            <span class="form-title"><g:message code="views.login.auth.newPassword.title" default="New password"/></span>
            <p>
                <span class="form-subtitle"><g:message code="views.login.auth.newPassword.subtitle" default="Please, you make sure to read the following instructions:"/></span>
            </p>
        </div>

        <!-- Accordion -->
        <div class="portlet-body">
            <div class="panel-group accordion" id="accordionNewPassword">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle accordion-toggle-styled" data-toggle="collapse" data-parent="#accordionNewPassword" href="#collapseNewPassword"> <g:message code="views.login.auth.newPassword.description" default="New password instructions"/> </a>
                        </h4>
                    </div>
                    <div id="collapseNewPassword" class="panel-collapse in">
                        <div class="panel-body">
                            <ul>
                                <li> <g:message code="views.login.auth.newPassword.longitude" default="It must contain a minimum length of 8 characters."/> </li>
                                <li> <g:message code="views.login.auth.newPassword.number" default="It must contain at least one number."/> </li>
                                <li> <g:message code="views.login.auth.newPassword.lowercase" default="It must contain at least one lowercase letter."/> </li>
                                <li> <g:message code="views.login.auth.newPassword.uppercase" default="It must contain at least one uppercase letter."/> </li>
                                <li> <g:message code="views.login.auth.newPassword.whitespace" default="It must not contain whitespaces."/> </li>
                                <li> <g:message code="views.login.auth.newPassword.character" default="It can contain special characters."/> </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Failure alert -->
        <g:if test='${flash.errorNewPassword}'>
            <div class="alert alert-block alert-danger alert-danger-custom alert-dismissable alert-newPassword fade in">
                <button type="button" class="close" data-dismiss="alert"></button>
                <h5 class="alert-heading alert-reauthentication">${raw(g.message(code:'views.login.auth.error.title', default:'<strong>Error!</strong>'))} </h5>
                <p> ${raw(flash.errorNewPassword)} </p>
            </div>
        </g:if>

        <!-- Password field -->
        <div class="form-group form-md-line-input form-md-floating-label has-success">
            <div class="input-icon right">
                <g:field type="password" class="form-control" id="password" name="password" autocomplete="off"/>
                <label for="password"><g:message code="views.login.auth.newPassword.password" default="New password"/></label>
                <span class="help-block"><g:message code="views.login.auth.newPassword.password.help" default="Enter a valid password"/></span>
                <i class="fa fa-key"></i>
            </div>
        </div>

        <!-- Password confirm field -->
        <div class="form-group form-md-line-input form-md-floating-label has-success">
            <div class="input-icon right">
                <g:field type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" autocomplete="off"/>
                <label for="passwordConfirm"><g:message code="views.login.auth.newPassword.passwordConfirm" default="Confirm password"/></label>
                <span class="help-block"><g:message code="views.login.auth.newPassword.passwordConfirm.help" default="Repeat your password"/></span>
                <i class="fa fa-key"></i>
            </div>
        </div>

        <!-- Token -->
        <g:hiddenField name="token" value="${params.token}"/>

        <div class="form-actions">
            <g:link type="button" uri="/" id="back-btn" class="btn green-dark back-button"><g:message code="views.login.auth.forgotPassword.back" default="Back"/></g:link>
            <g:submitButton name="${g.message(code:'views.login.auth.newPassword.send', default:'Confirm')}" id="newPassword-button" class="btn green-dark pull-right"/>
        </div>
    </g:form> <!-- /. Forgot password form -->
</div> <!-- /.Authentication -->

<g:javascript src="authentication/newPassword.js"/>

</body>
</html>