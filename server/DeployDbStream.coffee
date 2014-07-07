class DeployDbStream
  constructor: (db, @key) ->
    @ws = db.createWriteStream { keyEncoding: 'utf8', valueEncoding: 'json' }
    @ws.on 'error', (err) ->
      console.error err

    @

  ##
  # Write the current @record to db
  save: (deploy) ->
    @ws.write { key: "#{@key}", value: deploy }
    @

  ## Close resources, etc
  # @api private
  end: ->
    @ws.end()

module.exports = DeployDbStream
