API = require "./api"
limit = require "./limit"
cache = require "./cache"

get = (options, callback) ->
  API.get options, (err, result, headers) ->
    return callback err if err
    data = Object
      .keys result.list
      .map (key) -> result.list[key]
    limit.update headers
    callback null, data

latestTime = (callback) ->
  cache.get {}, (exi, data) ->
    callback data.reduce (big, item) ->
      Math.max(
        big,
        item.time_added, item.time_updated,
        item.time_read,item.time_favorited
      )
    , 0


module.exports = (options, callback, useCache = true) ->
  fetch = ->
    get options, (err, data) ->
      return callback err if err
      cache.set data
      callback null, data

  unless useCache
    return do fetch

  cache.get options, (exists, data) ->
    if exists
      callback null, data
    else
      do fetch

module.exports.latestTime = latestTime
