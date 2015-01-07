$("#client-modal").html("<%= escape_javascript(render 'new') %>")
$("#client-modal").modal("show")