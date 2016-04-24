<%@ page import="Enumerations.Sex; User.User; User.Department" %>

<div class="form-body">
    <!-- Row -->
    <div class="row space-register-username">
        <div class="col-xs-12 space-register-legend">
            <legend class="legend-register-account"><h4 class="title-legend-register"><g:message code="default.accountInformation.title" default="User account"/></h4></legend>
        </div>
        <!-- Username -->
        <div class="col-md-6 space-username">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'username', 'error')}">
                <div class="input-icon right">
                    <g:textField name='username' maxlength="30" class="form-control register-input username-input-register emptySpaces autofill-input" autocomplete="off"/>
                    <label for="username" class="control-label control-labelError"><g:message code="user.username.label" default="Username"/><span class="required"> * </span></label>
                    <span class="help-block username-register-block"></span>
                    <i class="fa fa-times i-delete-register-username" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-user"></i>
                </div>
            </div>
        </div>

        <!-- Email -->
        <div class="col-md-6">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'email', 'error')}">
                <div class="input-icon right">
                    <g:field type="email" name="email" maxlength="60" class="form-control register-input email-input-register emptySpaces autofill-input" value="${userRegisterInstance?.email}" autocomplete="off"/>
                    <label for="email" class="control-label control-labelError"><g:message code="user.email.label" default="Email"/><span class="required"> * </span></label>
                    <span class="help-block email-register-block"></span>
                    <i class="fa fa-times i-delete-register-email" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-envelope"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-register-password">
        <!-- Password -->
        <div class="col-md-6">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'password', 'error')}">
                <div class="input-icon right">
                    <g:passwordField name="password" class="form-control password-input-register emptySpaces autofill-input popovers" autocomplete="off"
                                     data-container="body" data-trigger="active" data-placement="top" data-content="${g.message(code:'views.login.body.auth.register.popover.password.description', default:'It must contain at least 8 characters with a uppercase letter, lowercase letter and a number. It may contain special characters.')}"
                                     data-original-title="${g.message(code:'views.login.body.auth.register.popover.password.title', default:'Instructions of the password')}"/>
                    <label for="password" class="control-label control-labelError"><g:message code="user.password.label" default="Password"/><span class="required"> * </span></label>
                    <span class="help-block"><g:message code="views.login.auth.newPassword.password.help" default="Enter a valid password"/></span>
                    <i class="fa fa-eye i-show-register-password"></i> <!-- Show password icon -->
                    <i class="fa fa-key"></i>
                </div>
            </div>
            <div id="container-password">
                <div class='pwstrength-viewport-progress'></div>
                <div class='pwstrength-viewport-verdict'></div>
            </div>
        </div>

        <!-- Confirm password -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'confirmPassword', 'error')}">
                <div class="input-icon right">
                    <g:passwordField name="confirmPassword" class="form-control password-confirm-input-register emptySpaces autofill-input" autocomplete="off"/>
                    <label for="confirmPassword" class="control-label control-labelError"><g:message code="user.confirmPassword.label" default="Confirm password"/><span class="required"> * </span></label>
                    <span class="help-block"><g:message code="views.login.auth.newPassword.passwordConfirm.help" default="Repeat your password"/></span>
                    <i class="fa fa-eye i-show-register-confirmPassword"></i> <!-- Show password icon -->
                    <i class="fa fa-key"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-register-legendPersonal">
        <div class="col-xs-12">
            <legend class="legend-register"><h4 class="title-legend-register"><g:message code="default.privateInformation.title" default="Personal information"/></h4></legend>
        </div>
        <!-- Name -->
        <div class="col-md-6 space-register-nameRow">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'name', 'error')}">
                <div class="input-icon right">
                    <g:textField name="name" maxlength="25" value="${userRegisterInstance?.name}" class="form-control register-input name-input-register autofill-input" autocomplete="off"/>
                    <label for="name" class="control-label control-labelError"><g:message code="user.name.label" default="Name"/><span class="required"> * </span></label>
                    <span class="help-block"></span>
                    <i class="fa fa-times i-delete-register-name" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-male"></i>
                </div>
            </div>
        </div>

        <!-- Surname -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'surname', 'error')}">
                <div class="input-icon right">
                    <g:textField name="surname" maxlength="40" value="${userRegisterInstance?.surname}" class="form-control register-input surname-input-register autofill-input" autocomplete="off"/>
                    <label for="surname" class="control-label control-labelError"><g:message code="user.surname.label" default="Surname"/><span class="required"> * </span></label>
                    <span class="help-block"></span>
                    <i class="fa fa-times i-delete-register-surname" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-male"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-register-birthDateRow">
        <!-- Birthdate -->
        <div class="col-md-6 col-register">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'birthDate', 'error')}">
                <label for="birthDate" class="control-label">
                    <h5 class="sbold h5-register h5-error">
                        <g:message code="user.birthDate.label" default="Birthdate"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon">
                    <div class="input-group date date-picker" data-date-format="dd-mm-yyyy" data-date-end-date="+0d">
                        <input type="text" name="birthDate" id="birthDate" value="${formatDate(format:'dd-MM-yyyy', date: userRegisterInstance?.birthDate)}" class="form-control form-shadow birthDate-input-register" autocomplete="off"/>
                        <span class="input-group-btn">
                            <button class="btn white" type="button">
                                <i class="fa fa-calendar"></i>
                            </button>
                        </span>
                    </div>
                    <span class="help-block">
                        <h5 class="thin h5-register">
                            <g:message code="custom.date.picker.description" default="Select a date"/>
                        </h5>
                    </span>
                  </div>
            </div>
        </div>

        <!-- Address -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'address', 'error')}">
                <div class="input-icon right">
                    <g:textField name="address" maxlength="70" value="${userRegisterInstance?.address}" class="form-control register-input address-input-register autofill-input" autocomplete="off"/>
                    <label for="address" class="control-label"><g:message code="user.address.label" default="Address"/></label>
                    <span class="help-block"></span>
                    <i class="fa fa-times i-delete-register-address" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-home"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-register-cityRow">
        <!-- City -->
        <div class="col-md-6">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'city', 'error')}">
                <div class="input-icon right">
                    <g:textField name="city" maxlength="70" value="${userRegisterInstance?.city}" class="form-control register-input city-input-register autofill-input" autocomplete="off"/>
                    <label for="city" class="control-label"><g:message code="user.city.label" default="City"/></label>
                    <span class="help-block"></span>
                    <i class="fa fa-times i-delete-register-city" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-location-arrow"></i>
                </div>
            </div>
        </div>

        <!-- Country -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'country', 'error')}">
                <div class="input-icon right">
                    <g:textField name="country" maxlength="70" value="${userRegisterInstance?.country}" class="form-control register-input country-input-register autofill-input" autocomplete="off"/>
                    <label for="country" class="control-label"><g:message code="user.country.label" default="Country"/></label>
                    <span class="help-block"></span>
                    <i class="fa fa-times i-delete-register-country" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-globe"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-register-phoneRow">
        <!-- Phone -->
        <div class="col-md-6">
            <div class="form-group form-md-line-input form-md-floating-label has-success ${hasErrors(bean: userRegisterInstance, field: 'phone', 'error')}">
                <div class="input-icon right">
                    <g:textField name="phone" maxlength="20" value="${userRegisterInstance?.phone}" class="form-control register-input phone-input-register autofill-input" autocomplete="off"/>
                    <label for="phone" class="control-label"><g:message code="user.phone.label" default="Phone"/></label>
                    <span class="help-block"></span>
                    <i class="fa fa-times i-delete-register-phone" style="right: 50px; cursor: pointer"></i> <!-- Delete text icon -->
                    <i class="fa fa-phone"></i>
                </div>
            </div>
        </div>

        <!-- Sex -->
        <div class="col-md-6 space-betweenCol col-register">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'sex', 'error')}">
                <label for="sex" class="control-label">
                    <h5 class="sbold h5-register h5-error">
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
                          class="bs-select form-control" data-style="yellow-mint"/>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-register-departmentRow">
        <!-- Department -->
        <div class="col-xs-12">
            <div class="form-group ${hasErrors(bean: userRegisterInstance, field: 'department', 'error')}">
                <label for="department" class="control-label">
                    <h5 class="sbold h5-register h5-error">
                        <g:message code="user.department.label" default="Department"/>
                        <span class="required"> * </span>
                    </h5>
                    <h5 class="thin h5-register"><g:message code="views.login.body.auth.register.department.select.description" default="Select the department to which belongs."/></h5>
                </label>
                <g:select name="department"
                          from="${Department.list()}"
                          value="${userRegisterInstance?.department*.id}"
                          optionKey="id"
                          optionValue="name"
                          noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.user.department.select', default: 'Select a department')}"]}"
                          class="bs-select form-control" data-style="yellow-mint"
                          data-live-search="true"/>
            </div>
        </div>
    </div>
</div>