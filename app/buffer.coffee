{EventEmitter} = require "events"

class LocalBuffer extends EventEmitter
  constructor: ->
    @localBuffer = []

  set: (data) =>
    @localBuffer = data
    @emit "change", @localBuffer


module.exports = LocalBuffer
