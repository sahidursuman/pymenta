@BrandForm = React.createClass
  getInitialState: ->
    code: ''
    description: ''
  handleSubmit: (e) ->
    e.preventDefault()
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    $.post '/brands', { brand: @state }, (data) =>
      @props.handleNewBrand data
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
        placeholder: 'Description'
        name: 'description'
        value: @state.description
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
    @state.code and @state.description
