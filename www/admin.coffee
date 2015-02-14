"use strict"

User        = require "../common/models/user"
Session     = require "../common/session"
C           = require "../common/constants"

module.exports = (zen) ->

  zen.get "/admin/:context/:id", (request, response) ->
    Session(request, response, redirect = true).then (error, session) ->
      return response.redirect "/admin" if not session
      bindings =
        page    : "admin"
        session : session
        asset   : "admin"
        host    : C.HOST[global.ZEN.type.toUpperCase()]
      response.page "base", bindings, []


  zen.get "/admin/:context", (request, response) ->
    Session(request, response, redirect = true).then (error, session) ->
      return response.redirect "/admin" if not session
      bindings =
        page    : "admin"
        session : session
        asset   : "admin"
        host    : C.HOST[global.ZEN.type.toUpperCase()]
      response.page "base", bindings, []


  zen.get "/admin", (request, response) ->
    Session(request, response, redirect = true).then (error, session) ->
      return response.redirect "/admin/dashboard" if session

      User.search(type: C.USER.TYPE.OWNER).then (error, users) ->
        response.page "base",
          page  : "session"
          asset : "admin"
          host  : C.HOST[global.ZEN.type.toUpperCase()]
          owner : (users.length > 0)
