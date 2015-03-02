theme = require "./theme"
#get = require "../lib/get"

module.exports = (blessed, screen, Munepoke) ->
  article = blessed.List
    bg: theme.article.bg
    selectedFg: "light-blue"
    selectedBg: "light-black"
    keys: true
    vi: true
    top: 1
  screen.append article

  article.focus()

  Munepoke.buffer.on "change", (data) ->
    article.clearItems()
    data.forEach (item) ->
      article.add item.resolved_title
    screen.render()

#  get {count: 3}, (err, result) ->
#    result.forEach (item) ->
#      article.add item.resolved_title
#    screen.render()
