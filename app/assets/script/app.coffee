socket = io.connect '/'
socket.on 'connect', ->
  socket.send 'init'

  socket.on 'message', (msg) ->
    console.log msg