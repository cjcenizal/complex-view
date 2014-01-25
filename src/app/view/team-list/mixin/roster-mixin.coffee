FS.factory "rosterMixin", ->

  create: ->
    
    _id = 1

    return new class

      add: ->

        @list.push
          name:   "New Player #{_id++}"
          wins:   0
          losses: 0
          rule:   "None"

      remove: (player) ->
        index = @list.indexOf player
        @list.splice index, 1

      activate: (player) ->

        player.active = true

      deactivate: (player) ->

        player.active = false