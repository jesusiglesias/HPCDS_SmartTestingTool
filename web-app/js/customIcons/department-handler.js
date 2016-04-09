/*-------------------------------------------------------------------------------------------*
 *                               JAVASCRIPT - ICONS DEPARTMENT                               *
 *-------------------------------------------------------------------------------------------*/

var iconDepartmentHandler = function () {

    /**
     * Handler icons in input fields of department
     */
    var handlerIconDepartment = function() {

        var departmentName = $('.name-department');
        var iconDepartmentName = $('.i-delete-department-name');

        /**
         * Name
         */
        // Show delete icon
        departmentName.keydown(function(){
            iconDepartmentName.show();
        });

        // Delete text and hide delete icon
        iconDepartmentName.click(function() {
            departmentName.val('').focus();
            iconDepartmentName.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClasses = function() {
            if (departmentName.val() == '') {
                iconDepartmentName.hide();
            }
        };
        departmentName.on('keyup keydown keypress change paste', function() {
            toggleClasses(); // Still toggles the classes on any of the above events
        });
        toggleClasses(); // And also on document ready
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerIconDepartment();
        }
    };
}();

jQuery(document).ready(function() {
    iconDepartmentHandler.init();
});
