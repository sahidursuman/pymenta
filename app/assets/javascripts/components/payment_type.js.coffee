@PaymentType = React.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    if confirm "Are you sure?"
      e.preventDefault()
      $.ajaxSetup
        headers:
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      $.ajax
        method: 'DELETE'
        url: "/payment_types/#{ @props.payment_type.id }"
        dataType: 'JSON'
        success: () =>
          @props.handleDeletePaymentType @props.payment_type
  handleEdit: (e) ->
    e.preventDefault()
    data =
      code: React.findDOMNode(@refs.code).value
      description: React.findDOMNode(@refs.description).value
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    $.ajax
      method: 'PUT'
      url: "/payment_types/#{ @props.payment_type.id }"
      dataType: 'JSON'
      data:
        payment_type: data
      success: (data) =>
        @setState edit: false
        @props.handleEditPaymentType @props.payment_type, data
  paymentTypeRow: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.a
          href: "/payment_types/#{ @props.payment_type.id }"
          @props.payment_type.code
      React.DOM.td null, @props.payment_type.description
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-mini'
          onClick: @handleToggle
          'Edit'
        ' '
        React.DOM.a
          className: 'btn btn-mini btn-danger'
          onClick: @handleDelete
          'Destroy'
  paymentTypeForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.payment_type.code
          ref: 'code'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'description'
          defaultValue: @props.payment_type.description
          ref: 'description'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-mini btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-mini btn-danger'
          onClick: @handleToggle
          'Cancel'
  render: ->
    if @state.edit
      @paymentTypeForm()
    else
      @paymentTypeRow()
