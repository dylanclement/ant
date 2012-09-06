express = require 'express'
, routes = require './routes'
, user = require './routes/user'
, http = require 'http'
, path = require 'path'

app = express()

front_port = process.env.FRONT_HTTP_PORT ? 36180

app.configure ->
  app.set 'port', front_port
  app.set 'views', __dirname + '/views'
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


app.get '/', routes.index
app.get '/users', user.list

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get 'port'