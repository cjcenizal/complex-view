FS.factory "CalvinballRosterModel", [
  "mixinFactory"
  "rosterMixin"
  (
    mixinFactory
    rosterMixin
  ) ->

    CalvinballRosterModel = class

      constructor: ->

        @list = [
          name:    "Calvin"
          wins:    4
          losses:  6
          retired: false
          rule:    "'No song' zone"
        ,
          name:    "Hobbes"
          wins:    5
          losses:  5
          retired: false
          rule:    "Touch the opposite pole"
        ,
          name:    "Susie"
          wins:    8
          losses:  0
          retired: true
          rule:    "Pernicious Poem Place"
        ,
          name:    "Moe"
          wins:    0
          losses:  0
          retired: true
          rule:    "Give before it hurts"
        ]

    mixinFactory CalvinballRosterModel, rosterMixin.create()

    return CalvinballRosterModel

]