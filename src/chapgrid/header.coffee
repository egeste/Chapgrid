_ = require 'underscore'
Chaplin = require 'chaplin'
Chapgrid = require 'chapgrid'
require 'chapgrid/row'

class Header extends Chaplin.View
  tagName: 'thead'

  initialize: (options) ->
    @createSubViews _.extend {}, options, { container: @el }

  createSubViews: (options) ->
    @subview 'row', Chapgrid.construct 'Row', options

  render: ->
    @subviewsByName.row.render()
    return this

module.exports = Chapgrid.Header = Header
