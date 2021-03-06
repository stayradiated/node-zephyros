When = require 'when'

preload = (attrs=[], models=[]) ->
  if attrs.length is 0 then return models

  attrs = if Array.isArray attrs then attrs else [attrs]
  models = if Array.isArray models then models else [models]
  promises = []

  for model in models
    for attr in attrs
      promises.push model[model._index[attr]]()

  When.all(promises).then ->
    if models.length is 1 then models[0] else models

preload.extend = (attrs...) ->
  preload attrs, this

module.exports = preload