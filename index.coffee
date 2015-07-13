pongular = require('pongular').pongular;

require 'pong-q'

# module.exports = 

pongular.module('pong-mark', ['pong-q'])

.service 'postmark', -> require 'postmark'

.service 'configuredPostmark', (postmark, postmarkConfig)->
  postmark(postmarkConfig.apiKey)

.service '$mailer', ($promise, configuredPostmark)->
  (attrs)->
    $promise (d)->
      configuredPostmark.send attrs, (error,success)->
        if error then d.reject(error.message) else d.resolve()         

#     From: "volunteer@sparks.network" # inject from-address
#     To: "#{profile.name} <#{profile.emailAddress}>"
#     ReplyTo: "#{replyTo}"
#     Subject: "#{eventId} Volunteer: #{subject}"
#     HtmlBody: messageWrapper(profile,message)
#     Tag: "#{eventId}"
