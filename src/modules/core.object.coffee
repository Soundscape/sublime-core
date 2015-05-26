_ = require 'lodash'
node = require 'detect-node'
uuid = require 'portable-uuid'
events = require 'events'
moduleKeywords = ['extended', 'included']

# Base class for all Sublime objects
class CoreObject extends events.EventEmitter
  # Construct a new CoreObject
  #
  # @param [Object] options Configuration options to be associated with the instance
  constructor: (options = {}) ->
    super()

    @uuid = uuid()
    @node = node
    @options = _.extend {}, options

  # Extend the instance with an object
  #
  # @example Extend an instance
  #   new CoreObject().extend greet: () -> console.log 'Hi there!'
  #
  # @param [Object] obj The extension object
  extend: (obj = {}) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value
    obj.extended?.apply @
    @

  # Extend the prototype with an object
  #
  # @example Extend the prototype
  #   new CoreObject().include greet: () -> console.log 'Hi there!'
  #
  # @param [Object] obj The extension object
  include: (obj = {}) ->
    for key, value of obj when key not in moduleKeywords
      @::[key] = value
    obj.included?.apply @
    @

module.exports = CoreObject
