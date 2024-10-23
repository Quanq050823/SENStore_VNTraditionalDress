$(document).ready(function () {
    $('#editButton').on('click', function (event) {
        event.preventDefault();
        var href = $(this).attr('href');

        // Use an AJAX request to fetch data from the server
        $.get(href, function (categoryEdit) {
            // Check if the data is not null
            if (categoryEdit) {
                // Set the existing category data in the modal
                $('#idEdit').val(categoryEdit.categoryId);
                $('#nameEdit').val(categoryEdit.categoryName);

                // Show the modal
                $('#editModal').modal();
            } else {
                console.error("Failed to retrieve category data");
            }
        }, 'json').fail(function (jqXHR, textStatus, errorThrown) {
            console.error("AJAX request failed: " + textStatus, errorThrown);
        });
    });
});