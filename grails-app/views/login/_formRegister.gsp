<%@ page import="Enumerations.Sex; User.User; User.Department" %>

<div class="form-body">
    <!-- Row -->
    <div class="row">
        <div class="col-xs-12">
            <legend class="control-label legend-register"><h4 class="title-legend-register"><g:message code="default.accountInformation.title" default="User account"/></h4></legend>
        </div>
        <!-- Username -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'username', 'error')}">
                <label for="username" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.username.label" default="Username"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:textField name="username" maxlength="30" class="form-control form-shadow emptySpaces username-user backend-input" value="${userRegisterInstance?.username}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="username-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
                <i class="fa fa-times i-delete-username-backend i-delete-user-username"></i> <!-- Delete text icon -->
            </div>
            <div class="help-block username-block">
                <h5>
                    <g:message code="layouts.main_auth_admin.body.content.admin.create.checker.block.info.username" default="Type a username and check its availability."/>
                </h5>
            </div>
        </div>

        <!-- Email -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'email', 'error')}">
                <label for="email" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.email.label" default="Email"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:field type="email" name="email" maxlength="60" class="form-control form-shadow emptySpaces email-user backend-input" value="${userRegisterInstance?.email}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="email-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
                <i class="fa fa-times i-delete-backend i-delete-user-email"></i> <!-- Delete text icon -->
            </div>
            <div class="help-block email-block">
                <h5>
                    <g:message code="layouts.main_auth_admin.body.content.admin.create.checker.block.info.email" default="Type an email and check its availability."/>
                </h5>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Password -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'password', 'error')}">
                <label for="password" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.password.label" default="Password"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:passwordField name="password" class="form-control password-admin form-shadow emptySpaces password-user backendPassword-input" autocomplete="off"/>
                </div>
                <i class="fa fa-eye i-show-user-password"></i> <!-- Show password icon -->
            </div>
        </div>

        <!-- Confirm password -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'confirmPassword', 'error')}">
                <label for="confirmPassword" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.confirmPassword.label" default="Confirm password"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:passwordField name="confirmPassword" class="form-control form-shadow emptySpaces  passwordConfirm-user backendPassword-input" autocomplete="off"/>
                </div>
                <i class="fa fa-eye i-show-user-confirmPassword"></i> <!-- Show password icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <div class="col-xs-12">
            <legend class="control-label legend-register"><h4 class="title-legend-register"><g:message code="default.privateInformation.title" default="Personal information"/></h4></legend>
        </div>
        <!-- Name -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'name', 'error')}">
                <label for="name" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.name.label" default="Name"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="name" maxlength="25" value="${userRegisterInstance?.name}" class="form-control form-shadow name-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-name-backend i-delete-user-name"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Surname -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'surname', 'error')}">
                <label for="surname" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.surname.label" default="Surname"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="surname" maxlength="40" value="${userRegisterInstance?.surname}" class="form-control form-shadow surname-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-surname"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Birthdate -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'birthDate', 'error')}">
                <label for="birthDate" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.birthDate.label" default="Birthdate"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon">
                    <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="+0d">
                        <input type="text" name="birthDate" id="birthDate" value="${formatDate(format:'dd-MM-yyyy', date: userInstance?.birthDate)}" class="form-control form-shadow"/>
                        <span class="input-group-btn">
                            <button class="btn default" type="button">
                                <i class="fa fa-calendar"></i>
                            </button>
                        </span>
                    </div>
                    <span class="help-block">
                        <h5>
                            <g:message code="custom.date.picker.description" default="Select a date"/>
                        </h5>
                    </span>
                  </div>
            </div>
        </div>

        <!-- Address -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'address', 'error')}">
                <label for="address" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.address.label" default="Address"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="address" maxlength="70" value="${userRegisterInstance?.address}" class="form-control form-shadow address-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-address"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- City -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'city', 'error')}">
                <label for="city" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.city.label" default="City"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="city" maxlength="70" value="${userRegisterInstance?.city}" class="form-control form-shadow city-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-city"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Country -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'country', 'error')}">
                <label for="country" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.country.label" default="Country"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="country" maxlength="70" value="${userRegisterInstance?.country}" class="form-control form-shadow country-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-country"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Phone -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'phone', 'error')}">
                <label for="phone" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.phone.label" default="Phone"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="phone" maxlength="20" value="${userRegisterInstance?.phone}" class="form-control form-shadow phone-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-phone"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Sex -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'sex', 'error')}">
                <label for="sex" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.sex.label" default="Sex"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <g:select name="sex"
                          from="${Sex?.values()}"
                          keys="${Sex?.values()*.name()}"
                          value="${userRegisterInstance?.sex?.name()}"
                          optionValue="${ {sex -> g.message(code: sex.gender)} }"
                          noSelection="${['': "${g.message(code: 'enumerations.sex.option', default: 'Select a gender')}"]}"
                          class="bs-select form-control" data-style="btn-success"/>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Department -->
        <div class="col-xs-12">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'department', 'error')}">
                <label for="department" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.department.label" default="Department"/>
                        <span class="required"> * </span>
                    </h5>
                    <h5 class="thin"><g:message code="layouts.main_auth_admin.body.content.user.department.select.description" default="Select the department to which the user belongs."/></h5>
                </label>
                <g:select name="department"
                          from="${Department.list()}"
                          value="${userRegisterInstance?.department*.id}"
                          optionKey="id"
                          optionValue="name"
                          noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.user.department.select', default: 'Select a department')}"]}"
                          class="bs-select form-control" data-style="btn-success"
                          data-live-search="true"/>
            </div>
        </div>
    </div>
</div>

<!-- Password field -->
<%--    <div class="form-group form-md-line-input form-md-floating-label has-success">
        <div class="input-icon right">
            <g:field type="password" class="form-control password-input autofill-input" id="password" name="password" autocomplete="off"/>
            <label for="password"><g:message code="views.login.auth.newPassword.password" default="New password"/></label>
            <span class="help-block"><g:message code="views.login.auth.newPassword.password.help" default="Enter a valid password"/></span>
            <i class="fa fa-eye i-show"></i> <!-- Show password icon -->
            <i class="fa fa-key"></i>
        </div>
    </div>

    <!-- Password confirm field -->
    <div class="form-group form-md-line-input form-md-floating-label has-success">
        <div class="input-icon right">
            <g:field type="password" class="form-control password-confirm-input autofill-input" id="passwordConfirm" name="passwordConfirm" autocomplete="off"/>
            <label for="passwordConfirm"><g:message code="views.login.auth.newPassword.passwordConfirm" default="Confirm password"/></label>
            <span class="help-block"><g:message code="views.login.auth.newPassword.passwordConfirm.help" default="Repeat your password"/></span>
            <i class="fa fa-eye i-show-confirm"></i> <!-- Show password icon -->
            <i class="fa fa-key"></i>
        </div>
    </div> --%>