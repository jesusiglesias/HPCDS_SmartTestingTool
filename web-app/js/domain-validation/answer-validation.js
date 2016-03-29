/*-------------------------------------------------------------------------------------------*
 *                                  ANSWER VALIDATION JAVASCRIPT                             *
 *-------------------------------------------------------------------------------------------*/

var DomainAnswerValidation = function () {

    /**
     * Answer validation
     */
    var handlerAnswerValidation = function() {

        var answerForm = $('.answer-form');

        answerForm.validate({
                errorElement: 'span', // Default input error message container
                errorClass: 'help-block help-block-error', // Default input error message class
                focusInvalid: false, // Do not focus the last invalid input
                ignore: "",  // Validate all fields including form hidden input
                rules: {
                    description: {
                        required: true,
                        maxlength: 300
                    },
                    score: {
                        required: true
                    }
                },

                messages: {
                    description: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    score: {
                        required: _requiredField
                    }
                },

                // Render error placement for each input type
                errorPlacement: function (error, element) {
                    var icon = $(element).parent('.input-icon').children('i');
                    icon.removeClass('fa-check').addClass("fa-warning");  
                    icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
                },

                // Set error class to the control group
                highlight: function (element) {
                    $(element)
                        .closest('.form-group').removeClass("has-success").addClass('has-error');
                },

                // Set success class to the control group
                success: function (label, element) {
                    var icon = $(element).parent('.input-icon').children('i');
                    $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
                    icon.removeClass("fa-warning").addClass("fa-check");
                },

                submitHandler: function (form) {
                    form.submit(); // Submit the form
                }
            });
    };

    /**
     * It handles the max length of the fields
     */
    var handlerMaxlength = function() {

            /* Description field */
            $('#description').maxlength({
                limitReachedClass: "label label-danger",
                alwaysShow: true,
                placement: 'top-right-inside',
                validate: true
            });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerAnswerValidation();
            handlerMaxlength();
        }
    };

}();

jQuery(document).ready(function() {
    DomainAnswerValidation.init();
});