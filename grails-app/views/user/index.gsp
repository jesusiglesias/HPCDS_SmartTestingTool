<%@ page import="User.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.user" default="STT | User management"/></title>
</head>

<body>
<%--<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
    </ul>
</div> --%>

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
                        <!-- TODO Modificar en cada pantalla -->
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.user" default="Normal user"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <!-- TODO Modificar en cada pantalla -->
                <g:link controller="user" action="index"><g:message code="layouts.main_auth_admin.body.title.user" default="User management"/></g:link>
                <i class="icon-arrow-right icon-title-admin"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.user" default="User list"/></small>
            </h3>

            <!-- Contain page  TODO-->
            <div id="list-user" class="content scaffold-list" role="main">
                <h1><g:message code="default.list.label" args="[entityName]"/></h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table>
                    <thead>
                    <tr>

                        <g:sortableColumn property="username"
                                          title="${message(code: 'user.username.label', default: 'Username')}"/>

                        <g:sortableColumn property="password"
                                          title="${message(code: 'user.password.label', default: 'Password')}"/>

                        <g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}"/>

                        <g:sortableColumn property="accountExpired"
                                          title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}"/>

                        <g:sortableColumn property="accountLocked"
                                          title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}"/>

                        <g:sortableColumn property="address"
                                          title="${message(code: 'user.address.label', default: 'Address')}"/>

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>

                            <td>${fieldValue(bean: userInstance, field: "password")}</td>

                            <td>${fieldValue(bean: userInstance, field: "email")}</td>

                            <td><g:formatBoolean boolean="${userInstance.accountExpired}"/></td>

                            <td><g:formatBoolean boolean="${userInstance.accountLocked}"/></td>

                            <td>${fieldValue(bean: userInstance, field: "address")}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${userInstanceCount ?: 0}"/>
                </div>
            </div>

        </div> <!-- Page-content -->
    </div> <!-- /. Page-content-wrapper -->
</body>
</html>
