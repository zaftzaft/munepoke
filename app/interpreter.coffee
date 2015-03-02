get = require "../lib/get"
module.exports = (Munepoke) ->
  Munepoke.interpreter = (cmd) ->
    if cmd is "ar"
      get {}, (err, data) -> Munepoke.buffer.set data


