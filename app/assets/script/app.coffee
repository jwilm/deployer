socket = io.connect '/'

deploys = window.deploys = {}
socket.on 'connect', ->
  socket.send 'init'

  socket.on 'message', (msg) ->
    msg = JSON.parse msg
    switch msg.type
      when 'deploy'
        addDeploy msg.value
      when 'init'
        addDeploy msg.value, 'init'
      when 'message'
        deploys[msg.key].addMessage msg.value
      when 'end'
        deploys[msg.key].updateCompletion msg

addDeploy = (deploy_info, init) ->
  deploy = new Deploy deploy_info
  deploys[deploy.key()] = deploy

  $el = $(deploy.renderSummary())
  $('.deployment-list').prepend($el)

  $el.on 'click', ->
    $('main').html deploy.render()

  unless init is 'init'
    $el.trigger 'click'

  deploy.save()

class Deploy
  constructor: (@info) ->
    @save()

  render: ->
    template.deployment(@info)

  renderSummary: ->
    template.deploySummary(@info)

  key: ->
    @info.key

  save: ->
    localStorage.setItem @key(), JSON.stringify(@info)

  addMessage: (msg) ->
    @info.messages.push(msg)
    
    if @isCurrentDetailView()
      $('.deployment-log').append("<p class=\"line\">#{msg.text}</p>")

    @save()

  isCurrentDetailView: ->
    $(".deployment-detail[data-deploy=\"#{@key()}\"]").length isnt 0

  updateCompletion: (completion) ->
    # Update internal hash
    @info.status = completion.value.status
    @info.completed = completion.value.completed

    # Update ui
    $(".deployment[data-deploy=\"#{completion.key}\"]")
    .replaceWith(@renderSummary())

    if @isCurrentDetailView()
      $('main').html @render()

    # Send to local storage
    @save()