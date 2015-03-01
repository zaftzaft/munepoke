readline     = require "readline"
qs           = require "querystring"
request      = require "request"
api          = require "./api"
urlShortener = require "./url-shortener"

consumerKey = api.consumerKey

getAccessToken = (code, callback) ->
  request.post
    url: "https://getpocket.com/v3/oauth/authorize",
    form:
      consumer_key: consumerKey,
      code: code
  , (err, resp, body) ->
    return callback err if err
    unless resp.statusCode is 200
      return callback new Error "
        #{resp.statusCode}:
        #{resp.headers["x-error-code"]}
        #{resp.headers["x-error"]}
      "
    callback null, qs.parse body

module.exports = (callback) ->
  request.post
    url: "https://getpocket.com/v3/oauth/request"
    form:
      consumer_key: consumerKey
      redirect_uri: "javascript:window.close()"
  , (err, resp, body) ->
    throw err if err
    unless resp.statusCode is 200
      return callback new Error "
        #{resp.statusCode}:
        #{resp.headers["x-error"]}
        #{resp.headers["x-error-code"]}
      "
    code = body.split("=")[1]
    authUrl = "https://getpocket.com/auth/authorize?request_token=" + code
    console.log authUrl

    rl = readline.createInterface
      input:  process.stdin
      output: process.stdout
    rl.setPrompt "> "

    console.log "And press enter After authentication"
    console.log "s : Google URL Shortener"

    rl.prompt()
    rl.on "line", (cmd) ->
      if cmd is ""
        getAccessToken code, callback
        rl.close()
        return
      else if cmd is "s"
        urlShortener authUrl, (err, sUrl) ->
          return callback err if err
          console.log sUrl
          rl.prompt()
      else
        rl.prompt()
