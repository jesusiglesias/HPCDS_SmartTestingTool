<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.faq" default="STT | FAQs"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/normalUser', file: 'contactFAQ.css')}" type="text/css"/>
</head>
<body>

    <!-- Page-bar -->
    <div class="page-bar-user">
        <ul class="page-breadcrumb">
            <li>
                <i class="icofont icofont-ui-home"></i>
                <g:link uri="/"><g:message code="layouts.main_auth_admin.pageBreadcrumb.title" default="Homepage"/></g:link>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span><g:message code="layouts.main_auth_user.body.title.faq" default="Frequently Asked Questions"/></span>
            </li>
        </ul>
    </div> <!-- /.Page-bar -->

    <!-- Page-title -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-12 col-userLayoutTitle">
            <!-- Page-title -->
            <div class="page-title-user-faq">
                <h3 class="page-title-user-faq-title">
                    <g:message code="layouts.main_auth_user.body.title.faq" default="Frequently Asked Questions"/>
                </h3>
                <p class="page-title-user-faq-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.faq.description", default:"Welcome to the help section of <strong>SMART TESTING TOOL</strong>. " +
                            "Here you can find answers to general doubts and questions that may occur during your user experience."))}
                </p>
            </div>
        </div>
    </div>

    <!-- Frequently questions -->
    <div class="row row-userLayoutTitle">
        <div class="col-md-6 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionOne" default="What is smart testing tool?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionOne.description" encodeAs="raw"/>
                </p>
            </div>
        </div>
        <div class="col-md-6 col-userLayoutTitle-faq colLine-rowLeft">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionTwo" default="I do not remember my password, what can I do?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionTwo.description" encodeAs="raw" args="[link(uri: '/forgotPassword') { message(code:'layouts.main_auth_user.body.title.faq.questionTwo.description.link', default: 'Restore password')}]"/>
                </p>
            </div>
        </div>
    </div>

    <div class="row row-userLayoutTitle">
        <div class="col-md-6 col-userLayoutTitle-faq colLine-rowRigth">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionThree" default="How can I modify my profile data?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionThree.description" encodeAs="raw" args="[link(uri: '/contact') { message(code:'layouts.main_auth_user.body.title.faq.question.link.contactForm', default: 'Contact form')}]"/>
                </p>
            </div>
        </div>
        <div class="col-md-6 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionFour" default="I want to delete my user account, how do I do?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionFour.description" encodeAs="raw" args="[link(uri: '/contact') { message(code:'layouts.main_auth_user.body.title.faq.question.link.contactForm', default: 'Contact form')}]"/>
                </p>
            </div>
        </div>
    </div>

    <div class="row row-userLayoutTitle">
        <div class="col-md-6 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionFive" default="My account or password is locked or expired."/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionFive.description" encodeAs="raw"/>
                </p>
            </div>
        </div>
        <div class="col-md-6 col-userLayoutTitle-faq colLine-rowLeft">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionSix" default="What are the topics and how to perform a test?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionSix.description" encodeAs="raw"/>
                </p>
            </div>
        </div>
    </div>

    <div class="row row-userLayoutTitle">
        <div class="col-md-6 col-userLayoutTitle-faq colLine-rowRigth">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionSeven" default="Where can I check my evaluations?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionSeven.description" encodeAs="raw"/>
                </p>
            </div>
        </div>
        <div class="col-md-6 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title hvr-bubble-float-bottom">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionEight" default="How do I close the current session?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    <g:message code="layouts.main_auth_user.body.title.faq.questionEight.description" encodeAs="raw"/>
                </p>
            </div>
        </div>
    </div>

    <!-- Contact section -->
    <div class="contentPage-form">
        <div class="row">
            <div class="col-md-12 contactPageContact">
                <div class="containerFaqPage">
                    <div class="title inverse">
                        <h3 class="uppercase"><g:message code="layouts.main_auth_user.body.title.faq.contact.title" default="Can not you find the answer your doubt?"/></h3>
                        <div class="line-left"></div>
                        <p><g:message code="layouts.main_auth_user.body.title.faq.contact.description" default="Contact us through the form and we will contact you as soon as possible."/></p>
                        <g:link uri="/contact" class="btn customContact"><g:message code="layouts.main_auth_user.body.title.faq.contact.button" default="Contact"/></g:link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>