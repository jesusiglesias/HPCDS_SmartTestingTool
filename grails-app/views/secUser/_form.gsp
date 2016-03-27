<%@ page import="Security.SecUser" %>

<div class="form-body">
    <!-- Row -->
    <div class="row">
        <!-- Username -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'username', 'error')}">
                <label for="username" class="control-label">
                    <g:message code="admin.username.label" default="Username"/>
                    <span class="required"> * </span>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:textField name="username" class="form-control" value="${secUserInstance?.username}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="username-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
            </div>
            <div class="help-block username-block"><g:message code="layouts.main_auth_admin.body.content.admin.create.checker.block.info.username" default="Type a username and check its availability."/> </div>
        </div>

        <!-- Email -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'email', 'error')}">
                <label for="email" class="control-label">
                    <g:message code="admin.email.label" default="Email"/>
                    <span class="required"> * </span>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:field type="email" name="email" class="form-control" value="${secUserInstance?.email}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="email-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
            </div>
            <div class="help-block email-block"><g:message code="layouts.main_auth_admin.body.content.admin.create.checker.block.info.email" default="Type an email and check its availability."/> </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row admin-secondRow">
        <!-- Password -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'password', 'error')}">
                <label for="password" class="control-label">
                    <g:message code="admin.password.label" default="Password"/>
                    <span class="required"> * </span>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:passwordField name="password" class="form-control password-admin"/>
                </div>
            </div>
        </div>

        <!-- Confirm password -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'confirmPassword', 'error')}">
                <label for="confirmPassword" class="control-label">
                    <g:message code="admin.confirmPassword.label" default="Confirm password"/>
                    <span class="required"> * </span>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:passwordField name="confirmPassword" class="form-control"/>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row">
        <!-- Account expired -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: secUserInstance, field: 'accountExpired', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="accountExpired" value="${secUserInstance?.accountExpired}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.expired.label', default:'Expired account')}"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Account locked -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: secUserInstance, field: 'accountLocked', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="accountLocked" value="${secUserInstance?.accountLocked}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.locked.label', default:'Locked account')}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row">
        <!-- Enabled -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: secUserInstance, field: 'enabled', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="enabled" value="${secUserInstance?.enabled}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.enabled.label', default:'Enabled account')}"/>
                    </div>
                </div>
            </div>
        </div>
        <!-- Password expired -->
        <div class="col-sm-6">
            <div class="${hasErrors(bean: secUserInstance, field: 'passwordExpired', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="passwordExpired" value="${secUserInstance?.passwordExpired}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.passwordExpired.label', default:'Expired password')}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row profileImage-row">
        <!-- Image profile -->
        <div class="form-group">
            <div class="col-sm-12">
                <legend class="control-label"><h4><g:message code="default.imageProfile.title" default="Profile image"/></h4></legend>
                <div class="fileinput fileinput-new" data-provides="fileinput">
                    <div class="fileinput-new thumbnail" data-trigger="fileinput" style="max-width: 160px; max-height: 200px;">
                        <g:if test="${secUserInstance.avatar}">
                            <img name="avatar" alt="Profile image"  src="${createLink(controller:'customTasksBackend', action:'profileImage', id:secUserInstance.ident())}" />
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
                    <p>
                        ${raw(g.message(code:"default.imageProfile.note.description", default:"For best results, your profile image should have a width-to-height ratio of 4:5. For example, if your image is 80 pixels wide, it should be 100 pixels high.<br/><strong>Maximum image size allowed: 1 MB.</strong>"))}
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
