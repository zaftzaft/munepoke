fs = require "fs"
paths = require "./paths"

class Cache
  fp: paths.article

  constructor: ->
    @keys = []
    @flowFn = []
    @collection = []
    @ready = false
    fs.readFile @fp, "utf8", (err, data) =>
      if err
        @collection = []
        @ready = true
      else
        JSON
          .parse data
          .forEach (d) => @add d
        @ready = true
      @run()

  save: =>
    fs.writeFile @fp, JSON.stringify @collection

  add: (item) =>
    #TODO same check
    #if ~@keys.indexOf item.item_id
    # orgItem = @getById item.item_id
    # x = @check orgItem, item
    # y = @check item, orgItem
    # if x is y
    #   same
    # else if x
    #   update
    # else trash
    @keys.push item.item_id
    @collection.push item

  get: (options, callback) =>
    @flow => callback true, @collection

  getById: (id) =>
    item for item in @collection when item.item_id is id
    null

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

  check: (item, item2) =>
    if item.time_added < item2.time_added or 
      item.time_updated < item2.time_updated or 
      item.time_read < item2.time_read or 
      item.time_favorited < item2.time_favorited
      then 1 else 0

module.exports = new Cache
