/*-------------------------------------------------------------------------------------------*
 *                                JAVASCRIPT - ICONS TOPIC                                   *
 *-------------------------------------------------------------------------------------------*/

var iconTopicHandler = function () {

    /**
     * Handler icons in input fields of topic
     */
    var handlerIconTopic = function() {

        var topicName = $('.name-topic');
        var iconTopicNAme = $('.i-delete-topic-name');
        var topicDescription = $('.description-topic');
        var iconTopicDescription = $('.i-delete-topic-description');

        /**
         * Name
         */
        // Show delete icon
        topicName.keydown(function(){
            iconTopicNAme.show();
        });

        // Delete text and hide delete icon
        iconTopicNAme.click(function() {
            topicName.val('').focus();
            iconTopicNAme.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesName = function() {
            if (topicName.val() == '') {
                iconTopicNAme.hide();
            }
        };
        topicName.on('keyup keydown keypress change paste', function() {
            toggleClassesName(); // Still toggles the classes on any of the above events
        });
        toggleClassesName(); // And also on document ready

        /**
         * Description
         */
        // Show delete icon
        topicDescription.keydown(function(){
            iconTopicDescription.show();
        });

        // Delete text and hide delete icon
        iconTopicDescription.click(function() {
            topicDescription.val('').focus();
            iconTopicDescription.hide();
        });

        // Hide delete icon when user deletes text with the keyboard
        var toggleClassesDescription = function() {
            if (topicDescription.val() == '') {
                iconTopicDescription.hide();
            }
        };

        topicDescription.on('keyup keydown keypress change paste', function() {
            toggleClassesDescription(); // Still toggles the classes on any of the above events
        });
        toggleClassesDescription(); // And also on document ready
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerIconTopic();
        }
    };
}();

jQuery(document).ready(function() {
    iconTopicHandler.init();
});
