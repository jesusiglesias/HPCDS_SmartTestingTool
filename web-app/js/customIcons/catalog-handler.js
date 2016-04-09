/*-------------------------------------------------------------------------------------------*
 *                                JAVASCRIPT - ICONS CATALOG                                 *
 *-------------------------------------------------------------------------------------------*/

var iconCatalogHandler = function () {

    /**
     * Handler icons in input fields of catalog
     */
    var handlerIconCatalog = function() {

        var catalogName = $('.name-catalog');
        var iconCatalogName = $('.i-delete-catalog-name');

        /**
         * Name
         */
        // Show delete icon
        catalogName.keydown(function(){
            iconCatalogName.show();
        });

        // Delete text and hide delete icon
        iconCatalogName.click(function() {
            catalogName.val('').focus();
            iconCatalogName.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClasses = function() {
            if (catalogName.val() == '') {
                iconCatalogName.hide();
            }
        };
        catalogName.on('keyup keydown keypress change paste', function() {
            toggleClasses(); // Still toggles the classes on any of the above events
        });
        toggleClasses(); // And also on document ready
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerIconCatalog();
        }
    };
}();

jQuery(document).ready(function() {
    iconCatalogHandler.init();
});
