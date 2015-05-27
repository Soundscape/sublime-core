CoreObject = require './core.object'
Stately = require 'stately.js'
When = require 'when'
_ = require 'lodash'
Err = require 'sublime-error'
Err.mixins.value()

# Class containing a Stately.js FSM
class Stateful extends CoreObject
  # Construct a Stateful object
  #
  # @example Create a Stateful object
  #
  #   states =
  #     engaged:
  #       greet: (name) ->
  #         console.log name
  #         @idle
  #     idle:
  #       wait: (instance, deferred) ->
  #         deferred.resolve()
  #         @setMachineState @engaged
  #
  #   fsm = new Stateful states, 'idle'
  #
  # @param [Object] states An object defining the available states and actions
  # @param [String] initialState The initial state for this instance
  constructor: (states, initialState) ->
    Err.Throw.isNullOrUndefined states, 'states'

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

  # Synchronously execute a method defined in the FSM
  #
  # @example Invoke a method synchronously
  #   result = fsm.apply 'greet', 'Joe'
  apply: () ->
    Err.Throw.isUnspecified arguments[0], 'method name'

    args = Array.prototype.slice.call arguments, 1
    @machine[arguments[0]].apply @, args
    @

  # Asynchronously execute a method defined in the FSM
  #
  # @example Invoke a method asynchronously
  #   promise = fsm.promise 'wait'
  promise: () ->
    Err.Throw.isUnspecified arguments[0], 'method name'

    dfr = When.defer()
    args = Array.prototype.slice.call arguments, 1
    @apply.apply @, [arguments[0], @, dfr].concat(args)
    dfr.promise

module.exports = Stateful
