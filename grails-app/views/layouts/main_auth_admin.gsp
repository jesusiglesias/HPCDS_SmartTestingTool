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

    <title><g:layoutTitle default="${message(code: 'layouts.main_auth_admin.head.title')}"/></title>

    <!-- TODO -->
    <meta name="description" content="Smart Testing Tool is a HP CDS solution for online evaluation of different subjects through testing that
    it intended as a tool for internal qualification of personnel."/>
    <meta name="author" content="Jesús Iglesias García"/>
    <meta name="keywords" content="HP CDS, Smart Testing Tool, online test, evaluation test, english testing tool, test online, evaluación online, Jesus Iglesias, TFG, Universidad de Valladolid, UVa"/>

    <!-- FAVICON -->
    <link rel="shortcut icon" href="${assetPath(src: 'Favicon/favicon.ico')}" type="image/x-icon">
    <link rel="icon" href="${assetPath(src: 'Favicon/favicon.ico')}" type="image/x-icon">

    <!-- HUMANS.TXT -->
    <link type="text/plain" rel="author" href="${createLink(uri: '/humans.txt')}"/>

    <!-- LOAD CSS -->
    <asset:stylesheet src="application.css"/>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'font-awesome.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'simple-line-icons.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'uniform.default.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-switch.min.css')}" type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <!-- <link href="../assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/morris/morris.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/jqvmap/jqvmap/jqvmap.css" rel="stylesheet" type="text/css" />
         <link href="../assets/global/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" type="text/css"/>-->
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THEME GLOBAL STYLES -->
    <!-- <link href="../../assets/admin/pages/css/tasks.css" rel="stylesheet" type="text/css"/> -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'components-md.css')}" type="text/css" id="style_components"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'plugins-md.css')}" type="text/css"/>
    <!-- END THEME GLOBAL STYLES -->

    <!-- BEGIN THEME LAYOUT STYLES -->
    <!-- <link href="../assets/global/css/components.css" rel="stylesheet" type="text/css"/>
         <link href="../assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
         <link href="../assets/layouts/layout/css/layout.css" rel="stylesheet" type="text/css"/> -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'light2.css')}" type="text/css" id="style_color"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'custom.css')}" type="text/css"/>
    <!-- END THEME LAYOUT STYLES -->

    <!-- LOAD JS -->
    <asset:javascript src="application.js"/>

    <!-- HTML5 SHIV, for IE6-8 support of HTML5 elements TODO -->
    <!--[if lt IE 9]>
		<script src="/js/html5shiv.min.js" type="text/javascript"></script>
    <![endif]-->

    <!-- LOAD HEADER OTHER VIEWS -->
    <g:layoutHead/>
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
                <asset:image src="Logo/logo.png" alt="HP CDS - Smart Testing Tool" class="logo-default"/>
            </g:link>
            <!-- Hamburguer -->
            <div class="menu-toggler sidebar-toggler">
                <asset:image src="Hamburguer/toggler_icon.png" alt="Toggler"/>
            </div>
        </div> <!-- /.Logo -->
    <!-- Responsive hamburguer -->
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
            <asset:image src="Hamburguer/toggler_icon.png" alt="Toggler"/>
        </a>

        <!-- Top navigation menu -->
        <div class="top-menu">
            <ul class="nav navbar-nav pull-right">
                <!-- Notification icons -->
                <li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                        <i class="icon-bell"></i>
                        <span class="badge badge-default"> 7 </span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="external">
                            <h3>
                                <span class="bold">12 pending</span> notifications</h3>
                            <a href="page_user_profile_1.html">view all</a>
                        </li>
                        <li>
                            <ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">just now</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-success">
                                                <i class="fa fa-plus"></i>
                                            </span> New user registered. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">3 mins</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-danger">
                                                <i class="fa fa-bolt"></i>
                                            </span> Server #12 overloaded. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">10 mins</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-warning">
                                                <i class="fa fa-bell-o"></i>
                                            </span> Server #2 not responding. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">14 hrs</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-info">
                                                <i class="fa fa-bullhorn"></i>
                                            </span> Application error. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">2 days</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-danger">
                                                <i class="fa fa-bolt"></i>
                                            </span> Database overloaded 68%. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">3 days</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-danger">
                                                <i class="fa fa-bolt"></i>
                                            </span> A user IP blocked. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">4 days</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-warning">
                                                <i class="fa fa-bell-o"></i>
                                            </span> Storage Server #4 not responding dfdfdfd. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">5 days</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-info">
                                                <i class="fa fa-bullhorn"></i>
                                            </span> System Error. </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="time">9 days</span>
                                        <span class="details">
                                            <span class="label label-sm label-icon label-danger">
                                                <i class="fa fa-bolt"></i>
                                            </span> Storage server failed. </span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <!-- END NOTIFICATION DROPDOWN -->
                <!-- BEGIN INBOX DROPDOWN -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                <li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                        <i class="icon-envelope-open"></i>
                        <span class="badge badge-default"> 4 </span>
                    </a>
                    <ul class="dropdown-menu">
                        <li class="external">
                            <h3>You have
                                <span class="bold">7 New</span> Messages</h3>
                            <a href="app_inbox.html">view all</a>
                        </li>
                        <li>
                            <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
                                <li>
                                    <a href="#">
                                        <span class="photo">
                                            <asset:image src="avatar2.jpg" class="img-circle" alt=""/>
                                        </span>
                                        <span class="subject">
                                            <span class="from"> Lisa Wong </span>
                                            <span class="time">Just Now </span>
                                        </span>
                                        <span class="message"> Vivamus sed auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="photo">
                                            <asset:image src="avatar3.jpg" class="img-circle" alt=""/>
                                        </span>
                                        <span class="subject">
                                            <span class="from"> Richard Doe </span>
                                            <span class="time">16 mins </span>
                                        </span>
                                        <span class="message"> Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="photo">
                                            <asset:image src="avatar1.jpg" class="img-circle" alt=""/>
                                        </span>
                                        <span class="subject">
                                            <span class="from"> Bob Nilson </span>
                                            <span class="time">2 hrs </span>
                                        </span>
                                        <span class="message"> Vivamus sed nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="photo">
                                            <asset:image src="avatar2.jpg" class="img-circle" alt=""/>
                                        </span>
                                        <span class="subject">
                                            <span class="from"> Lisa Wong </span>
                                            <span class="time">40 mins </span>
                                        </span>
                                        <span class="message"> Vivamus sed auctor 40% nibh congue nibh... </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="photo">
                                            <asset:image src="avatar3.jpg" class="img-circle" alt=""/>
                                        </span>
                                        <span class="subject">
                                            <span class="from"> Richard Doe </span>
                                            <span class="time">46 mins </span>
                                        </span>
                                        <span class="message"> Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <!-- END INBOX DROPDOWN -->
                <!-- BEGIN TODO DROPDOWN -->
                <li class="dropdown dropdown-extended dropdown-tasks" id="header_task_bar">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                        <i class="icon-calendar"></i>
                        <span class="badge badge-default"> 3 </span>
                    </a>
                    <ul class="dropdown-menu extended tasks">
                        <li class="external">
                            <h3>You have
                                <span class="bold">12 pending</span> tasks</h3>
                            <a href="app_todo.html">view all</a>
                        </li>
                        <li>
                            <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
                                <li>
                                    <a href="javascript:;">
                                        <span class="task">
                                            <span class="desc">New release v1.2 </span>
                                            <span class="percent">30%</span>
                                        </span>
                                        <span class="progress">
                                            <span style="width: 40%;" class="progress-bar progress-bar-success" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">40% Complete</span>
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="task">
                                            <span class="desc">Application deployment</span>
                                            <span class="percent">65%</span>
                                        </span>
                                        <span class="progress">
                                            <span style="width: 65%;" class="progress-bar progress-bar-danger" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">65% Complete</span>
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="task">
                                            <span class="desc">Mobile app release</span>
                                            <span class="percent">98%</span>
                                        </span>
                                        <span class="progress">
                                            <span style="width: 98%;" class="progress-bar progress-bar-success" aria-valuenow="98" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">98% Complete</span>
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="task">
                                            <span class="desc">Database migration</span>
                                            <span class="percent">10%</span>
                                        </span>
                                        <span class="progress">
                                            <span style="width: 10%;" class="progress-bar progress-bar-warning" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">10% Complete</span>
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="task">
                                            <span class="desc">Web server upgrade</span>
                                            <span class="percent">58%</span>
                                        </span>
                                        <span class="progress">
                                            <span style="width: 58%;" class="progress-bar progress-bar-info" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">58% Complete</span>
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="task">
                                            <span class="desc">Mobile development</span>
                                            <span class="percent">85%</span>
                                        </span>
                                        <span class="progress">
                                            <span style="width: 85%;" class="progress-bar progress-bar-success" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">85% Complete</span>
                                            </span>
                                        </span>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;">
                                        <span class="task">
                                            <span class="desc">New UI release</span>
                                            <span class="percent">38%</span>
                                        </span>
                                        <span class="progress progress-striped">
                                            <span style="width: 38%;" class="progress-bar progress-bar-important" aria-valuenow="18" aria-valuemin="0" aria-valuemax="100">
                                                <span class="sr-only">38% Complete</span>
                                            </span>
                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <!-- END TODO DROPDOWN -->
                <!-- BEGIN USER LOGIN DROPDOWN -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                <li class="dropdown dropdown-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                        <asset:image src="avatar3.jpg" class="img-circle" alt=""/>
                        <span class="username username-hide-on-mobile"> Admin </span>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">
                        <li>
                            <a href="page_user_profile_1.html">
                                <i class="icon-user"></i> <g:message code="layouts.main_auth_user.body.profile" default="My profile"/></a>
                        </li>
                        <li>
                            <a href="app_calendar.html">
                                <i class="icon-calendar"></i> My Calendar </a>
                        </li>
                        <li>
                            <a href="app_inbox.html">
                                <i class="icon-envelope-open"></i> My Inbox
                                <span class="badge badge-danger"> 3 </span>
                            </a>
                        </li>
                        <li>
                            <a href="app_todo.html">
                                <i class="icon-rocket"></i> My Tasks
                                <span class="badge badge-success"> 7 </span>
                            </a>
                        </li>
                        <li class="divider"> </li>
                        <li>
                            <a href="page_user_lock_1.html">
                                <i class="icon-lock"></i> Lock Screen </a>
                        </li>
                        <li>
                            <form name="logout" method="POST" action="${createLink(controller:'logout')}">
                                <a>
                                    <input type="submit" value="logout">
                                </a>
                            </form>

                            <g:form name="logout" method="post" controller="logout">
                                <a>
                                    <i class="icon-key"></i> <g:message code="layouts.main_auth_user.body.logout" default="Log out"/>
                                </a>
                            </g:form>


                            <g:remoteLink controller="logout" action="index" method="post">
                                <i class="icon-key"></i> <g:message code="layouts.main_auth_user.body.logout" default="Log out"/>
                            </g:remoteLink>

                            <g:remoteLink class="logout" controller="logout" method="post" asynchronous="false" onSuccess="location.reload()">Logout</g:remoteLink>


                        <!-- <a href="page_user_login_1.html">
                             </a> -->
                        </li>
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->
                <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                <li class="dropdown dropdown-quick-sidebar-toggler">
                    <a href="javascript:;" class="dropdown-toggle">
                        <i class="icon-logout"></i>
                    </a>
                </li>
                <!-- END QUICK SIDEBAR TOGGLER -->
            </ul>

        </div> <!-- /.Top navigation menu -->
    </div> <!-- /.Header inner -->
</div><!-- /.HEADER -->

<g:layoutBody/>


<%--


  <!-- BEGIN TOP NAVIGATION MENU -->
  <div class="top-menu">
    <ul class="nav navbar-nav pull-right">
      <!-- BEGIN NOTIFICATION DROPDOWN -->
      <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
      <li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
          <i class="icon-bell"></i>
          <span class="badge badge-default"> 7 </span>
        </a>
        <ul class="dropdown-menu">
          <li class="external">
            <h3>
              <span class="bold">12 pending</span> notifications</h3>
            <a href="page_user_profile_1.html">view all</a>
          </li>
          <li>
            <ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
              <li>
                <a href="javascript:;">
                  <span class="time">just now</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-success">
                      <i class="fa fa-plus"></i>
                    </span> New user registered. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">3 mins</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-danger">
                      <i class="fa fa-bolt"></i>
                    </span> Server #12 overloaded. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">10 mins</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-warning">
                      <i class="fa fa-bell-o"></i>
                    </span> Server #2 not responding. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">14 hrs</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-info">
                      <i class="fa fa-bullhorn"></i>
                    </span> Application error. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">2 days</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-danger">
                      <i class="fa fa-bolt"></i>
                    </span> Database overloaded 68%. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">3 days</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-danger">
                      <i class="fa fa-bolt"></i>
                    </span> A user IP blocked. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">4 days</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-warning">
                      <i class="fa fa-bell-o"></i>
                    </span> Storage Server #4 not responding dfdfdfd. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">5 days</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-info">
                      <i class="fa fa-bullhorn"></i>
                    </span> System Error. </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="time">9 days</span>
                  <span class="details">
                    <span class="label label-sm label-icon label-danger">
                      <i class="fa fa-bolt"></i>
                    </span> Storage server failed. </span>
                </a>
              </li>
            </ul>
          </li>
        </ul>
      </li>
      <!-- END NOTIFICATION DROPDOWN -->
      <!-- BEGIN INBOX DROPDOWN -->
      <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
      <li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
          <i class="icon-envelope-open"></i>
          <span class="badge badge-default"> 4 </span>
        </a>
        <ul class="dropdown-menu">
          <li class="external">
            <h3>You have
              <span class="bold">7 New</span> Messages</h3>
            <a href="app_inbox.html">view all</a>
          </li>
          <li>
            <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
              <li>
                <a href="#">
                  <span class="photo">
                    <img src="../assets/layouts/layout3/img/avatar2.jpg" class="img-circle" alt=""> </span>
                  <span class="subject">
                    <span class="from"> Lisa Wong </span>
                    <span class="time">Just Now </span>
                  </span>
                  <span class="message"> Vivamus sed auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                </a>
              </li>
              <li>
                <a href="#">
                  <span class="photo">
                    <img src="../assets/layouts/layout3/img/avatar3.jpg" class="img-circle" alt=""> </span>
                  <span class="subject">
                    <span class="from"> Richard Doe </span>
                    <span class="time">16 mins </span>
                  </span>
                  <span class="message"> Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                </a>
              </li>
              <li>
                <a href="#">
                  <span class="photo">
                    <img src="../assets/layouts/layout3/img/avatar1.jpg" class="img-circle" alt=""> </span>
                  <span class="subject">
                    <span class="from"> Bob Nilson </span>
                    <span class="time">2 hrs </span>
                  </span>
                  <span class="message"> Vivamus sed nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                </a>
              </li>
              <li>
                <a href="#">
                  <span class="photo">
                    <img src="../assets/layouts/layout3/img/avatar2.jpg" class="img-circle" alt=""> </span>
                  <span class="subject">
                    <span class="from"> Lisa Wong </span>
                    <span class="time">40 mins </span>
                  </span>
                  <span class="message"> Vivamus sed auctor 40% nibh congue nibh... </span>
                </a>
              </li>
              <li>
                <a href="#">
                  <span class="photo">
                    <img src="../assets/layouts/layout3/img/avatar3.jpg" class="img-circle" alt=""> </span>
                  <span class="subject">
                    <span class="from"> Richard Doe </span>
                    <span class="time">46 mins </span>
                  </span>
                  <span class="message"> Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
                </a>
              </li>
            </ul>
          </li>
        </ul>
      </li>
      <!-- END INBOX DROPDOWN -->
      <!-- BEGIN TODO DROPDOWN -->
      <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
      <li class="dropdown dropdown-extended dropdown-tasks" id="header_task_bar">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
          <i class="icon-calendar"></i>
          <span class="badge badge-default"> 3 </span>
        </a>
        <ul class="dropdown-menu extended tasks">
          <li class="external">
            <h3>You have
              <span class="bold">12 pending</span> tasks</h3>
            <a href="app_todo.html">view all</a>
          </li>
          <li>
            <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
              <li>
                <a href="javascript:;">
                  <span class="task">
                    <span class="desc">New release v1.2 </span>
                    <span class="percent">30%</span>
                  </span>
                  <span class="progress">
                    <span style="width: 40%;" class="progress-bar progress-bar-success" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">40% Complete</span>
                    </span>
                  </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="task">
                    <span class="desc">Application deployment</span>
                    <span class="percent">65%</span>
                  </span>
                  <span class="progress">
                    <span style="width: 65%;" class="progress-bar progress-bar-danger" aria-valuenow="65" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">65% Complete</span>
                    </span>
                  </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="task">
                    <span class="desc">Mobile app release</span>
                    <span class="percent">98%</span>
                  </span>
                  <span class="progress">
                    <span style="width: 98%;" class="progress-bar progress-bar-success" aria-valuenow="98" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">98% Complete</span>
                    </span>
                  </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="task">
                    <span class="desc">Database migration</span>
                    <span class="percent">10%</span>
                  </span>
                  <span class="progress">
                    <span style="width: 10%;" class="progress-bar progress-bar-warning" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">10% Complete</span>
                    </span>
                  </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="task">
                    <span class="desc">Web server upgrade</span>
                    <span class="percent">58%</span>
                  </span>
                  <span class="progress">
                    <span style="width: 58%;" class="progress-bar progress-bar-info" aria-valuenow="58" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">58% Complete</span>
                    </span>
                  </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="task">
                    <span class="desc">Mobile development</span>
                    <span class="percent">85%</span>
                  </span>
                  <span class="progress">
                    <span style="width: 85%;" class="progress-bar progress-bar-success" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">85% Complete</span>
                    </span>
                  </span>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <span class="task">
                    <span class="desc">New UI release</span>
                    <span class="percent">38%</span>
                  </span>
                  <span class="progress progress-striped">
                    <span style="width: 38%;" class="progress-bar progress-bar-important" aria-valuenow="18" aria-valuemin="0" aria-valuemax="100">
                      <span class="sr-only">38% Complete</span>
                    </span>
                  </span>
                </a>
              </li>
            </ul>
          </li>
        </ul>
      </li>
      <!-- END TODO DROPDOWN -->
      <!-- BEGIN USER LOGIN DROPDOWN -->
      <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
      <li class="dropdown dropdown-user">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
          <img alt="" class="img-circle" src="../assets/layouts/layout/img/avatar3_small.jpg" />
          <span class="username username-hide-on-mobile"> Nick </span>
          <i class="fa fa-angle-down"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-default">
          <li>
            <a href="page_user_profile_1.html">
              <i class="icon-user"></i> My Profile </a>
          </li>
          <li>
            <a href="app_calendar.html">
              <i class="icon-calendar"></i> My Calendar </a>
          </li>
          <li>
            <a href="app_inbox.html">
              <i class="icon-envelope-open"></i> My Inbox
              <span class="badge badge-danger"> 3 </span>
            </a>
          </li>
          <li>
            <a href="app_todo.html">
              <i class="icon-rocket"></i> My Tasks
              <span class="badge badge-success"> 7 </span>
            </a>
          </li>
          <li class="divider"> </li>
          <li>
            <a href="page_user_lock_1.html">
              <i class="icon-lock"></i> Lock Screen </a>
          </li>
          <li>
            <a href="page_user_login_1.html">
              <i class="icon-key"></i> Log Out </a>
          </li>
        </ul>
      </li>
      <!-- END USER LOGIN DROPDOWN -->
      <!-- BEGIN QUICK SIDEBAR TOGGLER -->
      <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
      <li class="dropdown dropdown-quick-sidebar-toggler">
        <a href="javascript:;" class="dropdown-toggle">
          <i class="icon-logout"></i>
        </a>
      </li>
      <!-- END QUICK SIDEBAR TOGGLER -->
    </ul>
  </div>
  <!-- END TOP NAVIGATION MENU -->
</div>
<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"> </div>
<!-- END HEADER & CONTENT DIVIDER -->
--%>

<!-- LOAD JAVASCRIPT TODO -->
<!--[if lt IE 9]>
    <script src="../js/respond.min.js"></script>
    <script src="../js/excanvas.min.js"></script>
    <![endif]-->

<!-- BEGIN CORE PLUGINS -->
<g:javascript src="bootstrap.min.js"/>
<g:javascript src="js.cookie.min.js"/>
<g:javascript src="bootstrap-hover-dropdown.min.js"/>
<g:javascript src="jquery.slimscroll.min.js"/>
<g:javascript src="jquery.blockui.min.js"/>
<g:javascript src="jquery.uniform.min.js"/>
<g:javascript src="bootstrap-switch.min.js"/>
<!-- END CORE PLUGINS -->

<!-- BEGIN THEME GLOBAL SCRIPTS -->
<g:javascript src="app.js"/>
<!-- END THEME GLOBAL SCRIPTS -->

<!-- BEGIN PAGE LEVEL SCRIPTS -->
<g:javascript src="dashboard.min.js"/>
<!-- END PAGE LEVEL SCRIPTS -->

<!-- BEGIN THEME LAYOUT SCRIPTS -->
<g:javascript src="layout.js"/>
<g:javascript src="demo.js"/>
<g:javascript src="quick-sidebar.js"/>
<!-- END THEME LAYOUT SCRIPTS -->
</body>
</html>
