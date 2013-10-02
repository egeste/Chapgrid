_ = require 'underscore'
Chaplin = require 'chaplin'
Chapgrid = require 'chapgrid'
require 'chapgrid/header'
require 'chapgrid/body'
require 'chapgrid/footer'
require 'chapgrid/columns'

class Grid extends Chaplin.View
  tagName: 'table'
  className: 'chapgrid'

  # header: 'Header'
  header: null
  body: 'Body'
  footer: null

  initialize: (options) ->
    throw new TypeError 'Chapgrid.Grid::constructor options.columns required' unless options.columns?
    throw new TypeError 'Chapgrid.Grid::constructor options.collection required' unless options.collection?

    unless options.columns instanceof Chapgrid.get 'Columns'
      options.columns = Chapgrid.construct 'Columns', options.columns
    _.extend this, _.pick options, 'body', 'header', 'footer', 'columns'

    strippedOptions = _.omit options,
      'container', 'region', 'autoRender'
      'el', 'attributes', 'className', 'tagName', 'events'
      'header', 'body', 'footer'
    subviewOptions = _.extend strippedOptions, { container: @el, autoRender: false }
    @createSubViews subviewOptions
    @listenTo @columns, 'reset', -> @createSubViews subviewOptions

    return super

  createSubViews: (options) ->
    # @subview 'header', Chapgrid.construct @header, options if @header
    @subview 'body', Chapgrid.construct @body, options if @body
    # @subview 'footer', Chapgrid.construct @footer, options if @footer

  render: ->
    @$el.empty()
    @subviewsByName.header? and @subviewsByName.header.render()
    @subviewsByName.body? and @subviewsByName.body.render()
    @subviewsByName.footer? and @subviewsByName.footer.render()
    return this

module.exports = Chapgrid.Grid = Grid
