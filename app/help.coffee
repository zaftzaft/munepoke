fs = require "fs"
path = require "path"

module.exports = (blessed, screen, Munepoke) ->
  docPath = path.join __dirname, "../doc", "1.txt"

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
    fs.readFile docPath, "utf8", (err, data) ->
      if err
        help.setContent "document #{docPath} is Not Found."
      else
        help.setContent data
      screen.render()

    help.show()
    help.focus()
    screen.render()
