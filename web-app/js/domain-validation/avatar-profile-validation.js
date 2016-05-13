/*-------------------------------------------------------------------------------------------*
 *                             PROFILE USER - AVATAR VALIDATION JAVASCRIPT                   *
 *-------------------------------------------------------------------------------------------*/

var DomainAvatarProfileValidation = function () {

    /**
     * Profile user validation - Avatar
     */
    var handlerAvatarProfileValidation = function() {

        var profileAvatarForm = $('.profileAvatarUser-form');
        var avatarSubject = $('.avatar-subject');

        profileAvatarForm.validate({
            errorElement: 'span', // Default input error message container
            errorClass: 'help-block help-block-error', // Default input error message class
            focusInvalid: false, // Do not focus the last invalid input
            ignore: "",  // Validate all fields including form hidden input
            rules: {
                avatarUser: {
                    required: true
                }
            },

            messages: {
                avatarUser: {
                    required: _requiredField
                }
            },

            // Render error placement for each input type
            errorPlacement: function (error, element) {
            },

            // Set error class to the control group
            highlight: function (element) {
                $(element).closest('.form-group').removeClass("has-success").addClass('has-error');
                avatarSubject.removeClass("font-green-dark").addClass('has-error-default');
            },

            // Set success class to the control group
            success: function (label, element) {
                $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
                avatarSubject.removeClass('has-error-default').addClass('font-green-dark');
            },

            submitHandler: function (form) {
                form.submit(); // Submit the form
            }
        })
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerAvatarProfileValidation();
        }
    };

}();

jQuery(document).ready(function() {
    DomainAvatarProfileValidation.init();
});