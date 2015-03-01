fs = require "fs"
paths = require "./paths"

class Cache
  fp: paths.article

  constructor: ->
    @flowFn = []
    @ready = false
    fs.readFile @fp, "utf8", (err, data) =>
      if err
        @collection = []
        @ready = true
      else
        @collection = JSON.parse data
        @ready = true
      @run()

  save: =>
    fs.writeFile @fp, JSON.stringify @collection

  add: (item) =>
    #TODO same check
    @collection.push item

  get: (options, callback) =>
    @flow => callback true, @collection

  set: (data) =>
    data.forEach (item) => @add item
    @save()

  flow: (callback) =>
    if @ready
      callback()
    else
      @flowFn.push callback

  run: =>
    @flowFn.forEach (cb) -> cb()


module.exports = new Cache
