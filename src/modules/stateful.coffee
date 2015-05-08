CoreObject = require './core.object'
Stately = require 'stately.js'
When = require 'when'
_ = require 'lodash'

class Stateful extends CoreObject
  constructor: (states, initialState) ->
    super()

    @machine = Stately.machine states, initialState
    @state = () -> @machine.getMachineState()

    @machine.bind ((e, oldState, newState) ->
      args =
        event: e
        oldState: oldState
        newState: newState

      @emit e, @, args

      if oldState != newState
        @emit newState, @, args
    ).bind @

  apply: () ->
    args = Array.prototype.slice.call arguments, 1
    @machine[arguments[0]].apply @, args
    @

  promise: () ->
    dfr = When.defer()
    args = Array.prototype.slice.call arguments, 1
    @apply.apply @, [arguments[0], @, dfr].concat(args)
    dfr.promise

module.exports = Stateful
