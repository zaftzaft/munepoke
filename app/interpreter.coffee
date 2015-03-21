get = require "../lib/get"
limit = require "../lib/limit"

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

    nextStr = ->
      str = ""
      do f = (t = 0) ->
        str += " " if t
        s = args[++i]
        str += s
        f 1 if /^"|^'|\\$/.test s
      return str.replace /"|'|\\/, ""

    loop
      c = args[i]

      if /^(ge|get)!$/.test c
        get.latestTime (time) ->
          get {
            state: "all"
            count: 10
            since: time + 1
            detailType: "complete"
          }, (err, data) ->
            Munepoke.buffer.add data
            Munepoke.log limit.get().user.remaining
          , false

        # scan cmd -> create query
        # get {query},, false
        break

      else if match "sy#nc", c
        i = 0
        do f = ->
          get {
            state: "all"
            count: 500
            offset: i++
            detailType: "complete"
          }, (err, data) ->
            if data.length is 0
              Munepoke.log "end"
              return
            Munepoke.buffer.add data
            Munepoke.log "API Limit #{limit.get().user.remaining} len #{data.length}"
            setTimeout f, 1000
          , false
        break

      else if match "ge#t", c
        get {}, (err, data) -> Munepoke.buffer.set data

      else if match "un#read", c
        Munepoke.buffer.filter status: "0"
        Munepoke.buffer.push()

      else if match "ar#chive", c
        Munepoke.buffer.filter status: "1"
        Munepoke.buffer.push()

      else if match "im#age", c
        Munepoke.buffer.filter has_image: true, true
        Munepoke.buffer.push()

      else if match "-im#age", c
        Munepoke.buffer.filter has_image: false, true
        Munepoke.buffer.push()

      else if match "vi#deo", c
        Munepoke.buffer.filter has_video: "1"
        Munepoke.buffer.push()

      else if match "fa#vorite", c
        Munepoke.buffer.filter favorite: "1"
        Munepoke.buffer.push()

      else if match "-fa#vorite", c
        Munepoke.buffer.filter favorite: "0"
        Munepoke.buffer.push()

      else if match "ti#tle", c
        Munepoke.buffer.searchTitle nextStr()
        Munepoke.buffer.push()

      else if match "-ti#tle", c
        Munepoke.buffer.filter resolved_title: ""
        Munepoke.buffer.push()

      else if match "ta#g", c
        Munepoke.buffer.searchTag nextStr()
        Munepoke.buffer.push()

      else if match "ne#w", c
        Munepoke.buffer.sort "new"

      else if match "ol#d", c
        Munepoke.buffer.sort "old"

      else if match "list-ta#gs", c
        Munepoke.showTags()

      else if match "cl#ear", c
        Munepoke.buffer.emit "clear"

      else if match "fo#cus", c
        Munepoke.buffer.emit "focus"

      else if match "h#elp", c
        Munepoke.showHelp()


      break if ++i > args.length

