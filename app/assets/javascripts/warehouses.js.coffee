$(document).ready ->
  $("#autocomplete_warehouse").autocomplete
    minLength: 2
    source: (request, response) ->
      $.ajax
        url: $("#autocomplete_warehouse").data('ajax_autocomplete_path')
        data: query: request.term
        dataType: "json"
        success: (data) -> response(data)	 
      return
    
    select: (event, ui) ->
      $.ajax
        url: $("#autocomplete_warehouse").data('ajax_info_path')
        data: "warehouse_id=" + ui.item.value
        dataType: "html"
        success: (data) -> $("#warehouse_name").html data
      return