$(document).ready ->
  $("#autocomplete_client").autocomplete
    minLength: 2
    source: (request, response) ->
      $.ajax
        url: $("#autocomplete_client").data('ajax_autocomplete_path')
        data: query: request.term
        dataType: "json"
        success: (data) -> response(data)	 
      return
    
    select: (event, ui) ->
      $.ajax
        url: $("#autocomplete_client").data('ajax_info_path')
        data: "client_id=" + ui.item.value
        dataType: "html"
        success: (data) -> $("#client_name").html data
      return
