/*-------------------------------------------------------------------------------------------*
 *                                QUESTION VALIDATION JAVASCRIPT                             *
 *-------------------------------------------------------------------------------------------*/

var DomainQuestionValidation = function () {

    /**
     * Question validation
     */
    var handlerQuestionValidation = function () {

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
     * It handles the multi select in create view
     */
    var handlerBootstrapMultiSelect = function() {

        var answersSelect = $('#answers');

        answersSelect.multiSelect({
            /* Headers */
            selectableHeader: "" +
            "<div class='custom-header'>" + _selectableAnswers + "</div>" +
            "<h5 class='sbold'>" + _search + "</h5>" +
            "<input type='text' class='search-input form-control form-shadow' autocomplete='off'>",

            selectionHeader: "" +
            "<div class='custom-header'>" + _selectionAnswers + "</div>" +
            "<h5 class='sbold'>" + _search + "</h5>" +
            "<input type='text' class='search-input form-control form-shadow' autocomplete='off'>",

            afterInit: function(ms){
                var that = this,
                    $selectableSearch = that.$selectableUl.prev(),
                    $selectionSearch = that.$selectionUl.prev(),
                    selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
                    selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';

                that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
                    .on('keydown', function(e){
                        if (e.which === 40){
                            that.$selectableUl.focus();
                            return false;
                        }
                    });

                that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
                    .on('keydown', function(e){
                        if (e.which == 40){
                            that.$selectionUl.focus();
                            return false;
                        }
                    });
            },
            afterSelect: function(){
                this.qs1.cache();
                this.qs2.cache();
            },
            afterDeselect: function(){
                this.qs1.cache();
                this.qs2.cache();
            }
        });

        // Select all items
        $('#select-all').click(function(){
            answersSelect.multiSelect('select_all');
            return false;
        });

        // Deselect all items
        $('#deselect-all').click(function(){
            answersSelect.multiSelect('deselect_all');
            return false;
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerQuestionValidation();
            handlerAnswerKeyAvailabilityChecker();
            handlerMaxlength();
            handlerBootstrapSelect();
            handlerBootstrapMultiSelect();
        }
    };
}();

jQuery(document).ready(function () {
    DomainQuestionValidation.init();
});