<!-------------------------------------------------------------------------------------------*
 *                                   EMAIL RESTORE PASSWORD                                  *
 *------------------------------------------------------------------------------------------->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
</head>
<body>
    <h3> <g:message code="resetPassword.email.body.title" default="Notification of password reset in SMART TESTING TOOL"/> </h3>
    <p> <g:message code="resetPassword.email.body.messageOne" default="You recently requested to reset the password for your user account. To do this, click on the following link:"/>
        <a href="${ createLink(uri: '/newPassword', params: [token:token], base:"http://localhost:8080/HPCDS_SmartTestingTool") }">
        <g:message code="resetPassword.email.body.messageTwo" default="Reset password"/></a>.
    </p>
</body>
</html>
