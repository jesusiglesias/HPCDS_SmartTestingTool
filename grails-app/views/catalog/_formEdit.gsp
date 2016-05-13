<%@ page import="Test.Question; Test.Catalog" %>
<div class="form-body">
    <!-- Row -->
    <div class="row">
        <!-- Name -->
        <div class="col-md-12">
            <div class="form-group ${hasErrors(bean: catalogInstance, field: 'name', 'error')}">
                <label for="name" class="control-label">
                    <h5 class="sbold">
                        <g:message code="catalog.name.label" default="Name"/>
                        <span class="required">*</span>
                    </h5>
                </label>

                <div class="input-group input-icon right">
                    <i class="fa icon-offset"></i>
                    <g:textField name="name" maxlength="60" value="${catalogInstance?.name}" class="form-control form-shadow name-catalog backend-input"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="nameCatalog-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
                <i class="fa fa-times i-delete-backend i-delete-catalog-name"></i> <!-- Delete text icon -->
            </div>

            <div class="help-block catalog-block">
                <h5 class="text-justify">
                    <g:message code="layouts.main_auth_admin.body.content.catalog.create.checker.block.info.name" default="Type a name of catalog and check its availability."/>
                </h5>
            </div>
        </div>
    </div> <!-- /.Row -->

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Questions -->
        <div class="col-md-12">
            <div class="form-group ${hasErrors(bean: catalogInstance, field: 'questions', 'error')}">
                <label for="questions" class="control-label">
                    <h5 class="sbold">
                        <g:message code="catalog.questions.label" default="Questions"/>
                    </h5>
                    <h5 class="thin text-justify"><g:message code="layouts.main_auth_admin.body.content.catalog.multiselect.description" default="Select the questions that constitute the catalog."/></h5>
                </label>
                <div class="input-group select2-bootstrap-append">
                    <g:select name="questions" id="multi-append" from="${Question.list()}" multiple="multiple" optionKey="id" optionValue="titleQuestionKey" size="10" value="${catalogInstance?.questions*.id}" class="many-to-many form-control select2"/>
                    <span class="input-group-btn">
                        <button class="btn blue-madison btn-multiSearch" type="button" data-select2-open="multi-append">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </span>
                </div>
            </div>
        </div>
    </div>
</div> <!-- /.Form-body -->