<%@ page import="Enumerations.Sex; User.User; User.Department" %>

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
                    <g:textField name="username" maxlength="30" class="form-control form-shadow emptySpaces" value="${userInstance?.username}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="username-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
            </div>
            <div class="help-block username-block">
                <h5>
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
                    <g:field type="email" name="email" maxlength="60" class="form-control form-shadow emptySpaces" value="${userInstance?.email}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="email-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
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
        <!-- Account expired -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: userInstance, field: 'accountExpired', 'error')}">
                <label for="accountExpired" class="control-label">
                    <h5 class="sbold">
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
                    <h5 class="sbold">
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
                    <h5 class="sbold">
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
                    <h5 class="sbold">
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
                    <g:textField name="name" maxlength="25" value="${userInstance?.name}" class="form-control form-shadow"/>
                </div>
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
                    <g:textField name="surname" maxlength="40" value="${userInstance?.surname}" class="form-control form-shadow"/>
                </div>
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
                <div class="input-icon rigth">
                    <i class="fa"></i>
                    <div class="input-icon">
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
                    <g:textField name="address" maxlength="70" value="${userInstance?.address}" class="form-control form-shadow"/>
                </div>
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
                    <g:textField name="city" maxlength="70" value="${userInstance?.city}" class="form-control form-shadow"/>
                </div>
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
                    <g:textField name="country" maxlength="70" value="${userInstance?.country}" class="form-control form-shadow"/>
                </div>
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
                    <g:textField name="phone" maxlength="20" value="${userInstance?.phone}" class="form-control form-shadow"/>
                </div>
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
</div>
