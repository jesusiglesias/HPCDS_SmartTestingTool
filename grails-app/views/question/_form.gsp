<%@ page import="Test.Question" %>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="question.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${questionInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'difficultyLevel', 'error')} required">
	<label for="difficultyLevel">
		<g:message code="question.difficultyLevel.label" default="Difficulty Level" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="difficultyLevel" from="${Enumerations.DifficultyLevel?.values()}" keys="${Enumerations.DifficultyLevel.values()*.name()}" required="" value="${questionInstance?.difficultyLevel?.name()}" />

</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="question.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${questionInstance?.title}"/>

</div>

