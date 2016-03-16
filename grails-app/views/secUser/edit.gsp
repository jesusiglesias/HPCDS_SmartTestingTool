<%@ page import="Security.SecUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.admin" default="STT | Administrator management"/></title>
</head>
<body>

    <!-- Page-content-wrapper -->
    <div class="page-content-wrapper">
        <!-- Page-content -->
        <div class="page-content">
            <!-- Page-bar -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.admin" default="Administrator user"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/administrator"><g:message code="layouts.main_auth_admin.body.title.admin" default="Administrator management"/></g:link>
                <i class="icon-arrow-right icon-title-admin"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.admin.edit" default="Edit administrator"/></small>
            </h3>

            <div id="edit-secUser" class="content scaffold-edit" role="main">

                <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
                </g:if>

                <g:hasErrors bean="${secUserInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${secUserInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                    </g:eachError>
                </ul>
                </g:hasErrors>
                <g:form url="[resource:secUserInstance, action:'update']" method="PUT" >
                    <g:hiddenField name="version" value="${secUserInstance?.version}" />
                    <fieldset class="form">
                        <g:render template="form"/>
                    </fieldset>
                    <fieldset class="buttons">
                        <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    </fieldset>
                </g:form>
            </div>

            <!-- Contain page -->
            <div id="list-domain">

            </div> <!-- /.Content page -->
    </div> <!-- /.Page-content -->
    </div> <!-- /. Page-content-wrapper -->

</body>
</html>