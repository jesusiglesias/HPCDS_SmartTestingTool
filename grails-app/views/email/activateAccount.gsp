<!-------------------------------------------------------------------------------------------*
 *                                     ACTIVATE ACCOUNT EMAIL                                *
 *------------------------------------------------------------------------------------------->

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- WEB FONT -->
    <!-- Desktop Outlook chokes on web font references and defaults to Times New Roman, so we force a safe fallback font -->
    <!--[if mso]>
            <style>
                * {
                    font-family: sans-serif !important;
                }
            </style>
        <![endif]-->

    <!--[if !mso]><!-->
    <link href='https://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet' type='text/css'>
    <!--<![endif]-->


    <!-- CSS Reset -->
    <style type="text/css">

    /* Remove spaces around the email design added by some email clients */
    html,
    body {
        Margin: 0 !important;
        padding: 0 !important;
        height: 100% !important;
        width: 100% !important;
        background-color: #555555;
    }

    /* Stops email clients resizing small text */
    * {
        -ms-text-size-adjust: 100%;
        -webkit-text-size-adjust: 100%;
    }

    /* Centers email on Android */
    div[style*="margin: 16px 0"] {
        margin:0 !important;
    }

    /* Stops Outlook from adding extra spacing to tables */
    table,
    td {
        mso-table-lspace: 0pt !important;
        mso-table-rspace: 0pt !important;
    }

    /* Fixes webkit padding issue. Fix for Yahoo mail table alignment bug. Applies table-layout to the first 2 tables then removes for anything nested deeper */
    table {
        border-spacing: 0 !important;
        border-collapse: collapse !important;
        table-layout: fixed !important;
        Margin: 0 auto !important;
    }

    table table table {
        table-layout: auto;
    }

    /* Uses a better rendering method when resizing images in IE */
    img {
        -ms-interpolation-mode:bicubic;
    }

    /* Overrides styles added when Yahoo's auto-senses a link */
    .yshortcuts a {
        border-bottom: none !important;
    }

    /* A work-around for iOS meddling in triggered links */
    .mobile-link--footer a,
    a[x-apple-data-detectors] {
        color:inherit !important;
        text-decoration: underline !important;
    }

    </style>

    <!-- Progressive Enhancements -->
    <style>

    /* Hover styles for buttons */
    .button-td,
    .button-a {
        transition: all 100ms ease-in;
    }
    .button-td:hover,
    .button-a:hover {
        background: #388578 !important;
        border-color: #388578 !important;
    }

    /* Media Queries */
    @media screen and (max-width: 480px) {

        /* Forces elements to resize to the full width of their container. Useful for resizing images beyond their max-width */
        .fluid,
        .fluid-centered {
            width: 100% !important;
            max-width: 100% !important;
            height: auto !important;
            Margin-left: auto !important;
            Margin-right: auto !important;
        }

        /* And center justify these ones */
        .fluid-centered {
            Margin-left: auto !important;
            Margin-right: auto !important;
        }

        /* Forces table cells into full-width rows */
        .stack-column,
        .stack-column-center {
            display: block !important;
            width: 100% !important;
            max-width: 100% !important;
            direction: ltr !important;
        }
        /* And center justify these ones */
        .stack-column-center {
            text-align: center !important;
        }

        /* Generic utility class for centering. Useful for images, buttons, and nested tables */
        .center-on-narrow {
            text-align: center !important;
            display: block !important;
            Margin-left: auto !important;
            Margin-right: auto !important;
            float: none !important;
        }
        table.center-on-narrow {
            display: inline-block !important;
        }
    }
    </style>
</head>

<body width="100%" bgcolor="#555555" style="Margin: 0;">
<table cellpadding="0" cellspacing="0" border="0" height="100%" width="100%" bgcolor="#F6F6F6" style="border-collapse:collapse;"><tr><td valign="top">
    <center style="width: 100%;">

        <div style="max-width: 680px; padding-top: 50px">
            <!--[if (gte mso 9)|(IE)]>
                <table cellspacing="0" cellpadding="0" border="0" width="680" align="center">
                <tr>
                <td>
                <![endif]-->

            <!-- Email body -->
            <table cellspacing="0" cellpadding="0" border="0" align="center" bgcolor="#ffffff" width="100%" style="max-width: 680px;">

                <!-- Title -->
                <tr>
                    <td>
                        <h1 width="680" height="" border="0" text-align="center" style="width: 100%; margin-top: 50px; text-align: center; color: #4DB3A2; font-family: roboto, sans-serif"> SMART TESTING TOOL </h1>
                    </td>
                </tr>

                <!-- Message -->
                <tr>
                    <td>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td style="padding: 30px; text-align: center; font-family: roboto, sans-serif; font-size: 15px; mso-height-rule: exactly; line-height: 20px; color: #555555;">
                                    <h3> <g:message code="activateAccount.email.body.title" default="Welcome to the online evaluation system!"/> </h3>
                                    <p> <g:message code="activateAccount.email.body.messageOne" default="You recently created a new user account. To finish the registration, you must confirm your user account."/> </p>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <!-- Button -->
                <tr>
                    <td bgcolor="#555555" valign="middle" style="text-align: center; background-position: center center !important; background-size: cover !important;">
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td style="padding: 30px; text-align: center; font-size: 15px; mso-height-rule: exactly; line-height: 20px; color: #555555;">
                                    <table cellspacing="0" cellpadding="0" border="0" align="center" style="Margin: auto">
                                        <tr>
                                            <td style="border-radius: 3px; background: #4DB3A2; text-align: center;" class="button-td">
                                                <a href="${createLink(uri: '/enabledAccount', params: [token:token], absolute: true)}" style="background: #4DB3A2; border: 15px solid #4DB3A2; padding: 0 10px;color: #ffffff; font-family: roboto, sans-serif; font-size: 13px; line-height: 1.1; text-align: center; text-decoration: none; display: block; border-radius: 3px; font-weight: bold;" class="button-a">
                                                    <g:message code="activateAccount.email.body.messageTwo" default="CONFIRM ACCOUNT"/>
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table> <!-- /. Email body -->

            <!-- Email Footer -->
            <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" style="max-width: 680px;">
                <tr>
                    <td style="padding: 40px 10px;width: 100%;font-size: 14px; font-family: sans-serif; mso-height-rule: exactly; line-height:18px; text-align: center; color: #888888;">
                        <p style="color:#555555 !important; text-decoration:underline; font-weight: bold;">2016 © <g:link style="text-decoration: none; color:#555555 !important;" uri="http://es.linkedin.com/in/jesusgiglesias"> Jesús Iglesias García</g:link></p>
                        <br>
                        <g:link uri="https://www.hpcds.com/">
                            <img src="http://i.imgur.com/ANpojrH.png" width="100" height="100"/>
                        </g:link>
                    </td>
                </tr>
            </table> <!-- /. Email Footer -->

            <!--[if (gte mso 9)|(IE)]>
                </td>
                </tr>
                </table>
            <![endif]-->
        </div>
    </center>
</td></tr></table>
</body>
</html>