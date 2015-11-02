@Brand = React.createClass
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
        url: "/brands/#{ @props.brand.id }"
        dataType: 'JSON'
        success: () =>
          @props.handleDeleteBrand @props.brand
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
      url: "/brands/#{ @props.brand.id }"
      dataType: 'JSON'
      data:
        brand: data
      success: (data) =>
        @setState edit: false
        @props.handleEditBrand @props.brand, data
  brandRow: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.a
          href: "/brands/#{ @props.brand.id }"
          @props.brand.code
      React.DOM.td null, @props.brand.description
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
  brandForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.brand.code
          ref: 'code'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'description'
          defaultValue: @props.brand.description
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
      @brandForm()
    else
      @brandRow()
