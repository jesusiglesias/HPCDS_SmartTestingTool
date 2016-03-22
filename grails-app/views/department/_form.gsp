<%@ page import="User.Department" %>

<div class="form-body">
    <!-- Row TODO -->
    <div class="row admin-secondRow">
        <!-- Name -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: departmentInstance, field: 'name', 'error')}">
                <label for="name" class="control-label">
                    <g:message code="department.name.label" default="Name"/>
                    <span class="required"> * </span>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <!-- TODO -->
                    <g:textField name="name" maxlength="30" value="${departmentInstance?.name}" class="form-control password-admin"/>
                </div>
            </div>
        </div>

        <!-- User list -->
        <div class="col-md-6">
            <div class="form-group  ${hasErrors(bean: departmentInstance, field: 'users', 'error')}">
                <label for="users" class="control-label">
                    <g:message code="department.users.label" default="Users"/>
                    <span class="required"> * </span>
                </label>
                <ul class="one-to-many">
                    <g:each in="${departmentInstance?.users ?}" var="u">
                        <li><g:link controller="user" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
                    </g:each>
                    <li class="add">
                        <g:link controller="user" action="create"
                                params="['department.id': departmentInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'user.label', default: 'User')])}</g:link>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
