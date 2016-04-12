<%@ page import="org.springframework.validation.FieldError" %>

<!-------------------------------------------------------------------------------------------*
 *                                   REGISTER NEW ACCOUNT                                    *
 *------------------------------------------------------------------------------------------->

<html>
<!-- HEAD -->
<head>
    <meta name="layout" content="main_login"/>
    <title><g:message code="views.login.auth.register.head.title" default="STT | User registration"/></title>

    <script type="text/javascript">

        // Auto close alert
        function createAutoClosingAlert(selector) {

            var alert = $(selector);

            window.setTimeout(function () {
                alert.hide(1000, function () {
                    $(this).remove();
                });
            }, 5000);
        }

    </script>

</head> <!-- /.HEAD -->

<!-- BODY -->
<body>

    <!-- Register -->
    <div class="content content-register">
            <div class="form-title register-contentTitle">
                <span class="form-title title-register"><g:message code="views.login.auth.register.title" default="Join Smart testing tool"/></span>
                <p>
                    <span class="form-subtitle subtitle-register"><g:message code="views.login.auth.register.subtitle" default="Platform for the online evaluation."/></span>
                </p>
            </div>

            <!-- Alert -->
            <g:if test='${flash.errorRegisterMessage}'>
                <div class="alert alert-block alert-danger alert-danger-custom alert-dismissable alert-register fade in">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden='true'></button>
                    <p> ${raw(flash.errorRegisterMessage)} </p>
                </div>

                <g:javascript>
                    createAutoClosingAlert('.alert-register');
                </g:javascript>
            </g:if>

            <!-- Error in validation -->
            <g:hasErrors bean="${userRegisterInstance}">
                <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-register-error fade in'>
                    <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                    <g:eachError bean="${userRegisterInstance}" var="error">
                        <p role="status" class="xthin" <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
                    </g:eachError>
                </div>

                <g:javascript>
                </g:javascript>
            </g:hasErrors>

            <!-- Creation form -->
            <g:form controller="customTasksUser" action="saveUserRegistered" autocomplete="on" class="horizontal-form register-form">
                <fieldset class="form">
                    <g:render template="/login/formRegister"/>
                </fieldset>

                <div class="form-actions content-register-btn">
                    <g:link type="button" uri="/" id="back-btn" class="btn green-dark back-button"><g:message code="views.login.auth.newPassword.homepage" default="Homepage"/></g:link>
                    <g:submitButton name="${g.message(code:'views.login.auth.form.createAccount', default:'Sign up')}" id="register-button" class="btn green-dark pull-right"/>
                </div>
            </g:form> <!-- /. Register form -->
    </div> <!-- /.Register -->

</body>
</html>