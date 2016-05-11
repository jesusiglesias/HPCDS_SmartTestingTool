<%@ page import="org.springframework.validation.FieldError" %>

<!-------------------------------------------------------------------------------------------*
 *                                   REGISTER NEW ACCOUNT                                    *
 *------------------------------------------------------------------------------------------->

<html>
<!-- HEAD -->
<head>
    <meta name="layout" content="main_login"/>
    <title><g:message code="views.login.auth.register.head.title" default="STT | User registration"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'bootstrap-select.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/date', file: 'bootstrap-datepicker3.min.css')}" type="text/css"/>
    <!-- Cookie message -->
    <g:javascript src="cookies/cookies.js"/>

    <script type="text/javascript">

        // Variables to use in script
        var _weak = '${g.message(code:'default.password.strength.weak', default:'Weak')}';
        var _normal = '${g.message(code:'default.password.strength.normal', default:'Normal')}';
        var _medium = '${g.message(code:'default.password.strength.medium', default:'Medium')}';
        var _strong = '${g.message(code:'default.password.strength.strong', default:'Strong')}';
        var _veryStrong = '${g.message(code:'default.password.strength.veryStrong', default:'Very strong')}';
        var _checkerUsernameBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.username', default:'Type a username and check its availability.')}';
        var _checkUsernameAvailibility = '${g.createLink(controller: "customTasksUser", action: 'checkUsernameRegisteredAvailibility')}';
        var _checkerEmailBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.email', default:'Type an email and check its availability.')}';
        var _checkEmailAvailibility = '${g.createLink(controller: "customTasksUser", action: 'checkEmailRegisteredAvailibility')}';
        var _requiredField = '${g.message(code:'default.validation.required', default:'This filed is required.')}';
        var _emailField = '${g.message(code:'default.validation.email', default:'Please, enter a valid email address.')}';
        var _equalPassword = '${raw(g.message(code:'default.password.notsame', default:'<strong>Password</strong> and <strong>Confirm password</strong> fields must match.'))}';
        var _equalPasswordUsername = '${raw(g.message(code:'default.password.username', default:'<strong>Password</strong> field must not be equal to username.'))}';
        var _maxlengthField = '${g.message(code:'default.validation.maxlength', default:'Please, enter less than {0} characters.')}';
        var _registering = '${g.message(code: "customTasksUser.user.registering", default: "Registering...")}';

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
                <span class="form-title title-register"><g:message code="views.login.auth.register.title" default="Join smart testing tool!"/></span>
                <p>
                    <span class="form-subtitle subtitle-register"><g:message code="views.login.auth.register.subtitle" default="Platform of online evaluation."/></span>
                </p>
            </div>

            <!-- Alert -->
            <g:if test='${flash.errorRegisterMessage}'>
                <div class="alert alert-block alert-danger alert-danger-custom alert-dismissable alert-register-error fade in">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden='true'></button>
                    <p> ${raw(flash.errorRegisterMessage)} </p>
                </div>

                <g:javascript>
                    createAutoClosingAlert('.alert-register-error');
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
                    createAutoClosingAlert('.alert-register-error');
                </g:javascript>
            </g:hasErrors>

            <!-- Creation form -->
            <g:form controller="customTasksUser" action="saveUserRegistered" autocomplete="off" class="horizontal-form register-form">
                <fieldset class="form form-responsive">
                    <g:render template="/login/formRegister"/>
                </fieldset>

                <!-- Checkbox agreement -->
                <div class="row text-center row-userLayoutTitle">
                    <div class="col-xs-2 col-xs-push-4 col-userLayoutTitle">
                        <div class="md-checkbox check-agreement">
                            <input type="checkbox" name='agreement_policy' id='agreement_policy' class="md-check"/>
                            <label for="agreement_policy" class="">
                                <span class=""></span>
                                <span class="check"></span>
                                <span class="box"></span>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="row text-center row-userLayoutTitle">
                    <div class="col-xs-12 col-userLayoutTitle">
                        <p class="text-agreement"><g:link uri="/cookiesPolicy"><g:message code="views.login.body.auth.register.agreement" default="By registering, you agree to our terms of service and privacy policy."/></g:link></p>
                    </div>
                </div>

                <div class="form-actions content-register-btn">
                    <g:link type="button" uri="/" id="back-btn" class="btn green-dark back-button"><g:message code="views.login.auth.newPassword.homepage" default="Homepage"/></g:link>
                    <button type="submit" id="register-button" class="btn green-dark pull-right">
                        <i class="fa fa-refresh refresh-icon-stop refreshIcon"></i>
                        <span><g:message code="views.login.auth.form.createAccount" default="Sign up"/></span>
                    </button>
                </div>
            </g:form> <!-- /. Register form -->
    </div> <!-- /.Register -->

    <!-- Cookie block - Template -->
    <g:render template="../template/cookieBanner"/>

    <!-- LOAD JAVASCRIPT  -->
    <g:javascript src="password/pwstrength-bootstrap.min.js"/>
    <g:javascript src="password/custom-passwordRegister.js"/>
    <g:javascript src="maxLength/bootstrap-maxlength.min.js"/>
    <g:javascript src="select/bootstrap-select.min.js"/>
    <g:javascript src="select/boostrap-select_i18n/defaults-es_CL.min.js"/>
    <g:javascript src="date/bootstrap-datepicker.min.js"/>
    <g:javascript src="date/bootstrap-datepicker.es.min.js"/>
    <g:javascript src="authentication/registerAccount.js"/>

</body>
</html>