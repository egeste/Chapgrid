_ = require 'underscore'
Chaplin = require 'chaplin'
Chapgrid = require 'chapgrid'
require 'chapgrid/row'

class Body extends Chaplin.CollectionView
  tagName: 'tbody'
  itemView: Chapgrid.get 'Row'

  initialize: (options) ->
    throw new TypeError 'Chapgrid.Body::constructor options.columns required' unless options.columns?
    throw new TypeError 'Chapgrid.Body::constructor options.collection required' unless options.collection?

    unless options.columns instanceof Chapgrid.get 'Columns'
      options.columns = Chapgrid.construct 'Columns', options.columns
    _.extend this, _.pick options, 'columns'

    return super

  initItemView: (model) =>
    return new @itemView {
      model
      @columns
      autoRender: false
    }

module.exports = Chapgrid.Body = Body
