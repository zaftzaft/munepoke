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
        get {count: 10}, (err, data) ->
          Munepoke.buffer.set data
        , false
        # scan cmd -> create query
        # get {query},, false
        break

      else if match "ge#t", c
        get {}, (err, data) -> Munepoke.buffer.set data

      else if match "un#read", c
      else if match "im#age", c
      else if match "vi#deo", c
      else if match "fa#vorite", c
        Munepoke.buffer.filter favorite: "1"
        Munepoke.buffer.push()

      else if match "ti#tle", c
        str = ""

        do f = (t = 0) ->
          str += " " if t
          s = args[++i]
          str += s
          f 1 if /^"|^'|\\$/. test s

        Munepoke.buffer.searchTitle str.replace /"|'|\\/, ""
        Munepoke.buffer.push()


      else if match "ta#g", c

      else if match "ar#chive", c
        get {}, (err, data) -> Munepoke.buffer.set data

      else if match "ne#w", c
        Munepoke.buffer.sort "new"

      else if match "ol#d", c
        Munepoke.buffer.sort "old"

      else if match "cl#ear", c
        Munepoke.buffer.emit "clear"

      break if ++i > args.length

