_ = require 'underscore'
Chaplin = require 'chaplin'
Chapgrid = require 'chapgrid'

class Cell extends Chaplin.View
  tagName: 'td'
  template: '<%- value %>'

  initialize: (options) ->
    throw new TypeError 'Chapgrid.Row::constructor options.model required' unless options.model?
    throw new TypeError 'Chapgrid.Row::constructor options.column required' unless options.column?

    unless options.column instanceof Chapgrid.get 'Column'
      options.column = Chapgrid.construct 'Columns', options.column
    _.extend this, _.pick options, 'column'

    return super

  getTemplateData: ->
    value: @model.get @column.get 'name'

  getTemplateFunction: ->
    _.template _.result this, 'template'

module.exports = Chapgrid.Cell = Cell
