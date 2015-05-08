_ = require 'lodash'
node = require 'detect-node'
uuid = require 'portable-uuid'
events = require 'events'
moduleKeywords = ['extended', 'included']

class CoreObject extends events.EventEmitter
  constructor: (options) ->
    super()

    @uuid = uuid()
    @node = node
    @options = _.extend {}, options

  extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value
    obj.extended?.apply @
    @

  include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @::[key] = value
    obj.included?.apply @
    @

module.exports = CoreObject
