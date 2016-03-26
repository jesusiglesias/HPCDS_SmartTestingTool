<%@ page import="Test.Answer" %>



<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'correct', 'error')} ">
	<label for="correct">
		<g:message code="answer.correct.label" default="Correct" />
		
	</label>
	<g:checkBox name="correct" value="${answerInstance?.correct}" />

</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="answer.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${answerInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: answerInstance, field: 'score', 'error')} required">
	<label for="score">
		<g:message code="answer.score.label" default="Score" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="score" type="number" value="${answerInstance.score}" required=""/>

</div>

