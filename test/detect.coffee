# Modules
express = require 'express'
mobile  = require '../lib/detectmobilebrowsers'
request = require 'request'

# Tests
describe 'Client', () ->
 
  # Server for "domain.com"
  app = express()
  app.configure () ->
    app.use mobile.redirect 'http://localhost:3001'
    app.get '/', (req, res) ->
      res.json {is_mobile: false}
  app.listen 3000

  # Server for m.domain.com
  app = express()
  app.configure () ->
    app.use mobile.is_mobile()
    app.get '/', (req, res) ->
      res.json {is_mobile: req.is_mobile}
  app.listen 3001

  it 'is not mobile to domain.com', (done) ->
    request 'http://localhost:3000', (err, res, body) ->
      return done err if err
      obj = JSON.parse body
      obj.should.have.property 'is_mobile'
      obj.is_mobile.should.be.equal false
      done()

  it 'is mobile to domain.com', (done) ->
    request {
      url: 'http://localhost:3000'
      headers:
        'user-agent': 'iphone'
    }, (err, res, body) ->
      return done err if err
      obj = JSON.parse body
      obj.should.have.property 'is_mobile'
      obj.is_mobile.should.be.equal true
      done()

  it 'is mobile to m.domain.com', (done) ->
    request {
      url: 'http://localhost:3001'
      headers:
        'user-agent': 'iphone'
    }, (err, res, body) ->
      return done err if err
      obj = JSON.parse body
      obj.should.have.property 'is_mobile'
      obj.is_mobile.should.be.equal true
      done()

