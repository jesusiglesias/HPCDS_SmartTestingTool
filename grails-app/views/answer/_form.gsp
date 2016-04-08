<%@ page import="Test.Answer" %>
<div class="form-body form-subtitle">
    <!-- Row -->
    <div class="row">
        <!-- Answer key -->
        <div class="col-md-6">
            <div class="form-group group-subtitle ${hasErrors(bean: answerInstance, field: 'titleAnswerKey', 'error')}">
                <label for="titleAnswerKey" class="control-label">
                    <h5 class="sbold">
                        <g:message code="answer.titleAnswerKey.label" default="Key"/>
                        <span class="required">*</span>
                    </h5>
                    <h5 class="thin"><g:message code="layouts.main_auth_admin.body.content.answer.titleAnswerKey.info.label" default="Internal ID. It is not shown to the normal user."/></h5>
                </label>

                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:textField name="titleAnswerKey" class="form-control form-shadow" maxlength="25" value="${answerInstance?.titleAnswerKey}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="keyAnswer-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
            </div>
            <div class="help-block keyAnswer-block">
                <h5>
                    <g:message code="layouts.main_auth_admin.body.content.answer.create.checker.block.info.key" default="Type a key of answer and check its availability."/>
                </h5>
            </div>
        </div>

        <!-- Description -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: answerInstance, field: 'description', 'error')}">
                <label for="description" class="control-label">
                    <h5 class="sbold">
                        <g:message code="answer.description.label" default="Description"/>
                        <span class="required">*</span>
                    </h5>
                </label>

                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textArea name="description" class="form-control autosizeme form-shadow" cols="40" rows="1" maxlength="400" value="${answerInstance?.description}"/>
                </div>
            </div>
        </div>
    </div> <!-- /.Row -->

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Correct -->
        <div class="col-md-6">
            <div class="${hasErrors(bean: answerInstance, field: 'correct', 'error')}">
                <label for="correct" class="control-label">
                    <h5 class="sbold">
                        <g:message code="layouts.main_auth_admin.body.content.answer.correctAnswer.label" default="Indicate whether the answer is correct"/>
                    </h5>
                </label>
                <div class="input-group inputGroup-checkBox">
                    <div class="icheck-list">
                        <g:checkBox name="correct" value="${answerInstance?.correct}" class="icheck" data-checkbox="icheckbox_line-green" data-label="${g.message(code: 'answer.correct.label', default: 'Correct')}"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- Score -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: answerInstance, field: 'score', 'error')}">
                <label for="score" class="control-label">
                    <h5 class="sbold">
                        <g:message code="answer.score.label" default="Score"/>
                        <span class="required">*</span>
                    </h5>
                    <h5 class="thin"><g:message code="layouts.main_auth_admin.body.content.answer.score.select.info.label" default="Active only when the answer is correct."/></h5>
                </label>
                <g:select name="score" from="${1..5}" value="${answerInstance?.score}" disabled="${!answerInstance?.correct}" noSelection="${['': "${g.message(code: 'layouts.main_auth_admin.body.content.answer.score.select.label', default: 'Select a score')}"]}"
                          class="bs-select form-control select-score" data-style="btn-success"/>
            </div>
        </div>
    </div>
</div> <!-- /.Form-body -->