/*-------------------------------------------------------------------------------------------*
 *                                 CATALOG VALIDATION JAVASCRIPT                             *
 *-------------------------------------------------------------------------------------------*/

var DomainCatalogValidation = function () {

    /**
     * Catalog validation
     */
    var handlerCatalogValidation = function() {

        var catalogForm = $('.catalog-form');

        catalogForm.validate({
            errorElement: 'span', // Default input error message container
            errorClass: 'help-block help-block-error', // Default input error message class
            focusInvalid: false, // Do not focus the last invalid input
            ignore: "",  // Validate all fields including form hidden input
            rules: {
                name: {
                    required: true,
                    maxlength: 60
                }
            },

            messages: {
                name: {
                    required: _requiredField,
                    maxlength: _maxlengthField
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
     * It checks the name availability
     */
    var handlerNameAvailabilityChecker = function () {

        var name = $('#name');
        var nameBlock = $('.catalog-block');

        $("#nameCatalog-checker").click(function (e) {

            // Empty name
            if (name.val() === "") {
                name.closest('.form-group').removeClass('has-success').addClass('has-error');

                nameBlock.html(_checkerNameBlockInfo);
                nameBlock.addClass('availibility-error');
                return;
            }

            var btn = $(this);

            btn.attr('disabled', true);

            name.attr("readonly", true).
            attr("disabled", true).
            addClass("spinner");

            $.post(_checkNameCatalogAvailibility, {

                // Name value
                name: name.val()

            }, function (res) {
                btn.attr('disabled', false);

                name.attr("readonly", false).
                attr("disabled", false).
                removeClass("spinner");

                if (res.status == 'OK') {
                    name.closest('.form-group').removeClass('has-error').addClass('has-success');

                    nameBlock.html(res.message);
                    nameBlock.removeClass('availibility-error');
                    nameBlock.addClass('availibility-success');

                } else {
                    name.closest('.form-group').removeClass('has-success').addClass('has-error');

                    nameBlock.html(res.message);
                    nameBlock.addClass('availibility-error');
                }
            }, 'json');
        });
    };

    /**
     * It handles the max length of the fields
     */
    var handlerMaxlength = function() {

        /* Name field */
        $('#name').maxlength({
            limitReachedClass: "label label-danger",
            threshold: 30,
            placement: 'top',
            validate: true
        });
    };

    /**
     * It handles the multi select in create view
     */
    var handlerBootstrapMultiSelect = function() {

        var questionsSelect = $('#questions');

        questionsSelect.multiSelect({
            /* Headers */
            selectableHeader: "" +
            "<div class='custom-header'>" +_selectable + "</div>" +
            "<h5 class='sbold'>" + _search + "</h5>" +
            "<input type='text' class='search-input form-control form-shadow' autocomplete='off'>",

            selectionHeader: "" +
            "<div class='custom-header'>" +_selection + "</div>" +
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
            questionsSelect.multiSelect('select_all');
            return false;
        });

        // Deselect all items
        $('#deselect-all').click(function(){
            questionsSelect.multiSelect('deselect_all');
            return false;
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerCatalogValidation();
            handlerNameAvailabilityChecker();
            handlerMaxlength();
            handlerBootstrapMultiSelect();
        }
    };

}();

jQuery(document).ready(function() {
    DomainCatalogValidation.init();
});