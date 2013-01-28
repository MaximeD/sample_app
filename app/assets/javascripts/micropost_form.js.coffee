field = $("#micropost_content").keyup ->
    micropost_length = $(this).val().length
    if micropost_length <= 140
        $("#length").html 140 - micropost_length
    else
        $("#length").html 0
        field.wrap('<div class="field_with_errors" />')
