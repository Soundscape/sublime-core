lib = require '../'

describe 'Observable test suite', ()  ->
  create = () ->
    new lib.Observable
      firstName: 'Shaun'
      lastName: 'Farrell'
      email: 'sfarrell.development@gmail.com'

  it 'should construct an instance', () ->
    instance = create()
    expect(instance).not.toBeNull()

  it 'should emit change events', (done) ->
    instance = create()
    expect(instance).not.toBeNull()

    instance.on 'change', () ->
      expect arguments[1].key
        .toBe 'email'
      done()

    instance.email = 'shaunfarrell@g.harvard.edu'
