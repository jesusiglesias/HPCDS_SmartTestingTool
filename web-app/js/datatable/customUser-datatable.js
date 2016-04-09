/*-------------------------------------------------------------------------------------------*
 *                                     DATATABLE JAVASCRIPT                                  *
 *-------------------------------------------------------------------------------------------*/

var DatatableUserList = function () {

    /**
     *  Table function
     */
    var initUserTable = function () {

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

            // Visibility of columns
            "columnDefs": [
                {
                    "targets": [5], // Expired account
                    "visible": false
                },
                {
                    "targets": [6], // Expired password
                    "visible": false
                },
                {
                    "targets": [7], // Name
                    "visible": false
                },
                {
                    "targets": [8], // Surname
                    "visible": false
                },
                {
                    "targets": [9], // Birthdate
                    "visible": false
                },
                {
                    "targets": [10], // Address
                    "visible": false
                },
                {
                    "targets": [11], // City
                    "visible": false
                },
                {
                    "targets": [12], // Country
                    "visible": false
                },
                {
                    "targets": [13], // Phone
                    "visible": false
                },
                {
                    "targets": [14], // Sex
                    "visible": false
                }
            ],

            buttons: [
                { extend: 'print', className: 'btn dark btn-outline', text: _print, exportOptions: {columns: [1, 2, 7, 8, 9, 14, 15, 17]} },
                { extend: 'copy', className: 'btn red-sunglo btn-outline', text: _copy, exportOptions: {columns: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17]} },
                { extend: 'pdf', className: 'btn green-dark btn-outline', text: _pdf, filename: _userFile, title: _userTableTitle, exportOptions: {columns: [1, 2, 7, 8, 9, 14, 15, 17]} },
                { extend: 'csv', className: 'btn blue-steel btn-outline', text: _csv, fieldSeparator: ';', filename: _userFile, exportOptions: {columns: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17]} },
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
                [1, 'asc']
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

        // Search of users
        var searchTable = table.DataTable();
        searchTable.search(_textSearch).draw();

    };

    return {

        // Main function to initiate the script
        init: function () {

            if (!jQuery().dataTable) {
                return;
            }
            initUserTable();
        }

    };

}();

jQuery(document).ready(function() {
    DatatableUserList.init();
});