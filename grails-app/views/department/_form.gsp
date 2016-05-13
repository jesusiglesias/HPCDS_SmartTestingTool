<%@ page import="User.Department" %>

<div class="form-body">
    <!-- Row -->
    <div class="row">
        <!-- Name -->
        <div class="col-md-12">
            <div class="form-group ${hasErrors(bean: departmentInstance, field: 'name', 'error')}">
                <label for="name" class="control-label">
                    <h5 class="sbold">
                        <g:message code="department.name.label" default="Name"/>
                        <span class="required">*</span>
                    </h5>
                </label>
                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:textField name="name" maxlength="50" value="${departmentInstance?.name}" class="form-control form-shadow name-department backend-input"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="nameDepartment-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
                <i class="fa fa-times i-delete-backend i-delete-department-name"></i> <!-- Delete text icon -->
            </div>
            <div class="help-block department-block">
                <h5 class="text-justify">
                    <g:message code="layouts.main_auth_admin.body.content.department.create.checker.block.info.name" default="Type a name of department and check its availability."/>
                </h5>
            </div>
        </div>
    </div> <!-- /.Row -->
</div> <!-- /.Form-body -->
