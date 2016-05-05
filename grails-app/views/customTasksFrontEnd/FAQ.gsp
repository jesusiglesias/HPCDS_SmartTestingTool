<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.faq" default="STT | FAQs"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/iconfont', file: 'icofont.css')}" type="text/css"/>
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
        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="¿Qué es smart testing tool?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
                </p>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="No recuerdo mis datos de acceso: usuario o contraseña. ¿Qué puedo hacer?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
                </p>
            </div>
        </div>

        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="¿Cómo cambio los datos de mi perfil Usuario"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
                </p>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="Deseo eliminar mi cuenta, ¿cómo lo hago?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
                </p>
            </div>
        </div>

        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="He olvidado mi contraseña. ¿Qué debo hacer?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
                </p>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="¿Cómo cambio mis datos de acceso (email y/o contraseña)?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
                </p>
            </div>
        </div>

        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="¿Qué es smart testing tool?"/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
                </p>
            </div>
        </div>
        <div class="col-md-6 col-lg-4 col-userLayoutTitle-faq">
            <!-- Page-title -->
            <div class="page-title-user-faq-section">
                <h3 class="page-title-user-faq-section-title">
                    <g:message code="la" default="¿Qué es ..."/>
                </h3>
                <p class="page-title-user-faq-section-description">
                    ${raw(g.message(code:"layouts.main_auth_user.body.title.cookie.section.one.description", default:""))}
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