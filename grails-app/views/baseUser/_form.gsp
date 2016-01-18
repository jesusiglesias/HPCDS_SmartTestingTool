<%@ page import="User.BaseUser" %>



<div class="fieldcontain ${hasErrors(bean: baseUserInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="baseUser.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="email" required="" value="${baseUserInstance?.email}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: baseUserInstance, field: 'idUser', 'error')} required">
	<label for="idUser">
		<g:message code="baseUser.idUser.label" default="Id User" />
		<span class="required-indicator">*</span>
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: baseUserInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="baseUser.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${baseUserInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: baseUserInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="baseUser.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${baseUserInstance?.password}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: baseUserInstance, field: 'surname', 'error')} required">
	<label for="surname">
		<g:message code="baseUser.surname.label" default="Surname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="surname" required="" value="${baseUserInstance?.surname}"/>

</div>

