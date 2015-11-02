@DocumentTypeForm = React.createClass
  getInitialState: ->
    description: ''
    account_type: ''
    stock_type: ''
    stock: ''
  handleSubmit: (e) ->
    e.preventDefault()
    $.ajaxSetup
      headers:
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    $.post '/document_types', { document_type: @state }, (data) =>
      @props.handleNewDocumentType data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.input
        type: 'text'
        placeholder: 'Description'
        name: 'description'
        value: @state.description
        onChange: @handleChange
      React.DOM.select
        name: 'account_type'
        value: @state.account_type
        onChange: @handleChange
        React.DOM.option
          value: ''
          @props.form_data.select_prompt
        for option in @props.form_data.account_types
          React.DOM.option
            value: option
            option
      React.DOM.select
        name: 'stock_type'
        value: @state.stock_type
        onChange: @handleChange
        React.DOM.option
          value: ''
          @props.form_data.select_prompt
        for option in @props.form_data.stock_types
          React.DOM.option
            value: option
            option
      ' '
      React.DOM.label
        className: 'checkbox'
        React.DOM.input
          type: 'checkbox'
          name: 'stock'
          value: 1
          onChange: @handleChange
          checked: @state.stock
        'Stock'
      ' '
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create'
  handleChange: (e) ->
    name = e.target.name
    if e.target.name != 'stock'
      value = e.target.value
    else if e.target.checked
      value = 1
    else
      value = 0
    @setState "#{ name }": value
  valid: ->
    @state.description and @state.account_type and @state.stock_type
