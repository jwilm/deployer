Handlebars.registerHelper "badge", (success) ->
  message = if success is "false"
    "Error"
  else
    "Deployed"

  highlight = if success is "true"
    'success'
  else if success is 'warning'
    'warning'
  else
    'danger'

  result = "<span class=\"badge badge-#{highlight}\">#{message}</span>"

  new Handlebars.SafeString result

Handlebars.registerHelper "moment", (time) ->
  new Handlebars.SafeString moment.unix(time).fromNow()
