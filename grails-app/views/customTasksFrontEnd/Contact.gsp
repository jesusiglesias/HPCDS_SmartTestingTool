<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main_auth_user">
    <title><g:message code="layouts.main_auth_user.head.title.contact" default="STT | Contact"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css/contact', file: 'contact.css')}" type="text/css"/>
    <link rel="stylesheet" href="${resource(dir: 'css/iconfont', file: 'icofont.css')}" type="text/css"/>

    <script>
        // Variables to use in script
        var _address = '${g.message(code:'layouts.main_auth_user.body.map.address', default:'José Echegaray street,')}';
        var _country = '${g.message(code:'layouts.main_auth_user.body.map.country', default:'Spain')}';
        var _webSite = '${g.message(code:'layouts.main_auth_user.body.map.icon.web', default:'Web site')}';
    </script>
</head>
<body>

<!-- BEGIN PAGE TITLE-->
<h3 class="page-title-user">
    <g:message code="layouts.main_auth_user.body.title.contactUs" default="Contact us"/>
</h3>

<!-- END PAGE HEADER-->
<div class="c-content-contact-1 c-opt-1">
    <div class="row" data-auto-height=".c-height">
        <div class="col-lg-8 col-md-6 c-desktop"></div>
        <div class="col-lg-4 col-md-6">
            <div class="c-body">
                <div class="c-section">
                    <h3>Hewlett Packard CDS</h3>
                </div>
                <div class="c-section">
                    <div class="c-content-label uppercase"><g:message code="layouts.main_auth_user.body.map.title.address" default="Address"/></div>
                    <p><g:message code="layouts.main_auth_user.body.map.address" default="José Echegaray street,"/><br/>Las Rozas 28232 Madrid,<br/><g:message code="layouts.main_auth_user.body.map.country" default="Spain"/></p>
                </div>
                <div class="c-section">
                    <div class="c-content-label uppercase"><g:message code="layouts.main_auth_user.body.map.title.contact" default="Contact"/></div>
                    <p> +34 91 631 16 84 </p>
                </div>
                <div class="c-section">
                    <div class="c-content-label uppercase"><g:message code="layouts.main_auth_user.body.map.title.social" default="Social"/></div>
                    <br/>
                    <ul class="c-content-iconlist-1">
                        <li class="li-site">
                            <a href="https://www.hpcds.com/">
                                <i class="icofont icofont-web"></i>
                            </a>
                        </li>
                        <li class="li-google">
                            <a href="https://plus.google.com/103304739299282206903">
                                <i class="fa fa-google"></i>
                            </a>
                        </li>
                        <li class="li-youtube">
                            <a href="https://www.youtube.com/user/HPCDSNL">
                                <i class="fa fa-youtube-play"></i>
                            </a>
                        </li>
                        <li class="li-linkedin">
                            <a href="https://www.linkedin.com/company/hp-cds">
                                <i class="fa fa-linkedin"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div id="gmapbg" class="c-content-contact-1-gmap" style="height: 615px;"></div>
</div>
<div class="c-content-feedback-1 c-option-1">
    <div class="row">
        <div class="col-md-6">
            <div class="c-container bg-green">
                <div class="c-content-title-1 c-inverse">
                    <h3 class="uppercase">Need to know more?</h3>
                    <div class="c-line-left"></div>
                    <p class="c-font-lowercase">Try visiting our FAQ page to learn more about our greatest ever expanding theme, Metronic.</p>
                    <button class="btn grey-cararra font-dark">Learn More</button>
                </div>
            </div>
            <div class="c-container bg-grey-steel">
                <div class="c-content-title-1">
                    <h3 class="uppercase">Have a question?</h3>
                    <div class="c-line-left bg-dark"></div>
                    <form action="#">
                        <div class="input-group input-group-lg c-square">
                            <input type="text" class="form-control c-square" placeholder="Ask a question" />
                            <span class="input-group-btn">
                                <button class="btn uppercase" type="button">Go!</button>
                            </span>
                        </div>
                    </form>
                    <p>Ask your questions away and let our dedicated customer service help you look through our FAQs to get your questions answered!</p>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="c-contact">
                <div class="c-content-title-1">
                    <h3 class="uppercase">Keep in touch</h3>
                    <div class="c-line-left bg-dark"></div>
                    <p class="c-font-lowercase">Our helpline is always open to receive any inquiry or feedback. Please feel free to drop us an email from the form below and we will get back to you as soon as we can.</p>
                </div>
                <form action="#">
                    <div class="form-group">
                        <input type="text" placeholder="Your Name" class="form-control input-md"> </div>
                    <div class="form-group">
                        <input type="text" placeholder="Your Email" class="form-control input-md"> </div>
                    <div class="form-group">
                        <input type="text" placeholder="Contact Phone" class="form-control input-md"> </div>
                    <div class="form-group">
                        <textarea rows="8" name="message" placeholder="Write comment here ..." class="form-control input-md"></textarea>
                    </div>
                    <button type="submit" class="btn grey">Submit</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- END CONTENT BODY -->

    <!-- LOAD JAVASCRIPT -->
    <script src="http://maps.google.com/maps/api/js?key=AIzaSyAVkszaEghO-lK3QH156C0w9ANDG2BeHc0" type="text/javascript"></script>
    <g:javascript src="contact/gmaps.min.js"/>
    <g:javascript src="contact/contact.js"/>

</body>
</html>