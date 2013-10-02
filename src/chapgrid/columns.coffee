Chaplin = require 'chaplin'
Chapgrid = require 'chapgrid'
require 'chapgrid/column'

class Columns extends Chaplin.Collection
  model: Chapgrid.get 'Column'

module.exports = Chapgrid.Columns = Columns
