@Warehouse= React.createClass
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
        url: "/warehouses/#{ @props.warehouse.id }"
        dataType: 'JSON'
        success: () =>
          @props.handleDeleteWarehouse @props.warehouse
  handleEdit: (e) ->
    e.preventDefault()
    data =
      code: this.refs.code.value
      name: this.refs.name.value
      city: this.refs.city.value
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    $.ajax
      method: 'PUT'
      url: "/warehouses/#{ @props.warehouse.id }"
      dataType: 'JSON'
      data:
        warehouse: data
      success: (data) =>
        @setState edit: false
        @props.handleEditWarehouse @props.warehouse, data
  warehouseRow: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.a
          href: "/warehouses/#{ @props.warehouse.id }"
          @props.warehouse.code
      React.DOM.td null, @props.warehouse.name
      React.DOM.td null, @props.warehouse.city
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
  warehouseForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.warehouse.code
          ref: 'code'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.warehouse.name
          ref: 'name'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.warehouse.city
          ref: 'city'
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
      @warehouseForm()
    else
      @warehouseRow()
