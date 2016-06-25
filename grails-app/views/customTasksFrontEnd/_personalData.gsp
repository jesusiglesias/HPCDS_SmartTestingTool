<%@ page import="Enumerations.Sex; User.User; User.Department" %>

<div class="form-body">
    <!-- Row -->
    <div class="row space-firstRow-profile-user">
        <!-- Username -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'username', 'error')}">
                <label for="username" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.username.label" default="Username"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="username" maxlength="30" class="form-control form-shadow emptySpaces" value="${currentUser?.username}" disabled="true"/>
                </div>
                <div class="help-block">
                    <h5 class="text-justify">
                        <g:message code="layouts.main_auth_user.content.myProfile.personalInformation.username.message" default="It is not possible to change the username directly. Contact us to do this process."/>
                    </h5>
                </div>
            </div>
        </div>

        <!-- Email -->
        <div class="col-md-6 space-betweenCol-profile-user">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'email', 'error')}">
                <label for="email" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.email.label" default="Email"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:field type="email" name="email" maxlength="60" class="form-control form-shadow emptySpaces email-userProfile user-profile-input" value="${currentUser?.email}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="email-profile-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
                <i class="fa fa-times i-delete-email-profile i-delete-userProfile-email"></i> <!-- Delete text icon -->
            </div>
            <div class="help-block emailProfile-block">
                <h5 class="text-justify">
                    <g:message code="layouts.main_auth_admin.body.content.admin.create.checker.block.info.email" default="Type an email and check its availability."/>
                </h5>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow-profile-user">

        <!-- Name -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'name', 'error')}">
                <label for="name" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.name.label" default="Name"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="name" maxlength="25" value="${currentUser?.name}" class="form-control form-shadow name-userProfile user-profile-input"/>
                </div>
                <i class="fa fa-times i-delete-userProfile i-delete-userProfile-name"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Surname -->
        <div class="col-md-6 space-betweenCol-profile-user">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'surname', 'error')}">
                <label for="surname" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.surname.label" default="Surname"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="surname" maxlength="40" value="${currentUser?.surname}" class="form-control form-shadow surname-userProfile user-profile-input"/>
                </div>
                <i class="fa fa-times i-delete-userProfile i-delete-userProfile-surname"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow-profile-user">
        <!-- Birthdate -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'birthDate', 'error')}">
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
                                <input type="text" name="birthDate" id="birthDate" value="${formatDate(format:'dd-MM-yyyy', date: currentUser?.birthDate)}" class="form-control form-shadow" autocomplete="off"/>
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
            </div>
        </div>

        <!-- Address -->
        <div class="col-md-6 space-betweenCol-profile-user">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'address', 'error')}">
                <label for="address" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.address.label" default="Address"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="address" maxlength="70" value="${currentUser?.address}" class="form-control form-shadow address-userProfile user-profile-input"/>
                </div>
                <i class="fa fa-times i-delete-userProfile i-delete-userProfile-address"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow-profile-user">
        <!-- City -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'city', 'error')}">
                <label for="city" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.city.label" default="City"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="city" maxlength="70" value="${currentUser?.city}" class="form-control form-shadow city-userProfile user-profile-input"/>
                </div>
                <i class="fa fa-times i-delete-userProfile i-delete-userProfile-city"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Country -->
        <div class="col-md-6 space-betweenCol-profile-user">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'country', 'error')}">
                <label for="country" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.country.label" default="Country"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="country" maxlength="70" value="${currentUser?.country}" class="form-control form-shadow country-userProfile user-profile-input"/>
                </div>
                <i class="fa fa-times i-delete-userProfile i-delete-userProfile-country"></i> <!-- Delete text icon -->
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow-profile-user">
        <!-- Phone -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'phone', 'error')}">
                <label for="phone" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.phone.label" default="Phone"/>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textField name="phone" maxlength="20" value="${currentUser?.phone}" class="form-control form-shadow phone-userProfile user-profile-input"/>
                </div>
                <i class="fa fa-times i-delete-userProfile i-delete-userProfile-phone"></i> <!-- Delete text icon -->
            </div>
        </div>

        <!-- Sex -->
        <div class="col-md-6 space-betweenCol-profile-user">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'sex', 'error')}">
                <label for="sex" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.sex.label" default="Sex"/>
                        <span class="required"> * </span>
                    </h5>
                </label>
                <g:select name="sex"
                          from="${Sex?.values()}"
                          keys="${Sex?.values()*.name()}"
                          value="${currentUser?.sex?.name()}"
                          optionValue="${ {sex -> g.message(code: sex.gender)} }"
                          noSelection="${['': "${g.message(code: 'enumerations.sex.option', default: 'Select a gender')}"]}"
                          class="bs-select form-control" data-style="btn-success"/>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow-profile-user">
        <!-- Department -->
        <div class="col-xs-12">
            <div class="form-group ${hasErrors(bean: currentUserInstance, field: 'department', 'error')}">
                <label for="department" class="control-label">
                    <h5 class="sbold">
                        <g:message code="user.department.label" default="Department"/>
                        <span class="required"> * </span>
                    </h5>
                    <h5 class="thin text-justify"><g:message code="layouts.main_auth_admin.body.content.user.department.select.description" default="Select the department to which the user belongs."/></h5>
                </label>
                <g:select name="department"
                          from="${Department.list()}"
                          value="${currentUser?.department*.id}"
                          optionKey="id"
                          optionValue="name"
                          noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.user.department.select', default: 'Select a department')}"]}"
                          class="bs-select form-control" data-style="btn-success"
                          data-live-search="true"/>
            </div>
        </div>
    </div>
</div>
