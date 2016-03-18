<!-------------------------------------------------------------------------------------------*
 *                                    LOGIN TASKS PAGES                                      *
 *------------------------------------------------------------------------------------------->

<!DOCTYPE html>
  <!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
  <!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
  <!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
  <!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
  <!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<!-- HEAD -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="description" content="Smart Testing Tool is a HP CDS solution for online evaluation of different subjects through testing that
    it intended as a tool for internal qualification of personnel."/>
    <meta name="author" content="Jesús Iglesias García"/>
    <meta name="keywords" content="HP CDS, Smart Testing Tool, online test, evaluation test, english testing tool, test online, evaluacion online, Jesus Iglesias, TFG, Universidad de Valladolid, UVa"/>

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
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'uniform.default.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'custom.css')}" type="text/css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/sweetalert2/0.4.3/sweetalert2.css">

    <!-- PAGE LEVEL PLUGINS -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.min.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2-bootstrap.min.css')}" type="text/css"/>

    <!-- THEME GLOBAL STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'components-md.css')}" type="text/css" id="style_components"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'plugins-md.css')}" type="text/css"/>

    <!-- PAGE LEVEL STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css/authentication', file: 'authentication.css')}" type="text/css"/>

    <!-- LOAD JS -->
    <asset:javascript src="application.js"/>
    <!-- Notification -->
    <script src="https://cdn.jsdelivr.net/sweetalert2/0.4.3/sweetalert2.min.js" crossorigin="anonymous"></script>

    <!-- HTML5 SHIV, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
		<script src="/js/html5shiv.min.js" type="text/javascript"></script>
    <![endif]-->

    <!-- LOAD HEADER OTHER VIEWS -->
    <g:layoutHead/>

</head> <!-- /.HEAD -->

<!-- BODY -->
<body class="login">

    <!-- Logo -->
    <div class="logo">
        <g:link uri="/">
            <asset:image src="logo/logo_auth.png" alt="SMART TESTING TOOL"/>
        </g:link>
    </div>

    <!-- LOAD BODY OTHER VIEWS -->
    <g:layoutBody/>

    <!-- Back to top -->
    <g:link href="#" class="back-to-top"><g:message code="views.general.backtotop" default="Top"/></g:link>

    <!-- LOAD JAVASCRIPT -->
    <!-- Enable responsive CSS code on browsers that don't support it -->
    <!--[if lt IE 9]>
        <script src="../js/respond.min.js"></script>
    <![endif]-->

    <!-- CORE PLUGINS -->
    <!-- TODO -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <g:javascript src="js.cookie.min.js"/>
    <g:javascript src="bootstrap-hover-dropdown.min.js"/>
    <g:javascript src="jquery.slimscroll.min.js"/>
    <g:javascript src="jquery.blockui.min.js"/>
    <g:javascript src="jquery.uniform.min.js"/>
    <g:javascript src="custom.js"/>

    <!-- TODO THEME GLOBAL SCRIPT -->
    <g:javascript src="app.js"/>

    <!-- PAGE LEVEL SCRIPTS -->
    <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/jquery.validate.min.js"></script>
    <script src="http://cdn.jsdelivr.net/jquery.validation/1.15.0/additional-methods.min.js"></script>
    <g:javascript src="authentication/select2.full.min.js"/>

</body>
</html>