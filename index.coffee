fs = require "fs"
path = require "path"
auth = require "./lib/auth"
paths = require "./lib/paths"

fs.mkdirSync paths.base unless fs.existsSync paths.base
unless fs.existsSync paths.article
  fs.writeFileSync paths.article, "[]"

fs.exists paths.token, (exists) ->
  launcher = -> require "./app/app"

  unless exists
    auth (err, result) ->
      throw err if err
      fs.writeFile paths.token, JSON.stringify(result), ->
        do launcher

  else
    do launcher
