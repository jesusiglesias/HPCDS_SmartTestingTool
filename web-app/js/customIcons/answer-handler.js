/*-------------------------------------------------------------------------------------------*
 *                                JAVASCRIPT - ICONS ANSWER                                  *
 *-------------------------------------------------------------------------------------------*/

var iconAnswerHandler = function () {

    /**
     * Handler icons in input fields of answer
     */
    var handlerIconAnswer = function() {

        var answerKey = $('.key-answer');
        var iconAnswerKey = $('.i-delete-answer-key');
        var answerDescription = $('.description-answer');
        var iconAnswerDescription = $('.i-delete-answer-description');

        /**
         * Key
         */
        // Show delete icon
        answerKey.keydown(function(){
            iconAnswerKey.show();
        });

        // Delete text and hide delete icon
        iconAnswerKey.click(function() {
            answerKey.val('').focus();
            iconAnswerKey.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesKey = function() {
            if (answerKey.val() == '') {
                iconAnswerKey.hide();
            }
        };
        answerKey.on('keyup keydown keypress change paste', function() {
            toggleClassesKey(); // Still toggles the classes on any of the above events
        });
        toggleClassesKey(); // And also on document ready

        /**
         * Description
         */
        // Show delete icon
        answerDescription.keydown(function(){
            iconAnswerDescription.show();
        });

        // Delete text and hide delete icon
        iconAnswerDescription.click(function() {
            answerDescription.val('').focus();
            iconAnswerDescription.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesDescription = function() {
            if (answerDescription.val() == '') {
                iconAnswerDescription.hide();
            }
        };

        answerDescription.on('keyup keydown keypress change paste', function() {
            toggleClassesDescription(); // Still toggles the classes on any of the above events
        });
        toggleClassesDescription(); // And also on document ready
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerIconAnswer();
        }
    };
}();

jQuery(document).ready(function() {
    iconAnswerHandler.init();
});
