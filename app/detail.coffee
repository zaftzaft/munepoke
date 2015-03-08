module.exports = (blessed, item) ->
  el = blessed.Box
    bg: "blue"
    fg: "white"
    width: "80%"
    height: "50%"
    top: "center"
    left: "center"

  el.setContent item.excerpt


  return el

