<%@ page import="org.springframework.validation.FieldError" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.myProfile" default="STT | My profile"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/normalUser', file: 'profile.css')}" type="text/css"/>

    <script>

        // Variables to use in script
        var _weak = '${g.message(code:'default.password.strength.weak', default:'Weak')}';
        var _normal = '${g.message(code:'default.password.strength.normal', default:'Normal')}';
        var _medium = '${g.message(code:'default.password.strength.medium', default:'Medium')}';
        var _strong = '${g.message(code:'default.password.strength.strong', default:'Strong')}';
        var _veryStrong = '${g.message(code:'default.password.strength.veryStrong', default:'Very strong')}';
        var _requiredField = '${g.message(code:'default.validation.required', default:'This field is required.')}';
        var _minlengthField = '${g.message(code:'default.validation.minlength', default:'Please, enter more than {0} characters.')}';
        var _maxlengthField = '${g.message(code:'default.validation.maxlength', default:'Please, enter less than {0} characters.')}';
        var _equalPassword = '${raw(g.message(code:'default.password.notsame', default:'<strong>Password</strong> and <strong>Confirm password</strong> fields must match.'))}';
        var _equalPasswordUsername = '${raw(g.message(code:'default.password.username', default:'<strong>Password</strong> field must not be equal to username.'))}';

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

    <!-- Horizontal menu -->
    <content tag="horizontalMenu">
        <div class="hor-menu hidden-sm hidden-xs">
            <ul class="nav navbar-nav">
                <li>
                    <g:link uri="/faq"><g:message code="layout.main_auth_user.horizontal.menu.faq" default="Help"/></g:link>
                </li>
                <li>
                    <g:link uri="/contact"><g:message code="layout.main_auth_user.horizontal.menu.contact" default="Contact"/></g:link>
                </li>
                <li>
                    <g:link uri="/cookiesPolicy"><g:message code="layout.main_auth_user.horizontal.menu.cookie" default="Cookies policy"/></g:link>
                </li>
            </ul>
        </div>
    </content>

    <!-- Responsive horizontal menu -->
    <content tag="responsiveHorizontalMenu">
        <li class="nav-item">
            <g:link uri="/faq" class="nav-link">
                <i class="icofont icofont-info"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.faq" default="Help"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
        <li class="nav-item">
            <g:link uri="/contact" class="nav-link">
                <i class="icofont icofont-speech-comments"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.contact" default="Contact"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
        <li class="nav-item">
            <g:link uri="/cookiesPolicy" class="nav-link">
                <i class="icofont icofont-file-text"></i>
                <span class="title"><g:message code="layout.main_auth_user.horizontal.menu.cookie" default="Cookies policy"/></span>
                <span class="arrow"></span>
            </g:link>
        </li>
    </content>

    <!-- Page-bar -->
    <div class="page-bar-user">
        <ul class="page-breadcrumb">
            <li>
                <i class="icofont icofont-ui-home"></i>
                <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span><g:message code="layouts.main_auth_user.body.title.myProfile" default="My profile"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-profile">
                <h3 class="page-title-user-profile-title">
                    <g:message code="layouts.main_auth_user.body.title.myProfile" default="My profile"/>
                </h3>

                <p class="page-title-user-profile-description">
                    ${raw(g.message(code: "layouts.main_auth_user.body.title.myProfile.description", default: "Data associated with your user account are displayed here. <strong>Remember:</strong> " +
                            "username can not be modified directly. Contact us for this."))}
                </p>
            </div>
        </div>
    </div>

    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Profile -->
            <div class="profile-sidebar">
                <!-- Sidebar - left -->
                <div class="portlet light customColor-profile profile-sidebar-portlet">

                    <!-- Personal information -->
                    <g:render template="information"/>

                    <!-- Menu -->
                    <div class="profile-usermenu">
                        <ul class="nav">
                            <li>
                                <g:link uri="/profile">
                                    <i class="icofont icofont-user-alt-2"></i>
                                    <g:message code="layouts.main_auth_user.content.myProfile.sidebar.personal" default="Personal information"/>
                                </g:link>
                            </li>
                            <li class="active">
                                <g:link uri="/profilePassword">
                                    <i class="icofont icofont-ui-password"></i>
                                    <g:message code="layouts.main_auth_user.content.myProfile.sidebar.password" default="Change password"/>
                                </g:link>
                            </li>
                            <li>
                                <g:link uri="/profileAvatar">
                                    <i class="icofont icofont-image"></i>
                                    <g:message code="layouts.main_auth_user.content.myProfile.sidebar.avatar" default="Change profile image"/>
                                </g:link>
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Statistics -->
                <g:render template="stats"/>
            </div>

            <!-- Personal information -->
            <div class="profile-content-password">
                <div class="row row-userLayoutTitle">
                    <div class="col-md-12 col-userLayoutTitle">

                        <!-- Alerts -->
                        <g:if test="${flash.userProfilePasswordMessage}">
                            <div class='alert alert-success-custom-backend alert-dismissable alert-entity-info-profile fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status">${raw(flash.userProfilePasswordMessage)}</span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-info-profile');
                            </g:javascript>
                        </g:if>

                        <g:if test="${flash.userProfilePasswordErrorMessage}">
                            <div class='alert alert-danger-custom-backend alert-dismissable alert-entity-error-profile fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status"> ${raw(flash.userProfilePasswordErrorMessage)} </span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-error-profile');
                            </g:javascript>
                        </g:if>

                        <!-- Accordion -->
                        <div class="portlet-body">
                            <div class="panel-group accordion" id="accordionProfilePassword">
                                <div class="panel panel-default">
                                    <div class="panel-heading profilePassword-instructions-head">
                                        <h4 class="panel-title">
                                            <a class="accordion-toggle accordion-toggle-styled" data-toggle="collapse" data-parent="#accordionProfilePassword" href="#collapseProfilePassword"> <g:message code="views.login.auth.newPassword.description" default="New password instructions"/> </a>
                                        </h4>
                                    </div>
                                    <div id="collapseProfilePassword" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul>
                                                <li> <g:message code="views.login.auth.newPassword.longitude" default="It must contain a length between 8 characters and 32 characters."/> </li>
                                                <li> <g:message code="views.login.auth.newPassword.number" default="It must contain at least one number."/> </li>
                                                <li> <g:message code="views.login.auth.newPassword.lowercase" default="It must contain at least one lowercase letter."/> </li>
                                                <li> <g:message code="views.login.auth.newPassword.uppercase" default="It must contain at least one uppercase letter."/> </li>
                                                <li> <g:message code="views.login.auth.newPassword.whitespace" default="It must not contain whitespaces."/> </li>
                                                <li> <g:message code="views.login.auth.newPassword.character" default="It can contain special characters."/> </li>
                                                <li> <g:message code="views.login.auth.newPassword.username" default="It must not be equal to username."/> </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="portlet light">
                            <div class="portlet-title">
                                <div class="caption caption-md">
                                    <span class="caption-subject sbold uppercase font-green-dark avatar-subject">
                                        <g:message code="layouts.main_auth_user.content.myProfile.sidebar.password.title" default="Password"/>
                                    </span>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <!-- Edit form -->
                                <g:form controller="customTasksFrontEnd" action="updatePassword" method="PUT" autocomplete="off" class="horizontal-form profilePassword-form">
                                    <g:hiddenField name="version" value="${currentUser?.version}" />
                                    <g:hiddenField name="username" value="${currentUser?.username}" />
                                    <fieldset class="form">
                                        <!-- Personal information -->
                                        <g:render template="passwordData"/>
                                    </fieldset>

                                    <div class="row">
                                        <div class="col-lg-6 col-lg-offset-3">
                                            <div class="domain-button-group-less">
                                                <!-- Cancel button -->
                                                <g:link type="button" uri="/" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
                                                <button type="submit" class="btn green-dark icon-button-container" name="update">
                                                    <i class="fa fa-check icon-button"></i>
                                                    <g:message code="default.button.update.label" default="Update"/>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </g:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- LOAD JAVASCRIPT -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <g:javascript src="counter/jquery.counterup.min.js"/>
    <g:javascript src="maxLength/bootstrap-maxlength.min.js"/>
    <g:javascript src="password/custom-password.js"/>
    <g:javascript src="password/pwstrength-bootstrap.min.js"/>
    <g:javascript src="domain-validation/password-profile-validation.js"/>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
    <script src="https://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>

</body>
</html>