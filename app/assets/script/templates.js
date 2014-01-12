this["template"] = this["template"] || {};

this["template"]["deploySummary"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, options, functionType="function", escapeExpression=this.escapeExpression, helperMissing=helpers.helperMissing;


  buffer += "<li class=\"deployment\">\n  <div class=\"commit-message\">";
  if (stack1 = helpers.message) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = (depth0 && depth0.message); stack1 = typeof stack1 === functionType ? stack1.call(depth0, {hash:{},data:data}) : stack1; }
  buffer += escapeExpression(stack1)
    + "</div>\n  \n  <span class=\"commit-time\">";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.moment || (depth0 && depth0.moment)),stack1 ? stack1.call(depth0, (depth0 && depth0.time), options) : helperMissing.call(depth0, "moment", (depth0 && depth0.time), options)))
    + "</span>\n  ";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.badge || (depth0 && depth0.badge)),stack1 ? stack1.call(depth0, (depth0 && depth0.success), options) : helperMissing.call(depth0, "badge", (depth0 && depth0.success), options)))
    + "\n</li>";
  return buffer;
  });

this["template"]["deployment"] = Handlebars.template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, options, functionType="function", escapeExpression=this.escapeExpression, helperMissing=helpers.helperMissing;


  buffer += "<h1>";
  if (stack1 = helpers.message) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = (depth0 && depth0.message); stack1 = typeof stack1 === functionType ? stack1.call(depth0, {hash:{},data:data}) : stack1; }
  buffer += escapeExpression(stack1)
    + "</h1>\n\n<dl>\n  <dt>Author</dt>\n  <dd>";
  if (stack1 = helpers.author) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = (depth0 && depth0.author); stack1 = typeof stack1 === functionType ? stack1.call(depth0, {hash:{},data:data}) : stack1; }
  buffer += escapeExpression(stack1)
    + "</dd>\n\n  <br>\n\n  <dt>SHA</dt>\n  <dd><a href=\"";
  if (stack1 = helpers.url) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = (depth0 && depth0.url); stack1 = typeof stack1 === functionType ? stack1.call(depth0, {hash:{},data:data}) : stack1; }
  buffer += escapeExpression(stack1)
    + "\">";
  if (stack1 = helpers.sha) { stack1 = stack1.call(depth0, {hash:{},data:data}); }
  else { stack1 = (depth0 && depth0.sha); stack1 = typeof stack1 === functionType ? stack1.call(depth0, {hash:{},data:data}) : stack1; }
  buffer += escapeExpression(stack1)
    + "</a></dd>\n\n  <br>\n\n  <dt>Time</dt>\n  <dd>";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.moment || (depth0 && depth0.moment)),stack1 ? stack1.call(depth0, (depth0 && depth0.time), options) : helperMissing.call(depth0, "moment", (depth0 && depth0.time), options)))
    + "</dd>\n\n  <br>\n\n  <dt>Status</dt>\n  <dd>";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.badge || (depth0 && depth0.badge)),stack1 ? stack1.call(depth0, (depth0 && depth0.success), options) : helperMissing.call(depth0, "badge", (depth0 && depth0.success), options)))
    + "</dd>\n</dl>\n\n<h2>Deployment Log</h2>\n\n<div class=\"deployment-log\">\n  <p class=\"line\">Deployer running `deploy_v0.1.8.sh`...</p>\n  <p class=\"line\">git fetch origin</p>\n  <p class=\"line\">remote: Counting objects: 8, done.</p>\n  <p class=\"line\">remote: Compressing objects: 100% (8/8), done.</p>\n  <p class=\"line\">remote: Total 8 (delta 0), reused 8 (delta 0)</p>\n  <p class=\"line\">Unpacking objects: 100% (8/8), done.</p>\n  <p class=\"line\">From https://github.com/jwilm/deployer</p>\n  <p class=\"line\">&nbsp;&nbsp;&nbsp;12aae1e..0293a82&nbsp;&nbsp;master&nbsp;&nbsp;&nbsp;&nbsp;-> origin/master</p>\n</div>";
  return buffer;
  });