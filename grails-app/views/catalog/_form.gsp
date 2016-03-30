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
                    <g:textField name="name" maxlength="100" value="${catalogInstance?.name}" class="form-control"/>
                    <span class="input-group-btn">
                        <a href="javascript:;" class="btn green-dark" id="nameCatalog-checker">
                            <i class="fa fa-check"></i><g:message code="default.checker.button" default="Check"/>
                        </a>
                    </span>
                </div>
            </div>

            <div class="help-block catalog-block">
                <h5>
                    <g:message code="layouts.main_auth_admin.body.content.catalog.create.checker.block.info.name" default="Type a name of catalog and check its availability."/>
                </h5>
            </div>
        </div>
    </div> <!-- /.Row -->

    <!-- Row -->
    <div class="row space-secondRow">
        <!-- Questions -->
        <div class="col-md-6">
            <div class="form-group ${hasErrors(bean: catalogInstance, field: 'questions', 'error')}">
                <label for="questions" class="control-label">
                    <h5 class="sbold">
                        <g:message code="catalog.questions.label" default="Questions"/>
                        <!-- TODO -->
                        <span class="required">*</span>
                    </h5>
                </label>
                <div class="input-icon right">
                    <i class="fa"></i>
                    <!-- TODO Form-control -->
                    <g:select name="questions" from="${Question.list()}" multiple="multiple" optionKey="id" size="5" value="${catalogInstance?.questions*.id}" class="many-to-many form-control"/>
                </div>
            </div>
        </div>

        <!-- Test TODO -->
        <div class="col-md-6 space-betweenCol">
            <div class="form-group ${hasErrors(bean: catalogInstance, field: 'testCatalogs', 'error')}">
                <label for="tests" class="control-label">
                    <h5 class="sbold">
                        <g:message code="catalog.testCatalogs.label" default="Test"/>
                    </h5>
                </label>

                <ul class="one-to-many">
                    <g:each in="${catalogInstance?.testCatalogs ?}" var="t">
                        <li><g:link controller="test" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
                    </g:each>
                    <li class="add">
                        <g:link controller="test" action="create" params="['catalog.id': catalogInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'test.label', default: 'Test')])}</g:link>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div> <!-- /.Form-body -->