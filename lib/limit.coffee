table =
  key: {}
  user: {}

module.exports.update = (header) ->
  table.key.limit     = header["x-limit-key-limit"]
  table.key.remaining = header["x-limit-key-remaining"]
  table.key.reset     = header["x-limit-key-reset"]


  table.user.limit     = header["x-limit-user-limit"]
  table.user.remaining = header["x-limit-user-remaining"]
  table.user.reset     = header["x-limit-user-reset"]

module.exports.get = -> table
