<!-------------------------------------------------------------------------------------------*
 *                                         USER MAIN                                         *
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

    <!-- GLOBAL MANDATORY STYLES -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.2.3/css/simple-line-icons.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'custom.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/placeholder', file: 'placeholder_polyfill.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/iconfont', file: 'icofont.css')}" type="text/css"/>

    <!-- THEME GLOBAL STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'components-md.css')}" type="text/css" id="style_components"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'plugins-md.css')}" type="text/css"/>

    <!-- THEME LAYOUT STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'light2.css')}" type="text/css" id="style_color"/>

    <!-- LOAD JS -->
    <asset:javascript src="application.js"/>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" crossorigin="anonymous"></script>

    <!-- HTML5 SHIV, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
		<script src="/js/html5shiv.min.js" type="text/javascript"></script>
    <![endif]-->

    <!-- LOAD HEADER OTHER VIEWS -->
    <g:layoutHead/>

    <!-- Google Analytics -->
    <script>
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
                m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

        ga('create', 'UA-77125571-1', 'none');
        ga('send', 'pageview');
    </script>

</head> <!-- /.HEAD -->

<!-- BODY -->
<body class="page-header-fixed page-header-fixed-mobile page-sidebar-closed-hide-logo page-content-white page-full-width page-md">

    <!-- HEADER -->
    <div class="page-header navbar navbar-fixed-top" role="navigation">
        <div class="page-header-inner">
            <!-- Logo -->
            <div class="page-logo">
                <!-- Image -->
                <g:link uri="/">
                    <asset:image src="logo/logo.png" alt="HP CDS - Smart Testing Tool" class="logo-default hvr-wobble-horizontal"/>
                </g:link>
                <!-- Hamburguer  TODO-->
                <!--<div class="menu-toggler sidebar-toggler">
                    <i class="icofont  icofont-navigation-menu"></i>
                </div> -->
            </div> <!-- /.Logo -->
            <!-- Responsive hamburguer -->
            <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
                <i class="icofont  icofont-navigation-menu"></i>
            </a>
            <sec:ifLoggedIn>
                <!-- Top navigation menu -->
                <div class="top-menu">
                    <ul class="nav navbar-nav pull-right">
                        <!-- User dropdown -->
                        <li class="dropdown dropdown-user">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <!-- Profile image -->
                                <img class="img-circle" alt="Profile image" src="${createLink(controller:'customTasksBackend', action:'profileImage')}"/>
                                <span class="username username-hide-on-mobile">
                                        <sec:username/>
                                </span>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- Profile TODO -->
                                <li class="li-iconId-user">
                                    <g:link uri="/profile" id="${sec.loggedInUserInfo(field:"id")}">
                                        <i class="icofont icofont-id iconId-user"></i> <g:message code="layouts.main_auth_admin.head.profile" default="My profile"/>
                                    </g:link>
                                </li>
                                <!-- Evaluations TODO -->
                                <li class="li-evaluations-user">
                                    <g:link uri="/profile" id="${sec.loggedInUserInfo(field:"id")}">
                                        <i class="icofont icofont-badge iconEvaluations-user"></i> <g:message code="layouts.main_auth_user.head.evaluations" default="My qualifications"/>
                                    </g:link>
                                </li>
                                <!-- Switch user -->
                                <li class="li-exchange-user">
                                    <sec:ifSwitched>
                                        <sec:ifAllGranted roles='ROLE_USER'>
                                            <form action='${request.contextPath}/j_spring_security_exit_user' method='POST'>
                                                <button class="exit-switch-button">
                                                    <i class="fa fa-exchange iconExchange-user"></i> <g:message code="layouts.main_auth_user.head.switchUser" default="Administrator user"/>
                                                </button>
                                            </form>
                                        </sec:ifAllGranted>
                                    </sec:ifSwitched>
                                </li>

                                <li class="divider"> </li>

                                <!-- Logout -->
                                <li class="li-logout-user">
                                    <form name="logout" method="POST" action="${createLink(controller:'logout')}">
                                        <button class="exit-switch-button">
                                            <i class="fa fa-sign-out iconLogout-user"></i> <g:message code="layouts.main_auth_admin.head.logout" default="Logout"/>
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
            </sec:ifLoggedIn>

        <!-- DOC: Remove "hor-menu-light" class to have a horizontal menu with theme background instead of white background -->
        <!-- DOC: This is desktop version of the horizontal menu. The mobile version is defined(duplicated) in the responsive menu below along with sidebar menu. So the horizontal menu has 2 seperate versions -->
            <div class="hor-menu  hidden-sm hidden-xs">
                <ul class="nav navbar-nav">
                    <!-- DOC: Remove data-hover="megamenu-dropdown" and data-close-others="true" attributes below to disable the horizontal opening on mouse hover -->
                    <li class="classic-menu-dropdown active">
                        <g:link uri="/faq"><g:message code="layout.main_auth_user.horizontal.menu.faq" default="Help"/>
                            <span class="selected"> </span>
                        </g:link>
                    </li>
                    <li class="classic-menu-dropdown active">
                        <g:link uri="/contact"><g:message code="layout.main_auth_user.horizontal.menu.contact" default="Contact"/>
                            <span class="selected"> </span>
                        </g:link>
                    </li>
                    <li class="classic-menu-dropdown active">
                        <g:link uri="/cookiesPolicy"><g:message code="layout.main_auth_user.horizontal.menu.cookie" default="Cookie policy"/>
                            <span class="selected"> </span>
                        </g:link>
                    </li>

                    <li class="mega-menu-dropdown">
                        <a href="javascript:;" class="dropdown-toggle" data-hover="megamenu-dropdown" data-close-others="true"> Mega
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu" style="min-width: 700px;">
                            <li>
                                <!-- Content container to add padding -->
                                <div class="mega-menu-content">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <ul class="mega-menu-submenu">
                                                <li>
                                                    <h3>Section 1</h3>
                                                </li>
                                                <li>
                                                    <a href="#">Example Link</a>
                                                </li>

                                            </ul>
                                        </div>
                                        <div class="col-md-4">
                                            <ul class="mega-menu-submenu">
                                                <li>
                                                    <h3>Section 2</h3>
                                                </li>
                                                <li>
                                                    <a href="#">Example Link</a>
                                                </li>

                                            </ul>
                                        </div>
                                        <div class="col-md-4">
                                            <ul class="mega-menu-submenu">
                                                <li>
                                                    <h3>Section 3</h3>
                                                </li>
                                                <li>
                                                    <a href="#">Example Link</a>
                                                </li>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li class="mega-menu-dropdown mega-menu-full" data-hover="megamenu-dropdown" data-close-others="true">
                        <a href="javascript:;" class="dropdown-toggle" data-hover="megamenu-dropdown" data-close-others="true"> Full Mega
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li>
                                <!-- Content container to add padding -->
                            <div class="mega-menu-content ">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <ul class="mega-menu-submenu">
                                                    <li>
                                                        <h3>Section 1</h3>
                                                    </li>
                                                    <li>
                                                        <a href="#">Example Link</a>
                                                    </li>

                                                </ul>
                                            </div>
                                            <div class="col-md-3">
                                                <ul class="mega-menu-submenu">
                                                    <li>
                                                        <h3>Section 1</h3>
                                                    </li>
                                                    <li>
                                                        <a href="#">Example Link</a>
                                                    </li>

                                                </ul>
                                            </div>
                                            <div class="col-md-3">
                                                <ul class="mega-menu-submenu">
                                                    <li>
                                                        <h3>Section 1</h3>
                                                    </li>
                                                    <li>
                                                        <a href="#">Example Link</a>
                                                    </li>

                                                </ul>
                                            </div>
                                            <div class="col-md-3">
                                                <ul class="mega-menu-submenu">
                                                    <li>
                                                        <h3>Section 4</h3>
                                                    </li>
                                                    <li>
                                                        <a href="#">Example Link</a>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div id="accordion" class="panel-group">
                                            <div class="panel panel-success">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" class="collapsed"> Mega Menu Info #1 </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseOne" class="panel-collapse in">
                                                    <div class="panel-body"> Metronic Mega Menu Works for fixed and responsive layout and has the facility to include (almost) any Bootstrap elements. </div>
                                                </div>
                                            </div>
                                            <div class="panel panel-danger">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed"> Mega Menu Info #2 </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseTwo" class="panel-collapse collapse">
                                                    <div class="panel-body"> Metronic Mega Menu Works for fixed and responsive layout and has the facility to include (almost) any Bootstrap elements. </div>
                                                </div>
                                            </div>
                                            <div class="panel panel-info">
                                                <div class="panel-heading">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree"> Mega Menu Info #3 </a>
                                                    </h4>
                                                </div>
                                                <div id="collapseThree" class="panel-collapse collapse">
                                                    <div class="panel-body"> Metronic Mega Menu Works for fixed and responsive layout and has the facility to include (almost) any Bootstrap elements. </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </li>
                <li class="classic-menu-dropdown">
                    <a href="javascript:;" data-hover="megamenu-dropdown" data-close-others="true"> Classic
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu pull-left">
                        <li>
                            <a href="javascript:;">
                                <i class="fa fa-bookmark-o"></i> Section 1 </a>
                        </li>
                        <li>
                            <a href="javascript:;">
                                <i class="fa fa-user"></i> Section 2 </a>
                        </li>
                        <li>
                            <a href="javascript:;">
                                <i class="fa fa-puzzle-piece"></i> Section 3 </a>
                        </li>
                        <li>
                            <a href="javascript:;">
                                <i class="fa fa-gift"></i> Section 4 </a>
                        </li>
                        <li>
                            <a href="javascript:;">
                                <i class="fa fa-table"></i> Section 5 </a>
                        </li>
                        <li class="dropdown-submenu">
                            <a href="javascript:;">
                                <i class="fa fa-envelope-o"></i> More options </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="javascript:;"> Second level link </a>
                                </li>
                                <li class="dropdown-submenu">
                                    <a href="javascript:;"> More options </a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="index.html"> Third level link </a>
                                        </li>
                                        <li>
                                            <a href="index.html"> Third level link </a>
                                        </li>
                                        <li>
                                            <a href="index.html"> Third level link </a>
                                        </li>
                                        <li>
                                            <a href="index.html"> Third level link </a>
                                        </li>
                                        <li>
                                            <a href="index.html"> Third level link </a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="index.html"> Second level link </a>
                                </li>
                                <li>
                                    <a href="index.html"> Second level link </a>
                                </li>
                                <li>
                                    <a href="index.html"> Second level link </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- DOC: Apply "search-form-expanded" right after the "search-form" class to have half expanded search box -->
        <form class="search-form" action="extra_search.html" method="GET">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search..." name="query">
                <span class="input-group-btn">
                    <a href="javascript:;" class="btn submit">
                        <i class="icon-magnifier"></i>
                    </a>
                </span>
            </div>
        </form>
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>



        </div> <!-- /.Header inner -->
    </div><!-- /.HEADER -->

    <!-- Container -->
    <div class="page-container">

        <!-- LOAD BODY OTHER VIEWS -->
        <g:layoutBody/>

    </div> <!-- /. Container -->

    <!-- BEGIN FOOTER -->
    <div class="page-footer">
        <div class="copyright-admin"> 2016 © <g:link uri="http://es.linkedin.com/in/jesusgiglesias" class="author-link"> Jesús Iglesias García </g:link></div>
        <div class="logoHP-admin">
            <g:link uri="https://www.hpcds.com/">
                <asset:image src="logo/logo_hp.png" alt="HP CDS" class="hvr-wobble-vertical"/>
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
    <g:javascript src="dropdown/bootstrap-hover-dropdown.min.js"/>
    <g:javascript src="slimScroll/jquery.slimscroll.min.js"/>
    <g:javascript src="custom/custom.js"/>
    <g:javascript src="custom/icon.js"/>
    <g:javascript src="placeholder/placeholder_polyfill.jquery.min.combo.js"/>

    <!-- THEME GLOBAL SCRIPTS -->
    <g:javascript src="app.js"/>

    <!-- THEME LAYOUT SCRIPTS -->
    <g:javascript src="layout.js"/>

    <!-- PAGE LEVEL SCRIPTS -->
    <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
    <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>

</body>
</html>