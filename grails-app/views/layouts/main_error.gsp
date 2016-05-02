<!-------------------------------------------------------------------------------------------*
 *                                       ERROR PAGES                                         *
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
    <meta name="dcterms.rightsHolder" content="Jesús Iglesias García">
    <meta name="dcterms.dateCopyrighted" content="2016">

    <!-- Disallow robots -->
    <meta name="robots" content="noindex, nofollow">

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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'custom.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/error', file: 'error.css')}" type="text/css"/>

    <!-- THEME GLOBAL STYLES -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'components-md.css')}" type="text/css" id="style_components"/>

    <!-- LOAD JS -->
    <asset:javascript src="application.js"/>

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
<body class="error-page">

    <!-- Logo -->
    <div class="logo-error">
        <g:link uri="/">
            <asset:image src="logo/logo_error_pages.png" alt="SMART TESTING TOOL"/>
        </g:link>
    </div>

    <!-- LOAD BODY OTHER VIEWS -->
    <g:layoutBody/>

    <!-- Back button -->
    <div class="content-error">
        <g:link uri="/" class="btn green-dark btn-block">
            <i class="fa fa-chevron-circle-left fa-lg icon-back"></i>
            <g:message code="layouts.error_pages.back" default="Go back to homepage"/>
        </g:link>
    </div>


    <div class="copyright"> 2016 © <g:link uri="http://es.linkedin.com/in/jesusgiglesias"> Jesús Iglesias García </g:link></div>
    <div class="logoHP-error-page">
        <g:link uri="https://www.hpcds.com/">
            <asset:image src="logo/logo_hp.png" alt="HP CDS"/>
        </g:link>
    </div>

    <!-- Back to top -->
    <g:link href="#" class="back-to-top back-to-top-error"><g:message code="views.general.backtotop" default="Top"/></g:link>

    <!-- LOAD JAVASCRIPT -->
    <!-- Enable responsive CSS code on browsers that don't support it -->
    <!--[if lt IE 9]>
        <script src="../js/respond.min.js"></script>
    <![endif]-->

    <!-- CORE PLUGINS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <g:javascript src="custom/custom.js"/>

</body>
</html>