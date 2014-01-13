Deploy = require '../../server/Deploy'
push = require '../fixtures/payload.json'
assert = require 'assert'

describe 'Deploy', ->
  deploy = null

  before ->
    deploy = new Deploy push

  describe 'genKey', ->
    it 'should generate a valid key', ->
      assert.equal "1363295520:octokitty/testing", deploy.genKey()

  describe 'toJSON', ->
    it 'should return a deploy object', ->
      d = deploy.toJSON()
      assert.ok 'push' of d
      assert.ok 'status' of d
      assert.ok 'completed' of d
      assert.ok 'messages' of d

  describe 'addMessage', ->
    afterEach ->
      deploy.deploy.messages = []

    it 'should add a message to deploy object', ->
      deploy.addMessage 'hi'
      assert.deepEqual {type: 'msg', text: 'hi'}, deploy.toJSON().messages[0]

    it 'should trigger the `addMessage` event', (done) ->
      deploy.once 'addMessage', ->
        done()
      deploy.addMessage 'hiAgain'

  describe 'addError', ->
    afterEach ->
      deploy.deploy.messages = []
      
    it 'should add the error message deploy object', ->
      deploy.addError 'error'
      assert.deepEqual {type: 'err', text: 'error'}, deploy.toJSON().messages[0]

    it 'should trigger the `addError` event', (done) ->
      deploy.once 'addError', ->
        done()

      deploy.addError 'hiError'

  describe 'success', ->
    before ->
      deploy.errors = false

    it 'should mark the deploy with `deployed`', ->
      deploy.success()
      assert.equal deploy.toJSON().status, "deployed"

    it 'should mark the deploy completed', ->
      deploy.success()
      assert.ok deploy.toJSON().completed

    it 'should trigger the end event', (done) ->
      deploy.once 'end', ->
        done()

      deploy.success()

    afterEach ->
      deploy.completed = null
      deploy.status = "running"

  describe 'fail', ->
    it 'should mark the deploy failed', ->
      deploy.fail()
      assert.equal deploy.toJSON().status, "failed"

    it 'should mark the deploy completed', ->
      deploy.fail()
      assert.ok deploy.toJSON().completed

    it 'should trigger the end event', (done) ->
      deploy.once 'end', ->
        done()

      deploy.fail()

    afterEach ->
      deploy.completed = null
      deploy.status = "running"