error = false

field = $("#micropost_content").keyup ->
    micropost_length = $(this).val().length
    if micropost_length <= 140
        $("#length").html 140 - micropost_length
        if error
          field.unwrap()
          error = false
    else
        $("#length").html 0
        if !error
          field.wrap('<div class="field_with_errors" />')
          error = true
