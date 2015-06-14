pongular = require('pongular').pongular
# global.jasmine = true
mocks = require 'pongular/lib/pongular-mocks'
# # should = require 'should'
# # shouldPromised = require 'should-promised'
# # sinon = require 'sinon'

require '../index.coffee'

VALID =
  From: "volunteer@sparks.network" # inject from-address
  To: "carl.5151f731@mailosaur.in"
  ReplyTo: "neil.5151f731@mailosaur.in"
  Subject: "A test subject"
  HtmlBody: "<b>the message</b>"

NO_FROM =
  To: "carl.5151f731@mailosaur.in"
  ReplyTo: "neil.5151f731@mailosaur.in"
  Subject: "A test subject"
  HtmlBody: "<b>the message</b>"

# describe 'a thing', ->
#   it 'is a thing', ->
#     expect(true).toBe true

describe 'sendTo', ->
  beforeEach ->
    mocks.module 'pong-mark'
    mocks.module(
      postmark:
        send: jasmine.createSpy().andCallFake (attrs,cb)->cb()
      )

  it 'should be a function', ->
    mocks.inject (sendTo)->
      expect(typeof sendTo).toBe 'function'

  it 'should make postmark send an email', (done)->
    mocks.inject (sendTo, postmark)->
      sendTo(VALID).then ->
        expect(postmark.send).toHaveBeenCalledWith VALID, jasmine.any(Function)
        done()

  describe 'should return a rejected promise', ->

    it 'if it gets no From field', (done)->
      mocks.inject (sendTo, postmark)->
        sendTo(NO_FROM).then (res)->
          console.log res
          expect(postmark.send).toHaveBeenCalledWith NO_FROM, jasmine.any(Function)
          done()

  #       # result.should.not.be.a.Promise
  #       result.should.eventually.be.false
  #       # result.should.be.rejectedWith 'foo'
