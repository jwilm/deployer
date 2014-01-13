express = require 'express'
path = require 'path'
fs = require 'fs'
Bluebird = require 'bluebird'
socketio = require 'socket.io'
http = require 'http'
levelup = require 'levelup'
Deployment = require './Deployment'

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
    io.disable 'log'

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
    push = JSON.parse(req.body.payload)
    if push
      deploy = new Deployment push, io, db
      deploy.run()
      return res.send(200)
    else
      console.error 'push error'
      console.error req.body
      next new Error "Invalid Request"

  io.on 'connection', (socket) ->
    db.createReadStream({ valueEncoding: 'json' })
    .on 'data', (data) ->
      data.type = 'init'
      socket.send JSON.stringify data
    .on 'error', (err) ->
      console.error err

  app
