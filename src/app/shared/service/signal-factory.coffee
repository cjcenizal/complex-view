FS.factory "signalFactory", ->

  Signal = class

    constructor: ->
      
      @_listeners = []

    add: (listener) ->

      removeCallback = =>
        @remove listener

      return removeCallback if @has listener
      @_listeners.push listener
      return removeCallback

    has: (listener) ->

      return true if @_listeners.indexOf(listener) >= 0
      return false

    remove: (listener) ->

      return unless @has listener
      @_listeners.splice @_listeners.indexOf(listener), 1

    removeAll: ->
      
      @_listeners = []

    dispatch: ->
      
      for listener in @_listeners
        listener.apply null, arguments

  create: ->

    return new Signal