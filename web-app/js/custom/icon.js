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
        var liExchangeAdmin = $('.li-exchange-admin');
        var iconExchangeAdmin = $('.iconExchange-admin');
        var liLogoutAdmin = $('.li-logout-admin');
        var iconLogoutAdmin = $('.iconLogout-admin');
        // Normal user
        var liIdUser = $('.li-iconId-user');
        var iconIdUser = $('.iconId-user');
        var liExchangeUser = $('.li-exchange-user');
        var iconExchangeUser = $('.iconExchange-user');
        var liLogoutUser = $('.li-logout-user');
        var iconLogoutUser = $('.iconLogout-user');

        // Layout administrator
        // My profile
        liIdAdmin.mouseover(function () {
            iconIdAdmin.addClass('overIcon')
        });
        liIdAdmin.mouseout(function () {
            iconIdAdmin.removeClass('overIcon')
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
