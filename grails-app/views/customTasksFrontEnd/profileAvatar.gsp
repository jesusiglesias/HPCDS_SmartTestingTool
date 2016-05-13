<%@ page import="org.springframework.validation.FieldError" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.myProfile" default="STT | My profile"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/normalUser', file: 'profile.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/fileInput', file: 'bootstrap-fileinput.css')}" type="text/css"/>

    <script>

        // Variables to use in script
        var _requiredField = '${g.message(code:'default.validation.required', default:'This field is required.')}';

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
                            <li>
                                <g:link uri="/profilePassword">
                                    <i class="icofont icofont-ui-password"></i>
                                    <g:message code="layouts.main_auth_user.content.myProfile.sidebar.password" default="Change password"/>
                                </g:link>
                            </li>
                            <li class="active">
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
            <div class="profile-content">
                <div class="row row-userLayoutTitle">
                    <div class="col-md-12 col-userLayoutTitle">

                        <!-- Alerts -->
                        <g:if test="${flash.userProfileAvatarMessage}">
                            <div class='alert alert-success-custom-backend alert-dismissable alert-entity-info-profile fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status">${raw(flash.userProfileAvatarMessage)}</span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-info-profile');
                            </g:javascript>
                        </g:if>

                        <g:if test="${flash.userProfileAvatarErrorMessage}">
                            <div class='alert alert-danger-custom-backend alert-dismissable alert-entity-error-profile fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status"> ${raw(flash.userProfileAvatarErrorMessage)} </span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-error-profile');
                            </g:javascript>
                        </g:if>

                        <!-- Error in validation -->
                        <g:hasErrors bean="${currentUser}">
                            <div class='alert alert-danger-custom-backend alert-dismissable alert-entity-error-profile fade in'>
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
                                    <span class="caption-subject sbold uppercase font-green-dark avatar-subject">
                                        <g:message code="layouts.main_auth_user.content.myProfile.sidebar.avatar.title" default="Profile image"/>
                                    </span>
                                </div>
                            </div>
                            <div class="portlet-body">
                                <!-- Edit form -->
                                <g:form controller="customTasksFrontEnd" action="updateAvatar" enctype="multipart/form-data" class="horizontal-form profileAvatarUser-form">
                                    <g:hiddenField name="version" value="${currentUser?.version}" />
                                    <fieldset class="form">
                                        <!-- Personal information -->
                                        <g:render template="avatarData"/>
                                    </fieldset>

                                    <div class="domain-button-group-less-avatar">
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
    <script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
    <g:javascript src="counter/jquery.counterup.min.js"/>
    <g:javascript src="domain-validation/avatar-profile-validation.js"/>
    <g:javascript src="fileInput/bootstrap-fileinput.js"/>

</body>
</html>