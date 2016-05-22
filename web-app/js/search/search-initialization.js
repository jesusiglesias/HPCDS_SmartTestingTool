/*-------------------------------------------------------------------------------------------*
 *                              SEARCH INITIALIZATION JAVASCRIPT                             *
 *-------------------------------------------------------------------------------------------*/

var SeachInitialization = function () {

    /**
     * Search initialization in /home (topics) and /topicSelect (test) paths
     */
    var handlerSearchInitialization = function() {

        var searchTopic = $('#search-topic');
        var searchTest = $('#search-test');

        searchTopic.hideseek({
            list:           '.ribbon-search-topic',
            highlight:      true,
            attribute:      'text',
            navigation:     false,
            ignore_accents: true,
            hidden_mode:    false
        });

        searchTest.hideseek({
            list:           '.ribbon-search-test',
            highlight:      true,
            attribute:      'text',
            navigation:     false,
            ignore_accents: true,
            hidden_mode:    false
        });
    };

    /**
     * Handler the first character in search form (not whitespace)
     */
    var handlerFirstCharacter = function() {

        var body = $('body');

        // It avoids the first character is space
        body.on('keydown', '#search-topic', function(e) {
            if (e.which === 32 &&  e.target.selectionStart === 0) {
                return false;
            }
        });
        body.on('keydown', '#search-test', function(e) {
            if (e.which === 32 &&  e.target.selectionStart === 0) {
                return false;
            }
        });
    };

    return {
        // Main function to initiate the module
        init: function () {
            handlerSearchInitialization();
            handlerFirstCharacter();
        }
    };

}();

jQuery(document).ready(function() {
    SeachInitialization.init();
});