<%@ page import="Test.Answer" %>
<div class="form-body">
	<!-- Row -->
	<div class="row">
		<!-- Description -->
		<div class="col-md-12">
			<div class="form-group ${hasErrors(bean: answerInstance, field: 'description', 'error')}">
				<label for="description" class="control-label">
					<g:message code="answer.description.label" default="Description"/>
					<span class="required">*</span>
				</label>

				<div class="input-icon right">
					<i class="fa"></i>
					<g:textArea name="description" class="form-control autosizeme" rows="1" maxlength="300" value="${answerInstance?.description}"/>
				</div>
			</div>
		</div>
	</div> <!-- /.Row -->

	<!-- Row -->
	<div class="row space-secondRow">
		<!-- Score -->
		<div class="col-md-6">
			<div class="form-group ${hasErrors(bean: answerInstance, field: 'score', 'error')}">
				<label for="score" class="control-label">
					<g:message code="answer.score.label" default="Score"/>
					<span class="required"> * </span>
				</label>
				<div class="input-icon right">
					<i class="fa"></i>
                    <g:field name="score" type="number" class="form-control" value="${answerInstance.score}"/>
                </div>
			</div>
		</div>

		<!-- Correct -->
		<div class="col-md-6 space-checkboxCol">
            <div class="${hasErrors(bean: answerInstance, field: 'correct', 'error')}">
                <div class="input-group">
                    <div class="icheck-list">
                        <g:checkBox name="correct" value="${answerInstance?.correct}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code:'answer.correct.label', default:'Solution')}"/>
                    </div>
                </div>
            </div>

         <!-- TODO Falta la relación. Generar el form de nuevo --!>
        </div>
	</div>
</div> <!-- /.Form-body -->