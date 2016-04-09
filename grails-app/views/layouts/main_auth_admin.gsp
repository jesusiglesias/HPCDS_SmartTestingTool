<!-------------------------------------------------------------------------------------------*
 *                                        ADMIN MAIN                                         *
 *------------------------------------------------------------------------------------------->
<!DOCTYPE html>
  <!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
  <!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
  <!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
  <!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
  <!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->

<!-- HEAD -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="description" content="Smart Testing Tool is a HP CDS solution for online evaluation of different subjects through testing that
    it intended as a tool for internal qualification of personnel."/>
    <meta name="author" content="Jesús Iglesias García"/>
    <meta name="keywords" content="HP CDS, Smart Testing Tool, online test, evaluation test, english testing tool, test online, evaluacion online, Jesus Iglesias, TFG, Universidad de Valladolid, UVa"/>
    <meta name="dcterms.rightsHolder" content="Jesús Iglesias García">
    <meta name="dcterms.dateCopyrighted" content="2016">

    <!-- LOAD TITLE -->
    <title><g:layoutTitle/></title>

    <!-- FAVICON -->
    <link rel="shortcut icon" href="${assetPath(src: 'favicon/favicon.ico')}" type="image/x-icon">
    <link rel="icon" href="${assetPath(src: 'favicon/favicon.ico')}" type="image/x-icon">

    <!-- HUMANS.TXT -->
    <link type="text/plain" rel="author" href="${createLink(uri: '/humans.txt')}"/>

    <!-- LOAD CSS TODO -->
   <%-- <asset:stylesheet src="application.css"/> --%>

    <!-- GLOBAL MANDATORY STYLES -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.2.3/css/simple-line-icons.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" crossorigin="anonymous">
    <%-- TODO <link rel="stylesheet" href="${resource(dir: 'css', file: 'uniform.default.min.css')}" type="text/css"/> --%>
    <!-- TODO -->
    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'custom.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'placeholder_polyfill.min.css')}" type="text/css"/>
    <!-- Notification switch user -->
    <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">

    <!-- BEGIN PAGE LEVEL PLUGINS TODO -->
    <!-- <link href="../assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/jqvmap/jqvmap/jqvmap.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" type="text/css"/>-->
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- THEME GLOBAL STYLES -->
    <!-- <link href="../../assets/admin/pages/css/tasks.css" rel="stylesheet" type="text/css"/> -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'components-md.css')}" type="text/css" id="style_components"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'plugins-md.css')}" type="text/css"/>

    <!-- THEME LAYOUT STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'light2.css')}" type="text/css" id="style_color"/>

    <!-- LOAD JS -->
    <asset:javascript src="application.js"/>
    <!-- Notification switch user -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" crossorigin="anonymous"></script>

    <!-- HTML5 SHIV, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
		<script src="/js/html5shiv.min.js" type="text/javascript"></script>
    <![endif]-->

    <!-- LOAD HEADER OTHER VIEWS -->
    <g:layoutHead/>
</head> <!-- /.HEAD -->

<!-- BODY -->
<body class="page-header-fixed page-header-fixed-mobile page-sidebar-closed-hide-logo page-content-white page-md">


    <!-- Account states notification -->
    <g:if test='${flash.errorSwitchUser}'>
        <script type="text/javascript">

            toastr["error"]("${flash.errorSwitchUser}");

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": false,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
        </script>
    </g:if>

    <!-- HEADER -->
    <div class="page-header navbar navbar-fixed-top" role="navigation">
        <div class="page-header-inner">
            <!-- Logo -->
            <div class="page-logo">
                <!-- Image -->
                <g:link uri="/">
                    <asset:image src="logo/logo.png" alt="HP CDS - Smart Testing Tool" class="logo-default"/>
                </g:link>
                <!-- Hamburguer -->
                <div class="menu-toggler sidebar-toggler">
                    <asset:image src="hamburguer/toggler_icon.png" alt="Toggler"/>
                </div>
            </div> <!-- /.Logo -->
            <!-- Responsive hamburguer -->
            <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
                <asset:image src="hamburguer/toggler_icon.png" alt="Toggler"/>
            </a>

            <!-- Top navigation menu -->
            <div class="top-menu">
                <ul class="nav navbar-nav pull-right">
                    <!-- User dropdown -->
                    <li class="dropdown dropdown-user">
                        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                            <!-- Profile image -->
                            <img class="img-circle" alt="Profile image" src="${createLink(controller:'customTasksBackend', action:'profileImage')}"/>
                            <span class="username username-hide-on-mobile">
                                <sec:ifLoggedIn>
                                    <sec:username/>
                                </sec:ifLoggedIn>
                            </span>
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- Profile -->
                            <li>
                                <g:link controller="secUser" action="edit" id="${sec.loggedInUserInfo(field:"id")}">
                                    <i class="icon-user"></i> <g:message code="layouts.main_auth_admin.head.profile" default="My profile"/>
                                </g:link>
                            </li>
                            <!-- Switch user -->
                            <li>
                                <sec:ifNotSwitched>
                                    <sec:ifAllGranted roles='ROLE_ADMIN'>
                                        <form action='${request.contextPath}/j_spring_security_switch_user' method='POST'>
                                            <g:hiddenField name="stt_hp_username" value="admin_switch" />
                                            <button class="exit-switch-button">
                                            <i class="fa fa-exchange"></i> <g:message code="layouts.main_auth_admin.head.switchUser" default="Normal user"/>
                                        </button>
                                        </form>
                                    </sec:ifAllGranted>
                                </sec:ifNotSwitched>
                            </li>

                            <li class="divider"> </li>

                            <!-- Logout -->
                            <li>
                                <form name="logout" method="POST" action="${createLink(controller:'logout')}">
                                    <button class="exit-switch-button">
                                        <i class="fa fa-sign-out"></i> <g:message code="layouts.main_auth_admin.head.logout" default="Logout"/>
                                    </button>
                                </form>
                            </li>
                        </ul>
                    </li> <!-- /. User dropdown -->

                    <!-- Exit button -->
                    <li class="dropdown">
                        <!-- Logout -->
                        <form name="logout" method="POST" action="${createLink(controller:'logout')}">
                            <button class="exit-button dropdown-toggle">
                                <i class="icon-logout"></i>
                            </button>
                        </form>
                    </li>
                </ul>
            </div> <!-- /.Top navigation menu -->
        </div> <!-- /.Header inner -->
    </div><!-- /.HEADER -->

    <!-- Container -->
    <div class="page-container">
        <!-- Page-sidebar-wrapper -->
        <div class="page-sidebar-wrapper">
            <!-- Page-sidebar -->
            <div class="page-sidebar navbar-collapse collapse">
                <!-- Page-sidebar-menu -->
                <ul class="page-sidebar-menu page-header-fixed" data-keep-expanded="true" data-auto-scroll="true" data-slide-speed="200" style="padding-top: 30px">
                    <li class="sidebar-search-wrapper">
                        <g:form class="sidebar-search" controller="user" action="index">
                            <a href="javascript:;" class="remove">
                                <i class="icon-close"></i>
                            </a>
                            <div class="input-group">
                                <!-- ie8, ie9 does not support html5 placeholder, so it just shows field title for that-->
                                <label class="control-label visible-ie8 visible-ie9" for="quickSearch"><g:message code="layouts.main_auth_admin.sidebar.search" default="Search..."/></label>
                                <g:textField name="quickSearch" class="form-control placeholder-no-fix quickSearch-input backend-input" placeholder="${message(code:'layouts.main_auth_admin.sidebar.search', default:'Search...')}" autocomplete="on"/>
                                <i class="fa fa-times i-delete-quickSearch"></i> <!-- Delete text icon -->
                                <span class="input-group-btn">
                                    <a href="javascript:;" class="btn submit">
                                        <i class="icon-magnifier"></i>
                                    </a>
                                </span>
                            </div>
                        </g:form>
                    </li> <!-- /.Search form -->

                    <li class="nav-item start active open">
                        <a href="javascript:;" class="nav-link nav-toggle">
                            <i class="icon-home"></i>
                            <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard" default="Dashboard"/></span>
                            <span class="selected"></span>
                            <span class="arrow open"></span>
                        </a>
                        <ul class="sub-menu">
                            <li class="nav-item start active open">
                                <g:link controller="customTasksBackend" action="dashboard" class="nav-link">
                                    <i class="fa fa-bar-chart"></i>
                                    <span class="title"><g:message code="layouts.main_auth_admin.sidebar.title.dashboard.statistics" default="Statistics"/></span>
                                    <span class="selected"></span>
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
                        </ul>
                    </li>

                    <!-- Normal user -->
                    <li class="nav-item">
                        <a href="javascript:;" class="nav-link nav-toggle">
                            <i class="fa fa-user"></i>
                            <span class="title"><g:message code="layouts.main_auth_admin.sidebar.normalUser" default="Normal user"/></span>
                            <span class="arrow"></span>
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
                        </ul>
                    </li>

                    <!-- Answer -->
                    <li class="nav-item">
                        <a href="javascript:;" class="nav-link nav-toggle">
                            <i class="fa fa-pencil"></i>
                            <span class="title"><g:message code="layouts.main_auth_admin.sidebar.answer" default="Answer"/></span>
                            <span class="selected"></span>
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
                        </ul>
                    </li>

                    <!-- Evaluation -->
                    <li class="nav-item">
                        <a href="javascript:;" class="nav-link nav-toggle">
                            <i class="fa fa-graduation-cap"></i>
                            <span class="title"><g:message code="layouts.main_auth_admin.sidebar.evaluation" default="Evaluation"/></span>
                            <span class="arrow"></span>
                        </a>
                        <ul class="sub-menu">
                            <li class="nav-item">
                            <!-- TODO -->
                                <g:link class="nav-link">
                                    <i class="fa fa-plus"></i>
                                    <span class="title"><g:message code="layouts.main_auth_admin.sidebar.newFemale" default="New"/></span>
                                </g:link>
                            </li>
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
                        <!-- TODO Nav-toggle -->
                        <g:link controller="customTasksBackend" action="reloadLogConfig" class="nav-link nav-toggle">
                            <i class="icon-settings"></i>
                            <span class="title"><g:message code="layouts.main_auth_admin.sidebar.logConfiguration" default="Log configuration"/></span>
                            <span class="arrow"></span>
                        </g:link>
                    </li>
                    <!-- /.CONFIGURATION -->

                </ul> <!-- /.Page-sidebar-menu -->
             </div> <!-- Page-sidebar -->
        </div> <!-- Page-sidebar-wrapper -->

        <!-- LOAD BODY OTHER VIEWS -->
        <g:layoutBody/>

    </div> <!-- /. Container -->

    <!-- BEGIN FOOTER -->
    <div class="page-footer">
        <div class="copyright-admin"> 2016 © <g:link uri="http://es.linkedin.com/in/jesusgiglesias" class="author-link"> Jesús Iglesias García </g:link></div>
        <div class="logoHP-admin">
            <g:link uri="https://www.hpcds.com/es/">
                <asset:image src="logo/logo_hp.png" alt="HP CDS"/>
            </g:link>
        </div>
    </div>

    <!-- Back to top -->
    <g:link href="#" class="back-to-top back-to-top-error"><g:message code="views.general.backtotop" default="Top"/></g:link>

    <!-- LOAD JAVASCRIPT -->
    <!-- Enable responsive CSS code on browsers that don't support it -->
    <!--[if lt IE 9]>
        <script src="../js/respond.min.js"></script>
    <![endif]-->

    <!-- CORE PLUGINS -->
    <!-- TODO -->
    <g:javascript src="js.cookie.min.js"/>
    <g:javascript src="bootstrap-hover-dropdown.min.js"/>
    <g:javascript src="jquery.slimscroll.min.js"/>
    <g:javascript src="jquery.blockui.min.js"/>
    <%-- TODO
    <g:javascript src="jquery.uniform.min.js"/> --%>
    <g:javascript src="custom.js"/>
    <g:javascript src="placeholder_polyfill.jquery.min.combo.js"/>

    <!-- THEME GLOBAL SCRIPTS -->
    <g:javascript src="app.js"/>

    <!-- THEME LAYOUT SCRIPTS -->
    <g:javascript src="layout.js"/>

    <!-- PAGE LEVEL SCRIPTS -->
    <%-- <g:javascript src="dashboard.min.js"/> --%>
    <!-- TODO -->
    <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
    <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>

    <%-- TODO
    <g:javascript src="demo.js"/>
    <g:javascript src="quick-sidebar.js"/> --%>

</body>
</html>