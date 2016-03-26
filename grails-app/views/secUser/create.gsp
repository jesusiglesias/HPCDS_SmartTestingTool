<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.admin" default="STT | Administrators management"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/iCheck', file: 'green.css')}" type="text/css"/>

    <script>
        // Variables to use in script
        var _weak = '${g.message(code:'default.password.strength.weak', default:'Weak')}';
        var _normal = '${g.message(code:'default.password.strength.normal', default:'Normal')}';
        var _medium = '${g.message(code:'default.password.strength.medium', default:'Medium')}';
        var _strong = '${g.message(code:'default.password.strength.strong', default:'Strong')}';
        var _veryStrong = '${g.message(code:'default.password.strength.veryStrong', default:'Very strong')}';
        var _checkerUsernameBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.username', default:'Type an username and check its availability.')}';
        var _checkUsernameAvailibility = '${g.createLink(controller: "secUser", action: 'checkUsernameAvailibility')}';
        var _checkerEmailBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.email', default:'Type an email and check its availability.')}';
        var _checkEmailAvailibility = '${g.createLink(controller: "secUser", action: 'checkEmailAvailibility')}';
        var _requiredField = '${g.message(code:'default.validation.required', default:'This filed is required.')}';
        var _emailField = '${g.message(code:'default.validation.email', default:'Please, enter a valid email address.')}';
        var _equalPassword = '${raw(g.message(code:'default.password.notsame', default:'<strong>Password</strong> and <strong>Confirm password</strong> fields must match.'))}';

        // Handler auto close alert
        function createAutoClosingAlert(selector) {
            var alert = $(selector);
            window.setTimeout(function () {
                alert.slideUp(1000, function () {
                    $(this).remove();
                });
            }, 5000);
        }
    </script>
</head>
<body>

    <!-- Page-content-wrapper -->
    <div class="page-content-wrapper">
        <!-- Page-content -->
        <div class="page-content">
            <!-- Page-bar -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.admin" default="Administrator user"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/administrator"><g:message code="layouts.main_auth_admin.body.title.admin" default="Administrators management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.admin.create" default="Create administrator"/></small>
            </h3>

            <!-- Contain page -->
            <div id="create-domain">

                <!-- Accordion -->
                <div class="portlet-body">
                    <div class="panel-group accordion panel-instruction-create" id="accordionPassword">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a class="accordion-toggle accordion-toggle-styled" data-toggle="collapse" data-parent="#accordionPassword" href="#collapsePassword"> <g:message code="views.login.auth.newPassword.description" default="New password instructions"/> </a>
                                </h4>
                            </div>
                            <div id="collapsePassword" class="panel-collapse collapse">
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

                <!-- Alerts -->
                <g:if test="${flash.secUserErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span role="status"> ${raw(flash.secUserErrorMessage)} </span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:if>

                <!-- Error in validation -->
                <g:hasErrors bean="${secUserInstance}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <g:eachError bean="${secUserInstance}" var="error">
                            <p role="status" <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
                        </g:eachError>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:hasErrors>

                <!-- Creation form -->
                <g:form url="[resource:secUserInstance, action:'save']" autocomplete="on" class="horizontal-form admin-form">
                    <fieldset class="form">
                        <g:render template="form"/>
                    </fieldset>

                    <div class="domain-button-group">
                        <!-- Cancel button -->
                        <g:link type="button" uri="/administrator" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
                        <button type="submit" class="btn green-dark" name="create">
                            <i class="fa fa-check"></i>
                            <g:message code="default.button.create.label" default="Create"/>
                        </button>
                    </div>
                </g:form>
            </div> <!-- /.Content page -->
        </div> <!-- /.Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="iCheck/icheck.min.js"/>
    <g:javascript src="password/custom-password.js"/>
    <g:javascript src="password/pwstrength-bootstrap.min.js"/>
    <g:javascript src="domain-validation/admin-validation.js"/>

</body>
</html>
