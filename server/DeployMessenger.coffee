class DeployMessenger
  constructor: (@io, @key) ->

  sendMessage: (msg, type) ->
    message = {
      key: @key
      value: msg
      type: type
    }

    @io.sockets.send JSON.stringify message

module.exports = DeployMessenger