
<%@ page import="User.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="address" title="${message(code: 'user.address.label', default: 'Address')}" />
					
						<g:sortableColumn property="birthDate" title="${message(code: 'user.birthDate.label', default: 'Birth Date')}" />
					
						<g:sortableColumn property="country" title="${message(code: 'user.country.label', default: 'Country')}" />
					
						<g:sortableColumn property="phone" title="${message(code: 'user.phone.label', default: 'Phone')}" />
					
						<g:sortableColumn property="sex" title="${message(code: 'user.sex.label', default: 'Sex')}" />
					
						<g:sortableColumn property="urlProfileImage" title="${message(code: 'user.urlProfileImage.label', default: 'Url Profile Image')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${userInstanceList}" status="i" var="userInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "address")}</g:link></td>
					
						<td><g:formatDate date="${userInstance.birthDate}" /></td>
					
						<td>${fieldValue(bean: userInstance, field: "country")}</td>
					
						<td>${fieldValue(bean: userInstance, field: "phone")}</td>

						<td>${message(code:'enumerations.sex.'+fieldValue(bean: userInstance, field: "sex"))}</td>
					
						<td>${fieldValue(bean: userInstance, field: "urlProfileImage")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
