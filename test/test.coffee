pongular = require('pongular').pongular
global.mocha = true
mocks = require 'pongular/lib/pongular-mocks'

sinon = require 'sinon'

chai = require 'chai'
chai.use require('chai-as-promised')
chai.use require('sinon-chai')
chai.should()

if !pongular.isModuleDefined 'pong-mark'
  require '../index.coffee' #sut

describe 'configuredPostmark creates... a configured postmark client instance', ->

  beforeEach ->
    mocks.module 'pong-mark'
    mocks.module(
      postmark: sinon.spy()
      postmarkConfig:
        apiKey: '2134'
      )

  it 'returns an initialized postmark, using postmarkConfig.apiKey', (done)->
    mocks.inject (configuredPostmark, postmark, postmarkConfig)->
      postmark.calledWith(postmarkConfig.apiKey).should.be.true
      done()

describe '$mailer sends emails', ->
  beforeEach ->
    mocks.module 'pong-mark'
    mocks.module(
      configuredPostmark:
        send: sinon.stub().callsArgWith(1, false, true)
      )

  it 'calls postmark with the attrs', (done)->
    mocks.inject ($mailer, configuredPostmark)->
      result = $mailer({})
      configuredPostmark.send.calledWith({}).should.be.true
      result.then done, done

  it 'fulfills a promise if the postmark call is successful', (done)->
    mocks.inject ($mailer)->
      $mailer({}).should.be.fulfilled.notify(done)

  it 'rejects a promise if the postmark call is unsuccessful', (done)->
    mocks.inject ($mailer, configuredPostmark)->
      configuredPostmark.send = sinon.stub().callsArgWith(1,true,false)
      $mailer({}).should.be.rejected.notify(done)
