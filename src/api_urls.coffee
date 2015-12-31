'use strict'

###*
 # @ngdoc service
 # @name AK.Request.APIUrls
 # @description
 # # APIUrls
 # Provider in the AK.Request.
###

angular.module('AK.Request').provider 'APIUrls', ->
  @rootUrl=null
  @urls={}
  @requestFormat=null
  # Private constructor

  APIUrls = ->

    @getUrl = (key, arg) ->
      console.log 'hostName: ', @rootUrl
      url = @urls[key]
      argsArray = undefined
      # allow the user to use a function which generates the url depending on some params
      if angular.isFunction(url)
        argsArray = Array::slice.call(arguments)
        argsArray.splice 0, 1
        url = url.apply(null, argsArray)
      #var result= location.protocol + "//" + this.hostname+':'+this.port + '/api/' + url;
      result = "#{@rootUrl}/#{url}"
      if arg
        result += '/' + arg
      if @requestFormat
        result += @requestFormat
      result

    return

  @setRootUrl = (url) ->
    @rootUrl = url

  @setUrls=(urls)->
    @urls=urls

  @setUrlRequestFormat=(format)->
    @requestFormat=format

  # Method for instantiating

  @$get = ->
    new APIUrls

  return
