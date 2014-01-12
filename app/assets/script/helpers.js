Handlebars.registerHelper("badge", function(success) {
  var message = success == "false" ? "Error" : "Deployed";
  var highlight;
  if(success === "true")
    highlight = 'success';
  else if (success === "warning")
    highlight = 'warning';
  else
    highlight = 'danger';

  var result = '<span class="badge badge-'
    + highlight + '">' + message + '</span>';

  return new Handlebars.SafeString(result);
});

Handlebars.registerHelper("moment", function(time) {
  return new Handlebars.SafeString(moment.unix(time).fromNow());
});