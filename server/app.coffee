express = require 'express'
path = require 'path'
fs = require 'fs'
Bluebird = require 'bluebird'
socketio = require 'socket.io'
http = require 'http'
levelup = require 'levelup'

db = levelup('./deployer.db')

join = path.join
normalize = path.normalize

read = (path) ->
  deferred = Bluebird.defer()
  fs.readFile path, {encoding: 'utf8'}, (err, out) ->
    return deferred.reject(err) if err
    deferred.resolve(out)

  deferred.promise

index = normalize(join(__dirname, '..', 'app', 'index.html'))

exports.create = ->
  cache = null
  app = express()
  app.server = http.createServer(app)
  io = socketio.listen(app.server)

  app.configure 'development', ->
    app.use express.logger()

  app.configure ->
    app.use express.json()
    app.use express.urlencoded()
    app.use '/assets', express.static normalize join(__dirname, '..', 'public/')
    app.use app.router
    app.use express.errorHandler()

  app.get '/', (req, res, next) ->
    if app.env is 'production'
      return res.send cache if cache

    read(index).then (html) ->
      cache = html
      res.send html
    .catch (err) ->
      return next(err)

  app.get '/stats', (req, res, next) ->
    res.send('Stats not implemented')

  app.post '/deploy', (req, res, next) ->
    return res.send(200) if req.body.payload
    next new Error "Not implemented"

  io.on 'connection', (socket) ->
    db.createReadStream()
    .on 'data', (data) ->
      socket.send data
    .on 'error', (err) ->
      console.error err

  app
