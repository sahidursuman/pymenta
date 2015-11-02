@Category = React.createClass
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
        url: "/categories/#{ @props.category.id }"
        dataType: 'JSON'
        success: () =>
          @props.handleDeleteCategory @props.category
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
      url: "/categories/#{ @props.category.id }"
      dataType: 'JSON'
      data:
        category: data
      success: (data) =>
        @setState edit: false
        @props.handleEditCategory @props.category, data
  categoryRow: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.a
          href: "/categories/#{ @props.category.id }"
          @props.category.code
      React.DOM.td null, @props.category.description
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
  categoryForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.category.code
          ref: 'code'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'description'
          defaultValue: @props.category.description
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
      @categoryForm()
    else
      @categoryRow()
