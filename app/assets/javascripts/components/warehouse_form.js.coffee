@WarehouseForm = React.createClass
  getInitialState: ->
    code: ''
    name: ''
    city: ''
  handleSubmit: (e) ->
    e.preventDefault()
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    $.post '/warehouses', { warehouse: @state }, (data) =>
      @props.handleNewWarehouse data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.input
        type: 'text'
        placeholder: 'Code'
        name: 'code'
        value: @state.code
        onChange: @handleChange
      React.DOM.input
        type: 'text'
        placeholder: 'Name'
        name: 'name'
        value: @state.name
        onChange: @handleChange
      React.DOM.input
        type: 'text'
        placeholder: 'City'
        name: 'city'
        value: @state.city
        onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create'
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.code and @state.name
