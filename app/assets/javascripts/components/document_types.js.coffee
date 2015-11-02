@DocumentTypes = React.createClass
  getInitialState: ->
    document_types: @props.data
  getDefaultProps: ->
    document_types: []
  addDocumentType: (document_type) ->
    document_types = React.addons.update(@state.document_types, { $push: [document_type] })
    @setState document_types: document_types
  deleteDocumentType: (document_type) ->
    index = @state.document_types.indexOf document_type
    document_types = React.addons.update(@state.document_types, { $splice: [[index, 1]] })
    @replaceState document_types: document_types
  updateDocumentType: (document_type, data) ->
    index = @state.document_types.indexOf document_type
    document_types = React.addons.update(@state.document_types, { $splice: [[index, 1, data]] })
    @replaceState document_types: document_types
  render: ->
    React.DOM.div
      className: 'document-types'
      React.DOM.h1
        className: 'title'
        @props.page_header
      React.createElement DocumentTypeForm, handleNewDocumentType: @addDocumentType, form_data: @props.form_data
      React.DOM.hr null
      React.DOM.table
        className: 'table table-striped'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Description'
            React.DOM.th null, 'Account Type'
            React.DOM.th null, 'Stock Type'
            React.DOM.th null, 'Stock'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for document_type in @state.document_types
            React.createElement DocumentType, key: document_type.id, document_type: document_type, handleDeleteDocumentType: @deleteDocumentType, handleEditDocumentType: @updateDocumentType, form_data: @props.form_data
