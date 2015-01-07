$(document).ready ->
  $("#autocomplete_provider").autocomplete
    minLength: 2
    source: (request, response) ->
      $.ajax
        url: $("#autocomplete_provider").data('ajax_autocomplete_path')
        data: query: request.term
        dataType: "json"
        success: (data) -> response(data)	 
      return
    
    select: (event, ui) ->
      $.ajax
        url: $("#autocomplete_provider").data('ajax_info_path')
        data: "provider_id=" + ui.item.value
        dataType: "html"
        success: (data) -> $("#provider_name").html data
      return