// Generated by CoffeeScript 1.9.2
(function() {
  var pongular;

  pongular = require('pongular').pongular;

  require('pong-q');

  pongular.module('pong-mark', ['pong-q']).service('postmark', function() {
    return require('Postmark');
  }).service('sendTo', function($promise, postmark) {
    return function(attrs) {
      return $promise(function(d) {
        return postmark.send(attrs, function(error, success) {
          if (error) {
            console.log('Postmark Error:', error);
          }
          return error && d.reject(error.message) || d.resolve();
        });
      });
    };
  }).service('$mailComposer', function($promise) {
    return function(config, composerFn) {
      return $promise(function(d) {
        var err;
        try {
          composerFn(config);
          return d.resolve();
        } catch (_error) {
          err = _error;
          return d.reject(err);
        }
      });
    };
  }).service('mailComposer', function() {
    return {
      init: function(config1) {
        this.config = config1;
      },
      buildAttrs: function(params) {
        this.params = params;
        return {
          From: "volunteer@sparks.network",
          To: profile.name + " <" + profile.emailAddress + ">",
          ReplyTo: "" + replyTo,
          Subject: eventId + " Volunteer: " + subject,
          HtmlBody: messageWrapper(profile, message),
          Tag: "" + eventId
        };
      }
    };
  });

}).call(this);