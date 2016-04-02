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
                    titleAnswerKey: {
                        required: true,
                        maxlength: 50
                    },
                    description: {
                        required: true,
                        maxlength: 400
                    },
                    score: {
                        required: true,
                        min: 0,
                        max: 5
                    }
                },

                messages: {
                    titleAnswerKey: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    description: {
                        required: _requiredField,
                        maxlength: _maxlengthField
                    },
                    score: {
                        required: _requiredField,
                        min: _minField,
                        max: _maxField
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

        var answerKey = $('#titleAnswerKey');
        var keyAnswerBlock = $('.keyAnswer-block');

        $("#keyAnswer-checker").click(function () {

            // Empty key
            if (answerKey.val() === "") {
                answerKey.closest('.form-group').removeClass('has-success').addClass('has-error');

                keyAnswerBlock.html(_checkerAnswerKeyBlockInfo);
                keyAnswerBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            answerKey.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkKeyAnswerAvailibility, {

                // Key value
                answerKey: answerKey.val()

            }, function (res) {
                btn.attr('disabled', false);

                answerKey.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    answerKey.closest('.form-group').removeClass('has-error').addClass('has-success');

                    keyAnswerBlock.html(res.message);
                    keyAnswerBlock.removeClass('availibility-error');
                    keyAnswerBlock.addClass('availibility-success');

                } else {
                    answerKey.closest('.form-group').removeClass('has-success').addClass('has-error');

                    keyAnswerBlock.html(res.message);
                    keyAnswerBlock.addClass('availibility-error');
                }
            }, 'json');

        });
    };

    /**
     * It handles the max length of the fields
     */
    var handlerMaxlength = function() {

            /* Answer key field */
            $('#titleAnswerKey').maxlength({
                limitReachedClass: "label label-danger",
                threshold: 20,
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
    var handlerBootstrapSelect = function() {

        // It adds the subtext
        $(".select-score option[value=\"1\"]").attr("data-subtext", _point);
        $(".select-score option[value=\"2\"]").attr("data-subtext", _points);
        $(".select-score option[value=\"3\"]").attr("data-subtext", _points);
        $(".select-score option[value=\"4\"]").attr("data-subtext", _points);
        $(".select-score option[value=\"5\"]").attr("data-subtext", _points);

        $('.bs-select').selectpicker({
            iconBase: 'fa',
            tickIcon: 'fa-check'
        });
    };

    /**
     * It handles the state of select depending on checkbox
     */
    var handlerStateSelect = function() {

        var checkboxCorrect = $('#correct');
        var selectScore = $('.select-score');

        // Checkbox checked
        checkboxCorrect.on('ifChecked', function(){
            selectScore.removeAttr("disabled", false);
            selectScore.find("div").removeClass("disabled");
            selectScore.find("button").removeClass("disabled");

        });

        // Checkbox unchecked
        checkboxCorrect.on('ifUnchecked', function(){
            selectScore.attr("disabled", true);
            selectScore.find("div").addClass("disabled");
            selectScore.find("button").addClass("disabled");
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerAnswerValidation();
            handlerAnswerKeyAvailabilityChecker();
            handlerMaxlength();
            handlerBootstrapSelect();
            handlerStateSelect();
        }
    };
}();

jQuery(document).ready(function() {
    DomainAnswerValidation.init();
});