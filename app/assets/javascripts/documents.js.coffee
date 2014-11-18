$(document).ready ->
  $("#autocomplete").autocomplete
    minLength: 2
    source: (request, response) ->
      $.ajax
        url: $("#autocomplete").data('ajax_path')
        data:
          query: request.term
        dataType: "json"
        success: (data) -> response(data)	  