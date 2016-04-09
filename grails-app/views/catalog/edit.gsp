<%@ page import="Test.Catalog" %>
<%@ page import="org.springframework.validation.FieldError" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.catalog" default="STT | Catalogs management"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'multi-select.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'select2.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/select', file: 'select2-bootstrap.min.css')}" type="text/css"/>

    <script>
        // Variables to use in script
        var _checkerNameBlockInfo = '${g.message(code:'layouts.main_auth_admin.body.content.catalog.create.checker.block.info.name', default:'Type a name of catalog and check its availability.')}';
        var _checkNameCatalogAvailibility = '${g.createLink(controller: "catalog", action: 'checkNameCatalogAvailibility')}';
        var _requiredField = '${g.message(code:'default.validation.required', default:'This filed is required.')}';
        var _maxlengthField = '${g.message(code:'default.validation.maxlength', default:'Please, enter less than {0} characters.')}';

        // Handler auto close alert
        function createAutoClosingAlert(selector) {
            var alert = $(selector);
            window.setTimeout(function () {
                alert.slideUp(1000, function () {
                    $(this).remove();
                });
            }, 5000);
        }
    </script>
</head>

<body>

    <!-- Page-content-wrapper -->
    <div class="page-content-wrapper">
        <!-- Page-content -->
        <div class="page-content">
            <!-- Page-bar -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li>
                        <i class="fa fa-home home-icon"></i>
                        <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.catalog" default="Catalog"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/catalog"><g:message code="layouts.main_auth_admin.body.title.catalog" default="Catalogs management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.catalog.edit" default="Edit catalog"/></small>
            </h3>

            <!-- Contain page -->
            <div id="edit-domain">

                <!-- Alerts -->
                <g:if test="${flash.catalogErrorMessage}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <span class="xthin" role="status">${raw(flash.catalogErrorMessage)}</span>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:if>

                <!-- Error in validation -->
                <g:hasErrors bean="${catalogInstance}">
                    <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                        <g:eachError bean="${catalogInstance}" var="error">
                            <p role="status" class="xthin"
                               <g:if test="${error in FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                    error="${error}"/></p>
                        </g:eachError>
                    </div>

                    <g:javascript>
                        createAutoClosingAlert('.alert-entity-error');
                    </g:javascript>
                </g:hasErrors>

                <!-- Delete button -->
                <g:form url="[resource: catalogInstance, controller: 'catalog', action: 'delete']" method="DELETE" class="form-delete">
                    <div class="btn-group">
                        <button class="btn red-soft btn-block" id="delete-confirm-popover" data-toggle="confirmation"
                                data-placement="rigth" data-popout="true" data-singleton="true"
                                data-original-title="${message(code: 'layouts.main_auth_admin.content.delete.confirm.message', default: 'Are you sure?')}"
                                data-btn-ok-label="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                data-btn-cancel-label="${message(code: 'default.button.cancel.label', default: 'Cancel')}"
                                data-btnOkIcon="glyphicon glyphicon-ok" data-btnOkClass="btn btn-sm btn-success"
                                data-btnCancelIcon="glyphicon glyphicon-remove" data-btnCancelClass="btn btn-sm btn-danger">
                            <i class="fa fa-trash"></i>
                            <g:message code="layouts.main_auth_admin.body.content.catalog.delete" default="Delete catalog"/>
                        </button>
                    </div>
                    <div class="has-error md-checkbox check-delete">
                        <input type="checkbox" name='delete_catalog' id='delete_catalog' class="md-check"/>
                        <label for="delete_catalog" class="sbold">
                            <span></span>
                            <span class="check"></span>
                            <span class="box"></span>
                            <g:message code="layouts.main_auth_admin.body.content.catalog.delete.relation" default="lEnable to remove the content associated (questions and answers)."/>
                        </label>
                    </div>
                </g:form>

                <!-- Edit form -->
                <g:form url="[resource: catalogInstance, action: 'update']" method="PUT" autocomplete="on" class="horizontal-form catalog-form">
                    <g:hiddenField name="version" value="${catalogInstance?.version}"/>
                    <fieldset class="form">
                        <g:render template="formEdit"/>
                    </fieldset>

                    <div class="domain-button-group-less">
                        <!-- Cancel button -->
                        <g:link type="button" uri="/catalog" class="btn grey-mint"><g:message
                                code="default.button.cancel.label" default="Cancel"/></g:link>
                        <button type="submit" class="btn green-dark" name="update">
                            <i class="fa fa-check"></i>
                            <g:message code="default.button.update.label" default="Update"/>
                        </button>
                    </div>
                </g:form>
            </div> <!-- /.Content page -->
        </div> <!-- /.Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <!-- LOAD JAVASCRIPT -->
    <g:javascript src="confirmation/bootstrap-confirmation.min.js"/>
    <g:javascript src="confirmation/custom-delete.js"/>
    <g:javascript src="select/jquery.multi-select.js"/>
    <g:javascript src="select/select2.full.min.js"/>
    <g:javascript src="select/select2_i18n/es.js"/>
    <g:javascript src="maxLength/bootstrap-maxlength.min.js"/>
    <g:javascript src="customIcons/catalog-handler.js"/>
    <g:javascript src="domain-validation/catalogSelectEdit-validation.js"/>

</body>
</html>
