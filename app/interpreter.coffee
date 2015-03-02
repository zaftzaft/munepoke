get = require "../lib/get"
module.exports = (Munepoke) ->
  Munepoke.interpreter = (cmd) ->
    cmd
      .split " "
      .forEach (c) ->
        switch c
          when "ar"
            get {}, (err, data) -> Munepoke.buffer.set data
          when "new" then Munepoke.buffer.sort "new"
          when "old" then Munepoke.buffer.sort "old"


