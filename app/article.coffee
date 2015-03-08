theme = require "./theme"
openUrl = require "./open-url"
detail = require "./detail"

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
    article.hide()
    Munepoke.clean()
    screen.render()

    el = detail blessed, item.data
    screen.append el
    screen.render()

    el.focus()
    el.key "c", ->
      screen.remove el
      Munepoke.clean()
      screen.render()
      article.show()
      article.focus()
      screen.render()
    #openUrl item.data.resolved_url

  article.focus()

  Munepoke.buffer.on "change", (data) ->
    article.clearItems()
    article.hide()
    Munepoke.clean()
    screen.render()
    data.forEach (item) ->
      article.add item.resolved_title
      article.items.slice(-1)[0].data = item
    article.show()
    screen.render()

  Munepoke.buffer.on "clear", ->
    article.clearItems()
    article.hide()

    Munepoke.clean()

    screen.render()
    article.show()
    screen.render()
