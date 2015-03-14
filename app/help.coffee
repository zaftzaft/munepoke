fs = require "fs"
path = require "path"

module.exports = (blessed, screen, Munepoke) ->
  docPath = path.join __dirname, "../doc", "1.txt"
  cache = null

  help = blessed.Box
    bg: "light-black"
    scrollable: true
    alwaysScroll: true
    keys: true
    vi: true

  help.hide()
  help.key "c", ->
    help.hide()
    screen.render()

  screen.append help

  Munepoke.showHelp = ->
    if cache
      help.setContent cache

    else
      fs.readFile docPath, "utf8", (err, data) ->
        if err
          help.setContent "document #{docPath} is Not Found."
        else
          cache = data
          help.setContent data
        screen.render()

    help.show()
    help.focus()
    screen.render()
