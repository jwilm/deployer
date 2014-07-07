Handlebars.registerHelper "badge", (status) ->

  highlight = if status is "deployed"
    'success'
  else if status is 'warning' or status is 'running'
    'warning'
  else
    'danger'

  result = "<span class=\"badge badge-#{highlight}\">#{status}</span>"

  new Handlebars.SafeString result

Handlebars.registerHelper "moment", (time) ->
  new Handlebars.SafeString moment.unix(time).fromNow()

Handlebars.registerHelper 'each', (context, options) ->
  ret = ''

  ret += options.fn(c) for c in context

  ret