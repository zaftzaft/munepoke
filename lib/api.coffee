fs      = require "fs"
request = require "request"
paths   = require "./paths"

API = {}

API.consumerKey = "38542-56e80c24a1f5a3924b017943"

API.getToken = do ->
  token = null
  raw = null
  return ->
    if token
      return token
    else
      raw = fs.readFileSync paths.token, "utf8"
      token = JSON.parse(raw).access_token

# Doc http://getpocket.com/developer/docs/v3/retrieve
API.get = (options, callback) ->
  options.consumer_key = API.consumerKey
  options.access_token = API.getToken()
  request.post
    url: "https://getpocket.com/v3/get"
    form: options
  , (err, resp, body) ->
    return callback err if err
    unless resp.statusCode is 200
      return callback new Error "
        #{resp.statusCode}:
        #{resp.headers["x-error-code"]}
        #{resp.headers["x-error"]}
      "
    callback null, JSON.parse(body), resp.headers


# Doc http://getpocket.com/developer/docs/v3/modify
API.send = (actions, callback) ->
  options =
    consumer_key: API.consumerKey
    access_token: API.getToken()
    actions: actions

  request.post
    url: "https://getpocket.com/v3/send"
    form: options
  , (err, resp, body) ->
    return callback err if err
    unless resp.statusCode is 200
      return callback new Error "
        #{resp.statusCode}:
        #{resp.headers["x-error-code"]}
        #{resp.headers["x-error"]}
      "
    callback null, JSON.parse(body), resp.headers


module.exports = API
