<%@ page import="Test.Test; Enumerations.Sex; User.User; User.Department" %>

<div class="form-body">
    <!-- Row -->
    <div class="row">
        <div class="col-xs-12">
            <legend class="control-label legend-profileImage"><h4 class="title-profileImage size-legend"><g:message code="default.accountInformation.title" default="User account"/></h4></legend>
        </div>
        <!-- Username -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'username', 'error')}">
                <label for="username" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.username.label" default="Username"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:textField name="username" maxlength="30" class="form-control form-shadow emptySpaces username-user backend-input" value="${userInstance?.username}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="username-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
                <i class="fa fa-times i-delete-username-backend i-delete-user-username"></i> <!-- Delete text icon -->
            </div>
            <div class="help-block username-block">
                <h5 class="text-justify">
                    <g:message code="layouts.main_auth_admin.body.content.admin.create.checker.block.info.username" default="Type a username and check its availability."/>
                </h5>
            </div>
        </div>

        <!-- Email -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'email', 'error')}">
                <label for="email" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.email.label" default="Email"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:field type="email" name="email" maxlength="60" class="form-control form-shadow emptySpaces email-user backend-input" value="${userInstance?.email}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="email-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
                <i class="fa fa-times i-delete-backend i-delete-user-email"></i> <!-- Delete text icon -->
            </div>
            <div class="help-block email-block">
                <h5 class="text-justify">
                    <g:message code="layouts.main_auth_admin.body.content.admin.create.checker.block.info.email" default="Type an email and check its availability."/>
                </h5>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Password -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'password', 'error')}">
                <label for="password" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.password.label" default="Password"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:passwordField name="password" class="form-control password-space-progress form-shadow emptySpaces password-user backendPassword-input" maxlength="32" autocomplete="off"/>
                </div>
                <i class="fa fa-eye i-show-user-password"></i> <!-- Show password icon -->
            </div>
        </div>

        <!-- Confirm password -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'confirmPassword', 'error')}">
                <label for="confirmPassword" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.confirmPassword.label" default="Confirm password"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:passwordField name="confirmPassword" class="form-control form-shadow emptySpaces  passwordConfirm-user backendPassword-input" maxlength="32" autocomplete="off"/>
                </div>
                <i class="fa fa-eye i-show-user-confirmPassword"></i> <!-- Show password icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row">
        <!-- Account expired -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: userInstance, field: 'accountExpired', 'error')}">
                <label for="accountExpired" class="control-label">
                    <h5 class="sbold text-justify">
                        <g:message code="default.user.expired.sublabel" default="Indicate whether the user account is expired"/>
                    </h5>
                </label>
                <div class="input-group inputGroup-checkBox">
                    <div class="icheck-list">
                        <g:checkBox name="accountExpired" value="${userInstance?.accountExpired}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.expired.label', default:'Expired account')}"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Account locked -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: userInstance, field: 'accountLocked', 'error')}">
                <label for="accountLocked" class="control-label">
                    <h5 class="sbold text-justify">
                        <g:message code="default.user.locked.sublabel" default="Indicate whether the user account is locked"/>
                    </h5>
                </label>
                <div class="input-group inputGroup-checkBox">
                    <div class="icheck-list">
                        <g:checkBox name="accountLocked" value="${userInstance?.accountLocked}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.locked.label', default:'Locked account')}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row">
        <!-- Enabled -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: userInstance, field: 'enabled', 'error')}">
                <label for="enabled" class="control-label">
                    <h5 class="sbold text-justify">
                        <g:message code="default.user.enabled.sublabel" default="Indicate whether the user account is enabled"/>
                    </h5>
                </label>
                <div class="input-group inputGroup-checkBox">
                    <div class="icheck-list">
                        <g:checkBox name="enabled" value="${userInstance?.enabled}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.enabled.label', default:'Enabled account')}"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Password expired -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: userInstance, field: 'passwordExpired', 'error')}">
                <label for="passwordExpired" class="control-label">
                    <h5 class="sbold text-justify">
                        <g:message code="default.user.passwordExpired.sublabel" default="Indicate whether the user password is expired"/>
                    </h5>
                </label>
                <div class="input-group inputGroup-checkBox">
                    <div class="icheck-list">
                        <g:checkBox name="passwordExpired" value="${userInstance?.passwordExpired}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.passwordExpired.label', default:'Expired password')}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <div class="col-xs-12">
            <legend class="control-label legend-profileImage"><h4 class="title-profileImage size-legend"><g:message code="default.privateInformation.title" default="Personal information"/></h4></legend>
        </div>
        <!-- Name -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'name', 'error')}">
                <label for="name" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.name.label" default="Name"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="name" maxlength="25" value="${userInstance?.name}" class="form-control form-shadow name-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-name-backend i-delete-user-name"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Surname -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'surname', 'error')}">
                <label for="surname" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.surname.label" default="Surname"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="surname" maxlength="40" value="${userInstance?.surname}" class="form-control form-shadow surname-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-surname"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Birthdate -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'birthDate', 'error')}">
                <label for="birthDate" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.birthDate.label" default="Birthdate"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon">
                    <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="+0d">
                        <input type="text" name="birthDate" id="birthDate" value="${formatDate(format:'dd-MM-yyyy', date: userInstance?.birthDate)}" class="form-control form-shadow" autocomplete="off"/>
                        <span class="input-group-btn">
                            <button class="btn default" type="button">
                                <i class="fa fa-calendar"></i>
                            </button>
                        </span>
                    </div>
                    <span class="help-block">
                        <h5 class="text-justify">
                            <g:message code="custom.date.picker.description" default="Select a date."/>
                        </h5>
                    </span>
                  </div>
            </div>
        </div>

        <!-- Address -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'address', 'error')}">
                <label for="address" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.address.label" default="Address"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="address" maxlength="70" value="${userInstance?.address}" class="form-control form-shadow address-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-address"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- City -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'city', 'error')}">
                <label for="city" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.city.label" default="City"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="city" maxlength="70" value="${userInstance?.city}" class="form-control form-shadow city-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-city"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Country -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'country', 'error')}">
                <label for="country" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.country.label" default="Country"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="country" maxlength="70" value="${userInstance?.country}" class="form-control form-shadow country-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-country"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Phone -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'phone', 'error')}">
                <label for="phone" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.phone.label" default="Phone"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="phone" maxlength="20" value="${userInstance?.phone}" class="form-control form-shadow phone-user backend-input"/>
                </div>
                <i class="fa fa-times i-delete-without-backend i-delete-user-phone"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Sex -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'sex', 'error')}">
                <label for="sex" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.sex.label" default="Sex"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <g:select name="sex"
                          from="${Sex?.values()}"
                          keys="${Sex?.values()*.name()}"
                          value="${userInstance?.sex?.name()}"
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
            <div class="form-group ${hasErrors(bean: userInstance, field: 'department', 'error')}">
                <label for="department" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.department.label" default="Department"/>
                        <span class="required"> * </span>
                    </h5>
                    <h5 class="thin"><g:message code="layouts.main_auth_admin.body.content.user.department.select.description" default="Select the department to which the user belongs."/></h5>
                </label>
                <g:select name="department"
                          from="${Department.list()}"
                          value="${userInstance?.department*.id}"
                          optionKey="id"
                          optionValue="name"
                          noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.user.department.select', default: 'Select a department')}"]}"
                          class="bs-select form-control" data-style="btn-success"
                          data-live-search="true"/>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Accessible test -->
        <div class="col-md-12">
            <div class="form-group ${hasErrors(bean: userInstance, field: 'accessTests', 'error')}">
                <label for="accessTests" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.accessTests.label" default="Accessible test"/>
                    </h5>
                    <h5 class="thin text-justify"><g:message code="layouts.main_auth_admin.body.content.user.multiselect.description" default="Select the test that the user can access."/></h5>
                </label>
                <g:select name="accessTests" from="${Test.list()}" multiple="multiple" optionKey="id" optionValue="name" size="10" value="${userInstance?.accessTests*.id}" class="many-to-many multi-select"/>
                <div class="text-center">
                    <a href='#' id='select-all' class="buttons-select btn btn-outline blue-madison">
                        <g:message code="default.multiselect.select.all" default="Select all"/>
                    </a>
                    <a href='#' id='deselect-all' class="buttons-select btn btn-outline blue-madison">
                        <g:message code="default.multiselect.deselect.all" default="Deselect all"/>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-imageRow">
        <!-- Image profile -->
        <div class="form-group">
            <div class="col-sm-12">
                <legend class="control-label legend-profileImage"><h4 class="title-profileImage size-legend"><g:message code="default.imageProfile.title" default="Profile image"/></h4></legend>
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <div class="fileinput-new thumbnail" data-trigger="fileinput" style="max-width: 160px; max-height: 200px;">
                        <g:if test="${userInstance.avatar}">
                            <img name="avatar" alt="Profile image"  src="${createLink(controller:'customTasksBackend', action:'profileImage', id:userInstance.ident())}" />
                        </g:if>
                        <g:else>
                            <img name="avatar" alt="Profile image" src="${resource(dir: 'img/profile', file: 'user_profile.png')}"/>
                        </g:else>
                    </div>

                    <div class="fileinput-preview fileinput-exists thumbnail" data-trigger="fileinput" style="max-width: 160px; max-height: 200px;"></div>

                    <div>
                        <span class="btn green-dark btn-outline btn-file">
                            <span class="fileinput-new"><g:message code="default.imageProfile.select" default="Select image"/></span>
                            <span class="fileinput-exists"><g:message code="default.imageProfile.change" default="Change"/></span>
                            <input type="file" accept="image/png,image/jpeg,image/gif" name="avatar" id="avatar">
                        </span>
                        <a href="javascript:;" class="btn red-soft fileinput-exists" data-dismiss="fileinput"><g:message code="default.imageProfile.remove" default="Remove"/></a>
                    </div>
                </div>
                <div class="clearfix profileImage-note">
                    <span class="label label-warning"><g:message code="default.imageProfile.note" default="NOTE!"/></span>
                    <p class="text-justify">
                        ${raw(g.message(code:"default.imageProfile.note.description", default:"For best results, your profile image should have a width-to-height ratio of 4:5. For example, if your image is 80 pixels wide, it should be 100 pixels high.<br/><strong>Maximum image size allowed: 1 MB.</strong>"))}
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
