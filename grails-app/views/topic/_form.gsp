<%@ page import="Test.Topic" %>



<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="topic.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${topicInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="topic.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${topicInstance?.name}"/>

</div>
<%-- TODO
<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'prueba', 'error')} required">
	<label for="prueba">
		<g:message code="topic.prueba.label" default="Prueba" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="prueba" required="" value="${topicInstance?.prueba}"/>

</div> --%>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'visibility', 'error')} ">
	<label for="visibility">
		<g:message code="topic.visibility.label" default="Visibility" />
		
	</label>
	<g:checkBox name="visibility" value="${topicInstance?.visibility}" />

</div>

<%-- TODO
<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'visibility2', 'error')} ">
	<label for="visibility2">
		<g:message code="topic.visibility2.label" default="Visibility2" />
		
	</label>
	<g:checkBox name="visibility2" value="${topicInstance?.visibility2}" />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'visibility3', 'error')} ">
	<label for="visibility3">
		<g:message code="topic.visibility3.label" default="Visibility3" />
		
	</label>
	<g:checkBox name="visibility3" value="${topicInstance?.visibility3}" />

</div>
--%>
