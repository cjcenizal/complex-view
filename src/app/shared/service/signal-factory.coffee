FS.factory "signalFactory", ->

  Signal = class

    constructor: ->
      
      @_listeners = []

    add: (listener) ->

      return listener if @has listener
      @_listeners.push listener
      return listener

    has: (listener) ->

      return true if @_listeners.indexOf(listener) >= 0
      return false

    remove: (listener) ->

      return listener unless @has listener
      return @_listeners.splice @_listeners.indexOf(listener), 1

    removeAll: ->
      
      @_listeners = []

    dispatch: ->
      
      for listener in @_listeners
        listener.apply null, arguments

  create: ->

    return new Signal