EventEmitter = require('events').EventEmitter

class Deploy extends EventEmitter
  constructor: (push) ->
    @deploy = {
      push: push
      status: "running"
      completed: false
      messages: []
    }

    @errors = false

    @deploy.key = @key = @genKey()

  ##
  # Generate key for db
  genKey: ->
    [
      "#{@deploy.push.repository.pushed_at}:"
      "#{@deploy.push.repository.owner.name}/"
      "#{@deploy.push.repository.name}"
    ].join('')

  ##
  # Add message to the deploy record
  #
  addMessage: (msg) ->
    message = { type: "msg", text: msg }
    @deploy.messages.push message
    @emit 'addMessage', message

  addError: (err) ->
    @errors = true
    error = { type: "err", text: err }
    @deploy.messages.push error
    @emit 'addError', error

  init: ->
    @emit 'init', @

  success: ->
    @deploy.status = if @errors then "warning" else "deployed"
    @end()

  fail: ->
    @deploy.status = "failed"
    @end()

  end: ->
    @deploy.completed = Math.round (Date.now() / 1000)
    @emit 'end', @toJSON

  toJSON: ->
    @deploy

module.exports = Deploy