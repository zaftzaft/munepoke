theme = require "./theme"

module.exports = (blessed, item) ->
  el = blessed.Box
    bg: theme.detail.bg
    fg: "white"
    width: "100%"
    height: "100%"
    top: 1

  status = blessed.Box
    bg: theme.detail.statusBg
    tags: true
    top: 0
    height: 1

  status.setContent(
    "{yellow-fg}#{item.favorite}{/yellow-fg}
    {green-fg}#{item.status}{/green-fg}"
  )

  title = blessed.Box
    bg: theme.detail.titleBg
    fg: theme.detail.titleFg
    top: 1
    height: 1
    content: "#{item.resolved_title}"


  url = blessed.Box
    bg: theme.detail.urlBg
    fg: theme.detail.urlFg
    top: 2
    height: 1
    content: "#{item.resolved_url}"


  excerpt = blessed.Box
    bg: theme.detail.excerptBg
    fg: theme.detail.excerptFg
    top: 5
    left: 2
    content: item.excerpt

  keymaps = [
    "a: Archive(Unread)"
    "f: Favorite"
    "dd: Delete"
    "t: Tag Mode"
    "o: Open"
    "c: Close"
  ]
  keymap = blessed.Box
    bg: theme.detail.bg
    bottom: 0
    height: 3
    content: "#{keymaps.join ", "}"


  el.append status
  el.append title
  el.append url
  el.append excerpt
  el.append keymap
  #el.setContent item.excerpt


  return el

