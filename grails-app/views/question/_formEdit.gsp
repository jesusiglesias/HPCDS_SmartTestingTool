<%@ page import="Test.Answer; Enumerations.DifficultyLevel; Test.Question" %>
<div class="form-body form-subtitle">
    <!-- Row -->
    <div class="row">
        <!-- Question key -->
        <div class="col-md-6">
            <div class="form-group group-subtitle ${hasErrors(bean: questionInstance, field: 'titleQuestionKey', 'error')}">
                <label for="titleQuestionKey" class="control-label">
                    <h5 class="sbold">
                        <g:message code="question.titleQuestionKey.label" default="Key"/>
                        <span class="required">*</span>
                    </h5>
                    <h5 class="thin">
                        <g:message code="layouts.main_auth_admin.body.content.question.titleQuestionKey.info.label" default="Internal ID. It is not shown to the normal user."/>
                    </h5>
                </label>

                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:textField name="titleQuestionKey" class="form-control form-shadow" maxlength="50" value="${questionInstance?.titleQuestionKey}"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="keyQuestion-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
            </div>

            <div class="help-block keyQuestion-block">
                <h5>
                    <g:message code="layouts.main_auth_admin.body.content.question.create.checker.block.info.key" default="Type a key of question and check its availability."/>
                </h5>
            </div>
        </div>

        <!-- Description -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: questionInstance, field: 'description', 'error')}">
                <label for="description" class="control-label">
                    <h5 class="sbold">
                        <g:message code="question.description.label" default="Description"/>
                        <span class="required">*</span>
                    </h5>
                </label>

                <div class="input-icon right">
                    <i class="fa"></i>
                    <g:textArea name="description" class="form-control autosizeme form-shadow" cols="40" rows="1" maxlength="800" value="${questionInstance?.description}"/>
                </div>
            </div>
        </div>
    </div> <!-- /.Row -->

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Difficulty level -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: questionInstance, field: 'difficultyLevel', 'error')}">
                <label for="difficultyLevel" class="control-label">
                    <h5 class="sbold">
                        <g:message code="question.difficultyLevel.label" default="Difficulty level"/>
                        <span class="required">*</span>
                    </h5>
                </label>
                <g:select name="difficultyLevel"
                     from="${DifficultyLevel?.values()}"
                     keys="${DifficultyLevel?.values()*.name()}"
                     value="${questionInstance?.difficultyLevel?.name()}"
                     optionValue="${ {difficultyLevel -> g.message(code:difficultyLevel.level)} }"
                     noSelection="${['': "${g.message(code: 'enumerations.difficultyLevel.option', default: 'Select a difficulty')}"]}"
                     class="bs-select form-control" data-style="btn-success"/>
            </div>
        </div>
    </div>

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Answers -->
        <div class="col-md-12">
            <div class="form-group ${hasErrors(bean: questionInstance, field: 'answers', 'error')}">
                <label for="answers" class="control-label">
                    <h5 class="sbold">
                        <g:message code="question.answers.label" default="Answers"/>
                    </h5>
                    <h5 class="thin"><g:message code="layouts.main_auth_admin.body.content.question.multiselect.description" default="Select the answers that constitute the question."/></h5>
                </label>
                <div class="input-group select2-bootstrap-append">
                    <g:select name="answers" id="multi-append"  from="${Answer.list()}" multiple="multiple" optionKey="id" optionValue="titleAnswerKey" size="10" value="${questionInstance?.answers*.id}" class="many-to-many form-control select2"/>
                    <span class="input-group-btn">
                        <button class="btn blue-madison btn-multiSearch" type="button" data-select2-open="multi-append">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </span>
                </div>
            </div>
        </div>

        <!-- TODO  -->
        <div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'catalogs', 'error')} ">
            <label for="catalogs">
                <g:message code="question.catalogs.label" default="Catalogs"/>

            </label>
        </div>
    </div>
</div> <!-- /.Form-body -->