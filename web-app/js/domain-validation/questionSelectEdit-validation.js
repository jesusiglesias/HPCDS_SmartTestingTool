/*-------------------------------------------------------------------------------------------*
 *                              QUESTION EDIT VALIDATION JAVASCRIPT                          *
 *-------------------------------------------------------------------------------------------*/

var DomainQuestionEditValidation = function () {

    /**
     * Question validation
     */
    var handlerQuestionEditValidation = function () {

        var questionForm = $('.question-form');

        questionForm.validate({
            errorElement: 'span', // Default input error message container
            errorClass: 'help-block help-block-error', // Default input error message class
            focusInvalid: false, // Do not focus the last invalid input
            ignore: "",  // Validate all fields including form hidden input
            rules: {
                titleQuestionKey: {
                    required: true,
                    maxlength: 25
                },
                description: {
                    required: true,
                    maxlength: 800
                },
                difficultyLevel: {
                    required: true
                }
            },

            messages: {
                titleQuestionKey: {
                    required: _requiredField,
                    maxlength: _maxlengthField
                },
                description: {
                    required: _requiredField,
                    maxlength: _maxlengthField
                },
                difficultyLevel: {
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
     * It checks the answer key availability
     */
    var handlerAnswerKeyAvailabilityChecker = function () {

        var questionKey = $('#titleQuestionKey');
        var keyQuestionBlock = $('.keyQuestion-block');

        $("#keyQuestion-checker").click(function (e) {

            // Empty key
            if (questionKey.val() === "") {
                questionKey.closest('.form-group').removeClass('has-success').addClass('has-error');

                keyQuestionBlock.html(_checkerQuestionKeyBlockInfo);
                keyQuestionBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            questionKey.attr("readonly", true).attr("disabled", true).addClass("spinner");

            $.post(_checkKeyQuestionAvailibility, {

                // Key value
                questionKey: questionKey.val()

            }, function (res) {
                btn.attr('disabled', false);

                questionKey.attr("readonly", false).attr("disabled", false).removeClass("spinner");

                if (res.status == 'OK') {
                    questionKey.closest('.form-group').removeClass('has-error').addClass('has-success');

                    keyQuestionBlock.html(res.message);
                    keyQuestionBlock.removeClass('availibility-error');
                    keyQuestionBlock.addClass('availibility-success');

                } else {
                    questionKey.closest('.form-group').removeClass('has-success').addClass('has-error');

                    keyQuestionBlock.html(res.message);
                    keyQuestionBlock.addClass('availibility-error');
                }
            }, 'json');

        });
    };

    /**
     * It handles the max length of the fields
     */
    var handlerMaxlength = function () {

        /* Question key field */
        $('#titleQuestionKey').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 10,
            placement: 'top',
            validate: true
        });

        /* Description field */
        $('#description').maxlength({
            limitReachedClass: "label label-danger",
            alwaysShow: true,
            placement: 'top-right-inside',
            validate: true
        });
    };

    /**
     * It handles the select
     */
    var handlerBootstrapSelect = function () {

        $('.bs-select').selectpicker({
            iconBase: 'fa',
            tickIcon: 'fa-check'
        });
    };

    /**
     * It handles the multi select in edit view
     */
    var handlerBootstrapMultiSelectEdit = function() {

        $.fn.select2.defaults.set("theme", "bootstrap");

        $(".select2, .select2-multiple").select2({
            language: "es",
            width: null,
            allowClear: true
        });

        $("button[data-select2-open]").click(function() {
            $("#" + $(this).data("select2-open")).select2("open");
        });
    };

    /**
     * It handles the checkbox to delete the question
     */
    var handlerCheckboxDeleted = function() {

        var checkboxDelete = $("#delete_question");
        var checkboxDeleteAnswer = $("#delete_question_answer");

        checkboxDeleteAnswer.change(function() {

            if (checkboxDeleteAnswer.is(':checked')) {
                checkboxDelete.attr( "disabled" ,"true" );

            } else {
                checkboxDelete.removeAttr("disabled", false);
            }
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerQuestionEditValidation();
            handlerAnswerKeyAvailabilityChecker();
            handlerMaxlength();
            handlerBootstrapSelect();
            handlerBootstrapMultiSelectEdit();
            handlerCheckboxDeleted();
        }
    };
}();

jQuery(document).ready(function () {
    DomainQuestionEditValidation.init();
});