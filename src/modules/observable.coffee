CoreObject = require './core.object'
property = require 'property.js'

class Observable extends CoreObject
  constructor: (values, options) ->
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
