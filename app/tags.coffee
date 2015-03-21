get = require "../lib/get"

module.exports = (blessed, screen, Munepoke) ->
  tags = blessed.List
    bg: "light-black"
    selectedFg: "light-blue"
    selectedBg: "light-black"
    keys: true
    vi: true
    top: 1

  tags.hide()
  tags.key "c", ->
    tags.hide()
    screen.render()

  screen.append tags

  Munepoke.showTags = ->
    tags.clearItems()

    get {}, (err, data) ->
      list = {}
      data.forEach (item) ->
        if item.tags
          Object
            .keys item.tags
            .forEach (tag) -> list[tag] = 1

      tags.setItems Object.keys(list)

    tags.show()
    tags.focus()
    screen.render()
