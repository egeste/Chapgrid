Chaplin = require 'chaplin'
Chapgrid = require 'chapgrid'
require 'chapgrid/cell'

class Row extends Chaplin.CollectionView
  tagName: 'tr'
  itemView: Chapgrid.get 'Cell'

  initialize: (options) ->
    throw new TypeError 'Chapgrid.Row::constructor options.model required' unless options.model?
    throw new TypeError 'Chapgrid.Row::constructor options.columns required' unless options.columns?

    unless options.columns instanceof Chapgrid.get 'Columns'
      options.columns = Chapgrid.construct 'Columns', options.columns
    _.extend this, _.pick options, 'columns'
    @collection = @columns

    return super

  initItemView: (column) =>
    return new @itemView {
      @model
      column
      autoRender: false
    }

module.exports = Chapgrid.Row = Row
