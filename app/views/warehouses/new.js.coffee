$("#warehouse-modal").html("<%= escape_javascript(render 'new') %>")
$("#warehouse-modal").modal("show")