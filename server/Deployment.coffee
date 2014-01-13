spawn = require('child_process').spawn
Deploy = require './Deploy'
DeployDbStream = require './DeployDbStream'
DeployMessenger = require './DeployMessenger'

class Deployment
  constructor: (push, io, db) ->
    @deploy = new Deploy(push)
    @dbStream = new DeployDbStream(db, @deploy.key)
    @clientStream = new DeployMessenger(io, @deploy.key)

    @deploy.once 'init', (deploy) =>
      @dbStream.save deploy.toJSON()
      @clientStream.sendMessage deploy, 'deploy'

    @deploy.on 'addMessage', (message) =>
      @dbStream.save @deploy.toJSON()
      @clientStream.sendMessage message, 'message'

    @deploy.on 'addError', (err) =>
      @dbStream.save @deploy.toJSON()
      @clientStream.sendMessage err, 'message'

    @deploy.once 'end', (deploy) =>
      @dbStream.save(@deploy.toJSON()).end()
      @clientStream.sendMessage {
        status: @deploy.toJSON().status
        completed: @deploy.toJSON().completed
      }, 'end'

  run: ->
    @deploy.init()
    @child = spawn("./deploy.sh")
    @child.on 'close', (status) =>
      if status is 0
        @deploy.success()
      else
        @deploy.fail()

    @child.stdout.setEncoding 'utf8'
    @child.stderr.setEncoding 'utf8'

    @child.stdout.on 'data', (message) =>
      @deploy.addMessage message
    @child.stderr.on 'data', (error) =>
      @deploy.addError error

module.exports = Deployment
