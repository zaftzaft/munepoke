path = require "path"

expand = (p) -> p.replace /^~/, process.env.HOME

base = expand "~/.munepoke"
token = path.join base, "token"
article = path.join base, "article.json"

module.exports =
  base:    base
  token:   token
  article: article
  expand:  expand
