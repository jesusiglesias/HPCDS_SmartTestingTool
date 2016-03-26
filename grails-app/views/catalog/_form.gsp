<%@ page import="Test.Catalog" %>



<div class="fieldcontain ${hasErrors(bean: catalogInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="catalog.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${catalogInstance?.name}"/>

</div>

