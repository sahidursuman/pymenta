@Categories = React.createClass
  getInitialState: ->
    items: @props.data
  getDefaultProps: ->
    items: []
  addItem: (item) ->
    items = React.addons.update(@state.items, { $push: [item] })
    @setState items: items
  deleteItem: (item) ->
    index = @state.items.indexOf item
    items = React.addons.update(@state.items, { $splice: [[index, 1]] })
    @replaceState items: items
  updateItem: (item, data) ->
    index = @state.items.indexOf item
    items = React.addons.update(@state.items, { $splice: [[index, 1, data]] })
    @replaceState items: items
  render: ->
    React.DOM.div
      className: 'categories'
      React.DOM.h1
        className: 'title'
        @props.page_header
      React.createElement CategoryForm, handleNewCategory: @addItem, form_data: @props.form_data
      React.DOM.hr null
      React.DOM.table
        className: 'table table-striped'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Code'
            React.DOM.th null, 'Description'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for item in @state.items
            React.createElement Category, key: item.id, category: item, handleDeleteCategory: @deleteItem, handleEditCategory: @updateItem, form_data: @props.form_data
