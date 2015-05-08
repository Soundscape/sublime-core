lib = require '../'

describe 'CoreObject test suite', ()  ->
  create = () -> new lib.CoreObject()

  it 'should construct an instance', () ->
    instance = create()
    expect(instance).not.toBeNull()
