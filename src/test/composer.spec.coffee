lib = require '../'

describe 'Composer test suite', ()  ->
  instance = new lib.Composer()

  it 'should construct an instance', () ->
    expect(instance).not.toBeNull()

  it 'should get a container', () ->
    res = instance.from 'test'
    expect(res).not.toBeNull()
    expect(instance.catalog.test).not.toBeNull()

  it 'should register a global', () ->
    container = instance.from 'test'
    expect(container).not.toBeNull()

    container.register 'myGlobal', value: 'hello'
    expect(container.get 'myGlobal').not.toBeNull()

  it 'should register a class', () ->
    container = instance.from 'test'
    expect(container).not.toBeNull()

    lib.Observable.$inject = ['myGlobal']
    container.register 'myType', lib.Observable
    expect(container.get 'myType').not.toBeNull()
