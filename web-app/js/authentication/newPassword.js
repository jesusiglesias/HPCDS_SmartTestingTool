/*-------------------------------------------------------------------------------------------*
 *                                    NEW PASSWORD JAVASCRIPT                                *
 *-------------------------------------------------------------------------------------------*/

var Login = function() {

    /**
     * New password form.
     */
    var handleNewPassword = function () {

        // Reset password button activates when user enter the data
        var forgetForm = $(".forget-form");
        var newPasswordButton = $("#newPassword-button");
        var passwordField = $("#password");
        var passwordConfirmField = $("#passwordConfirm");

        newPasswordButton.attr('disabled', 'disabled');

        forgetForm.keyup(function () {
            // Disable new password button
            newPasswordButton.attr('disabled', 'disabled');

            // Validating fields
            var password = passwordField.val().trim();
            var passwordConfirm = passwordConfirmField.val().trim();

            // Validating whitespaces
            var passwordWhitespace = /\s/g.test(password);
            var passwordConfirmWhitespace = /\s/g.test(passwordConfirm);

            if (!(password == "" || passwordConfirm == "" || passwordWhitespace || passwordConfirmWhitespace)) {
                // Enable new password Button
                newPasswordButton.removeAttr('disabled');
            }
        });
    };

    return {
        // Main function to initiate the module
        init: function() {
            handleNewPassword();
        }
    };
}();

// Init login functions when page is loaded
jQuery(document).ready(function() {
    Login.init();
});