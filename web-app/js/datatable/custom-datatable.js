/*-------------------------------------------------------------------------------------------*
 *                                     DATATABLE JAVASCRIPT                                  *
 *-------------------------------------------------------------------------------------------*/

var DatatableList = function () {

    var initEntityTable = function () {
        var table = $('#entity-table');

        var oTable = table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
          /*  "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ entries",
                "infoEmpty": "No entries found",
                "infoFiltered": "(filtered1 from _MAX_ total entries)",
                "lengthMenu": "_MENU_ entries",
                "search": "Search:",
                "zeroRecords": "No matching records found"
            }, */

            // Or you can use remote translation file
            "language": {
                url: '//cdn.datatables.net/plug-ins/1.10.11/i18n/Spanish.json'
            },

            buttons: [
                { extend: 'print', className: 'btn dark btn-outline', text: _print },
                { extend: 'copy', className: 'btn red-sunglo btn-outline', text: _copy },
                { extend: 'pdf', className: 'btn green-dark btn-outline', text: _pdf },
                { extend: 'excel', className: 'btn yellow btn-outline ', text: _excel },
                { extend: 'csv', className: 'btn blue-steel btn-outline ', text: _csv },
                { extend: 'colvis', className: 'btn yellow-casablanca btn-outline', text: _columns}
            ],

            // Setup responsive extension
            responsive: true,

            // Disable column ordering
            //"ordering": false,

            // Disable pagination
            //"paging": false,

            colReorder: {
                reorderCallback: function () {
                }
            },

            "order": [
                [0, 'asc']
            ],
            
            "lengthMenu": [
                [5, 10, 15, 20, -1],
                [5, 10, 15, 20, "All"] // Change per page values here
            ],

            // Set the initial value
            "pageLength": 10,

            // Horizontal scrollable datatable
            "dom": "<'row' <'col-md-12'B>><'row'<'col-sm-6 col-xs-12'l><'col-sm-6 col-xs-12'f>r><'table-scrollable't><'row'<'col-sm-5 col-xs-12'i><'col-sm-7 col-xs-12'p>>"
        });
    };

    return {

        // Main function to initiate the script
        init: function () {

            if (!jQuery().dataTable) {
                return;
            }
            initEntityTable();
        }

    };

}();

jQuery(document).ready(function() {
    DatatableList.init();
});