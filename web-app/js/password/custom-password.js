/*-------------------------------------------------------------------------------------------*
 *                            CUSTOM JAVASCRIPT - STRENGTH PASSWORD                          *
 *-------------------------------------------------------------------------------------------*/

var CustomPassword = function () {

    /**
     * Handler password strength
     */
    var handlePasswordStrengthChecker = function() {

        var initialized = false;
        var inputPassword = $("#password");

        inputPassword.keydown(function () {
            if (initialized === false) {

                // Set base options
                inputPassword.pwstrength({
                    raisePower: 1.4,
                    minChar: 8,
                    scores: [17, 26, 40, 50, 60],
                    ui: {
                        verdicts: [_weak, _normal, _medium, _strong, _veryStrong]
                    }
                });

                // Add your own rule to calculate the password strength
                inputPassword.pwstrength("addRule", "demoRule", function (options, word, score) {
                    return word.match("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+\$).{8,}\$") && score;
                }, 10, true);

                // Set as initialized
                initialized = true;
            }
        });
    };

    /**
     * It checks the username availability
     */
    var handleUsernameAvailabilityChecker = function () {

        var username = $('#username');
        var usernameBlock = $('.username-block');

        $("#username-checker").click(function (e) {

            // Empty username
            if (username.val() === "") {
                username.closest('.form-group').removeClass('has-success').addClass('has-error');

                usernameBlock.html(_checkerUsernameBlockInfo);
                usernameBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            username.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkUsernameAvailibility, {

                // Username value
                username: username.val()

            }, function (res) {
                btn.attr('disabled', false);

                username.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    username.closest('.form-group').removeClass('has-error').addClass('has-success');

                    usernameBlock.html(res.message);
                    usernameBlock.removeClass('availibility-error');
                    usernameBlock.addClass('availibility-success');

                } else {
                    username.closest('.form-group').removeClass('has-success').addClass('has-error');

                    usernameBlock.html(res.message);
                    usernameBlock.addClass('availibility-error');
                }
            }, 'json');

        });
    };

    /**
     * It checks the email availability
     */
    var handleEmailAvailabilityChecker = function () {

        var email = $('#email');
        var emailBlock = $('.email-block');

        $("#email-checker").click(function (e) {

            // Empty email
            if (email.val() === "") {
                email.closest('.form-group').removeClass('has-success').addClass('has-error');

                emailBlock.html(_checkerEmailBlockInfo);
                emailBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            email.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkEmailAvailibility, {

                // Username value
                email: email.val()

            }, function (res) {
                btn.attr('disabled', false);

                email.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    email.closest('.form-group').removeClass('has-error').addClass('has-success');

                    emailBlock.html(res.message);
                    emailBlock.removeClass('availibility-error');
                    emailBlock.addClass('availibility-success');

                } else {
                    email.closest('.form-group').removeClass('has-success').addClass('has-error');

                    emailBlock.html(res.message);
                    emailBlock.addClass('availibility-error');
                }
            }, 'json');

        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlePasswordStrengthChecker();
            handleUsernameAvailabilityChecker();
            handleEmailAvailabilityChecker();
        }
    };
}();

jQuery(document).ready(function() {
    CustomPassword.init();
});
