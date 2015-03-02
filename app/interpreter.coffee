get = require "../lib/get"

cmap = {}
match = (cmd, str) ->
  unless cmap[cmd]
    [main, sub] = cmd.split "#"
    opt = []
    for i in [0..sub.length]
      opt.push main + sub.slice 0, i

    cmap[cmd] = new RegExp "^(#{opt.join "|"})$"

  cmap[cmd].test str

module.exports = (Munepoke) ->
  Munepoke.interpreter = (cmd) ->
    args = cmd.split " "
    i = 0
    loop
      c = args[i]
      if match "ar#chive", c
        get {}, (err, data) -> Munepoke.buffer.set data

      else if match "ne#w", c
        Munepoke.buffer.sort "new"

      else if match "ol#d", c
        Munepoke.buffer.sort "old"

      break if ++i > args.length

