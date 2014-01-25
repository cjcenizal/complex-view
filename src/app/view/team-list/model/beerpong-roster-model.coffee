FS.factory "BeerpongRosterModel", [
  "mixinFactory"
  "rosterMixin"
  (
    mixinFactory
    rosterMixin
  ) ->

    BeerpongRosterModel = class

      constructor: ->

        @list = [
          name:     "CJ"
          wins:     3
          losses:   67
          active:   false
          hand:     "Righty"
          position: "Designated drinker"
        ,
          name:     "Karla"
          wins:     429
          losses:   106
          active:   false
          hand:     "Righty"
          position: "Overlord"
        ,
          name:     "Cory"
          wins:     34
          losses:   12
          active:   false
          hand:     "Righty"
          position: "Enforcer"
        ,
          name:     "Christina"
          wins:     12
          losses:   34
          active:   true
          hand:     "Righty"
          position: "Poor loser"
        ,
          name:     "Greg"
          wins:     9
          losses:   3
          active:   false
          hand:     "Lefty"
          position: "I'm Ron Burgundy?"
        ]

      switchHandedness: (player) ->

        if player.hand is "Lefty"
          player.hand = "Righty"

        else if player.hand is "Righty"
          player.hand = "Lefty"

    mixinFactory BeerpongRosterModel, rosterMixin.create()

    return BeerpongRosterModel

]