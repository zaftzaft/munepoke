{EventEmitter} = require "events"

class LocalBuffer extends EventEmitter
  constructor: ->
    @localBuffer = []

  set: (data) =>
    @localBuffer = data
    @emit "change", @localBuffer

  sort: (compare) =>
    newOrder = (a, b) -> b.time_updated - a.time_updated 
    oldOrder = (a, b) -> a.time_updated - b.time_updated 
    @localBuffer.sort (if compare is "old" then oldOrder else newOrder)
    @emit "change", @localBuffer

  filter: (query) =>


module.exports = LocalBuffer
