theme = require "./theme"
openUrl = require "./open-url"

module.exports = (blessed, screen, Munepoke) ->
  article = blessed.List
    bg: theme.article.bg
    selectedFg: "light-blue"
    selectedBg: "light-black"
    keys: true
    vi: true
    top: 1
  screen.append article

  article.on "select", (item) ->
    openUrl item.data.resolved_url

  article.focus()

  Munepoke.buffer.on "change", (data) ->
    article.clearItems()
    data.forEach (item) ->
      article.add item.resolved_title
      article.items.slice(-1)[0].data = item
    screen.render()
