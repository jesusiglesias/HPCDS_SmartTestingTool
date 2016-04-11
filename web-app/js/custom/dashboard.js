/*-------------------------------------------------------------------------------------------*
 *                               CUSTOM JAVASCRIPT - DASHBOARD                               *
 *-------------------------------------------------------------------------------------------*/

var CustomDashboardScript = function () {

    /**
     * It handles the tooltips
     */
    var handlerTooltip = function () {

        // Global tooltips
        $('.tooltips').tooltip();

        // Portlet tooltips
        $('.portlet > .portlet-title .fullscreen').tooltip({
            container: 'body',
            title: fullscreenTooltip
        });

        $('.portlet > .portlet-title > .tools > .remove').tooltip({
            container: 'body',
            title: removeTooltip
        });
        $('.portlet > .portlet-title > .tools > .collapse, .portlet > .portlet-title > .tools > .expand').tooltip({
            container: 'body',
            title: collapseTooltip
        });

        // Reload tooltips
        $('.iconReload').tooltip({
            container: 'body',
            title: reloadTooltip
        });

        // Reload tooltips
        $('.reloadGraph').tooltip({
            container: 'body',
            title: reloadTooltip
        });
    };

    /**
     * It reload the content from AJAX call in dashboards
     */
    var handlerAJAXCallDashboard = function () {

        // Call AJAX to upload the number of users
        $('.reloadUsers').click(function () {

            var counterUsers = $('.counterUsers');
            var widgetUsers = $('.widget-users');

            $.ajax({
                url: reloadUsersURL,
                beforeSend: function () {

                    widgetUsers.LoadingOverlay("show", {
                        image: "",
                        fontawesome: "fa fa-spinner fa-spin"
                    });
                },
                success: function (data) {
                    counterUsers.attr('data-value', data);
                    counterUsers.text(data);

                    counterUsers.counterUp({});
                },
                error: function () {
                    toastr["error"](reloadAjaxError);

                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": true,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }
                },
                complete: function () {
                    setTimeout(function () {
                        widgetUsers.LoadingOverlay("hide");
                    }, 500);
                }
            });
        });

        // Call AJAX to upload the number of test
        $('.reloadTest').click(function () {

            var counterTest = $('.counterTest');
            var widgetTest = $('.widget-test');

            $.ajax({
                url: reloadTestURL,
                beforeSend: function () {

                    widgetTest.LoadingOverlay("show", {
                        image: "",
                        fontawesome: "fa fa-spinner fa-spin"
                    });
                },
                success: function (data) {
                    counterTest.attr('data-value', data);
                    counterTest.text(data);

                    counterTest.counterUp({});
                },
                error: function () {
                    toastr["error"](reloadAjaxError);

                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": true,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }
                },
                complete: function () {
                    setTimeout(function () {
                        widgetTest.LoadingOverlay("hide");
                    }, 500);
                }
            });
        });

        // Call AJAX to upload the number of evaluations
        $('.reloadEvaluations').click(function () {

            var counterEvaluations = $('.counterEvaluations');
            var widgetEvaluations = $('.widget-evaluations');

            $.ajax({
                url: reloadEvaluationsURL,
                beforeSend: function () {

                    widgetEvaluations.LoadingOverlay("show", {
                        image: "",
                        fontawesome: "fa fa-spinner fa-spin"
                    });
                },
                success: function (data) {
                    counterEvaluations.attr('data-value', data);
                    counterEvaluations.text(data);

                    counterEvaluations.counterUp({});
                },
                error: function () {
                    toastr["error"](reloadAjaxError);

                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "newestOnTop": false,
                        "progressBar": true,
                        "positionClass": "toast-top-right",
                        "preventDuplicates": false,
                        "onclick": null,
                        "showDuration": "300",
                        "hideDuration": "1000",
                        "timeOut": "5000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }
                },
                complete: function () {
                    setTimeout(function () {
                        widgetEvaluations.LoadingOverlay("hide");
                    }, 500);
                }
            });
        });

        // Call AJAX to upload the last 10 registered users
        $('.reloadLastUsers').click(function () {

            var portletUsers = $('.portlet-users');

            // Overlay active
            portletUsers.LoadingOverlay("show", {
                image: "",
                fontawesome: "fa fa-spinner fa-spin"
            });

            // AJAX call
            $(".content-lastUsers").load("customTasksBackend/reloadLastUsers", function() {

                // Stop overlay
                setTimeout(function () {
                    portletUsers.LoadingOverlay("hide");
                }, 500);
            });
        });
    };

return {
    // Main function to initiate the module
    init: function () {
        handlerTooltip();
        handlerAJAXCallDashboard();
    }
};
}();

jQuery(document).ready(function () {
    CustomDashboardScript.init();
});
