express = require 'express'
, http = require 'http'
, routes = require './routes'
, neo4j = require 'neo4j'
, path = require 'path'

app = express()

membrPort = process.env.MEMBR_HTTP_PORT ? 36181

app.configure -> 
  app.set 'port', membrPort
  app.set 'views', "#{__dirname}/views"
  app.set 'view engine', 'jade'
  app.use express.favicon
  app.use express.logger 'dev'
  app.use express.bodyParser
  app.use express.methodOverride
  app.use app.router
  app.use require('less-middleware')( src: "#{__dirname}/public")
  app.use express.static(path.join(__dirname, 'public'))


app.configure 'development', ->
  app.use express.errorHandler

http.createServer(app).listen app.get('port'), ->
  db = new neo4j.GraphDatabase 'http://localhost:7474'
  routes app, db
  console.log "Express server listening on port #{app.get('port')}"
