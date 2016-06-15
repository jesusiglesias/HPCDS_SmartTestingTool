<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_admin">
    <title><g:message code="layouts.main_auth_admin.head.title.user" default="STT | Users management"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/fileInput', file: 'bootstrap-fileinput.css')}" type="text/css"/>

    <script>
        // Auto close alert
        function createAutoClosingAlert(selector) {
            var alert = $(selector);

            window.setTimeout(function() {
                alert.slideUp(1000, function(){
                    $(this).remove();
                });
            }, 5000);
        }
    </script>
</head>

<body>
    <script>

        // Variables to use in script
        var _requiredField = '${g.message(code:'default.validation.required', default:'This field is required.')}';
        var _fullscreenTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.fullscreen', default:'Fullscreen!')}';
        var _removeTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.remove', default:'Remove')}';
        var _collapseTooltip = '${g.message(code:'layouts.main_auth_admin.body.content.logConfiguration.tooltip.collapse', default:'Collapse/Expand')}';
        var _importingData = '${message(code: "default.import.process", default: "Importing data...")}';

    </script>

    <!-- Page-sidebar-wrapper -->
    <div class="page-sidebar-wrapper">
        <!-- Page-sidebar -->
        <div class="page-sidebar navbar-collapse collapse">
            <!-- Page-sidebar-menu -->
            <ul class="page-sidebar-menu page-header-fixed" data-keep-expanded="true" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 30px">

                <!-- Load search action -->
                <g:render template="/template/searchControlPanel"/>

                <li class="nav-item start">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="icon-home"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard" default="Dashboard"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item start">
                            <g:link controller="customTasksBackend" action="dashboard" class="nav-link">
                                <i class="icofont icofont-dashboard-web"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard.statistics" default="Statistics"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- USERS -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.users" default="Users"/></h3>
                </li>

                <!-- Admin user -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-user-secret"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.admin" default="Admin user"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link uri="/administrator/create" class="nav-link">
                                <i class="fa fa-user-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/administrator" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/administrator/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Normal user -->
                <li class="nav-item active open">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-user"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.normalUser" default="Normal user"/></span>
                        <span class="selected"></span>
                        <span class="arrow open"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="user" action="create" class="nav-link">
                                <i class="fa fa-user-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/user" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item active open">
                            <g:link uri="/user/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                                <span class="selected"></span>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <!-- /.USERS -->

                <!-- GENERAL -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.general" default="General"/></h3>
                </li>

                <!-- Department -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-building"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.department" default="Department"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="department" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/department" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/department/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Topic -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-briefcase"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.topic" default="Topic"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="topic" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/topic" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/topic/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Catalog -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-folder-open"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.catalog" default="Catalog"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="catalog" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/catalog" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/catalog/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Question -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-question"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.question" default="Question"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="question" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/question" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/question/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Answer -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-pencil"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.answer" default="Answer"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="answer" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/answer" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/answer/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <!-- /.GENERAL -->

                <!-- EVALUATION PROCESS -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.evaluationProcess" default="Evaluation process"/></h3>
                </li>

                <!-- Test -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="fa fa-file-text"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.test" default="Test"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link controller="test" action="create" class="nav-link">
                                <i class="fa fa-plus"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.new" default="New"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/test" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                        <li class="nav-item">
                            <g:link uri="/test/import" class="nav-link">
                                <i class="fa fa-cloud-upload"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>

                <!-- Evaluation -->
                <li class="nav-item">
                    <a href="javascript:;" class="nav-link nav-toggle">
                        <i class="icofont icofont-badge"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.evaluation" default="Evaluation"/></span>
                        <span class="arrow"></span>
                    </a>
                    <ul class="sub-menu">
                        <li class="nav-item">
                            <g:link uri="/evaluation" class="nav-link">
                                <i class="fa fa-list"></i>
                                <span class="title"><g:message code="layouts.main_auth_admin.sidebar.list" default="List"/></span>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <!-- /.TEST -->

                <!-- CONFIGURATION -->
                <li class="heading">
                    <h3 class="uppercase"><g:message code="layouts.main_auth_admin.sidebar.title.configuration" default="Configurations"/></h3>
                </li>
                <li class="nav-item">
                    <g:link controller="customTasksBackend" action="reloadLogConfig" class="nav-link">
                        <i class="icon-settings"></i>
                        <span class="title"><g:message code="layouts.main_auth_admin.sidebar.logConfiguration" default="Log configuration"/></span>
                        <span class="arrow"></span>
                    </g:link>
                </li>
                <!-- /.CONFIGURATION -->
            </ul> <!-- /.Page-sidebar-menu -->
        </div> <!-- Page-sidebar -->
    </div> <!-- Page-sidebar-wrapper -->

    <!-- Page-content-wrapper -->
    <div class="page-content-wrapper">
        <!-- Page-content -->
        <div class="page-content">
            <!-- Page-bar -->
            <div class="page-bar">
                <ul class="page-breadcrumb">
                    <li class="iconBar-admin-container">
                        <i class="fa fa-home home-icon iconBar-admin"></i>
                        <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span><g:message code="layouts.main_auth_admin.pageBreadcrumb.subtitle.user" default="Normal user"/></span>
                    </li>
                </ul>
            </div> <!-- /.Page-bar -->

            <!-- Page-title -->
            <h3 class="page-title">
                <g:link uri="/user"><g:message code="layouts.main_auth_admin.body.title.user" default="Users management"/></g:link>
                <i class="icon-arrow-right icon-title-domain"></i>
                <small><g:message code="layouts.main_auth_admin.body.subtitle.user.import" default="Import users"/></small>
            </h3>

            <!-- Contain page -->
            <div id="list-panel">
                <div class="row panel-row-import">
                    <div class="col-md-12 col-lg-10 col-lg-offset-1">

                        <!-- Alerts -->
                        <g:if test="${flash.userImportErrorMessage}">
                            <div class='alert alert-error alert-danger-custom-backend alert-dismissable alert-entity-error fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status">${raw(flash.userImportErrorMessage)}</span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-error');
                            </g:javascript>
                        </g:if>

                        <g:if test="${flash.userImportMessage}">
                            <div class='alert alert-info alert-info-custom-backend alert-dismissable alert-entity alert-entity-info fade in'>
                                <button type='button' class='close' data-dismiss='alert' aria-hidden='true'></button>
                                <span class="xthin" role="status">${raw(flash.userImportMessage)}</span>
                            </div>

                            <g:javascript>
                                createAutoClosingAlert('.alert-entity-info');
                            </g:javascript>
                        </g:if>

                        <!-- Portlet -->
                        <div class="portlet light bg-inverse logConfig-portlet">
                            <div class="portlet-title">
                                <div class="caption font-green-dark">
                                    <i class="icon-speech font-green-dark"></i>
                                    <span class="caption-subject sbold uppercase"><g:message code="layouts.main_auth_admin.body.content.logConfiguration.portlet.subject" default="Important information"/></span>
                                </div>
                                <div class="tools">
                                    <a href="" class="collapse"> </a>
                                    <a href="" class="fullscreen"> </a>
                                    <a href="" class="remove"> </a>
                                </div>
                                <div>
                                    <a href="${resource(dir: 'files', file: 'STT_UserTemplate.csv')}" download="" class="btn green-dark button-template icon-button-container"><i class="fa fa-download icon-button" aria-hidden="true"></i><g:message code="default.import.template" default="Template"/></a>
                                </div>
                            </div>

                            <div class="portlet-body">
                                <div class="scroller" style="height:560px" data-rail-visible="1" data-rail-color="#105d41" data-handle-color="#4A9F60">
                                    <h4 class="log-portlet-h4 bold"><g:message code="default.import.title" default="Instructions for importing data"/></h4>
                                    <p>
                                        ${raw(g.message(code: 'default.import.description', default: 'Importing information allows a simple and quick way to enter data into the system. Then, general information to follow for proper operation is shown:' +
                                                '<ul><li>The file to import must have the format <strong>.csv</strong>.</li>' +
                                                '<li>The separator character must be the <strong>semicolon ;</strong>.</li>' +
                                                '<li>The set of coding used is: <strong>UTF-8</strong>.</li>' +
                                                '<li><strong>Due to problems in encoding special characters <i>eg.: tildes</i> appeared to save the file with the software <i>Microsoft Excel</i>, it is advisable not to use this tool.</strong> In case of ' +
                                                'not use these special characters, this software can be used perfectly with the template or a new file.</li>' +
                                                '<li><strong>Free software: <i>LibreOffice</i> presents a problem</strong> when a file already created (eg.: the downloadable template) is used. This file when it is edited and saved with this software and ' +
                                                'later it is imported, the columns are not recognized correctly and the following error is displayed: <strong><i>incorrect number of columns</i></strong> so it is advisable to create a new file for import.</strong></li>' +
                                                '<li><strong>It is recommend using the free software: <i>OpenOffice</i> with the template or with a new file.</strong></li>' +
                                                '<li><strong>The first row is ignored </strong>, corresponding for example to the name of each field.</li>' +
                                                '<li>Each field has the same restrictions as in its manual creation or editing (character limit, pattern to follow, etc.)</li>' +
                                                '<li>At the end of the process, a result message is displayed.</li>' +
                                                '<li>The import process may take several minutes depending on the size of the file.</li></ul>'))}
                                    </p>
                                    <p>
                                        ${raw(g.message(code: 'default.import.description.user', default: 'To import correctly the users, you must follow the following scheme: <strong>| Username<span style="color: #D05454">*</span> | Email<span style="color: #D05454">*</span> | Password<span style="color: #D05454">*</span> ' +
                                                '| Enabled account<span style="color: #D05454">*</span> | Locked account<span style="color: #D05454">*</span> | Expired account<span style="color: #D05454">*</span> | Expired password<span style="color: #D05454">*</span> | Name<span style="color: #D05454">*</span> | ' +
                                                'Surname<span style="color: #D05454">*</span> | Birthdate<span style="color: #D05454">*</span> | Address | City | Country | Phone | Sex<span style="color: #D05454">*</span> | Department<span style="color: #D05454">*</span> | Test | </strong>; where username and email must be unique, ' +
                                                'ie, be available. <br><br> Fields marked with <span style="color: #D05454">*</span> are required, the rest are optional being mandatory that the column is in the <strong>.csv</strong> document although the corresponding fields in each row are empty.'))}
                                    </p>
                                    <p>
                                        ${raw(g.message(code: 'default.import.description.user.recommendation', default: 'Fields that represents the state of the user account can have two values (<strong>true</strong> and <strong>false</strong>) depending on their activation or not, being recommended to enable the <strong>Enabled account</strong> by word: <strong>true</strong>.'))}
                                    </p>
                                    <p>
                                        ${raw(g.message(code: 'default.import.description.user.remember', default: 'Besides, <strong>remember:</strong>' +
                                                '<ul><li>Birthdate must have the following format <strong>dd-MM-yyyy</strong>; where <i>dd</i>: day, <i>MM</i>: month and <i>yyyy</i>: year in numeric format. <strong>Important!</strong> You must configure the ' +
                                                'date format in the sotfware used. Example: The exact path depends on the software used. Approximate path: <i>Configuration/Preferences -> Format -> Cells -> Date</i>.</li>' +
                                                '<li><i>Sex</i> field can have two values: <strong>Masculino/Male</strong> or <strong>Femenino/Female</strong>.</li>' +
                                                '<li>In the <i>Departament</i> field, you must type <strong>only the name</strong> of the department to which the user belongs. <strong>It is important, the prior existence in the system of the department indicated.</strong></li>' +
                                                '<li>The importation of users does not require necessarily associate test.</li><li>To associate test to user, you must specify the <strong>test name</strong>. <strong>It is important, the prior existence in the system of the' +
                                                ' test indicated.</strong></li><li>To associate a test, you must only define its name in the <i>Test</i> field. Example: <strong>testName1</strong></li><li>To associate several test, you must define them separated by <strong>comma</strong> ' +
                                                'in the <i>Test</i> field. Example: <strong>testName1, testName2, testName3</strong></li></ul>'))}
                                    </p>
                                </div>
                            </div>
                        </div> <!-- /. Portlet -->
                    </div>
                </div>

                <!-- Select button -->
                <div class="row">
                    <div class="col-md-12 col-lg-10 col-lg-offset-1">
                        <!-- Upload CSV file -->
                        <g:uploadForm uri="/user/uploadFile" class="user-import-form">
                            <div class="fileinput fileinput-new fileinput-import" data-provides="fileinput">
                                <div class="input-group btn-block input-import">
                                    <div class="form-control uneditable-input input-fixed" data-trigger="fileinput">
                                        <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                        <span class="fileinput-filename"> </span>
                                    </div>
                                    <span class="input-group-addon btn btn-block grey-gallery btn-file">
                                        <span class="fileinput-new"><g:message code="default.import.select.button" default="Select file"/></span>
                                        <span class="fileinput-exists"><g:message code="default.imageProfile.change" default="Change"/></span>
                                        <input type="file" accept="text/comma-separated-values, text/csv, application/csv" name="importFileUser" id="importFileUser" required />
                                    </span>
                                    <a href="javascript:;" class="input-group-addon btn red-soft fileinput-exists" data-dismiss="fileinput"><g:message code="default.imageProfile.remove" default="Remove"/></a>
                                </div>
                            </div>
                            <!-- Submit button -->
                            <div class="importData-button">
                                <button type="submit" name="user-import-button" id="user-import-button" class="btn green-dark btn-block">
                                    <i class="fa fa-refresh fa-lg refresh-icon-stop refreshIcon"></i>
                                    <span><g:message code="layouts.main_auth_admin.sidebar.import" default="Import"/></span>
                                </button>
                            </div>
                        </g:uploadForm>
                    </div> <!-- /.Col -->
                </div> <!-- /.Row -->
            </div> <!-- /.Content page -->
        </div> <!-- /.Page-content -->
    </div> <!-- /. Page-content-wrapper -->

    <g:javascript src="fileInput/bootstrap-fileinput.js"/>
    <g:javascript src="import-validation/userImport-validation.js"/>

</body>
</html>