CoreObject = require './core.object'
intravenous = require 'intravenous'

# Container for dependecy catalogs created with Intravenous
#
# @example How to create a Composer
#   composer = new Composer()
#
# @example How to register a class
#   composer
#     .from 'logging'
#     .register 'log', MyLoggerClass
#
# @example How to register a global value
#   composer
#     .from 'logging'
#     .register 'log', data: 'Hello'
#
# @example How to instantiate an instance
#   log = composer
#     .from 'logging'
#     .get 'log'
class Composer extends CoreObject
  # Construct a new Composer
  constructor: () ->
    super()
    @catalog = {}

  # Get or create a catalog
  # @param [String] key The name of the catalog
  from: (key = 'main') ->
    @catalog[key] = @catalog[key] || intravenous.create()

module.exports = Composer
