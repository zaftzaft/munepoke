{EventEmitter} = require "events"

class LocalBuffer extends EventEmitter
  constructor: ->
    @localBuffer = []

  set: (data) =>
    @localBuffer = data
    @push()
    #@emit "change", @localBuffer

  add: (data) =>
    @localBuffer = [].concat @localBuffer, data

  sort: (compare) =>
    newOrder = (a, b) -> b.time_updated - a.time_updated 
    oldOrder = (a, b) -> a.time_updated - b.time_updated 
    @localBuffer.sort (if compare is "old" then oldOrder else newOrder)
    #@emit "change", @localBuffer
    @push()

  filter: (query, bool = false) =>
    qk = Object.keys query
    l = qk.length
    @localBuffer = @localBuffer.filter (buf) ->
      qk.every (k) ->
        return Boolean buf[k] is query[k] if bool
        buf[k] is query[k]

  searchTitle: (str) ->
    exp = new RegExp str
    @localBuffer = @localBuffer.filter (buf) ->
      exp.test buf.resolved_title

  push: -> @emit "change", @localBuffer


module.exports = LocalBuffer
