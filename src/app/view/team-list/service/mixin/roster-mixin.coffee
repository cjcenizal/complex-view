FS.factory "rosterMixinFactory", ->

  RosterMixin = class

    constructor: ->

      @_id  = 1
      @list = []

    add: ->

      @list.push @create()

    addWith: (attributes) ->

      @list.push _.extend @create(), attributes

    create: ->

      return {
        name:   "New Player #{@_id++}"
        wins:   0
        losses: 0
        active: false
      }

    remove: (player) ->
      
      index = @list.indexOf player
      @list.splice index, 1

    activate: (player) ->

      player.active = true

    deactivate: (player) ->

      player.active = false

    toggleSelect: (player) ->

      player.selected = not player.selected

    deselectAll: ->

      for player in @getAllSelected()
        player.selected = false

    getAllSelected: ->

      return _.where @list,
        selected: true

  create: ->

    return new RosterMixin