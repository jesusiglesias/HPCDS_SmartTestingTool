/*-------------------------------------------------------------------------------------------*
 *                                     DATATABLE JAVASCRIPT                                  *
 *-------------------------------------------------------------------------------------------*/

var DatatableAnswerList = function () {

    /**
     *  Table function
     */
    var initAnswerTable = function () {

        var table = $('#entity-table');

        var oTable = table.dataTable({

            // Internationalisation
            "language": {
                "aria": {
                    "sortAscending": _sortAscending,
                    "sortDescending": _sortDescending
                },
                "emptyTable": _emptyTable,
                "info": _info,
                "infoEmpty": _infoEmpty,
                "infoFiltered": _infoFiltered,
                "lengthMenu": _lengthMenu,
                "search": _search,
                "zeroRecords": _zeroRecords,
                "processing": _processing,
                "infoThousands": _infoThousands,
                "loadingRecords": _loadingRecords,
                "paginate": {
                    "first": _first,
                    "last": _last,
                    "next": _next,
                    "previous": _previous
                }
            },

            // Row selectable
            select: false,

            // Auto width
            "autoWidth": true,

            buttons: [
                { extend: 'print', className: 'btn dark btn-outline', text: _print, exportOptions: {columns: [0, 1, 2, 3, 4]} },
                { extend: 'copy', className: 'btn red-sunglo btn-outline', text: _copy, exportOptions: {columns: [0, 1, 2, 3, 4]} },
                { extend: 'pdf', className: 'btn green-dark btn-outline', text: _pdf, filename: _answerFile, title: _answerTableTitle, exportOptions: {columns: [0, 1, 2, 3, 4]} },
                { extend: 'csv', className: 'btn blue-steel btn-outline', text: _csv, fieldSeparator: ';', filename: _answerFile, exportOptions: {columns: [0, 1, 2, 3, 4]} },
                { extend: 'colvis', className: 'btn yellow-casablanca btn-outline', text: _columns },
                { extend: 'colvisRestore', className: 'btn yellow btn-outline ', text: _restore }
            ],

            // Pagination type
            "pagingType": "bootstrap_full_number",

            // Setup responsive extension
            responsive: true,

            // Disable column ordering
            //"ordering": false,

            // Disable pagination
            //"paging": false,

            // Save the state of search form
            //"bStateSave" : true,

            colReorder: {
                reorderCallback: function () {
                }
            },

            "order": [
                [0, 'asc']
            ],
            
            "lengthMenu": [
                [5, 10, 20, 50, 100, -1],
                [5, 10, 20, 50, 100, _all] // Change per page values here
            ],

            // Set the initial value
            "pageLength": 20,

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
            initAnswerTable();
        }

    };

}();

jQuery(document).ready(function() {
    DatatableAnswerList.init();
});