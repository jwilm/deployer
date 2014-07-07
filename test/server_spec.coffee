payload = require './fixtures/payload.json'
assert = require 'assert'
server = require '../server/app'
request = require 'supertest'

describe 'deployer', ->
  app = null
  before ->
    app = server.create().server.listen()

  # describe 'webhook listener at POST /deploy', ->
  #   it 'should respond to valid requests', (done) ->
  #     request(app)
  #     .post('/deploy')
  #     .type('form')
  #     .send({payload: payload})
  #     .expect(200)
  #     .end (err) ->
  #       return done(err) if err
  #       done()

  describe 'root path', ->
    it 'should serve the application', (done) ->
      request(app)
      .get('/')
      .expect(200)
      .end (err, page) ->
        return done(err) if err
        assert.ok /Deployer/.test page.text
        done()