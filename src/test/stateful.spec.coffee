lib = require '../'

describe 'Stateful test suite', ()  ->
  create = () ->
    new lib.Stateful
      disconnected:
        connect: 'connected'
        foo: () ->
          return
      connected:
        disconnect: 'disconnected'

  it 'should construct an instance', () ->
    instance = create()
    expect(instance).not.toBeNull()

  it 'should default to disconnected', () ->
    instance = create()
    expect(instance).not.toBeNull()
    expect instance.state()
      .toBe 'disconnected'

  it 'should be able to connect and disconnect', () ->
    instance = create()
    expect(instance).not.toBeNull()

    instance.apply 'connect'
    expect instance.state()
      .toBe 'connected'

    instance.apply 'disconnect'
    expect instance.state()
      .toBe 'disconnected'

  it 'should emit state transitions', (done) ->
    instance = create()
    expect(instance).not.toBeNull()

    instance.on 'connected', () ->
      expect instance.state()
        .toBe 'connected'
      done()

    instance.apply 'connect'

  it 'should emit state events', (done) ->
    instance = create()
    expect(instance).not.toBeNull()

    instance.on 'foo', () ->
      expect instance.state()
        .toBe 'disconnected'
      done()

    instance.apply 'foo'
