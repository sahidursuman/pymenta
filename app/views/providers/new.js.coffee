$("#provider-modal").html("<%= escape_javascript(render 'new') %>")
$("#provider-modal").modal("show")