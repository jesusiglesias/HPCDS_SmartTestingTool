<%@ page import="Security.SecUser" %>

<div class="form-body">
    <!-- Row -->
    <div class="row">
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'username', 'error')} required">
                <label for="username" class="control-label">
                    <g:message code="admin.username.label" default="Username"/>
                </label>
                <g:textField name="username" class="form-control" required="" value="${secUserInstance?.username}"/>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'email', 'error')}  required">
                <label for="email" class="control-label">
                    <g:message code="admin.email.label" default="Email" />
                </label>
                <g:field type="email" name="email" class="form-control" required="" value="${secUserInstance?.email}"/>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row">
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'password', 'error')} required">
                <label for="password" class="control-label">
                    <g:message code="admin.password.label" default="Password"/>
                </label>
                <g:passwordField name="password" class="form-control password-admin" required=""/>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: secUserInstance, field: 'confirmPassword', 'error')} required">
                <label for="confirmPassword" class="control-label">
                    <g:message code="admin.confirmPassword.label" default="Confirm password"/>
                </label>
                <g:passwordField name="confirmPassword" class="form-control" required=""/>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row">
        <div class="col-md-6">
            <div class="${hasErrors(bean: secUserInstance, field: 'accountExpired', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="accountExpired" value="${secUserInstance?.accountExpired}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.expired.label', default:'Expired account')}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
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
        <div class="col-md-6">
            <div class="${hasErrors(bean: secUserInstance, field: 'enabled', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="enabled" value="${secUserInstance?.enabled}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.enabled.label', default:'Enabled account')}"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="${hasErrors(bean: secUserInstance, field: 'passwordExpired', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="passwordExpired" value="${secUserInstance?.passwordExpired}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'admin.passwordExpired.label', default:'Expired password')}"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
