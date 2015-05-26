CoreObject = require './core.object'
property = require 'property.js'

# Simple class that emits a 'change' event when its properties change
class Observable extends CoreObject
  # Construct a new Observable
  #
  # @example Listen for changes
  #   myObj = new Observable name: 'John Smith', email: ''
  #   myObj.on 'change', (sender, args) -> console.log args
  #   myObj.email = 'john.smith@mail.com'
  #
  # @param [Object] values The properties to observe
  # @param [Object] options Configuration options to be associated with the instance
  constructor: (values = {}, options = {}) ->
    super options

    property.mixin @
    Object.keys values
      .forEach (key) ->
        @.addProperty key, values[key]
          .observe (oldVal, newVal) ->
            if oldVal != newVal
              @.emit 'change', @,
                key: key
                oldValue: oldVal
                newValue: newVal
      , @

module.exports = Observable
