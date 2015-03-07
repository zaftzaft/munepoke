{exec} = require "child_process"

module.exports = (url) ->
  exec "chromium #{url}"
