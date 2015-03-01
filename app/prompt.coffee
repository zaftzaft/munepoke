theme = require "./theme"

module.exports = (blessed, screen) ->
  showPrompt = ->
    promptLine.show()
    prompt.show()
  
  hidePrompt = ->
    promptLine.hide()
    prompt.hide()
  
  promptLine = blessed.Box
    bg: theme.promptLine.bg
    fg: theme.promptLine.fg
    height: 1
    bottom: 0
    width: 1
    content: ":"
  promptLine.hide()
  screen.append promptLine
  
  prompt = blessed.Textbox
    #key: true
    #vi: true
    bg: theme.prompt.bg
    fg: theme.prompt.fg
    left: 1
    bottom: 0
    height: 1
  prompt.hide()
  screen.append prompt

  prompt.on "cancel", ->
    prompt.clearValue()
    hidePrompt()
    screen.render()

  screen.key ":", ->
    showPrompt()
    prompt.readInput()
    screen.render()
