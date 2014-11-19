$(document).ready ->
  $("#autocomplete").autocomplete
    minLength: 2
    source: (request, response) ->
      $.ajax
        url: $("#autocomplete").data('ajax_path')
        data: query: request.term
        dataType: "json"
        success: (data) -> response(data)	 
      return
    
    select: (event, ui) ->
      $.ajax
        url: $("#autocomplete").data('ajax_path_2')
        data: "product_id=" + ui.item.value
        dataType: "html"
        success: (data) -> $("#product_description").html data
      return

 