
<%@ page import="User.BaseUser" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'baseUser.label', default: 'BaseUser')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-baseUser" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-baseUser" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="email" title="${message(code: 'baseUser.email.label', default: 'Email')}" />
					
						<g:sortableColumn property="idUser" title="${message(code: 'baseUser.idUser.label', default: 'Id User')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'baseUser.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="password" title="${message(code: 'baseUser.password.label', default: 'Password')}" />
					
						<g:sortableColumn property="surname" title="${message(code: 'baseUser.surname.label', default: 'Surname')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${baseUserInstanceList}" status="i" var="baseUserInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${baseUserInstance.id}">${fieldValue(bean: baseUserInstance, field: "email")}</g:link></td>
					
						<td>${fieldValue(bean: baseUserInstance, field: "idUser")}</td>
					
						<td>${fieldValue(bean: baseUserInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: baseUserInstance, field: "password")}</td>
					
						<td>${fieldValue(bean: baseUserInstance, field: "surname")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${baseUserInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
