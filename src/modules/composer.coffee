CoreObject = require './core.object'
intravenous = require 'intravenous'

class Composer extends CoreObject
  constructor: () ->
    super()
    @catalog = {}

  from: (key) ->
    @catalog[key] = @catalog[key] || intravenous.create()

module.exports = Composer
