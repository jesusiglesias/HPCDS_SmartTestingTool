/*-------------------------------------------------------------------------------------------*
 *                            CUSTOM JAVASCRIPT - ICON IN DROPDOWN                           *
 *-------------------------------------------------------------------------------------------*/

var IconScript = function () {

    /**
     * It handles the icon colour
     */
    var handlerIconColour = function() {

        // Administrator
        var liIdAdmin = $('.li-iconId-admin');
        var iconIdAdmin = $('.iconId-admin');
        var liCookieAdmin = $('.li-iconCookie-admin');
        var iconCookieAdmin = $('.iconCookie-admin');
        var liExchangeAdmin = $('.li-exchange-admin');
        var iconExchangeAdmin = $('.iconExchange-admin');
        var liLogoutAdmin = $('.li-logout-admin');
        var iconLogoutAdmin = $('.iconLogout-admin');
        // Normal user
        var liIdUser = $('.li-iconId-user');
        var iconIdUser = $('.iconId-user');
        var liEvaluationsUser = $('.li-iconEvaluations-user');
        var iconEvaluationsUser = $('.iconEvaluations-user');
        var liExchangeUser = $('.li-evaluations-user');
        var iconExchangeUser = $('.iconEvaluations-user');
        var liLogoutUser = $('.li-logout-user');
        var iconLogoutUser = $('.iconLogout-user');
        // Error pages
        var iconBackButton = $('.content-error');
        var iconBack = $('.icon-back');
        // Admin and user pages
        var iconButtonContainer = $('.icon-button-container');
        var iconButton = $('.icon-button');
        var iconDeleteButtonContainer = $('.iconDelete-button-container');
        var iconDeleteButton = $('.iconDelete-button');
        // Breadcrumb admin pages
        var iconBarAdminContainer = $('.iconBar-admin-container');
        var iconBarAdmin = $('.iconBar-admin');

        // Layout administrator
        // My profile
        liIdAdmin.mouseover(function () {
            iconIdAdmin.addClass('overIcon')
        });
        liIdAdmin.mouseout(function () {
            iconIdAdmin.removeClass('overIcon')
        });
        // Cookies policy
        liCookieAdmin.mouseover(function () {
            iconCookieAdmin.addClass('overIcon')
        });
        liCookieAdmin.mouseout(function () {
            iconCookieAdmin.removeClass('overIcon')
        });
        // Switch user
        liExchangeAdmin.mouseover(function () {
            iconExchangeAdmin.addClass('overIcon')
        });
        liExchangeAdmin.mouseout(function () {
            iconExchangeAdmin.removeClass('overIcon')
        });
        // Log out
        liLogoutAdmin.mouseover(function () {
            iconLogoutAdmin.addClass('overIcon')
        });
        liLogoutAdmin.mouseout(function () {
            iconLogoutAdmin.removeClass('overIcon')
        });

        // Layout normal user
        // My profile
        liIdUser.mouseover(function () {
            iconIdUser.addClass('overIcon')
        });
        liIdUser.mouseout(function () {
            iconIdUser.removeClass('overIcon')
        });
        // Evaluations
        liEvaluationsUser.mouseover(function () {
            iconEvaluationsUser.addClass('overIcon')
        });
        liEvaluationsUser.mouseout(function () {
            iconEvaluationsUser.removeClass('overIcon')
        });
        // Switch user
        liExchangeUser.mouseover(function () {
            iconExchangeUser.addClass('overIcon')
        });
        liExchangeUser.mouseout(function () {
            iconExchangeUser.removeClass('overIcon')
        });
        // Log out
        liLogoutUser.mouseover(function () {
            iconLogoutUser.addClass('overIcon')
        });
        liLogoutUser.mouseout(function () {
            iconLogoutUser.removeClass('overIcon')
        });
        // Error pages
        iconBackButton.mouseover(function () {
            iconBack.addClass('icon-back-mouseOver')
        });
        iconBackButton.mouseout(function () {
            iconBack.removeClass('icon-back-mouseOver')
        });
        // Admin and user pages
        iconButtonContainer.mouseover(function () {
            iconButton.addClass('icon-button-mouseOver')
        });
        iconButtonContainer.mouseout(function () {
            iconButton.removeClass('icon-button-mouseOver')
        });
        iconDeleteButtonContainer.mouseover(function () {
            iconDeleteButton.addClass('iconDelete-button-mouseOver')
        });
        iconDeleteButtonContainer.mouseout(function () {
            iconDeleteButton.removeClass('iconDelete-button-mouseOver')
        });
        // Breadcrumb admin pages
        iconBarAdminContainer.mouseover(function () {
            iconBarAdmin.addClass('home-icon-hover')
        });
        iconBarAdminContainer.mouseout(function () {
            iconBarAdmin.removeClass('home-icon-hover')
        });
    };
    
    return {
        // Main function to initiate the module
        init: function () {
            handlerIconColour();
        }
    };
}();

jQuery(document).ready(function() {
    IconScript.init();
});
