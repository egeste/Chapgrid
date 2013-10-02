Chapgrid = require 'chapgrid'

describe 'Chapgrid object', ->

  beforeEach -> Chapgrid.TestObject = sinon.stub()
  afterEach -> delete Chapgrid.TestObject

  describe 'get method', ->

    it 'should return Chapgrid[arguments[0]]', ->
      expect(Chapgrid.get 'TestObject').toBe Chapgrid.TestObject

  describe 'construct method', ->

    it 'should return an instance of Chapgrid[arguments[0]]', ->
      expect(Chapgrid.construct('TestObject') instanceof Chapgrid.TestObject).toBe true

    it 'should pass through any additional arguments to the constructor', ->
      Chapgrid.construct 'TestObject', 1, 2, 3
      expect(Chapgrid.TestObject).toHaveBeenCalledOnce()
      expect(Chapgrid.TestObject).toHaveBeenCalledWith 1, 2, 3
