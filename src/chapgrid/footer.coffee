Chaplin = require 'chaplin'
Chapgrid = require 'chapgrid'

class Footer extends Chaplin.View
  tagName: 'tfoot'

  render: -> this

module.exports = Chapgrid.Footer = Footer
