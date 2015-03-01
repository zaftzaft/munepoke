blessed = require "blessed"
require("../lib/blessed-unicode") blessed
theme = require "./theme"
LocalBuffer = require "./buffer"

# namespace
Munepoke = {}
Munepoke.buffer = new LocalBuffer



blessed.Node::query = (id) ->
  el = null
  @children.some (a, i) ->
    if a.id is id
      el = a
      true
    else
      false
  return el

screen = blessed.Screen()
screen.key ["q", "C-c"], -> process.exit 0

status = blessed.Box
  bg: theme.status.bg
  fg: theme.status.fg
  top: 0
  width: "100%"
  height: 1

screen.append status


require("./article") blessed, screen, Munepoke
require("./prompt") blessed, screen, Munepoke


screen.render()
