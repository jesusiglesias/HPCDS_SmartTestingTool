<%@ page import="org.springframework.validation.FieldError" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.myProfile" default="STT | My profile"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/normalUser', file: 'profile.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'bootstrap-select.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/date', file: 'bootstrap-datepicker3.min.css')}" type="text/css"/>

    <script>

        // Variables to use in script TODO
        var _checkerUsernameBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.username', default:'Type a username and check its availability.')}';
        var _checkUsernameAvailibility = '${g.createLink(controller: "secUser", action: 'checkUsernameAvailibility')}';
        var _checkerEmailBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.admin.create.checker.block.info.email', default:'Type an email and check its availability.')}';
        var _checkEmailAvailibility = '${g.createLink(controller: "secUser", action: 'checkEmailAvailibility')}';

        var _requiredField = '${g.message(code:'default.validation.required', default:'This field is required.')}';
        var _emailField = '${g.message(code:'default.validation.email', default:'Please, enter a valid email address.')}';
        var _maxlengthField = '${g.message(code:'default.validation.maxlength', default:'Please, enter less than {0} characters.')}';

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
                    <!-- Image profile -->
                    <div class="profile-userpic">
                        <g:if test="${infoCurrentUser?.avatar}">
                            <img class="profileImage-view" alt="Profile image"
                                 src="${createLink(controller: 'customTasksBackend', action: 'profileImage', id: infoCurrentUser.ident())}"/>
                        </g:if>
                        <g:else>
                            <img class="profileImage-view" alt="Profile image"
                                 src="${resource(dir: 'img/profile', file: 'user_profile.png')}"/>
                        </g:else>
                    </div>
                    <!-- User information -->
                    <div class="profile-usertitle">
                        <div class="profile-usertitle-name">${infoCurrentUser?.name} ${infoCurrentUser?.surname}</div>

                        <div class="profile-usertitle-department">${infoCurrentUser.department?.name}</div>
                    </div>
                    <!-- Extra information -->
                    <div class="profile-userExtraInformation">
                        <ul class="list-inline">
                            <g:if test="${infoCurrentUser?.city && infoCurrentUser?.country}">
                                <li><i class="fa fa-map-marker"></i> ${infoCurrentUser?.city}, ${infoCurrentUser?.country}</li>
                            </g:if>
                            <g:elseif test="${infoCurrentUser?.city}">
                                <li><i class="fa fa-map-marker"></i> ${infoCurrentUser?.city}</li>
                            </g:elseif>
                            <g:elseif test="${infoCurrentUser?.country}">
                                <li><i class="fa fa-map-marker"></i> ${infoCurrentUser?.country}</li>
                            </g:elseif>
                            <li><i class="fa fa-calendar"></i> <g:formatDate formatName="custom.date.birthdate.format" date="${infoCurrentUser?.birthDate}"/></li>
                        </ul>
                    </div>
                    <!-- Menu -->
                    <div class="profile-usermenu">
                        <ul class="nav">
                            <li class="active">
                                <g:link>
                                    <i class="icofont icofont-user-alt-2"></i>
                                    <g:message code="layouts.main_auth_user.content.myProfile.sidebar.personal" default="Personal information"/>
                                </g:link>
                            </li>
                            <li>
                                <g:link>
                                    <i class="icofont icofont-ui-password"></i>
                                    <g:message code="layouts.main_auth_user.content.myProfile.sidebar.password" default="Change password"/>
                                </g:link>
                            </li>
                            <li>
                                <g:link>
                                    <i class="icofont icofont-image"></i>
                                    <g:message code="layouts.main_auth_user.content.myProfile.sidebar.avatar" default="Change profile image"/>
                                </g:link>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- Sidebar of statistics - left, bottom -->
                <div class="portlet light customColor-profile">
                    <div class="row list-separated profile-stat">
                        <div class="col-xs-6">
                            <div class="uppercase profile-stat-title" data-counter="counterup" data-value="${numberActiveTest}"> ${numberActiveTest}</div>
                            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.test" default="Active test"/></div>
                        </div>
                        <div class="col-xs-6">
                            <div class="uppercase profile-stat-title" data-counter="counterup" data-value="${completedTest}"> ${completedTest}</div>
                            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.testDone" default="Completed test"/></div>
                        </div>
                    </div>
                    <div class="row list-separated profile-stat-secondRow">
                        <div class="col-xs-6">
                            <div class="uppercase profile-stat-title" data-counter="counterup" data-value="${numberApprovedTest}"> ${numberApprovedTest}</div>
                            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.testApproved" default="Approved test"/></div>
                        </div>
                        <div class="col-xs-6">
                            <div class="uppercase profile-stat-title-unapproved" data-counter="counterup" data-value="${numberUnapprovedTest}"> ${numberUnapprovedTest}</div>
                            <div class="uppercase profile-stat-text"><g:message code="layouts.main_auth_user.content.myProfile.sidebar.bottom.testUnapproved" default="Unapproved test"/></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Personal information -->
            <div class="profile-content">
                <div class="row row-userLayoutTitle">
                    <div class="col-md-12 col-userLayoutTitle">

                        <!-- Alerts -->
                        <g:if test="${flash.userProfileMessage}">
                            <div class='alert alert-info alert-info-custom-backend alert-dismissable alert-entity-info-profile fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status">${raw(flash.userProfileMessage)}</span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-info-profile');
                            </g:javascript>
                        </g:if>

                        <g:if test="${flash.userProfileErrorMessage}">
                            <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error-profile fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status"> ${raw(flash.userProfileErrorMessage)} </span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-error-profile');
                            </g:javascript>
                        </g:if>

                        <!-- Error in validation -->
                        <g:hasErrors bean="${currentUser}">
                            <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error-profile fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <g:eachError bean="${currentUser}" var="error">
                                    <p role="status" class="xthin" <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
                                </g:eachError>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-error-profile');
                            </g:javascript>
                        </g:hasErrors>

                        <div class="portlet light">
                            <div class="portlet-title">
                                <div class="caption caption-md">
                                    <span class="caption-subject sbold uppercase font-green-dark">
                                        <g:message code="layouts.main_auth_user.content.myProfile.sidebar.personal" default="Personal information"/>
                                    </span>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <!-- Edit form -->
                                <g:form controller="customTasksFrontEnd" action="updatePersonalInfo" method="PUT" autocomplete="on" class="horizontal-form profileUser-form">
                                    <g:hiddenField name="version" value="${currentUser?.version}" />
                                    <fieldset class="form">
                                        <!-- Personal information -->
                                        <g:render template="personalData"/>
                                    </fieldset>

                                    <div class="domain-button-group-less">
                                        <!-- Cancel button -->
                                        <g:link type="button" uri="/" class="btn grey-mint"><g:message code="default.button.cancel.label" default="Cancel"/></g:link>
                                        <button type="submit" class="btn green-dark icon-button-container" name="update">
                                            <i class="fa fa-check icon-button"></i>
                                            <g:message code="default.button.update.label" default="Update"/>
                                        </button>
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
    <g:javascript src="maxLength/bootstrap-maxlength.min.js"/>
    <g:javascript src="select/bootstrap-select.min.js"/>
    <g:javascript src="select/boostrap-select_i18n/defaults-es_CL.min.js"/>
    <g:javascript src="date/bootstrap-datepicker.min.js"/>
    <g:javascript src="date/bootstrap-datepicker.es.min.js"/>
    <g:javascript src="domain-validation/personalInformation-profile-validation.js"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <g:javascript src="counter/jquery.counterup.min.js"/>

</body>
</html>