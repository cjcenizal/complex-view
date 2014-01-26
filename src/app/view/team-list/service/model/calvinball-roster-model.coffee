FS.factory "CalvinballRosterModel", [
  "mixinFactory"
  "rosterMixinFactory"
  (
    mixinFactory
    rosterMixinFactory
  ) ->

    CalvinballRosterModel = class

      constructor: ->

        @list = [
          name:   "Calvin"
          wins:   4
          losses: 6
          active: false
          rule:   "'No song' zone"
        ,
          name:   "Hobbes"
          wins:   5
          losses: 5
          active: false
          rule:   "Touch the opposite pole"
        ,
          name:   "Susie"
          wins:   8
          losses: 0
          active: true
          rule:   "Pernicious Poem Place"
        ,
          name:   "Moe"
          wins:   0
          losses: 0
          active: true
          rule:   "Give before it hurts"
        ]

      add: ->

        @addWith
          rule: "None"

    mixinFactory CalvinballRosterModel, rosterMixinFactory.create()

    return CalvinballRosterModel

]