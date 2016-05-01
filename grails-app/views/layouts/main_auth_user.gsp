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

    <!-- THEME GLOBAL STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'components-md.css')}" type="text/css" id="style_components"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'plugins-md.css')}" type="text/css"/>

    <!-- THEME LAYOUT STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'light2.css')}" type="text/css" id="style_color"/>

    <!-- LOAD JS -->
    <asset:javascript src="application.js"/>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" crossorigin="anonymous"></script>

    <!-- Cookie message -->
    <g:javascript src="cookies/cookies.js"/>

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
<body class="page-header-fixed page-header-fixed-mobile page-sidebar-closed-hide-logo page-content-white page-md">

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
                    <li class="dropdown dropdown-user open">
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
                            <!-- Profile TODO -->
                            <li>
                                <g:link uri="/profile" id="${sec.loggedInUserInfo(field:"id")}">
                                    <i class="icon-user"></i> <g:message code="layouts.main_auth_admin.head.profile" default="My profile"/>
                                </g:link>
                            </li>
                            <!-- Switch user -->
                            <li>
                                <sec:ifSwitched>
                                    <sec:ifAllGranted roles='ROLE_USER'>
                                        <form action='${request.contextPath}/j_spring_security_exit_user' method='POST'>
                                            <button class="exit-switch-button">
                                                <i class="fa fa-exchange"></i> <g:message code="layouts.main_auth_user.head.switchUser" default="Administrator user"/>
                                            </button>
                                        </form>
                                    </sec:ifAllGranted>
                                </sec:ifSwitched>
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

    <!-- Cookie block -->
    <div id="cookie-container" class="row">
        <div id="cookie-message" class="col-xs-12">
            <p>
                <i class="fa fa-exclamation-circle fa-custom" aria-hidden="true"></i>
                <g:message code="layouts.main_auth_user.body.content.cookie.message" default="This site uses cookies for the correct user navigation. If you continue browsing, it considers that you accept its use."/>
            </p>
            <div>
                <g:link controller="customTasksBackend" action="dashboard" class="btn blue-chambray btn-sm"><g:message code="layouts.main_auth_user.body.content.cookie.information" default="More information"/></g:link>
                <a onclick="acceptCookies();" style="cursor:pointer;" class="btn blue-chambray btn-sm">
                    <g:message code="layouts.main_auth_user.body.content.cookie.close" default="Close"/>
                </a>
            </div>
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