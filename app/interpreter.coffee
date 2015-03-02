get = require "../lib/get"

cmap = {}
match = (cmd, str) ->
  unless cmap[cmd]
    [main, sub] = cmd.split "#"
    opt = [main]
    if sub
      for i in [1..sub.length]
        opt.push main + sub.slice 0, i

    cmap[cmd] = new RegExp "^(#{opt.join "|"})$"

  cmap[cmd].test str

module.exports = (Munepoke) ->
  Munepoke.interpreter = (cmd) ->
    args = cmd.split " "
    i = 0
    loop
      c = args[i]

      if /^(ge|get)!$/.test c
        # scan cmd -> create query
        # get {query},, false
        break

      else if match "ge#t", c
      else if match "un#read", c
      else if match "im#age", c
      else if match "vi#deo", c
      else if match "fa#vorite", c
        Munepoke.buffer.filter favorite: "1"
        Munepoke.buffer.push()
      else if match "ti#tle", c
      else if match "ta#g", c

      else if match "ar#chive", c
        get {}, (err, data) -> Munepoke.buffer.set data

      else if match "ne#w", c
        Munepoke.buffer.sort "new"

      else if match "ol#d", c
        Munepoke.buffer.sort "old"

      break if ++i > args.length

